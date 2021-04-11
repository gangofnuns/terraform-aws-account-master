output "config" {
  value       = local.config
  description = "Stack configurations"
}

output "rendered" {
  value = "${local.decoded.rendered}"
}
