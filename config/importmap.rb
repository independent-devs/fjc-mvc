# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers", preload: false

pin 'intl-tel-input', to: 'https://ga.jspm.io/npm:intl-tel-input@18.2.1/index.js', preload: false
pin "stimulus-sortable", preload: false # @4.1.1
pin "@rails/request.js", to: "@rails--request.js.js", preload: false # @0.0.8
pin "sortablejs", preload: false # @1.15.2
pin "stimulus-notification" # @2.2.0
pin "hotkeys-js" # @3.13.7
pin "stimulus-use" # @0.51.3
pin "stimulus-rails-autosave", preload: false # @5.1.0,
pin "@stimulus-components/dialog", to: "@stimulus-components--dialog.js" # @1.0.1
pin "js-image-zoom", preload: false # @0.7.0
