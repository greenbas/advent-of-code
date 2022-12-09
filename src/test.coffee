title = 'Advent of code App Step 1'

window.main = () ->  
  separator = '\n\n'
  input = document.getElementById("input")
  output = document.getElementById("output")
  foodBags = input.value.trim().split(separator)
  foodBags = foodBags.map((cur) -> cur.split('\n'))
    .map((cur) -> 
      cur.reduce(((acc,cur) -> acc + parseInt(cur)),0))
  sortedBags = foodBags.sort((a,b) -> b-a)
  output.innerText = JSON.stringify(sortedBags[0..2].reduce((acc,cur) -> acc+cur))