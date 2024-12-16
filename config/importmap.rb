# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "flowbite", to: "flowbite.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.15.1/modular/sortable.esm.js"
pin "mout/array/indexOf", to: "mout--array--indexOf.js" # @0.11.1
pin "mout/object/fillIn", to: "mout--object--fillIn.js" # @0.11.1
