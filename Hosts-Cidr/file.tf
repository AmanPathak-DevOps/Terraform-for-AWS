variable hosts {
    type = number
}
output ipaddr {
    value = "Total IP's: ${cidrhost("10.12.112.16/20",var.hosts)}"
}