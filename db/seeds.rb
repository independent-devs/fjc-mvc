# frozen_string_literal: true

if Rails.env.development?
  User.create(name: 'John Doe', phone_no: '+639079247641', password: 'password', admin: true)
  User.create(name: 'Admin', phone_no: '+639012345678', password: 'password', admin: true)
end

base_category = Category.create(name: 'Categories')

clothes = Category.create(name: 'Clothes', parent: base_category)
Category.create(name: 'Polo Shirt', parent: clothes)
Category.create(name: 'T-Shirt', parent: clothes)
