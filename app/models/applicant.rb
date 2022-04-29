class Applicant < ApplicationRecord
  belongs_to :job

  enum stage: {
    application: "application",
    interview: "interview",
    offer: "offer",
    hired: "hire"
  }

  enum status: {
    active: "active",
    inactive: "inactive"
  }

  validates :first_name, :last_name, :email, presence: true

  delegate :title, :location, to: :job, prefix: true

  def name
    [first_name, last_name].join(" ")
  end
end
