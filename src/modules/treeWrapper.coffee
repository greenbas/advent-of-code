
import {curry$} from './lsutils.coffee'


attribute_gen = curry$ (self, name, getterSetterHash) ->
  Object.defineProperty self, name, getterSetterHash

export default curry$ Tree = (forestData,element) ->
  debugger

  res = {}

  `const forest = element.parentElement.parentElement`

  unless element.classList.contains("tree")
    throw "Tree cannot wrap a non tree class element"
    return 


  attribute = attribute_gen res

  explorer = (y,x) -> 
    debugger
    ptr = {y: res.yPos + y, x: res.xPos + x}
    while (forestData[ptr.y]? and forestData[ptr.y][ptr.x]?)
        yield Number(forestData[ptr.y][ptr.x])
        ptr.y += y
        ptr.x += x

  getView = (neighbours) -> 
    isBlocked = false
    viewLength = 0
    for neighbour from neighbours
        viewLength += 1
        if res.height <= neighbour
            isBlocked = true
            break
    return {viewLength,isBlocked} 

  attribute 'element', 
    get: () -> return element

  res.height = Number element.innerText
  res.yPos = Number element.parentElement.getAttribute("rowidx")
  res.xPos = Number element.getAttribute("colidx")

  attribute 'eastNeighbours',
    get: () -> explorer(1,0)

  attribute 'westNeighbours',
    get: () -> explorer(-1,0)

  attribute 'northNeighbours', 
    get: () -> explorer(0,-1)

  attribute 'southNeighbours',
    get: () -> explorer(0,1)

  attribute 'eastView',
    get: () -> 
        getView(res.eastNeighbours)

  attribute 'westView',
    get: () -> 
        getView(res.westNeighbours)

  attribute 'northView',
    get: () -> 
        getView(res.northNeighbours)

  attribute 'southView',
    get: () -> 
        getView(res.southNeighbours)

  attribute 'isVisible',
    get: () -> 
        views = [res.westView,res.eastView,res.northView,res.southView]
        return !views.reduce(((acc,cur) -> acc and cur.isBlocked),true)

  attribute 'visibilityScore',
    get: () -> 
        views = [res.westView,res.eastView,res.northView,res.southView]
        return views.reduce(((acc,cur) -> acc * cur.viewLength),1)
        


  return res
  