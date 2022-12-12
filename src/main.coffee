import Terminal from './classes/terminal.coffee'

title = 'Advent of code'

`const MAX_FOLDER_SIZE = 100000`

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.processDirectory = (acc,cur) ->
  if cur.constructor.name isnt 'Directory'
    return acc
  if cur.size > MAX_FOLDER_SIZE
    return acc.concat(cur.children.reduce(processDirectory,[]))
  return acc.concat(cur).concat(cur.children.reduce(processDirectory,[]))

window.main = () ->
  console.clear()
  terminal = new Terminal()
  lines = input.value.trim().split("\n")
  
  lines.forEach (cur,idx) ->
    console.log("processing line #{idx}: #{cur}")
    terminal.processLine(cur)
  
  terminal.goHome()
  
  toOutput Object.values(terminal.dirs).reduce(processDirectory,[]).reduce(((acc,cur) -> acc + cur.size),0)

    

  
  