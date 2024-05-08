variable "compartment_id" {
  description = "Display name used for compartment"
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaafujaxb5oanlmpe4nuyzxjircz6cfm75pqp5b2cjqbri6de4qy7gq"
}

##################################################
# tags variables
##################################################

variable "free_form_tag_key" {
  description = "A free-form tag key that can be used to categorize resources. This key is customizable based on your tagging conventions."
  type        = string
  default     = "Department"
}

variable "free_form_tag_value" {
  description = "A free-form tag value associated with the specified tag key. This value provides additional information about the resource, such as its purpose."
  type        = string
  default     = "TRANSILITY"
}


##################################################
# application and functions variables
##################################################

variable "application_display_name" {
  description = "Display name for the application to be created."
  type        = string
  default     = "kj-application"
}

variable "application_shape" {
  description = "The shape to be used by the application."
  type        = string
  default     = "GENERIC_X86"
}

variable "function_display_name" {
  description = "Display name for the function to be created."
  type        = string
  default     = "kj-node-function"
}

variable "function_memory_in_mbs" {
  description = "Memory to be allotted to the function, specified in megabytes."
  type        = string
  default     = "512"
}

variable "provisioned_concurrency_config_strategy" {
  description = "The strategy to be used for provisioned concurrency configuration."
  type        = string
  default     = "NONE"
}

variable "provisioned_concurrency_config_count" {
  description = "The count of provisioned concurrency to be configured."
  type        = string
  default     = "0"
}

variable "function_timeout_in_seconds" {
  description = "The maximum time (in seconds) that the function is allowed to run."
  type        = string
  default     = "30"
}

variable "trace_config_is_enabled" {
  description = "Enable or disable trace configuration for the function."
  type        = bool
  default     = false
}

variable "invoke_function_body" {
  description = "The body content to be used when invoking the function."
  type        = string
  default     = ""
}

variable "fn_intent" {
  description = "The intent for the function, e.g., 'httprequest'."
  type        = string
  default     = "httprequest"
}

variable "fn_invoke_type" {
  description = "The type of function invocation, e.g., 'sync'."
  type        = string
  default     = "sync"
}

variable "function_invoke_base64_encode_content" {
  description = "Encode the content of function invocation in base64 format."
  type        = bool
  default     = false
}

variable "application_trace_config_enabled" {
  description = "Enable or disable trace configuration for the application."
  type        = bool
  default     = false
}

variable "application_image_policy_config_enabled" {
  description = "Enable or disable image policy configuration for the application."
  type        = bool
  default     = false
}

variable "function_syslog_url" {
  description = "The URL for syslog configuration for the function."
  type        = string
  default     = null
}

variable "trace_config_domain_id" {
  description = "The domain ID for trace configuration."
  type        = string
  default     = null
}

variable "function_kms_key_id" {
  description = "The KMS key ID to be used for the function."
  type        = string
  default     = null
}

variable "function_image_digest" {
  description = "The digest of the function image to be used."
  type        = string
  default     = null
}

variable "function_pbf_listing_id" {
  description = "The PBF (Policy Builder Framework) listing ID for the function."
  type        = string
  default     = null
}

variable "function_source_type" {
  description = "The source type for the function."
  type        = string
  default     = null
}

##################################################
# policy variables
##################################################

variable "policy_description" {
  description = "Description for the policy. Provide a meaningful description to explain the purpose or intent of this policy."
  type        = string
  default     = "kj-gateway-function-policy"
}

variable "policy_name" {
  description = "Name for the policy. Specify a unique and identifiable name for the policy."
  type        = string
  default     = "kj-gateway-function-policy"
}


variable "policy_statement" {
  description = "statements for the policy to be added"
  #   type        = string
  default = ["ALLOW any-user to use functions-family in compartment Transility-oci where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = 'ocid1.compartment.oc1..aaaaaaaafujaxb5oanlmpe4nuyzxjircz6cfm75pqp5b2cjqbri6de4qy7gq'}"]
}

##################################################
# vcn variables
##################################################
variable "vcn_cidr_blocks" {
  description = "The CIDR blocks for the VPC."
  default     = ["10.0.0.0/16"]
}

variable "vcn_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = null
}

variable "ipv6private_cidr_blocks" {
  description = "The CIDR blocks for IPv6 in the VPC."
  type        = string
  default     = null
}

