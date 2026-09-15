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

## The problem

Azure Policy prevents non-compliant resources from being created, but prevention
alone leaves gaps:

- **Policies are not retroactive.** Resources created before a policy was assigned
  remain non-compliant indefinitely.
- **Scope is limited.** A policy assigned to one subscription says nothing about
  the others.
- **Exemptions accumulate.** Temporary `notScopes` and exemptions are rarely
  reviewed once the urgency passes.
- **Presence is not correctness.** A `deny` effect typically checks that a tag key
  exists. It does not catch `costcentre` versus `costcenter`, or a value of `TBD`.

Prevention is a control that applies going forward. Detection verifies what is
actually there. This project provides the detection half: it scans resources
across a subscription, validates them against governance rules, and reports
where reality diverges from policy — including resources that no policy covers
at all.