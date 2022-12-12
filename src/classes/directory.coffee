Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}

Function::setter = (prop, set) ->
  Object.defineProperty @prototype, prop, {set, configurable: yes}

class Directory
  constructor: (@name,@_parent = null) -> 
    @children = []
  
  @getter 'size', -> 
    if @children.length is 0
      return 0
    else 
      @children.reduce(((acc,cur) -> 
        acc + cur.size),0)
  
  appendChild: (newChild) -> 
    @children.push(newChild)
  
  @getter 'parent', -> 
    if !@_parent? 
      return null
    else 
      return @_parent

  @getter 'hasParent', -> @_parent?

    
export { Directory as default }
    