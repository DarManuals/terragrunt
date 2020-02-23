resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

resource "aws_iam_user" "conditional" {
  count = var.enabled ? 1 : 0
  name  = "test-conditional"
}

variable "enabled" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default     = true
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  //  default     = ["test1", "test2"]
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}