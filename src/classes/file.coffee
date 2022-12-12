Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}


class File 
    constructor: (@name,@_size) -> 

    @getter 'size', -> 
        if typeof @_size isnt Number
            @_size = Number(@_size)
        return @_size




export {File as default}