#@ts-check 

export treeSpan = (acc,height,colidx) -> 
  return acc + "<span class='tree' colidx='#{colidx}'>#{height}</span>"

export rowSpan = (rowidx,content) -> 
  return "<span class='row' rowidx='#{rowidx}'>#{content}</span>"

###*
 * @param {String} attr
 * @param {any} val
 * @param {String=} append
 * @returns {String}
###
export attributeQuery = (attr,val,append = "") -> 
  return "[#{attr}='#{val}'] " + append
