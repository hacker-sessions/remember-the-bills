class Reminder < ApplicationRecord
  belongs_to :user
  validates :label, :user, presence: true
  enum status: [:pending, :paid, :unpaid]
end
