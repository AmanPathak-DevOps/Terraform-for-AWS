variable players-name {
    type = list
    default = ["kunal","rohit","mrituanjay"]
}

output players {
    value = "Player Names are: ${var.players-name[0]}, ${var.players-name[2]}"
}