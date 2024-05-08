provider "oci" {
  config_file_profile = "DEFAULT"
}

resource "oci_artifacts_container_repository" "test_container_repository" {
  compartment_id = var.compartment_id
  display_name   = var.oci_artifacts_container_repository_display_name
  is_immutable   = var.oci_artifacts_container_repository_is_immutable
  is_public      = var.oci_artifacts_container_repository_is_public
  readme {
    content = var.oci_artifacts_container_repository_readme_content
    format  = var.oci_artifacts_container_repository_readme_format
  }
  freeform_tags = { (var.free_form_tag_key) = (var.free_form_tag_value) }
  # defined_tags  = { "Operations.CostCenter" = "42" }
}