variable "vcn_byoipv6cidr_details_id" {
  description = "The CIDR block details ID for BYOIPv6 in the VPC."
  type        = string
  default     = null
}

variable "vcn_byoipv6cidr_details_cidr_block" {
  description = "The CIDR block for BYOIPv6 in the VPC."
  type        = string
  default     = null
}

variable "vcn_route_table_cidr_block" {
  description = "The CIDR block for the route table in the VPC."
  type        = string
  default     = null
}

variable "vcn_route_table_route_rule_description" {
  description = "The route rule description for the route table in the VPC."
  type        = string
  default     = null
}

variable "vcn_subnet_dhcp_options_id" {
  description = "The DHCP options ID for the subnet in the VPC."
  type        = string
  default     = null
}

variable "vcn_subnet_ipv6cidr_block" {
  description = "The IPv6 CIDR block for the subnet in the VPC."
  type        = string
  default     = null
}

variable "vcn_core_subnet_ipv6cidr_blocks" {
  description = "The IPv6 CIDR blocks for the core subnet in the VPC."
  type        = string
  default     = null
}

variable "vcn_subnet_dns_label" {
  description = "The DNS label for the subnet in the VPC."
  type        = string
  default     = null
}

variable "vcn_subnet_availability_domain" {
  description = "The availability domain for the subnet in the VPC."
  type        = string
  default     = null
}

variable "vcn_is_oracle_gua_allocation_enabled" {
  description = "Enable or disable Oracle GUA (Global Unique Address) allocation in the VPC."
  type        = string
  default     = null
}

variable "vcn_display_name" {
  description = "Display name used for the VCN."
  type        = string
  default     = "kj-dev-vcn"
}

variable "vcn_is_ipv6enabled" {
  description = "Enable or disable IPv6 for the VCN."
  type        = bool
  default     = false
}

variable "destination_port_max" {
  description = "The maximum destination port number for traffic rules."
  type        = string
  default     = "65535"
}

variable "destination_port_min" {
  description = "The minimum destination port number for traffic rules."
  type        = string
  default     = "1"
}

variable "source_port_max" {
  description = "The maximum source port number for traffic rules."
  type        = string
  default     = "65535"
}

variable "source_port_min" {
  description = "The minimum source port number for traffic rules."
  type        = string
  default     = "1"
}

variable "vcn_dns_label" {
  description = "The DNS label for the VCN."
  type        = string
  default     = "vcn1"
}

variable "vcn_ipv6private_cidr_blocks" {
  description = "The IPv6 CIDR blocks for private traffic in the VCN."
  type        = list
  default     = []
}

variable "internet_gateway_enabled" {
  description = "Enable or disable the internet gateway in the VCN."
  type        = bool
  default     = true
}

variable "internet_gateway_display_name" {
  description = "Display name used for the internet gateway."
  type        = string
  default     = "kj-dev-igw"
}

variable "oci_core_default_route_table_display_name" {
  description = "Display name used for the default route table in the VCN."
  type        = string
  default     = "kj-dev-igw-route-table"
}

variable "route_rules_destination" {
  description = "The destination CIDR block for route rules in the VCN."
  type        = string
  default     = "0.0.0.0/0"
}

variable "route_rules_destination_type" {
  description = "The type of the destination CIDR block for route rules in the VCN."
  type        = string
  default     = "CIDR_BLOCK"
}

variable "security_list_display_name" {
  description = "Display name used for the security list in the VCN."
  type        = string
  default     = "kj-dev-security-list"
}

variable "oci_core_subnet_cidr_block" {
  description = "The CIDR block for the subnet in the VCN."
  type        = string
  default     = "10.0.0.0/24"
}

variable "oci_core_subnet_display_name" {
  description = "Display name used for the subnet in the VCN."
  type        = string
  default     = "kj-dev-public-subnet"
}

variable "oci_core_subnet_prohibit_internet_ingress" {
  description = "Prohibit internet ingress for the subnet in the VCN."
  type        = bool
  default     = false
}

variable "oci_core_subnet_prohibit_public_ip_on_vnic" {
  description = "Prohibit public IP on VNIC for the subnet in the VCN."
  type        = bool
  default     = false
}

