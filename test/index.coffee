fs     = require 'node:fs/promises'
path   = require 'node:path'
test   = require 'node:test'
assert = require 'node:assert'


runDirectory = (dir, t) ->
  test "Testing directory: #{dir}", (t) ->
    for file from await fs.readdir dir when not dotFile file
      assert.notEqual file[0], '.'

      continue if file is path.basename __filename

      stats = await fs.stat fullPath = path.resolve __dirname, file

      if stats.isDirectory()
        await runDirectory fullPath, t
        continue

      if stats.isFile()
        await runFile fullPath, t
        continue

      console.warn "Ignoring non-file, non-directory '#{fullPath}'"

dotFile = (name) -> name[0] is '.'

runFile = (fullPath, t) ->
  t.test "Testing file: #{fullPath}", (t) ->
    testModule = require fullPath
    await testModule t

test 'Testing all', (t) ->
  runDirectory '.', t
