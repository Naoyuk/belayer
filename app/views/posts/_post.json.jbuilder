json.extract! post, :id, :date, :start_time, :end_time, :kind_of_climbing, :created_at, :updated_at
json.url post_url(post, format: :json)
