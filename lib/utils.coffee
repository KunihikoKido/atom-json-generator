module.exports =
  jsonlines: (data) ->
    if data instanceof Array
      items = (JSON.stringify(line) for line in data)
      return items.join("\n")
    return JSON.stringify(json)

  esBulk: (data) ->
    action = ""
    if data instanceof Array
      items = []
      for obj in data
        action = index: {}
        if obj._index?
          action.index._index = obj._index
          delete obj._index
        if obj._type?
          action.index._type = obj._type
          delete obj._type
        if obj._id?
          action.index._id = obj._id
          delete obj._id
        if obj._version?
          action.index._version = obj._version
          delete obj._version
        if obj._routing?
          action.index._routing = obj._routing
          delete obj._routing?
        if obj._parent
          action.index._parent = obj._parent
          delete obj._parent
        if obj._timestamp?
          action.index._timestamp = obj._timestamp
          delete obj._timestamp
        if obj._ttl?
          action.index._ttl = obj._ttl
          delete obj._ttl
        items.push(JSON.stringify(action))
        items.push(JSON.stringify(obj))
      return items.join("\n") + "\n"
    return JSON.stringify([data])
