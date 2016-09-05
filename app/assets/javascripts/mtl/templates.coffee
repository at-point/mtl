@MTL.templates = {}
@MTL.renderTemplate = (name, data) ->
  MTL.templates[name] = _.template(MTL.templates[name]) unless _.isFunction(MTL.templates[name])
  MTL.templates[name](data)
