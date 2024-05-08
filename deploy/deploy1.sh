for i in $@
do
var=$(echo $i | cut -f1 -d =)
declare $var=$(echo $i | cut -f2- -d =)
done

[[ -z "$env" ]] && echo "Environment is Required" && exit 1
[[ -z "$file" ]] && echo "JSON Configurations file is Required" && exit 1
[[ -z "$mode" ]] && echo "Terraform backend mode is Required" && exit 1

echo mode : $mode
if [ "$mode" == "cicd" ];
then
    [[ -z "$tf_http_address" ]] && echo "Terraform Remote Backend Address is Required" && exit 1
    [[ -z "$tf_http_lock_address" ]] && echo "Terraform Remote Backend Lock Address is Required" && exit 1
    [[ -z "$tf_http_unlock_address" ]] && echo "Terraform Remote Backend Unlock Address is Required" && exit 1
    [[ -z "$tf_http_username" ]] && echo "Terraform Remote Backend Username is Required" && exit 1
    [[ -z "$tf_http_password" ]] && echo "Terraform Remote Backend Password is Required" && exit 1

    echo "Setting Terraform HTTP backend environment variables..."
    export TF_HTTP_ADDRESS=$tf_http_address/$env
    export TF_HTTP_LOCK_ADDRESS=$tf_http_lock_address/$env
    export TF_HTTP_UNLOCK_ADDRESS=$tf_http_unlock_address/$env
    export TF_HTTP_USERNAME=$tf_http_username
    export TF_HTTP_PASSWORD=$tf_http_password
fi

declare -A arr
while IFS== read key value; do
 printf -v "$key" "$value"  
 arr[$key]=$key
