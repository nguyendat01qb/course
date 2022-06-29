json.extract! event, :id, :title, :description, :start_time, :end_time, :address, :learning_objectives, :total_slot, :created_at, :updated_at
json.url event_url(event, format: :json)
