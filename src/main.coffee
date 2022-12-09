title = 'Advent of code'

import {TABLE} from './gameTable.coffee'

window.TABLE = TABLE;

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.main = () -> 
  inputValue = input.value.trim()
  rounds = inputValue.split("\n")
  console.log rounds.reduce(((acc,cur) -> 
    [opponent,player] = cur.split(" ")
    acc + TABLE[opponent][player]
  ),0)