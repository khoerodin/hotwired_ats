class Email < ApplicationRecord
  belongs_to :applicant
  belongs_to :user

  has_rich_text :body

  validates :subject, presence: true
end
