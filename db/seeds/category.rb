# frozen_string_literal: true

base_category = Category.create(name: 'Categories')

clothes = Category.create(name: 'Clothes', parent: base_category)
Category.create(name: 'Polo Shirt', parent: clothes)
Category.create(name: 'T-Shirt', parent: clothes)
