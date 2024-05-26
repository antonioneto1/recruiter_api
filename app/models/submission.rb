class Submission < ApplicationRecord
  validates :name, :email, :mobile_phone, :job_id, presence: true
  validates :email, uniqueness: { scope: :job_id, message: 'Você já se inscreveu para esta vaga' }
  validates :resume, presence: true
  validate :validate_resume_content_type

  has_one_attached :resume
  belongs_to :job

  private

  def validate_resume_content_type
    if resume.attached? && !resume.blob.content_type.start_with?('application/pdf')
      errors.add(:resume, 'deve ser um arquivo PDF')
    end
  end
end
