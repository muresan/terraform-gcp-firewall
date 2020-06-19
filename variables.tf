variable "name" {
    description = <<-DESCRIPTION
    (Required) Name of the resource. Provided by the client when the resource is created. The name must be 1-63
    characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters long and match the
    regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a lowercase letter,
    and all following characters must be a dash, lowercase letter, or digit, except the last character,
    which cannot be a dash.
    DESCRIPTION
    type = string
    # Required
}

variable "network" {
    description = "The name or self_link of the network to attach this firewall to."
    type = string
    # Required
}

variable "project" {
    description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default = null
}

variable "description" {
    description = "An optional description of this resource. Provide this property when you create the resource."
    default = "Managed by Terraform"
}

variable "direction" {
    description = <<-DESCRIPTION
    Direction of traffic to which this firewall applies; default is INGRESS. Note: For INGRESS traffic,
    it is NOT supported to specify destinationRanges; For EGRESS traffic, it is NOT supported to specify
    sourceRanges OR sourceTags
    DESCRIPTION
    type = string
    default = "INGRESS"
}

variable "disabled" {
    description = <<-DESCRIPTION
    Denotes whether the firewall rule is disabled, i.e not applied to the network it is associated with.
    When set to true, the firewall rule is not enforced and the network behaves as if it did not exist.
    If this is unspecified, the firewall rule will be enabled
    DESCRIPTION
    type = bool
    default = false
}

variable "enable_logging" {
    description = "This field denotes whether to enable logging for a particular firewall rule. If logging is enabled, logs will be exported to Stackdriver"
    type = bool
    default = false
}

variable "priority" {
    description = <<-DESCRIPTION
    Priority for this rule. This is an integer between 0 and 65535, both inclusive. When not specified, 
    the value assumed is 1000. Relative priorities determine precedence of conflicting rules. Lower value 
    of priority implies higher precedence (eg, a rule with priority 0 has higher precedence than a rule 
    with priority 1). DENY rules take precedence over ALLOW rules having equal priority
    DESCRIPTION
    type = number
    default = 1000
}

variable "source_ranges" {
    description = <<-DESCRIPTION
    If source ranges are specified, the firewall will apply only to traffic that has source IP address 
    in these ranges. These ranges must be expressed in CIDR format. One or both of sourceRanges and 
    sourceTags may be set. If both properties are set, the firewall will apply to traffic that has 
    source IP address within sourceRanges OR the source IP that belongs to a tag listed in the sourceTags 
    property. The connection does not need to match both properties for the firewall to apply. 
    Only IPv4 is supported.
    DESCRIPTION
    type = list(string)
    default = null
}

variable "source_service_accounts" {
    description = <<-DESCRIPTION
    If source service accounts are specified, the firewall will apply only to traffic originating from 
    an instance with a service account in this list. Source service accounts cannot be used to control 
    traffic to an instance's external IP address because service accounts are associated with an instance, 
    not an IP address. sourceRanges can be set at the same time as sourceServiceAccounts. If both are set, 
    the firewall will apply to traffic that has source IP address within sourceRanges OR the source IP 
    belongs to an instance with service account listed in sourceServiceAccount. The connection does not 
    need to match both properties for the firewall to apply. sourceServiceAccounts cannot be used at the 
    same time as sourceTags or targetTags.
    DESCRIPTION
    type = list(string)
    default = null
}

variable "source_tags" {
    description = <<-DESCRIPTION
    If source tags are specified, the firewall will apply only to traffic with source IP that belongs to 
    a tag listed in source tags. Source tags cannot be used to control traffic to an instance's external 
    IP address. Because tags are associated with an instance, not an IP address. One or both of sourceRanges 
    and sourceTags may be set. If both properties are set, the firewall will apply to traffic that has source 
    IP address within sourceRanges OR the source IP that belongs to a tag listed in the sourceTags property.
    The connection does not need to match both properties for the firewall to apply.
    DESCRIPTION
    type = list(string)
    default = null
}

variable "destination_ranges" {
    description = <<-DESCRIPTION
    If destination ranges are specified, the firewall will apply only to traffic that has destination IP 
    address in these ranges. These ranges must be expressed in CIDR format. Only IPv4 is supported.
    DESCRIPTION
    type = list(string)    
    default = null
}

variable "target_service_accounts" {
    description = <<-DESCRIPTION
    A list of service accounts indicating sets of instances located in the network that may make network 
    connections as specified in allowed[]. targetServiceAccounts cannot be used at the same time as targetTags 
    or sourceTags. If neither targetServiceAccounts nor targetTags are specified, the firewall rule applies 
    to all instances on the specified network.
    DESCRIPTION
    type = list(string)    
    default = null
}

variable "target_tags" {
    description = <<-DESCRIPTION
    A list of instance tags indicating sets of instances located in the network that may make network 
    connections as specified in allowed[]. If no targetTags are specified, the firewall rule applies 
    to all instances on the specified network.
    DESCRIPTION
    type = list(string)
    default = null
}

variable "allow" {
    description = <<-DESCRIPTION
    protocol - (Required) The IP protocol to which this rule applies. The protocol type is required 
    when creating a firewall rule. This value can either be one of the following well known protocol 
    strings (tcp, udp, icmp, esp, ah, sctp, ipip), or the IP protocol number.

    ports - (Optional) An optional list of ports to which this rule applies. This field is only 
    applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not 
    specified, this rule applies to connections through any port.
    DESCRIPTION
    type = list(object({
        protocol = string
        ports = list(string)
    }))
    default = []
}

variable "deny" {
    description = <<-DESCRIPTION
    protocol - (Required) The IP protocol to which this rule applies. The protocol type is required 
    when creating a firewall rule. This value can either be one of the following well known protocol 
    strings (tcp, udp, icmp, esp, ah, sctp, ipip), or the IP protocol number.

    ports - (Optional) An optional list of ports to which this rule applies. This field is only 
    applicable for UDP or TCP protocol. Each entry must be either an integer or a range. If not 
    specified, this rule applies to connections through any port.
    DESCRIPTION
    type = list(object({
        protocol = string
        ports = list(string)
    }))
    default = []
}