class Job < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :recruiter_id, presence: true

  belongs_to :recruiter

  enum status: { active: 0, closed: 1 }
end
