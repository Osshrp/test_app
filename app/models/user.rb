class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :birth_date, presence: true
  validates :bio, presence: true
  mount_uploader :avatar, AvatarUploader

  def create_and_send_pdf
    CreatePdfJob.perform_now(self)
  end
end
