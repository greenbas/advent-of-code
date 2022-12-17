import {curry$} from './modules/lsutils.coffee'

title = 'Advent of code'

document.addEventListener("load",() ->
  window.input = document.getElementById("input")
  window.output = document.getElementById("output")
)

window.toOutput = (str) -> 
  output.innerText = JSON.stringify(str)

window.inputProc = () ->
  rows = input.value.split('\n')
  trees = rows[1...rows.length-1].map (cur,xPos) ->
    cur = cur.split("")[1...cur.length-1].map (cur,yPos) ->
      {height:+cur, xPos: xPos+1, yPos: yPos+1,visibility: 0} 
  forest = input.value.split('\n')
  {trees: trees.flat(),forest}

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
    while (forest[ptr[0]]? and forest[ptr[0]][ptr[1]]?)
      yield Number forest[ptr[0]][ptr[1]]
      ptr[0] += y
      ptr[1] += x
    

window.isVisible = curry$ (forest,tree) -> 
    debugger
    forestTraverse = moveDir(forest,tree)
    treeEast =  [...forestTraverse(1,0)]
    treeWest =  [...forestTraverse(-1,0)]
    treeNorth = [...forestTraverse(0,-1)]
    treeSouth = [...forestTraverse(0,1)]
    rowCheck = visibleRow(tree)
    vecs = [treeEast,treeNorth,treeSouth,treeWest]
    return vecs.reduce((acc,cur) ->
      return acc * rowCheck(cur)
    ,1)



window.main = () ->
  {forest,trees} = inputProc()
  outerTreesRows = forest[0].length*2
  outerTreesSides = forest[1...forest.length-1].length*2
  visibilityCheck = isVisible(forest)
  trees.forEach((cur) ->
    cur.visibility = visibilityCheck(cur)
  )
  
  toOutput trees.reduce((acc,cur) ->
    return Math.max(cur.visibility,acc)
  ,0)
 
  
  
