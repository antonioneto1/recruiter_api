class Submission < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :resume, presence: true, content_type: ['application/pdf']

  belongs_to :job
end
