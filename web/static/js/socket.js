import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {guardian_token: window.guardianToken}})
socket.connect()

let channel = socket.channel(`rooms:${window.postID}`, {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

let commentBox = document.getElementById("comments");
let input = document.getElementById("input");
let submitBtn = document.getElementById("submit");

submitBtn.addEventListener("click", function(e){
  channel.push("new_comment", {body: input.value})
  input.value = ""
})

export default socket
