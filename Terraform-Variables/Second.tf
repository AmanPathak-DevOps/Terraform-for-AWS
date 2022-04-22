variable "Technology" {
    type = string
}
output technology_name {
    value = "There are some technology names which is: ${var.Technology}"
}