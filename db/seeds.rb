Role.create(name: 'registered') if Role.find_by(name: 'registered').blank?
Role.create(name: 'admin') if Role.find_by(name: 'admin').blank?

if User.find_by(login: 'admin').blank?
	admin = User.create(login: 'admin', email: 'admin@forum.com', password: 'adminpass')
	admin.roles << Role.admin
end