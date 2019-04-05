class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      HashWithIndifferentAccess.new(
        JWT.decode(
          token,
          Rails.application.credentials.secret_key_base
        )[0]
      )
    rescue
      nil
    end
  end
end
