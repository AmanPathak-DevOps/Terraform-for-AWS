variable Name {
    type = map
    default = {
        aman = 21
        aryan = 16
    }
}
output static {
    value = "Age of Aman ${lookup(var.Name,"aman")}"
}
output static2 {
    value = "Age of Aryan ${lookup(var.Name,"aryan")}"
}