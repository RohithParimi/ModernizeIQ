# ModernizeIQ — Data Design & Portfolio Archetypes

This document defines the 5 application archetypes that make up our synthetic 50-app enterprise portfolio. Use this as the engineering reference for prompt engineering and data generation.

---

## 1. Legacy Monolith

- **Business Purpose:** Core back-office processing (e.g., Old Payroll, Billing Engine, Mainframe wrappers).
- **Tech Stack:** Java 6 or 7, .NET Framework 4.0, C++, COBOL.
- **Infrastructure Profile:** Shared On-Prem physical hardware or ancient VMware clusters running Windows Server 2008/2012 R2 or RedHat Enterprise Linux 6.
- **Telemetry Trends:** - High CPU utilization (60% - 90%) due to unoptimized, single-threaded processing loops.
  - Low Availability (95% - 98%) with high incident counts (5-10 per quarter) because failures crash the whole app.
  - Horrible MTTR (12+ hours) because the code is a "spaghetti" black box.
- **Security Profile:** Flooded with Critical/High CVEs. No official vendor remediation patches available because the underlying OS/runtime is entirely End-of-Life (EOL).
- **Ideal 6R Target:** Refactor (if strategic) or Replace (if standard business function). Never Rehost a security liability.

## 2. Modern Microservice

- **Business Purpose:** Customer-facing web/mobile backends, high-frequency transactional layers.
- **Tech Stack:** Node.js, Python 3.11, Go, Java 21 (Spring Boot 3).
- **Infrastructure Profile:** Cloud-native environments (AWS EKS, Azure AKS, on-prem Kubernetes clusters).
- **Telemetry Trends:**
  - Low/Stable CPU utilization (10% - 30%) with automated horizontal scaling enabled.
  - Excellent Availability (99.95% - 99.99%) and minimal quarterly incidents (0-1).
  - Outstanding MTTR (under 15 minutes) due to container replication and self-healing systems.
- **Security Profile:** Low to zero vulnerabilities. Any discovered CVEs are easily remediated via simple base-image updates or library patches.
- **Ideal 6R Target:** Retain or Rehost. They are already in a modern state; leave them alone or shift them between cloud regions easily.

## 3. Vendor COTS (Commercial Off-The-Shelf)

- **Business Purpose:** Specialized third-party enterprise tools (e.g., Carbon Black App Control, Tivoli Identity Manager, SAP components).
- **Tech Stack:** Pre-compiled vendor binary packages (C++, Java, .NET core platforms).
- **Infrastructure Profile:** Dedicated On-Prem virtual machines or specialized cloud EC2/Compute instances.
- **Telemetry Trends:**
  - Moderate to heavy memory consumption, highly dependent on the vendor's licensing configurations.
  - Steady availability (99.0% - 99.9%) tied directly to strict vendor SLA metrics.
- **Security Profile:** Highly prone to system-level CVEs (like OS EOL windows). Remediation depends entirely on whether the vendor has shipped an official advisory patch package.
- **Ideal 6R Target:** Replatform (upgrade vendor version onto a managed instance) or Replace (if the market has switched to a superior cloud SaaS alternative).

## 4. Internal Tool

- **Business Purpose:** Employee-facing utilities, secondary reporting dashboards, internal asset logs.
- **Tech Stack:** PHP, Python (Flask/Django), basic HTML/jQuery frontends.
- **Infrastructure Profile:** Low-cost, shared internal virtual servers or small cloud instances.
- **Telemetry Trends:**
  - Incredibly low CPU utilization (1% - 5%), completely quiet outside regular business working hours.
  - Sub-optimal availability (98%) is tolerated because an outage does not impact external paying customers.
- **Security Profile:** Moderate, unpatched Medium/Low severity vulnerabilities that have been ignored because the tool lacks external internet exposure.
- **Ideal 6R Target:** Rehost (lift-and-shift to low-cost cloud storage as-is) or Retire (if system telemetry reveals zero employee usage over the last quarter).

## 5. Compliance-Critical System

- **Business Purpose:** High-security financial transaction processing, patient health record storage (HIPAA/PCI-DSS scopes).
- **Tech Stack:** Hardened Java, C#, secure custom frameworks.
- **Infrastructure Profile:** Heavily isolated on-prem hardware modules or dedicated, air-gapped cloud private subnets.
- **Telemetry Trends:**
  - High availability targets (99.99%) enforced by tight security clustering configurations.
  - Low MTTR requirements managed by specialized round-the-clock infrastructure engineers.
- **Security Profile:** Subject to regular auditing. Zero critical CVEs allowed; any discovered flaws are heavily mitigated using extensive firewall and proxy access lists.
- **Ideal 6R Target:** Retain (keep on-premise due to strict geopolitical data residency boundaries) or Refactor into a highly secure, modern private cloud framework.
