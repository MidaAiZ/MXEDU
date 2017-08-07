json.extract! index_user, :id, :number, :password_digest, :phone, :email, :name, :sex, :info, :created_at, :updated_at
json.url index_user_url(index_user, format: :json)
