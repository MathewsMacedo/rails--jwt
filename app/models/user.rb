class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true
    validates :password,
              length: { minimum: 6 },
              if: -> { new_record? || !password.nil? }

    after_create :send_event


    def send_event
        DeliveryBoy.deliver( { id: self.id, username: self.username, email: self.email, firstname: self.name.to_s.split(" ")[0], lastname: self.name.to_s.split(" ")[-1] }.to_json, topic: 'users-upsert')
    rescue => e
        Rails.logger.error("Error when send event upsert user: #{e.message}")
    end
end
