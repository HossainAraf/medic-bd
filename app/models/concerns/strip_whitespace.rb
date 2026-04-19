# app/models/concerns/strip_whitespace.rb
module StripWhitespace
  extend ActiveSupport::Concern

  included do
    before_save :strip_whitespace
  end

  private

  def strip_whitespace
    attributes.each do |key, value|
      self[key] = value.strip.gsub(/\s+/, ' ') if value.is_a?(String)
    end
  end
end
