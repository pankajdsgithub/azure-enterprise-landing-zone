
# Enterprise Architecture & Design Decisions

This document details the architectural topology, state dependency graphs, trust boundaries, and workflows governing the enterprise landing zone.

---

## 1. Management Group Hierarchy

The Management Group structure mirrors Microsoft's enterprise guidance, enforcing security baselines and policy inheritance from the tenant root down to individual workload tiers.

```mermaid
graph TD
    Root[Tenant Root Management Group] --> Platform[Platform Management Group]
    Root --> LandingZones[Landing Zones Management Group]
    Root --> Sandbox[Sandbox Management Group]
    Root --> Decomm[Decommissioned Management Group]

    Platform --> Mgmt[Management Subscription]
    Platform --> Conn[Connectivity Subscription]
    Platform --> Ident[Identity Subscription]

    LandingZones --> Prod[Production Management Group]
    LandingZones --> NonProd[Non-Production Management Group]

    Prod --> ProdSub1[Workload Prod Sub 1]
    Prod --> ProdSub2[Workload Prod Sub 2]
    NonProd --> NonProdSub1[Workload NonProd Sub 1]