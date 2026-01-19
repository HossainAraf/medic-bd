# app/services/doctor_schedules/bulk_update.rb
module DoctorSchedules
  class BulkUpdate
    Result = Struct.new(:success, :data, :errors, :message, keyword_init: true)

    def initialize(payload, doctor)
      @payload = payload
      @doctor = doctor
      @errors = []
      @schedules = []
    end

    def call
      validate_payload!
      return Result.new(success: false, errors: @errors) if @errors.any?

      ActiveRecord::Base.transaction do
        @payload[:available_days].each do |day|
          @payload[:slots].each do |slot|
            process_day_slot(day, slot)
          end
        end

        # rollback if any errors
        raise ActiveRecord::Rollback if @errors.any?
      end

      if @schedules.empty?
        Result.new(success: true, data: nil, message: 'No schedules were changed')
      else
        Result.new(success: true, data: @schedules, message: 'Updated successfully')
      end
    end

    private

    def validate_payload!
      %i[available_days slots times].each do |key|
        @errors << "#{key} must be provided" if @payload[key].blank?
      end
    end

    def process_day_slot(day, slot)
      time = @payload[:times][slot.to_s] || @payload[:times][slot.to_sym]

      unless time
        @errors << "Missing times for slot #{slot}"
        return
      end

      schedule = DoctorSchedule.find_or_initialize_by(
        doctor: @doctor,
        chamber_id: @payload[:chamber_id],
        available_day: day,
        slot: slot
      )

      schedule.assign_attributes(
        start_time: time[:start],
        end_time: time[:end]
      )

      # save only if new or changed
      schedule.save! if schedule.new_record? || schedule.changed?

      @schedules << schedule
    rescue StandardError => e
      @errors << "Failed for day #{day}, slot #{slot}: #{e.message}"
    end
  end
end
