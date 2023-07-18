class User < ApplicationRecord
  has_secure_password

  has_many :gardens

  validates :email_address, presence: true, uniqueness: true, length: { minimum: 8 },
                            format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
