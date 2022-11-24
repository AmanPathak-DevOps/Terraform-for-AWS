variable Name {
    type = string
}
variable Name2 {
  type = string
}
output name {
    value = "${lower(var.Name)}"
}
output name2 {
    value = "${upper(var.Name2)}"
}