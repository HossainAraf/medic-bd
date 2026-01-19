# app/services/doctor_schedules/bulk_update.rb
module DoctorSchedules
  class BulkUpdate
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @payload = params[:doctor_schedule]
      @errors = []
    end

    def call
      return failure("Missing required key 'doctor_schedule'") unless valid_payload?

      ActiveRecord::Base.transaction do
        process_payload
        raise ActiveRecord::Rollback if errors.any?
      end

      errors.any? ? failure(errors) : success
    end

    private

    attr_reader :payload, :errors

    def valid_payload?
      payload.present? && payload.is_a?(Array)
    end

    def process_payload
      payload.each do |item|
        process_item(item)
      end
    end

    def process_item(_item)
      # create/update logic here
    rescue ActiveRecord::RecordInvalid => e
      errors << e.record.errors.full_messages
    end

    def success
      OpenStruct.new(success?: true, data: payload)
    end

    def failure(errors)
      OpenStruct.new(success?: false, errors: errors)
    end
  end
end
