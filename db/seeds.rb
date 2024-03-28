# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: 'John Doe', phone_no: '+639079247641', password: 'password', admin: true)
User.create(name: 'Admin', phone_no: '+639012345678', password: 'password', admin: true)

women = Category.create(name: 'Women')
Category.create!(name: 'Bags', parent: women)
clothes = Category.create(name: 'Clothes', parent: women)
Category.create(name: 'Sample', parent: clothes)

shoe = Category.create(name: 'Shoe')
Category.create!(name: 'Nike', parent: shoe)
adidas = Category.create(name: 'Adidas', parent: shoe)
Category.create(name: 'T-21', parent: adidas)

# base = Category.create(name: 'Base 2')
# lvl_one = Category.create(name: 'Base 2 lvl 1', lft_id: base.id, parent_id: base.id)
# Category.create(name: 'Base 2 lvl 2', lft_id: lvl_one.id, parent_id: base.id)
