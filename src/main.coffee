title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.main = () ->
  console.clear()
  inputValue = input.value.trim()
  for i in [3...inputValue.length]
    ###*@type String###
    cur = inputValue[i-3..i]
    curSet = new Set()
    foundSignal = true
    for char in cur
      if curSet.has(char)
        foundSignal = false
        break
      else 
        curSet.add(char)
    if(foundSignal)  
      toOutput(cur + " @ " + (i + 1))
      break
    