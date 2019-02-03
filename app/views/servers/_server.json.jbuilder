json.extract! server, :id, :host_name, :ip, :created_at, :updated_at
json.url server_url(server, format: :json)
