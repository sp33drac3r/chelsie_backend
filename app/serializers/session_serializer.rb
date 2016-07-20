class SessionSerializer < ActiveModel::Serializer
    # attributes :email, :token_type, :user_id, :access_token, :host_code
    attributes :token_type

    # def user_id
    #   object.id
    # end

    def token_type
      'Bearer'
    end
end
