class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :salary, numericality: { greater_than: 0 }
  validates :recruiter_id, presence: true

  belongs_to :recruiter
end
