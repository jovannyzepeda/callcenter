json.extract! campaign, :id, :nombre, :telefono, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)