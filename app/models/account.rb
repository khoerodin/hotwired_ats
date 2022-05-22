class Account < ApplicationRecord
  validates :name, presence: true

  has_many :jobs, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :applicants, through: :jobs, enable_updates: { on: :create }
end
