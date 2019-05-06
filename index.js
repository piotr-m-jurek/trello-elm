import { Elm } from './src/Main.elm'
import monitor from 'elm-monitor'
monitor()

Elm.Main.init({
  node: document.getElementById('elm')
})

