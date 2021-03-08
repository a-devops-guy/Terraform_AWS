resource "aws_placement_group" "spread_strategy" {
  name     = "spread"
  strategy = "spread"
}