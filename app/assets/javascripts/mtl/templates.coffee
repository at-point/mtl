@MTL.templates = {}
@MTL.renderTemplate = (template, data) ->
  MTL.templates[template] = _.template(MTL.templates[template]) unless _.isFunction(MTL.templates[template])
  MTL.templates[template](data)
