variable "tables" {
  description = "Map of DynamoDB table configurations"
  type = map(object({
    name         = string
    billing_mode = string // Use "PAY_PER_REQUEST" or "PROVISIONED"
    hash_key     = string
    range_key    = optional(string)
    attributes = list(object({
      name = string
      type = string // "S", "N", or "B"
    }))
    read_capacity  = optional(number)
    write_capacity = optional(number)
    tags           = optional(map(string))
  }))
}
