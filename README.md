# cloud-cost-guard

Azure resource governance and cost compliance scanner.

Cloud environments accumulate untagged, oversized and forgotten resources
that quietly generate cost. This project provisions test infrastructure with
Terraform, scans it against governance rules (required tags, allowed regions,
SKU limits) using Azure Resource Graph, and enforces those checks
automatically in a CI pipeline.

## Status

Work in progress - infrastructure and scanning logic under development.

## Stack

Terraform, Python, Azure Resource Graph, GitHub Actions
