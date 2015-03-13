json.array!(@history_jobs) do |history_job|
  json.extract! history_job, :id, :company_name, :title, :location, :start_time, :end_time, :current, :description
  json.url history_job_url(history_job, format: :json)
end