done < <(jq 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' $file | sed -e 's/^"//' -e 's/"$//')
envObj=${arr[$env]}
while IFS== read key value; do
 printf -v "$key" "%s" "$value"
done < <(jq 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' <<< ${!envObj} | sed -e 's/^"//' -e 's/"$//')


[[ -z "$compartment_id" ]] && compartment_id="ocid1.compartment.oc1..aaaaaaaafujaxb5oanlmpe4nuyzxjircz6cfm75pqp5b2cjqbri6de4qy7gq"

[[ -z "$free_form_tag_key" ]] && free_form_tag_key="Department"
[[ -z "$free_form_tag_value" ]] && free_form_tag_value="TRANSILITY"

[[ -z "$application_display_name" ]] && application_display_name="kj-application"
[[ -z "$application_shape" ]] && application_shape="GENERIC_X86"
[[ -z "$function_display_name" ]] && function_display_name="kj-node-function"
[[ -z "$function_memory_in_mbs" ]] && function_memory_in_mbs="512"
[[ -z "$provisioned_concurrency_config_strategy" ]] && provisioned_concurrency_config_strategy="NONE"
[[ -z "$provisioned_concurrency_config_count" ]] && provisioned_concurrency_config_count="0"
[[ -z "$function_timeout_in_seconds" ]] && function_timeout_in_seconds="30"
[[ -z "$trace_config_is_enabled" ]] && trace_config_is_enabled=false
[[ -z "$invoke_function_body" ]] && invoke_function_body=""
[[ -z "$fn_intent" ]] && fn_intent="httprequest"
[[ -z "$fn_invoke_type" ]] && fn_invoke_type="sync"
[[ -z "$function_invoke_base64_encode_content" ]] && function_invoke_base64_encode_content=false
[[ -z "$application_trace_config_enabled" ]] && application_trace_config_enabled=false
[[ -z "$application_image_policy_config_enabled" ]] && application_image_policy_config_enabled=false
[[ -z "$function_syslog_url" ]] && function_syslog_url=null
[[ -z "$trace_config_domain_id" ]] && trace_config_domain_id=null
[[ -z "$function_kms_key_id" ]] && function_kms_key_id=null
[[ -z "$function_image_digest" ]] && function_image_digest=null
[[ -z "$function_pbf_listing_id" ]] && function_pbf_listing_id=null
[[ -z "$function_source_type" ]] && function_source_type=null

[[ -z "$policy_description" ]] && policy_description="kj-gateway-function-policy"
[[ -z "$policy_name" ]] && policy_name="kj-gateway-function-policy"
[[ -z "$policy_statement" ]] && policy_statement='["ALLOW any-user to use functions-family in compartment Transility-oci where ALL {request.principal.type= '\''ApiGateway'\'', request.resource.compartment.id = '\''ocid1.compartment.oc1..aaaaaaaafujaxb5oanlmpe4nuyzxjircz6cfm75pqp5b2cjqbri6de4qy7gq'\''}"]'

[[ -z "$vcn_cidr_blocks" ]] && vcn_cidr_blocks='["10.0.0.0/16"]'
[[ -z "$vcn_cidr_block" ]] && vcn_cidr_block=null
[[ -z "$ipv6private_cidr_blocks" ]] && ipv6private_cidr_blocks=null
[[ -z "$vcn_byoipv6cidr_details_id" ]] && vcn_byoipv6cidr_details_id=null
[[ -z "$vcn_byoipv6cidr_details_cidr_block" ]] && vcn_byoipv6cidr_details_cidr_block=null
[[ -z "$vcn_route_table_cidr_block" ]] && vcn_route_table_cidr_block=null
[[ -z "$vcn_route_table_route_rule_description" ]] && vcn_route_table_route_rule_description=null
[[ -z "$vcn_subnet_dhcp_options_id" ]] && vcn_subnet_dhcp_options_id=null
[[ -z "$vcn_subnet_ipv6cidr_block" ]] && vcn_subnet_ipv6cidr_block=null
[[ -z "$vcn_core_subnet_ipv6cidr_blocks" ]] && vcn_core_subnet_ipv6cidr_blocks=null
[[ -z "$vcn_subnet_dns_label" ]] && vcn_subnet_dns_label=null
[[ -z "$vcn_subnet_availability_domain" ]] && vcn_subnet_availability_domain=null
[[ -z "$vcn_is_oracle_gua_allocation_enabled" ]] && vcn_is_oracle_gua_allocation_enabled=null
[[ -z "$vcn_display_name" ]] && vcn_display_name="kj-dev-vcn"
[[ -z "$vcn_is_ipv6enabled" ]] && vcn_is_ipv6enabled=false
[[ -z "$destination_port_max" ]] && destination_port_max="65535"
[[ -z "$destination_port_min" ]] && destination_port_min="1"
[[ -z "$source_port_max" ]] && source_port_max="65535"
[[ -z "$source_port_min" ]] && source_port_min="1"
[[ -z "$vcn_dns_label" ]] && vcn_dns_label="vcn1"
[[ -z "$vcn_ipv6private_cidr_blocks" ]] && vcn_ipv6private_cidr_blocks='[]'
[[ -z "$internet_gateway_enabled" ]] && internet_gateway_enabled=true
[[ -z "$internet_gateway_display_name" ]] && internet_gateway_display_name="kj-dev-igw"
[[ -z "$oci_core_default_route_table_display_name" ]] && oci_core_default_route_table_display_name="kj-dev-igw-route-table"
[[ -z "$route_rules_destination" ]] && route_rules_destination="0.0.0.0/0"
[[ -z "$route_rules_destination_type" ]] && route_rules_destination_type="CIDR_BLOCK"
[[ -z "$security_list_display_name" ]] && security_list_display_name="kj-dev-security-list"
[[ -z "$oci_core_subnet_cidr_block" ]] && oci_core_subnet_cidr_block="10.0.0.0/24"
[[ -z "$oci_core_subnet_display_name" ]] && oci_core_subnet_display_name="kj-dev-public-subnet"
[[ -z "$oci_core_subnet_prohibit_internet_ingress" ]] && oci_core_subnet_prohibit_internet_ingress=false
[[ -z "$oci_core_subnet_prohibit_public_ip_on_vnic" ]] && oci_core_subnet_prohibit_public_ip_on_vnic=false
[[ -z "$default_security_list_egress_destination" ]] && default_security_list_egress_destination="0.0.0.0/0"
[[ -z "$default_security_list_egress_protocol" ]] && default_security_list_egress_protocol="all"
[[ -z "$default_security_list_egress_description" ]] && default_security_list_egress_description="Allow all outgoing traffic to any destination."
[[ -z "$default_security_list_egress_destination_type" ]] && default_security_list_egress_destination_type="CIDR_BLOCK"
[[ -z "$default_security_list_egress_stateless" ]] && default_security_list_egress_stateless=false
[[ -z "$default_security_list_ingress_potocol_tcp" ]] && default_security_list_ingress_potocol_tcp="6"
[[ -z "$default_security_list_ingress_source_tcp" ]] && default_security_list_ingress_source_tcp="0.0.0.0/0"
[[ -z "$default_security_list_ingress_description_tcp" ]] && default_security_list_ingress_description_tcp="Allowing ingress to all via TCP on port 443"
[[ -z "$default_security_list_ingress_icmp_options_type_tcp" ]] && default_security_list_ingress_icmp_options_type_tcp="3"
[[ -z "$default_security_list_ingress_icmp_options_code_tcp" ]] && default_security_list_ingress_icmp_options_code_tcp="4"
[[ -z "$default_security_list_ingress_source_type_tcp" ]] && default_security_list_ingress_source_type_tcp="CIDR_BLOCK"
[[ -z "$default_security_list_ingress_tcp_options_destination_max_port_tcp" ]] && default_security_list_ingress_tcp_options_destination_max_port_tcp="443"
[[ -z "$default_security_list_ingress_tcp_options_destination_min_port_tcp" ]] && default_security_list_ingress_tcp_options_destination_min_port_tcp="443"
[[ -z "$default_security_list_ingress_tcp_options_source_min_port_tcp" ]] && default_security_list_ingress_tcp_options_source_min_port_tcp="1"
[[ -z "$default_security_list_ingress_tcp_options_source_max_port_tcp" ]] && default_security_list_ingress_tcp_options_source_max_port_tcp="65535"
[[ -z "$default_security_list_ingress_tcp_stateless" ]] && default_security_list_ingress_tcp_stateless=false
[[ -z "$default_security_list_ingress_potocol_icmp" ]] && default_security_list_ingress_potocol_icmp="1"
[[ -z "$default_security_list_ingress_source_icmp" ]] && default_security_list_ingress_source_icmp="0.0.0.0/0"
[[ -z "$default_security_list_ingress_description_icmp" ]] && default_security_list_ingress_description_icmp="Allowing ingress to all via ICMP"
[[ -z "$default_security_list_ingress_icmp_options_type_icmp" ]] && default_security_list_ingress_icmp_options_type_icmp="3"
[[ -z "$default_security_list_ingress_icmp_options_code_icmp" ]] && default_security_list_ingress_icmp_options_code_icmp="4"
[[ -z "$default_security_list_ingress_source_type_icmp" ]] && default_security_list_ingress_source_type_icmp="CIDR_BLOCK"
[[ -z "$default_security_list_ingress_tcp_options_destination_max_port_icmp" ]] && default_security_list_ingress_tcp_options_destination_max_port_icmp="443"
[[ -z "$default_security_list_ingress_tcp_options_destination_min_port_icmp" ]] && default_security_list_ingress_tcp_options_destination_min_port_icmp="443"
[[ -z "$default_security_list_ingress_tcp_options_source_min_port_icmp" ]] && default_security_list_ingress_tcp_options_source_min_port_icmp="1"
[[ -z "$default_security_list_ingress_tcp_options_source_max_port_icmp" ]] && default_security_list_ingress_tcp_options_source_max_port_icmp="65535"
[[ -z "$default_security_list_ingress_icmp_stateless" ]] && default_security_list_ingress_icmp_stateless=false

[[ -z "$configure_byoipv6" ]] && configure_byoipv6=false
[[ -z "$kms_key_id" ]] && kms_key_id=false
[[ -z "$source_details" ]] && source_details=false
[[ -z "$oci_artifacts_container_repository_display_name" ]] && oci_artifacts_container_repository_display_name="kj-test"
[[ -z "$oci_artifacts_container_repository_is_public" ]] && oci_artifacts_container_repository_is_public=false
[[ -z "$oci_artifacts_container_repository_is_immutable" ]] && oci_artifacts_container_repository_is_immutable=false
[[ -z "$oci_artifacts_container_repository_readme_content" ]] && oci_artifacts_container_repository_readme_content="kj-test-registry"
[[ -z "$oci_artifacts_container_repository_readme_format" ]] && oci_artifacts_container_repository_readme_format="text/plain"

echo "Following values will be used for deployment..."
echo compartment_id: $compartment_id
echo free_form_tag_key: $free_form_tag_key
echo free_form_tag_value: $free_form_tag_value
echo application_display_name: $application_display_name
echo application_shape: $application_shape
echo function_display_name: $function_display_name
echo function_memory_in_mbs: $function_memory_in_mbs
echo provisioned_concurrency_config_strategy: $provisioned_concurrency_config_strategy
echo provisioned_concurrency_config_count: $provisioned_concurrency_config_count
echo function_timeout_in_seconds: $function_timeout_in_seconds
echo trace_config_is_enabled: $trace_config_is_enabled
echo invoke_function_body: $invoke_function_body
echo fn_intent: $fn_intent
echo fn_invoke_type: $fn_invoke_type
echo function_invoke_base64_encode_content: $function_invoke_base64_encode_content
echo application_trace_config_enabled: $application_trace_config_enabled
echo application_image_policy_config_enabled: $application_image_policy_config_enabled
echo function_syslog_url: $function_syslog_url
echo trace_config_domain_id: $trace_config_domain_id
echo function_kms_key_id: $function_kms_key_id
echo function_image_digest: $function_image_digest
echo function_pbf_listing_id: $function_pbf_listing_id
echo function_source_type: $function_source_type
echo policy_description: $policy_description
echo policy_name: $policy_name
echo policy_statement: $policy_statement
echo vcn_cidr_blocks: $vcn_cidr_blocks
echo vcn_display_name: $vcn_display_name
echo vcn_is_ipv6enabled: $vcn_is_ipv6enabled
echo destination_port_max: $destination_port_max
echo destination_port_min: $destination_port_min
echo source_port_max: $source_port_max
echo source_port_min: $source_port_min
echo vcn_dns_label: $vcn_dns_label
echo internet_gateway_enabled: $internet_gateway_enabled
echo internet_gateway_display_name: $internet_gateway_display_name
echo oci_core_default_route_table_display_name: $oci_core_default_route_table_display_name
echo route_rules_destination: $route_rules_destination
echo route_rules_destination_type: $route_rules_destination_type
echo security_list_display_name: $security_list_display_name
echo oci_core_subnet_cidr_block: $oci_core_subnet_cidr_block
echo oci_core_subnet_display_name: $oci_core_subnet_display_name
echo oci_core_subnet_prohibit_internet_ingress: $oci_core_subnet_prohibit_internet_ingress
echo oci_core_subnet_prohibit_public_ip_on_vnic: $oci_core_subnet_prohibit_public_ip_on_vnic
echo default_security_list_egress_destination: $default_security_list_egress_destination
echo default_security_list_egress_protocol: $default_security_list_egress_protocol
echo default_security_list_egress_description: $default_security_list_egress_description
echo default_security_list_egress_destination_type: $default_security_list_egress_destination_type
echo default_security_list_egress_stateless: $default_security_list_egress_stateless
echo default_security_list_ingress_potocol_tcp: $default_security_list_ingress_potocol_tcp
echo default_security_list_ingress_source_tcp: $default_security_list_ingress_source_tcp
echo default_security_list_ingress_description_tcp: $default_security_list_ingress_description_tcp
echo default_security_list_ingress_icmp_options_type_tcp: $default_security_list_ingress_icmp_options_type_tcp
echo default_security_list_ingress_icmp_options_code_tcp: $default_security_list_ingress_icmp_options_code_tcp
echo default_security_list_ingress_source_type_tcp: $default_security_list_ingress_source_type_tcp
echo default_security_list_ingress_tcp_options_destination_max_port_tcp: $default_security_list_ingress_tcp_options_destination_max_port_tcp
echo default_security_list_ingress_tcp_options_destination_min_port_tcp: $default_security_list_ingress_tcp_options_destination_min_port_tcp
echo default_security_list_ingress_tcp_options_source_min_port_tcp: $default_security_list_ingress_tcp_options_source_min_port_tcp
echo default_security_list_ingress_tcp_options_source_max_port_tcp: $default_security_list_ingress_tcp_options_source_max_port_tcp
echo default_security_list_ingress_tcp_stateless: $default_security_list_ingress_tcp_stateless
echo default_security_list_ingress_potocol_icmp: $default_security_list_ingress_potocol_icmp
echo default_security_list_ingress_source_icmp: $default_security_list_ingress_source_icmp
echo default_security_list_ingress_description_icmp: $default_security_list_ingress_description_icmp
echo default_security_list_ingress_icmp_options_type_icmp: $default_security_list_ingress_icmp_options_type_icmp
echo default_security_list_ingress_icmp_options_code_icmp: $default_security_list_ingress_icmp_options_code_icmp
echo default_security_list_ingress_source_type_icmp: $default_security_list_ingress_source_type_icmp
echo default_security_list_ingress_tcp_options_destination_max_port_icmp: $default_security_list_ingress_tcp_options_destination_max_port_icmp
echo default_security_list_ingress_tcp_options_destination_min_port_icmp: $default_security_list_ingress_tcp_options_destination_min_port_icmp
echo default_security_list_ingress_tcp_options_source_min_port_icmp: $default_security_list_ingress_tcp_options_source_min_port_icmp
echo default_security_list_ingress_tcp_options_source_max_port_icmp: $default_security_list_ingress_tcp_options_source_max_port_icmp
echo default_security_list_ingress_icmp_stateless: $default_security_list_ingress_icmp_stateless
echo configure_byoipv6: $configure_byoipv6
echo kms_key_id: $kms_key_id
echo source_details: $source_details
echo oci_artifacts_container_repository_display_name: $oci_artifacts_container_repository_display_name
echo oci_artifacts_container_repository_is_public: $oci_artifacts_container_repository_is_public
echo oci_artifacts_container_repository_is_immutable: $oci_artifacts_container_repository_is_immutable
echo oci_artifacts_container_repository_readme_content: $oci_artifacts_container_repository_readme_content
echo oci_artifacts_container_repository_readme_format: $oci_artifacts_container_repository_readme_format
echo vcn_byoipv6cidr_details_id: $vcn_byoipv6cidr_details_id
echo vcn_byoipv6cidr_details_cidr_block: $vcn_byoipv6cidr_details_cidr_block
echo vcn_route_table_cidr_block: $vcn_route_table_cidr_block
echo vcn_route_table_route_rule_description: $vcn_route_table_route_rule_description
echo vcn_subnet_dhcp_options_id: $vcn_subnet_dhcp_options_id
echo vcn_subnet_ipv6cidr_block: $vcn_subnet_ipv6cidr_block
echo vcn_core_subnet_ipv6cidr_blocks: $vcn_core_subnet_ipv6cidr_blocks
echo vcn_subnet_dns_label: $vcn_subnet_dns_label
echo vcn_subnet_availability_domain: $vcn_subnet_availability_domain
echo vcn_is_oracle_gua_allocation_enabled: $vcn_is_oracle_gua_allocation_enabled
echo vcn_ipv6private_cidr_blocks: $vcn_ipv6private_cidr_blocks


cd infra
cd registry

terraform init -reconfigure

terraform apply \
    -var oci_artifacts_container_repository_display_name="$oci_artifacts_container_repository_display_name" \
    -var oci_artifacts_container_repository_is_public="$oci_artifacts_container_repository_is_public" \
    -var oci_artifacts_container_repository_is_immutable="$oci_artifacts_container_repository_is_immutable" \
    -var oci_artifacts_container_repository_readme_content="$oci_artifacts_container_repository_readme_content" \
    -var oci_artifacts_container_repository_readme_format="$oci_artifacts_container_repository_readme_format" \
    -var="free_form_tag_key=$free_form_tag_key" \
    -var="free_form_tag_value=$free_form_tag_value" \
    -var="compartment_id=$compartment_id" \
    -auto-approve

cd ../app

# Build the Docker image and capture the image ID
IMAGE_ID=$(docker build -q -t nodeslocal:v1.1 .)


# Tag the image with the desired repository and version
docker tag $IMAGE_ID iad.ocir.io/idmaqhrbiuyo/$oci_artifacts_container_repository_display_name:v1.1

# Push the tagged image to the repository
docker push iad.ocir.io/idmaqhrbiuyo/$oci_artifacts_container_repository_display_name:v1.1

echo "docker image pushed"

echo "Provisioning resources- vcn,application,function,policy and invoke endpoint"
cd ../infra/functions

terraform init -reconfigure
terraform apply \
  -var="compartment_id=$compartment_id" \
  -var="free_form_tag_key=$free_form_tag_key" \
  -var="free_form_tag_value=$free_form_tag_value" \
  -var="application_display_name=$application_display_name" \
  -var="application_shape=$application_shape" \
  -var="function_display_name=$function_display_name" \
  -var="function_memory_in_mbs=$function_memory_in_mbs" \
  -var="provisioned_concurrency_config_strategy=$provisioned_concurrency_config_strategy" \
  -var="provisioned_concurrency_config_count=$provisioned_concurrency_config_count" \
  -var="function_timeout_in_seconds=$function_timeout_in_seconds" \
  -var="trace_config_is_enabled=$trace_config_is_enabled" \
  -var="invoke_function_body=$invoke_function_body" \
  -var="fn_intent=$fn_intent" \
  -var="fn_invoke_type=$fn_invoke_type" \
  -var="function_invoke_base64_encode_content=$function_invoke_base64_encode_content" \
  -var="application_trace_config_enabled=$application_trace_config_enabled" \
  -var="application_image_policy_config_enabled=$application_image_policy_config_enabled" \
  -var="function_syslog_url=$function_syslog_url" \
  -var="trace_config_domain_id=$trace_config_domain_id" \
  -var="function_kms_key_id=$function_kms_key_id" \
  -var="function_image_digest=$function_image_digest" \
  -var="function_pbf_listing_id=$function_pbf_listing_id" \
  -var="function_source_type=$function_source_type" \
  -var="policy_description=$policy_description" \
  -var="policy_name=$policy_name" \
  -var="policy_statement=$policy_statement" \
  -var="vcn_cidr_blocks=$vcn_cidr_blocks" \
  -var="vcn_display_name=$vcn_display_name" \
  -var="vcn_is_ipv6enabled=$vcn_is_ipv6enabled" \
  -var="destination_port_max=$destination_port_max" \
  -var="destination_port_min=$destination_port_min" \
  -var="source_port_max=$source_port_max" \
  -var="source_port_min=$source_port_min" \
  -var="vcn_dns_label=$vcn_dns_label" \
  -var="internet_gateway_enabled=$internet_gateway_enabled" \
  -var="internet_gateway_display_name=$internet_gateway_display_name" \
  -var="oci_core_default_route_table_display_name=$oci_core_default_route_table_display_name" \
  -var="route_rules_destination=$route_rules_destination" \
  -var="route_rules_destination_type=$route_rules_destination_type" \
  -var="security_list_display_name=$security_list_display_name" \
  -var="oci_core_subnet_cidr_block=$oci_core_subnet_cidr_block" \
  -var="oci_core_subnet_display_name=$oci_core_subnet_display_name" \
  -var="oci_core_subnet_prohibit_internet_ingress=$oci_core_subnet_prohibit_internet_ingress" \
  -var="oci_core_subnet_prohibit_public_ip_on_vnic=$oci_core_subnet_prohibit_public_ip_on_vnic" \
  -var="default_security_list_egress_destination=$default_security_list_egress_destination" \
  -var="default_security_list_egress_protocol=$default_security_list_egress_protocol" \
  -var="default_security_list_egress_description=$default_security_list_egress_description" \
  -var="default_security_list_egress_destination_type=$default_security_list_egress_destination_type" \
  -var="default_security_list_egress_stateless=$default_security_list_egress_stateless" \
  -var="default_security_list_ingress_potocol_tcp=$default_security_list_ingress_potocol_tcp" \
  -var="default_security_list_ingress_source_tcp=$default_security_list_ingress_source_tcp" \
  -var="default_security_list_ingress_description_tcp=$default_security_list_ingress_description_tcp" \
  -var="default_security_list_ingress_icmp_options_type_tcp=$default_security_list_ingress_icmp_options_type_tcp" \
  -var="default_security_list_ingress_icmp_options_code_tcp=$default_security_list_ingress_icmp_options_code_tcp" \
  -var="default_security_list_ingress_source_type_tcp=$default_security_list_ingress_source_type_tcp" \
  -var="default_security_list_ingress_tcp_options_destination_max_port_tcp=$default_security_list_ingress_tcp_options_destination_max_port_tcp" \
  -var="default_security_list_ingress_tcp_options_destination_min_port_tcp=$default_security_list_ingress_tcp_options_destination_min_port_tcp" \
  -var="default_security_list_ingress_tcp_options_source_min_port_tcp=$default_security_list_ingress_tcp_options_source_min_port_tcp" \
  -var="default_security_list_ingress_tcp_options_source_max_port_tcp=$default_security_list_ingress_tcp_options_source_max_port_tcp" \
  -var="default_security_list_ingress_tcp_stateless=$default_security_list_ingress_tcp_stateless" \
  -var="default_security_list_ingress_potocol_icmp=$default_security_list_ingress_potocol_icmp" \
  -var="default_security_list_ingress_source_icmp=$default_security_list_ingress_source_icmp" \
  -var="default_security_list_ingress_description_icmp=$default_security_list_ingress_description_icmp" \
  -var="default_security_list_ingress_icmp_options_type_icmp=$default_security_list_ingress_icmp_options_type_icmp" \
  -var="default_security_list_ingress_icmp_options_code_icmp=$default_security_list_ingress_icmp_options_code_icmp" \
  -var="default_security_list_ingress_source_type_icmp=$default_security_list_ingress_source_type_icmp" \
  -var="default_security_list_ingress_tcp_options_destination_max_port_icmp=$default_security_list_ingress_tcp_options_destination_max_port_icmp" \
  -var="default_security_list_ingress_tcp_options_destination_min_port_icmp=$default_security_list_ingress_tcp_options_destination_min_port_icmp" \
  -var="default_security_list_ingress_tcp_options_source_min_port_icmp=$default_security_list_ingress_tcp_options_source_min_port_icmp" \
  -var="default_security_list_ingress_tcp_options_source_max_port_icmp=$default_security_list_ingress_tcp_options_source_max_port_icmp" \
  -var="default_security_list_ingress_icmp_stateless=$default_security_list_ingress_icmp_stateless" \
  -var="configure_byoipv6=$configure_byoipv6" \
  -var="kms_key_id=$kms_key_id" \
  -var="source_details=$source_details" \
  -var="vcn_byoipv6cidr_details_id=$vcn_byoipv6cidr_details_id" \
  -var="vcn_byoipv6cidr_details_cidr_block=$vcn_byoipv6cidr_details_cidr_block" \
  -var="vcn_route_table_cidr_block=$vcn_route_table_cidr_block" \
  -var="vcn_route_table_route_rule_description=$vcn_route_table_route_rule_description" \
  -var="vcn_subnet_dhcp_options_id=$vcn_subnet_dhcp_options_id" \
  -var="vcn_subnet_ipv6cidr_block=$vcn_subnet_ipv6cidr_block" \
  -var="vcn_core_subnet_ipv6cidr_blocks=$vcn_core_subnet_ipv6cidr_blocks" \
  -var="vcn_subnet_dns_label=$vcn_subnet_dns_label" \
  -var="vcn_subnet_availability_domain=$vcn_subnet_availability_domain" \
  -var="vcn_is_oracle_gua_allocation_enabled=$vcn_is_oracle_gua_allocation_enabled" \
  -var="vcn_ipv6private_cidr_blocks=$vcn_ipv6private_cidr_blocks" \
  -auto-approve


echo "Everything is ready...."
echo "Append /api/ping to th eendpoint URL"
echo "::To destroy everything run"
echo ":: terraform destroy -auto-approve"