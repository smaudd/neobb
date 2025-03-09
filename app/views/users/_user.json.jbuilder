json.extract! user, :id, :username, :email_address ,:created_at, :updated_at, :bans
json.url user_url(user, format: :json)