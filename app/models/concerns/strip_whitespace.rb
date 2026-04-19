# app/models/concerns/strip_whitespace.rb
module StripWhitespace
  extend ActiveSupport::Concern

  included do
    before_save :strip_whitespace
  end

  private

  def strip_whitespace
    Rails.logger.debug { "StripWhitespace called for #{self.class.name} with attributes: #{attributes}" }
    attributes.each do |key, value|
      if value.is_a?(String)
        Rails.logger.debug { "Processing attribute: #{key}, value: '#{value}'" }
        self[key] = value.strip.gsub(/\s+/, ' ')
      end
    end
  end
end
