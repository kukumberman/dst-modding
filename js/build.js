require("dotenv").config()

const path = require("path")
const { build } = require("./utils.js")
const package = require("../package.json")

async function main() {
  const source = process.env.MOD_SOURCE_PATH
  const destination = path.join(process.env.GAME_MODS_FOLDER, package.name)

  await build(source, destination)
  console.log("Build!")
}

main()
