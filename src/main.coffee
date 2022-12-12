title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.transpose = (array,arrayLength) -> 


window.processCrates = (crateStr) -> 
  console.clear()
  lines = crateStr.split("\n")
  crateLines = lines[0...lines.length-1]
  nameLines = lines[lines.length-1]
  crateLines = crateLines.map((cur) -> 
    ret = []
    for i in [0...cur.length] by 4
      res = cur.substring(i,i+3)
      if res is "   "
        ret.push("")
      else 
        ret.push(res)
    ret
  )
  crateStacks = crateLines[0].map((_, colIndex) => crateLines.map((row) -> row[colIndex]))
  return crateStacks.map((cur) -> cur.filter((crate) -> crate isnt "")).map((cur) -> cur.map((letter) -> letter[1]))

window.main = () ->
  parts = input.value[1...input.value.length-1].split("\n\n")
  [crates,commands] = parts
  crateStacks = processCrates(crates)
  moveCommand = /move (\d*) from (\d*) to (\d*)/g
  processedCommands = [...commands.matchAll(moveCommand)].map((cur) -> 
    [_,_move,_from,_to] = cur
    _move = parseInt _move
    _from = parseInt(_from) - 1
    _to = parseInt(_to) - 1
    {move: _move, from: _from, to: _to}
  )
  processedCommands.forEach((command) -> 
    temp = crateStacks[command.from].splice(0,command.move)
    crateStacks[command.to] = [...temp,...crateStacks[command.to]]
  )
  toOutput(crateStacks.map((cur) -> cur[0]).join(""))  