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
  console.clear()
  knots = [{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0},{x:0,y:0}]
  tailHistory = new Set()
  logTailSet = () -> 
    tailHistory.add("#{knots[9].x},#{knots[9].y}")
  
  tailTooFar = (a,b) -> 
    x = Math.abs(a.x - b.x)
    y = Math.abs(a.y - b.y)
    return Math.max(x,y) > 1
  
  differenceVector = (a,b) -> 
    x = Math.sign(a.x - b.x)
    y = Math.sign(a.y - b.y)
    return {x,y} 

  addVectors = (a,b) -> 
    return {x: a.x + b.x,y: a.y + b.y} 
  
  directions = procInput()
  logTailSet()
  directions.forEach (cur) ->
    {dir,num} = cur
    outerDelta = {x:0,y:0}
    switch dir
      when 'R'
        outerDelta.x = 1 
      when 'L'
        outerDelta.x = -1
      when 'U'
        outerDelta.y = 1
      when 'D' 
        outerDelta.y = -1
    while num > 0
      knots[0] = addVectors(knots[0],outerDelta)
      knots[1...].forEach (_,idx) ->
        innerDelta = differenceVector(knots[idx],knots[idx+1])
        if tailTooFar(knots[idx],knots[idx+1])
          knots[idx+1] = addVectors(knots[idx+1],innerDelta)
      logTailSet()
      num--
  toOutput tailHistory.size 