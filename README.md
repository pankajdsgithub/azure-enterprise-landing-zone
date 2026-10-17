# Enterprise Greenfield Azure Landing Zone (ALZ)

[![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.6.0-blue.svg)](https://www.terraform.io/)
[![Azure CAF](https://img.shields.io/badge/Cloud%20Adoption%20Framework-Aligned-success.svg)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A production-oriented, fully automated, enterprise-grade Azure Landing Zone (ALZ) built from scratch using **Terraform**, **Azure DevOps CI/CD Workload Identity Federation**, and **Enterprise Agreement (EA) Subscription Vending**.

---

## 🏗️ Architectural Overview

This repository establishes a centralized Azure platform adhering strictly to **Microsoft's Cloud Adoption Framework (CAF)**, least-privilege security principles, and robust Infrastructure as Code (IaC) isolation.

### Core Pillars
1. **Tenant Governance**: Scalable Management Group hierarchy with inherited Azure Policy compliance and least-privilege RBAC.
2. **State Isolation**: Independent Terraform state backends partitioned by lifecycle, security boundary, and ownership (`bootstrap`, `governance`, `connectivity`, `management`, `vending`, and `workloads`).
3. **Hub-and-Spoke Networking**: Centralized egress inspection via Azure Firewall, hybrid connectivity, and shared Private DNS zones.
4. **Automated Subscription Vending**: Approval-gated ARM Subscription Alias API workflow backed by EA billing arrangements.
5. **DevSecOps Integration**: Passwordless OIDC authentication via Azure DevOps workload identity federation and automated compliance checks.

---

## 📂 Repository Structure

```text
azure-enterprise-landing-zone/
├── bootstrap/               # Terraform remote state backend storage & containers
├── governance/
│   ├── management-groups/   # CAF Management Group hierarchy
│   ├── policy/              # Azure Policy initiatives & compliance baselines
│   └── rbac/                # Least-privilege role assignments
├── platform/
│   ├── management/          # Central Log Analytics, Action Groups & Automation
│   ├── connectivity/        # Hub VNet, Azure Firewall & Private DNS zones
│   └── security/            # Microsoft Defender for Cloud baselines
├── subscription-vending/    # EA subscription automation, schemas & terraform
├── workloads/               # Sample application spoke environments (Dev/Prod)
├── pipelines/               # Azure DevOps YAML templates & master pipelines
└── docs/                    # Architecture diagrams, ADRs & runbooks