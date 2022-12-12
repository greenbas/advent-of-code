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

window.processDirectory = (availSpace) -> (acc,cur) ->
  if cur.constructor.name isnt 'Directory'
    return acc
  if (cur.size + availSpace) < NEEDED_SPACE
    return acc
  return acc.concat(cur).concat(cur.children.reduce(processDirectory(availSpace),[]))

window.main = () ->
  console.clear()
  terminal = new Terminal()
  lines = input.value.trim().split("\n")
  
  lines.forEach (cur,idx) ->
    console.log("processing line #{idx}: #{cur}")
    terminal.processLine(cur)
  
  terminal.goHome()

  curSpace = TOTAL_SPACE - terminal.curDir.size
  
  allDirs = Object.values(terminal.dirs).reduce(processDirectory(curSpace),[]).sort((a,b) -> a.size - b.size)

  toOutput allDirs[0].size
  
  


    

  
  