title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.main = () ->
  cleaningLists = input.value.trim().split("\n").map((cur) -> 
    ret = cur.split(",").map((set) -> 
      [start, end] = set.split("-")
      start = parseInt(start)
      end = parseInt(end)
      length = 1 + end - start
      {start,end,length}
    ).sort((a,b) -> b.length - a.length)
  )
  total = cleaningLists.reduce(((acc,cur) -> 
    [bigset,smallset] = cur
    innerStart = smallset.start >= bigset.start
    innerEnd = bigset.end >= smallset.end
    if(innerStart and innerEnd)
      return acc+1 
    else 
      return acc
  ),0)
  toOutput(total)