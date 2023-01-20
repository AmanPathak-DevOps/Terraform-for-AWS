variable "Names" {
    type = map
    default = {
        aman = 21
        aryan = 16
    }
}

variable "username" {
    type = string
}

output "mapping" {
    value = "Age of ${var.username}: ${lookup(var.Names,"${var.username}")}"
}