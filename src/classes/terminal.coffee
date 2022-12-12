Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}


import Directory from './directory.coffee'
import File from './File.coffee'



class Terminal
  constructor: () ->
    @curDir = null
    @_dirs = {'/': new Directory('/')}

  processLine: (line) -> 
    [command,...args] = line.split(" ")
    switch command
      when '$' then @dollarSign(args)
      when 'dir' then @mkdir(...args)
      else @mkfile(...args,command)
  
  mkdir: (name) ->
    newDir = new Directory(name,@curDir)
    @curDir.appendChild(newDir)
    console.log("Made dir #{name}")
    return

  mkfile: (name,size) ->
    newFile = new File(name,size)
    @curDir.appendChild(newFile)
    console.log("Made file #{name}")
    return

  dollarSign: (argsList) -> 
    [command,...args] = argsList
    switch command
      when 'cd' then @changeDirectory(...args)
      when 'ls' then @logList()

  @getter 'dirs', -> 
    if !@curDir
      return @_dirs 
    else 
      ret = {}
      if @curDir.hasParent
        ret['..'] = @curDir.parent
      @curDir.children.forEach (cur) -> 
        if cur instanceof Directory
          ret[cur.name] = cur
      ret
  
  changeDirectory: (dir) -> 
    @curDir = @dirs[dir]
    console.log("changed directory to #{dir}")
    return
  
  logList: () -> 
    console.log("logging #{@curDir.name}")
    console.log(@curDir.children)

  goHome: () -> 
    @curDir = @_dirs['/']








export {Terminal as default}