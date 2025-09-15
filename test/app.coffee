fs     = require 'node:fs/promises'
path   = require 'node:path'
assert = require 'node:assert'

module.exports = (t) ->
  app    = require path.resolve __dirname, '..', 'app'
  server = app.listen serverPort()

  assert.equal typeof(server.close), 'function'

  new Promise (resolve, reject) ->
    server.close (result) ->
      if result instanceof Error
        return reject result

      resolve result

serverPort = -> 3000