variable "default_security_list_egress_destination" {
  description = "The destination CIDR block for egress traffic in the default security list."
  type        = string
  default     = "0.0.0.0/0"
}

variable "default_security_list_egress_protocol" {
  description = "The protocol for egress traffic in the default security list."
  type        = string
  default     = "all"
}

variable "default_security_list_egress_description" {
  description = "The description for egress traffic in the default security list."
  type        = string
  default     = "Allow all outgoing traffic to any destination."
}

variable "default_security_list_egress_destination_type" {
  description = "The type of the destination CIDR block for egress traffic in the default security list."
  type        = string
  default     = "CIDR_BLOCK"
}

variable "default_security_list_egress_stateless" {
  description = "Enable or disable stateless egress traffic in the default security list."
  type        = bool
  default     = false
}

variable "default_security_list_ingress_potocol_tcp" {
  description = "The protocol number for TCP traffic in the default security list ingress rules."
  type        = string
  default     = 6
}

variable "default_security_list_ingress_source_tcp" {
  description = "The source CIDR block for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "0.0.0.0/0"
}

variable "default_security_list_ingress_description_tcp" {
  description = "Description for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "Allowing ingress to all via TCP on port 443"
}

variable "default_security_list_ingress_icmp_options_type_tcp" {
  description = "ICMP type for TCP traffic in the default security list ingress rules."
  type        = string
  default     = 3
}

variable "default_security_list_ingress_icmp_options_code_tcp" {
  description = "ICMP code for TCP traffic in the default security list ingress rules."
  type        = string
  default     = 4
}

variable "default_security_list_ingress_source_type_tcp" {
  description = "Source type for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "CIDR_BLOCK"
}

variable "default_security_list_ingress_tcp_options_destination_max_port_tcp" {
  description = "The maximum destination port for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "443"
}

variable "default_security_list_ingress_tcp_options_destination_min_port_tcp" {
  description = "The minimum destination port for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "443"
}

variable "default_security_list_ingress_tcp_options_source_min_port_tcp" {
  description = "The minimum source port for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "1"
}

variable "default_security_list_ingress_tcp_options_source_max_port_tcp" {
  description = "The maximum source port for TCP traffic in the default security list ingress rules."
  type        = string
  default     = "65535"
}

variable "default_security_list_ingress_tcp_stateless" {
  description = "Enable or disable stateless handling for TCP traffic in the default security list ingress rules."
  type        = bool
  default     = false
}

variable "default_security_list_ingress_potocol_icmp" {
  description = "The protocol number for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = 1
}

variable "default_security_list_ingress_source_icmp" {
  description = "The source CIDR block for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "0.0.0.0/0"
}

variable "default_security_list_ingress_description_icmp" {
  description = "Description for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "Allowing ingress to all via ICMP"
}

variable "default_security_list_ingress_icmp_options_type_icmp" {
  description = "ICMP type for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = 3
}

variable "default_security_list_ingress_icmp_options_code_icmp" {
  description = "ICMP code for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = 4
}

variable "default_security_list_ingress_source_type_icmp" {
  description = "Source type for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "CIDR_BLOCK"
}

variable "default_security_list_ingress_tcp_options_destination_max_port_icmp" {
  description = "The maximum destination port for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "443"
}

variable "default_security_list_ingress_tcp_options_destination_min_port_icmp" {
  description = "The minimum destination port for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "443"
}

variable "default_security_list_ingress_tcp_options_source_min_port_icmp" {
  description = "The minimum source port for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "1"
}

variable "default_security_list_ingress_tcp_options_source_max_port_icmp" {
  description = "The maximum source port for ICMP traffic in the default security list ingress rules."
  type        = string
  default     = "65535"
}

variable "default_security_list_ingress_icmp_stateless" {
  description = "Enable or disable stateless handling for ICMP traffic in the default security list ingress rules."
  type        = bool
  default     = false
}

##################################################
# dynamic blocks
##################################################

variable "configure_byoipv6" {
  description = "Set this variable to true if you want to configure BYOIPv6 (Bring Your Own IPv6) for the resource."
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The ID of the Key Management Service (KMS) key to be used for encryption."
  type        = bool
  default     = false
}

variable "source_details" {
  description = "Provide additional details or configuration for the data source."
  type        = bool
  default     = false
}








