class Profile < ApplicationRecord
  belongs_to :user
  validates :name, :user, presence: true
  enum kind: [:admin, :regular]
end
