const fs = require("fs")
const copy = require("recursive-copy")

async function build(source, destination) {
  fs.rmSync(destination, {
    recursive: true,
    force: true
  })
  await copy(source, destination)
}

module.exports = {
  build
}
