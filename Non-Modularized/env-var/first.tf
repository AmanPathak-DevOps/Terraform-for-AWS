variable "username" {
    type = string
}
output name {
    value = "Hello! ${var.username}"
}