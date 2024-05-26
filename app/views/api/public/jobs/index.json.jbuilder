json.array!(@jobs) do |job|
  json.partial! 'api/public/jobs/job', job: job
end