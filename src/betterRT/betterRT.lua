local console = require("console")
local ui = require("ui")
local win = ui.Window("server nuker 5000", 1, 1)
win:show()

console.writecolor("white", "[com.dootdev.test_channel] $ cn sit\n")
console.writecolor("white", "[com.dootdev.test_channel:sit] $ diagnose -subject:pid 885637 -treatment:pushcmd test kaspersky -target msmgr.exe\n")
console.writecolor("yellow", "[com.dootdev.test_channel:sit] > Pushing treatment to pipeline...\n")
console.writecolor("yellow", "[com.dootdev.test_channel:sit] > Importing \"binary::sequencerTest\"...\n")
console.writecolor("yellow", "[com.dootdev.test_channel:sit] > Flushing CLI...\n")
console.writecolor("yellow", "[com.dootdev.test_channel:sit] > Clearing parameters...\n")
console.writecolor("red", "[com.dootdev.test_channel:sit] > Pentesting pipe has returned: Malicious asset has been removed by process \"vnuke.exe\". Heuristic patterns logged.\n")

repeat ui.update() until not win.visible