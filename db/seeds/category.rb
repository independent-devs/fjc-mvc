# frozen_string_literal: true

clothes = Category.create(name: 'Clothes')
Category.create(name: 'Polo Shirt', parent: clothes)

tshirt = Category.create(name: 'T-Shirt', parent: clothes)
Category.create(name: 'Shirt', parent: tshirt)
