# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  User.create(name: 'John Doe', phone_no: '+639079247641', password: 'password', admin: true)
  User.create(name: 'Admin', phone_no: '+639012345678', password: 'password', admin: true)
end

category = Category.create(name: 'Categories')

clothes = Category.create(name: 'Clothes', parent: category)
Category.create(name: 'Polo Shirt', parent: clothes)
Category.create(name: 'T-Shirt', parent: clothes)

pants = Category.create(name: 'Pants', parent: clothes)
Category.create(name: 'Trousers', parent: pants)
Category.create(name: 'Shorts', parent: pants)
