json.extract! suggestion, :id, :title, :content, :created_at, :updated_at
json.url suggestion_url(suggestion, format: :json)
