require 'jwt'

module AuthToken
  def AuthToken.issue_token(payload)
    payload['exp'] = 72.hours.from_now.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS512')
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base, true, { :algorithm => 'HS512' })
    rescue
      false
    end
  end
end
