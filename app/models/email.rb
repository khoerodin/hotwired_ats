class Email < ApplicationRecord
  belongs_to :applicant
  belongs_to :user

  has_rich_text :body

  validates :subject, presence: true

  after_create_commit :send_email

  def send_email
    ApplicantMailer.contact(email: self).deliver_later
  end
end
