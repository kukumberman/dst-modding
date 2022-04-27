require("dotenv").config()

const path = require("path")
const watch = require("node-watch")
const debounce = require("debounce")
const { build } = require("./utils.js")
const package = require("../package.json")

function main() {
  const source = process.env.MOD_SOURCE_PATH
  const destination = path.join(process.env.GAME_MODS_FOLDER, package.name)

  const fn = debounce(async () => {
    await build(source, destination)
    console.log("Build!")
  }, 1 * 1000)

  const watcher = watch(source, { recursive: true })

  watcher.on("ready", () => console.log("Waiting for changes.."))

  watcher.on("change", () => {
    fn()
  })

  watcher.on("error", (err) => {
    console.log(err)
  })
}

main()
