skipNth = (nth, cb) ->
  cntr = 0
  ->
    cb() unless cntr == nth
    cntr += 1

@MTL ?= {}
@MTL.onReady = (cb) ->
  $(document).on 'ready turbolinks:load', skipNth(1, cb)

@MTL.onTurbolinksLoad = (cb) ->
  $(document).on 'turbolinks:load', skipNth(0, cb)
