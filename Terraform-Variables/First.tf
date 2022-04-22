variable "name" {
    type =string
}
output name {
    value = "My Name is ${var.name}"
}