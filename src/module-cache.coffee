Module = require 'module'
fs = require 'fs-plus'

nativeModules = process.binding('natives')

originalResolveFilename = Module._resolveFilename

# Precompute versions of all modules in node_modules
# Precompute the version each file is compatible

getCachedModulePath = (relative, parent) ->
  return unless relative
  return unless parent?.id

  return if relative[0] is '.'
  return if relative[relative.length - 1] is '/'
  return if fs.isAbsolute(relative)
  return if nativeModules.hasOwnProperty(relative)

  console.log "looking up #{relative} from #{parent.id}"

  undefined

Module._resolveFilename = (relative, parent) ->
  getCachedModulePath(relative, parent) ? originalResolveFilename(relative, parent)
