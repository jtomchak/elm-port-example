import Markov from "libmarkov";
import "./main.css";
import { Main } from "./Main.elm";
import { TheDonald } from "./seeds";
import registerServiceWorker from "./registerServiceWorker";
var app = Main.fullscreen();
/*
Methods we delcared as 'port' in Elm will be available on app.ports that
will get invoked/called when we send a cmd message out via Elm.
*/
app.ports.check.subscribe(function(num) {
  let suggestions = Number.isInteger(parseInt(num))
    ? generateChat(num)
    : "Unable to Parse " + num;
  // invoke JS function, return array of strings
  app.ports.suggestions.send(suggestions.split(" ")); // sending to the Elm sub
});

function spellCheck(word) {
  console.log(word); // Word from Elm!!!!!
  return [];
}

const generateChat = num => new Markov(TheDonald).generate(num);

registerServiceWorker();
