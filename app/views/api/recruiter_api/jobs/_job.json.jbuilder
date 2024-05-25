json.extract! job, :id, :title, :description, :start_date, :end_date, :status, :skills, :created_at, :updated_at
json.recruiter_name job.recruiter.name
json.submissions job.submissions do |submission|
  json.partial! 'api/public/submissions/submission', submission: submission
end
