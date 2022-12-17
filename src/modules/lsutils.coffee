export curry$ = (f, bound) ->
  context = undefined

  _curry = (args) ->
    if f.length > 1 then (->
      params = if args then args.concat() else []
      context = if bound then context or this else this
      if params.push.apply(params, arguments) < f.length and arguments.length then _curry.call(context, params) else f.apply(context, params)
    ) else f

  _curry()
