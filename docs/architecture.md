
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


    graph TD
    subgraph Hub_Subscription [Hub & Connectivity Subscription]
        HubVNet[Hub Virtual Network (10.100.0.0/16)]
        FW[Azure Firewall]
        Gateway[VPN / ExpressRoute Gateway]
        
        HubVNet --> FW
        HubVNet --> Gateway
    end

    subgraph Spoke_Subscription [Workload Production Subscription]
        SpokeVNet[Spoke Virtual Network (10.200.0.0/16)]
        AppSubnet[Application Subnet]
        PepSubnet[Private Endpoints Subnet]
        
        SpokeVNet --> AppSubnet
        SpokeVNet --> PepSubnet
    end

    SpokeVNet -.->|VNet Peering & UDR (0.0.0.0/0)| HubVNet



stateDiagram-v2
[*] --> Requested
Requested --> Validated: Schema & Policy Check
Validated --> AwaitingApproval: Security & FinOps Review
AwaitingApproval --> Approved: Manager Sign-off
Approved --> CreatingSubscription: ARM Alias API Call
CreatingSubscription --> ApplyingGovernance: MG Placement & Policies
ApplyingGovernance --> ConfiguringPlatform: Network & Monitoring Setup
ConfiguringPlatform --> Validating: Post-Provisioning Checks
Validating --> Ready: Published to Application Team
Ready --> [*]



graph TD
    S0[00-bootstrap] --> S1[01-governance]
    S0 --> S2[02-connectivity]
    S1 --> S3[03-platform-management]
    S2 --> S3
    S3 --> S4[04-subscription-vending]
    S4 --> S5[05-workload-foundations]
