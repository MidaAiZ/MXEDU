json.extract! manage_admin, :id, :number, :password_digest, :name, :role, :created_at, :updated_at
json.url manage_admin_url(manage_admin, format: :json)
