import Terminal from './classes/terminal.coffee'

title = 'Advent of code'

`const TOTAL_SPACE = 70000000`
`const NEEDED_SPACE = 30000000`

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.processDirectory = (acc,cur) ->
  if cur.constructor.name isnt 'Directory'
    return acc
  return acc.concat(cur).concat(cur.children.reduce(processDirectory,[]))

window.main = () ->
  console.clear()
  terminal = new Terminal()
  lines = input.value.trim().split("\n")
  
  lines.forEach (cur,idx) ->
    console.log("processing line #{idx}: #{cur}")
    terminal.processLine(cur)
  
  terminal.goHome()

  curSpace = TOTAL_SPACE - terminal.curDir.size
  
  allDirs = Object.values(terminal.dirs).reduce(processDirectory,[]).sort((a,b) -> b.size - a.size)

  console.log curSpace
  console.log allDirs
  i = 0;
  while (allDirs[i + 1].size + curSpace) > NEEDED_SPACE
    i++
  toOutput allDirs[i].size


    

  
  