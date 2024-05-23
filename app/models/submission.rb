class Submission < ApplicationRecord
  validates :resume, presence: true, content_type: ['application/pdf']
  validates :name, :email, :mobile_phone, :job_id, presence: true
  validates :email, uniqueness: { scope: :job_id, message: 'Você já se inscreveu para esta vaga' }

  has_one_attached :resume
  belongs_to :job
end
