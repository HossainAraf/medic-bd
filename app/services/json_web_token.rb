class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret)
  end

  def self.decode(token)
    body = JWT.decode(token, secret)[0]
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end

  def self.secret
    ENV['JWT_SECRET'].presence || Rails.application.credentials.secret_key_base
  end
end
