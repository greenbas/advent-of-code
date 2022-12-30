title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.procInput = () -> 
  str = input.value.split('\n').map (cur) -> 
    [dir,num] = cur.split(" ");
    return {dir, num: Number num } 



window.main = () ->
  head = {x:0,y:0}
  tail = {x:0,y:0}
  tailHistory = new Set()
  logTailSet = () -> 
    tailHistory.add("#{tail.x},#{tail.y}")
  
  directions = procInput()
  logTailSet()
  directions.forEach (cur) ->
    tailTooFar = () -> 
      x = Math.abs(head.x - tail.x)
      y = Math.abs(head.y - tail.y)
      return Math.max(x,y) > 1
    
    differenceVector = () -> 
      x = Math.sign(head.x - tail.x)
      y = Math.sign(head.y - tail.y)
      return {x,y} 

    addVectors = (a,b) -> 
      return {x: a.x + b.x,y: a.y + b.y} 

    {dir,num} = cur
    delta = {x:0,y:0}
    switch dir
      when 'R'
        delta.x = 1 
      when 'L'
        delta.x = -1
      when 'U'
        delta.y = 1
      when 'D' 
        delta.y = -1
    while num > 0
      head = addVectors(head,delta)
      if tailTooFar() 
        tail = addVectors(tail,differenceVector()) 
        logTailSet() 
      num--
  toOutput tailHistory.size
###