class User < ApplicationRecord
    validates :name, :password_digest, :session_token, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :session_token, uniqueness: true

    attr_reader :password

    after_initialize :ensure_session_token

    def self.find_by_parameters(name, password)
        user = User.find_by(name: name)
        return nil unless user && is_password?(password)
        user
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


end