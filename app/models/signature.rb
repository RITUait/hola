class Signature < ApplicationRecord
  belongs_to :user

  def delivery_options
    options = {
      :address => smtp_mail_server,
      :port => '587',
      :password => api_key,
      :domain => email.split('@').last,
      :authentication => 'plain',
      :enable_starttls_auto => true
    }

    if (smtp_mail_server =="smtp.sendgrid.net")
      options[:user_name] ='apikey'
    else
      options[:user_name] = api_key
    end
    options
  end
  validates :name,:api_key,:smtp_mail_server, presence: true
  validates_uniqueness_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,:message => '%{value} has already been taken'
end
