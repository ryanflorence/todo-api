fs = require 'fs'

fs.readdirSync(__dirname).forEach (file) ->
  return if (file is 'index.coffee') or (file[0] is '.')
  moduleName = file.replace /.coffee$/, ''
  exports[moduleName] = require "./#{moduleName}"

