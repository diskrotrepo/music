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
