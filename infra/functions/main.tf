provider "oci" {
  config_file_profile = "DEFAULT"
}

locals {
  current_date = formatdate("YYYY-MM-DD", timestamp())
}

resource "oci_core_vcn" "test_vcn" {
  compartment_id                   = var.compartment_id
  cidr_block                       = var.vcn_cidr_block
  cidr_blocks                      = var.vcn_cidr_blocks
  display_name                     = var.vcn_display_name
  dns_label                        = var.vcn_dns_label
  is_ipv6enabled                   = var.vcn_is_ipv6enabled
  ipv6private_cidr_blocks          = null
  is_oracle_gua_allocation_enabled = var.vcn_is_oracle_gua_allocation_enabled
  # defined_tags   = { "Operations.CostCenter" = "42" }
  freeform_tags = {}
  dynamic "byoipv6cidr_details" {
    for_each = var.configure_byoipv6 ? [1] : []
    content {
      byoipv6range_id = var.vcn_byoipv6cidr_details_id
      ipv6cidr_block  = var.vcn_byoipv6cidr_details_cidr_block
    }
  }
}

resource "oci_core_internet_gateway" "test_internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.test_vcn.id
  enabled        = var.internet_gateway_enabled
  display_name   = var.internet_gateway_display_name
  freeform_tags  = {}
  defined_tags   = {}
  # route_table_id = oci_core_default_route_table.test_route_table.id #Error: Cycle: oci_core_internet_gateway.test_internet_gateway, oci_core_default_route_table.test_route_table
}

resource "oci_core_default_route_table" "test_route_table" {
  compartment_id             = var.compartment_id
  manage_default_resource_id = oci_core_vcn.test_vcn.default_route_table_id
  display_name               = var.oci_core_default_route_table_display_name
  route_rules {
    network_entity_id = oci_core_internet_gateway.test_internet_gateway.id
    cidr_block        = var.vcn_route_table_cidr_block
    description       = var.vcn_route_table_route_rule_description
    destination       = var.route_rules_destination
    destination_type  = var.route_rules_destination_type
  }
  freeform_tags = {}
  defined_tags  = {}
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block                 = var.oci_core_subnet_cidr_block
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.test_vcn.id
  display_name               = var.oci_core_subnet_display_name
  prohibit_internet_ingress  = var.oci_core_subnet_prohibit_internet_ingress
  prohibit_public_ip_on_vnic = var.oci_core_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_default_route_table.test_route_table.id
  security_list_ids          = [oci_core_default_security_list.test_security_list.id]
  dhcp_options_id            = var.vcn_subnet_dhcp_options_id
  ipv6cidr_block             = var.vcn_subnet_ipv6cidr_block
  ipv6cidr_blocks            = null
  dns_label                  = var.vcn_subnet_dns_label
  availability_domain        = var.vcn_subnet_availability_domain
  freeform_tags              = { (var.free_form_tag_key) = (var.free_form_tag_value) }
  defined_tags               = {}
}

