class Artist < ApplicationRecord
  has_many :records, dependent: :destroy

  validates :name, presence: true
  validates :approved, inclusion: { in: [true, false] }
end
