const App = require('./src/Main.elm')
const monitor = require('elm-monitor')
monitor()

App.Elm.Main.init({
    node: document.getElementById('elm')
})

