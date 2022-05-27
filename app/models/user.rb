class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :account
  accepts_nested_attributes_for :account

  belongs_to :invited_by, optional: true, class_name: "User"

  has_many :emails, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :invited_users,
           class_name: "User",
           foreign_key: "invited_by_id",
           dependent: :nullify,
           inverse_of: :invited_by

  after_create_commit :generate_alias

  def generate_alias
    email_alias = "#{email.split('@')[0]}-#{id[0 ... 4]}"
    update_column(:email_alias, email_alias)
  end

  def name
    [first_name, last_name].join(" ").presence || "(Not set)"
  end

  def reset_invite!(inviting_user)
    update(invited_at: Time.current, invited_by: inviting_user)
  end
end
