resource "aws_dynamodb_table" "this" {
  for_each     = var.tables
  name         = each.value.name
  billing_mode = each.value.billing_mode
  hash_key     = each.value.hash_key


  range_key = lookup(each.value, "range_key", null)

  dynamic "attribute" {
    for_each = each.value.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {

    for_each = each.value.global_secondary_indexes == null ? [] : each.value.global_secondary_indexes

    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      range_key       = lookup(global_secondary_index.value, "range_key", null)
      projection_type = global_secondary_index.value.projection_type

      read_capacity  = each.value.billing_mode == "PROVISIONED" ? lookup(global_secondary_index.value, "read_capacity", null) : null
      write_capacity = each.value.billing_mode == "PROVISIONED" ? lookup(global_secondary_index.value, "write_capacity", null) : null
    }
  }

  read_capacity  = each.value.billing_mode == "PROVISIONED" ? each.value.read_capacity : null
  write_capacity = each.value.billing_mode == "PROVISIONED" ? each.value.write_capacity : null

  tags = lookup(each.value, "tags", {})
  dynamic "ttl" {
    for_each = lookup(each.value, "ttl", null) != null ? [lookup(each.value, "ttl", null)] : []
    content {
      attribute_name = ttl.value.attribute_name
      enabled        = ttl.value.enabled
    }
  }
}
