json.extract! manage_admin, :id, :number, :name, :avatar
json.created_at manage_admin.created_at.strftime('%Y-%m-%d %H:%M:%S')
json.role translate_role manage_admin.role
json.password "********"
