#@ts-check 

import {curry$} from './modules/lsutils.coffee'

import {treeSpan,rowSpan,attributeQuery} from "./modules/domutils.coffee"

import Tree from "./modules/treeWrapper.coffee"

title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

###* 
 * @param {String} str
 * @returns {void}
###
window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)



window.visibleRow = curry$ (tree,line) -> 
  sum = 0
  `for(let cur of line) {
    if(cur >= tree.height)
      return sum + 1;
    else 
      sum += 1;
  }//`
  return sum

window.moveDir = curry$ (forest,tree,x,y) -> 
  [Symbol.iterator]: () ->
    ptr = [tree.yPos+y,tree.xPos+x]
    while (forest.querySelector("[rowidx='#{ptr[0]}'] [colidx='#{ptr[1]}']"))
      yield Tree(forest.querySelector("[rowidx='#{ptr[0]}'] [colidx='#{ptr[1]}']")).height
      ptr[0] += y
      ptr[1] += x
    

window.isVisible = curry$ (forest,treeElement) -> 
    tree = Tree treeElement

    treeEast =  tree.eastNeighbours
    treeWest =  tree.westNeighbours
    treeNorth = tree.northNeighbours
    treeSouth = tree.southNeighbours
    console.log(treeEast,treeWest,treeNorth,treeSouth)
    




window.main = () ->
  console.clear()
  `const forestData = document.createElement('pre')`
  rows = input.value.split('\n').map((row,rowidx) -> 
    row = row.split("").reduce(treeSpan,"")
    rowSpan(rowidx,row)
  ).join("\n")
  forestData.innerHTML = rows
  document.getElementById("data").appendChild forestData
  `const NUM_ROWS = forestData.querySelectorAll(".row").length`
  `const NUM_COLS = forestData.querySelectorAll("[rowidx='0'] .tree").length`
  console.dir({NUM_ROWS,NUM_COLS})

  do -> 
    edges = 
      document.querySelectorAll [attributeQuery("rowidx", 0, ".tree")
        attributeQuery("rowidx",NUM_ROWS - 1,".tree")
        attributeQuery("colidx",0)
        attributeQuery("colidx",NUM_COLS - 1)].join(', ')
    [...edges].forEach (cur) ->
      cur.classList.add("edge")

  checkTree = Tree(forestData.innerText.split('\n'))
  
  ###
  console.log [...forestData.querySelectorAll(".tree:not(.edge)")].forEach(((cur) -> 
    debugger
    cur = checkTree(cur)
    if cur.isVisible
      cur.element.style.color = "green" 
  ))
  ###
  
  
  toOutput [...forestData.querySelectorAll(".tree:not(.edge)")].reduce(((acc,cur) -> 
    return Math.max(acc,checkTree(cur).visibilityScore)
  ),-1 )
  ###

      

  


  

   
  
  
  
  
 
  
  