resource "oci_core_default_security_list" "test_security_list" {
  compartment_id             = var.compartment_id
  manage_default_resource_id = oci_core_vcn.test_vcn.default_security_list_id
  display_name               = var.security_list_display_name
  egress_security_rules {
    destination      = var.default_security_list_egress_destination
    protocol         = var.default_security_list_egress_protocol
    description      = var.default_security_list_egress_description
    destination_type = var.default_security_list_egress_destination_type
    stateless        = var.default_security_list_egress_stateless
  }

  ingress_security_rules {
    protocol    = var.default_security_list_ingress_potocol_tcp
    source      = var.default_security_list_ingress_source_tcp
    description = var.default_security_list_ingress_description_tcp
    icmp_options {
      type = var.default_security_list_ingress_icmp_options_type_tcp
      code = var.default_security_list_ingress_icmp_options_code_tcp
    }
    source_type = var.default_security_list_ingress_source_type_tcp
    stateless   = var.default_security_list_ingress_tcp_stateless
    tcp_options {
      max = var.default_security_list_ingress_tcp_options_destination_max_port_tcp
      min = var.default_security_list_ingress_tcp_options_destination_min_port_tcp
      source_port_range {
        max = var.default_security_list_ingress_tcp_options_source_max_port_tcp
        min = var.default_security_list_ingress_tcp_options_source_min_port_tcp
      }
    }
    dynamic "udp_options" {
      for_each = var.default_security_list_ingress_potocol_tcp != "6" ? [1] : []
      content {
        max = var.destination_port_max
        min = var.destination_port_min
        source_port_range {
          max = var.source_port_max
          min = var.source_port_min
        }
      }
    }
  }

  ingress_security_rules {
    protocol    = var.default_security_list_ingress_potocol_icmp
    source      = var.default_security_list_ingress_source_icmp
    description = var.default_security_list_ingress_description_icmp
    icmp_options {
      type = var.default_security_list_ingress_icmp_options_type_icmp
      code = var.default_security_list_ingress_icmp_options_code_icmp
    }
    source_type = var.default_security_list_ingress_source_type_icmp
    stateless   = var.default_security_list_ingress_icmp_stateless


    dynamic "tcp_options" {
      for_each = var.default_security_list_ingress_potocol_icmp != "1" ? [1] : []
      content {
        max = var.destination_port_max
        min = var.destination_port_min
        source_port_range {
          max = var.source_port_max
          min = var.source_port_min
        }
      }
    }

    dynamic "udp_options" {
      for_each = var.default_security_list_ingress_potocol_icmp != "1" ? [1] : []
      content {
        max = var.destination_port_max
        min = var.destination_port_min
        source_port_range {
          max = var.source_port_max
          min = var.source_port_min
        }
      }
    }

  }
}

resource "oci_identity_policy" "policy_for_function" {
  compartment_id = var.compartment_id
  description    = var.policy_description
  name           = var.policy_name
  statements     = var.policy_statement
  freeform_tags  = {}
  version_date   = local.current_date
  defined_tags   = {}
}

resource "oci_functions_application" "test_application" {
  compartment_id             = var.compartment_id
  display_name               = var.application_display_name
  subnet_ids                 = [oci_core_subnet.test_subnet.id]
  network_security_group_ids = null
  shape                      = var.application_shape
  syslog_url                 = var.function_syslog_url
  trace_config {
    domain_id  = var.trace_config_domain_id
    is_enabled = var.application_trace_config_enabled
  }
  image_policy_config {
    is_policy_enabled = var.application_image_policy_config_enabled

    # Optional
    dynamic "key_details" {
      for_each = var.kms_key_id ? [1] : []
      content {
        kms_key_id = var.function_kms_key_id
      }
    }
  }
  config        = {}
  freeform_tags = {}
  defined_tags  = {}
}

resource "oci_functions_function" "test_function" {
  application_id = oci_functions_application.test_application.id
  display_name   = var.function_display_name
  memory_in_mbs  = var.function_memory_in_mbs
  image          = "iad.ocir.io/idmaqhrbiuyo/kj-test:v1.1"
  image_digest   = var.function_image_digest
  provisioned_concurrency_config {
    strategy = var.provisioned_concurrency_config_strategy
    count    = var.provisioned_concurrency_config_count
  }
  timeout_in_seconds = var.function_timeout_in_seconds
  trace_config {
    is_enabled = var.trace_config_is_enabled
  }
  config        = {}
  freeform_tags = {}

  dynamic "source_details" {
    for_each = var.source_details ? [1] : []
    content {
      pbf_listing_id = var.function_pbf_listing_id
      source_type    = var.function_pbf_listing_id
    }
  }
  defined_tags = {}
}

resource "oci_functions_invoke_function" "test_invoke_function" {
  function_id           = oci_functions_function.test_function.id
  invoke_function_body  = var.invoke_function_body
  fn_intent             = var.fn_intent
  fn_invoke_type        = var.fn_invoke_type
  base64_encode_content = var.function_invoke_base64_encode_content
}








