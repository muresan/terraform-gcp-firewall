resource "google_compute_firewall" "rule" {
    name                    = var.name
    network                 = var.network
    project                 = var.project
    description             = var.description

    direction               = var.direction
    disabled                = var.disabled
    enable_logging          = var.enable_logging
    priority                = var.priority

    source_ranges           = var.source_ranges
    destination_ranges      = var.destination_ranges

    source_service_accounts = var.source_service_accounts    
    target_service_accounts = var.target_service_accounts

    source_tags             = var.source_tags
    target_tags             = var.target_tags

    dynamic "allow" {
        for_each = var.allow
        content {
            protocol = allow.value.protocol
            ports = allow.value.ports
        }
    }

    dynamic "deny" {
        for_each = var.deny
        content {
            protocol = deny.value.protocol
            ports = deny.value.ports
        }
    }
}

