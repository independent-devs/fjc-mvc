# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers", preload: false

pin 'intl-tel-input', to: 'https://ga.jspm.io/npm:intl-tel-input@18.2.1/index.js'
pin "stimulus-sortable", preload: false # @4.1.1
pin "@rails/request.js", to: "@rails--request.js.js", preload: false # @0.0.8
pin "sortablejs", preload: false # @1.15.2
