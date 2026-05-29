--
-- PostgreSQL database dump
--

\restrict 50ZE1LXMyLKpUKSjFHvJPOSrTeQWq5HgO8iJ3igTxam96YfYDYx4Oo5RAqDRHqG

-- Dumped from database version 16.14 (Debian 16.14-1.pgdg12+1)
-- Dumped by pg_dump version 16.14 (Debian 16.14-1.pgdg12+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
679ccd8cc0c2
\.


--
-- Data for Name: infrastructure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.infrastructure (id, environment_type, os_name, os_eol_date, cpu_cores, memory_gb, location, owner_team) FROM stdin;
infra-bdd640fb	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-07a0ca6e	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-72ff5d2a	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-f50bea63	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	32	64	Hyderabad DC	Windows Core OS Team
infra-bacfb3d0	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	32	On-Prem East	Windows Core OS Team
infra-dc98d2c1	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	16	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-3b982ef8	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-b3aa7efe	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	128	Mumbai DC	Windows Core OS Team
infra-451b4cf3	ON_PREM_VM	Windows Server 2019	2029-01-09	4	64	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-d261a7ab	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-a7cad415	ON_PREM_VM	Windows Server 2019	2029-01-09	4	16	Hyderabad DC	Enterprise Systems Hosting
infra-434308bc	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	2	8	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-c17af08a	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	32	64	On-Prem East	Windows Core OS Team
infra-988c24c9	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	16	32	Mumbai DC	Windows Core OS Team
infra-e2817efd	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-b8db0672	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-d777a477	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	32	On-Prem East	Windows Core OS Team
infra-eb2263dd	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	2	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-0ed42f1a	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	4	64	Hyderabad DC	Enterprise Systems Hosting
infra-c40db9b4	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	16	128	On-Prem East	Windows Core OS Team
infra-36386821	ON_PREM_VM	Debian 11	2026-06-30	2	4	Shared Internal Support Cluster	IT Infrastructure Support
infra-702753a1	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-01d74256	ON_PREM_VM	Windows Server 2019	2029-01-09	4	16	Hyderabad DC	Enterprise Systems Hosting
infra-474a493b	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-7914c120	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-0dde29a6	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	4	32	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-310c0c00	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	8	32	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-ceda8bbb	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-3c835dc0	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-43e458fc	ON_PREM_VM	Debian 11	2026-06-30	1	4	Shared Internal Support Cluster	IT Infrastructure Support
infra-b7e99aca	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	16	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-0ea2622b	ON_PREM_VM	Windows Server 2019	2029-01-09	4	32	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-2f923996	ON_PREM_VM	Windows Server 2019	2029-01-09	4	32	Hyderabad DC	Enterprise Systems Hosting
infra-98326856	ON_PREM_VM	Debian 11	2026-06-30	2	4	Shared Internal Support Cluster	IT Infrastructure Support
infra-b758588d	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	16	32	Hyderabad DC	Windows Core OS Team
infra-12922f83	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-eeea163e	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-9c96e9ec	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	32	On-Prem East	Windows Core OS Team
infra-f05db76e	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-57c700aa	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	8	16	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-a2607723	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	64	Mumbai DC	Windows Core OS Team
infra-711c21c9	ON_PREM_VM	Windows Server 2019	2029-01-09	4	64	Hyderabad DC	Enterprise Systems Hosting
infra-093923de	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	32	Mumbai DC	Windows Core OS Team
infra-f8e1daa7	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	128	Hyderabad DC	Windows Core OS Team
infra-dfed2c43	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	16	32	Hyderabad DC	Windows Core OS Team
infra-2d534dd0	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	64	Hyderabad DC	Windows Core OS Team
infra-bc2cbb0d	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	2	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-d10bd1d0	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	128	Mumbai DC	Windows Core OS Team
infra-5408f9ac	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	8	128	Hyderabad DC	Windows Core OS Team
infra-89456f27	ON_PREM_VM	Debian 11	2026-06-30	1	4	Shared Internal Support Cluster	IT Infrastructure Support
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, name, archetype, language, runtime_version, criticality, owner_team, app_owner_name, infrastructure_id) FROM stdin;
app-23b8c1e9	svc-auth-begin	MODERN_MICROSERVICE	Node.js	v20.9.0	LOW	Digital Engineering Hub	Megan Mcclain	infra-bdd640fb
app-815ef6d1	svc-payment-api-science	MODERN_MICROSERVICE	Python	3.11.5	HIGH	Digital Engineering Hub	Kristina Baldwin	infra-07a0ca6e
app-de8a774b	svc-payment-api-grow	MODERN_MICROSERVICE	Python	3.11.5	MEDIUM	Digital Engineering Hub	Robert Wolfe	infra-72ff5d2a
app-17be3111	MainframeSettlementWrapper-314	LEGACY_MONOLITH	.NET Framework 4.0	4.0.30319	HIGH	Enterprise Risk Ops DevTeam	Ian Cooper	infra-f50bea63
app-f91e1d4c	CoreBillingLedger-646	LEGACY_MONOLITH	Java 7	1.7.0_80	MISSION_CRITICAL	HR Services Tech DevTeam	Angela Carter	infra-bacfb3d0
app-b45ed1f0	Secure-KyvValidationLedger	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Matthew Mejia	infra-dc98d2c1
app-47294739	svc-user-profile-hear	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	MEDIUM	Digital Engineering Hub	Roy Martin	infra-3b982ef8
app-12476f57	LegacyClearingHouse-505	LEGACY_MONOLITH	C++ / MFC	Native v140	MISSION_CRITICAL	Core Banking Platform DevTeam	Carolyn Daniel	infra-b3aa7efe
app-b02b61c4	Informatica PowerCenter	COTS_VENDOR	Pre-compiled Binary	v10.5	MISSION_CRITICAL	Enterprise Vendor Applications Team	Melinda Cameron	infra-451b4cf3
app-66b2bc5b	svc-payment-api-under	MODERN_MICROSERVICE	Go	1.21.4	MEDIUM	Digital Engineering Hub	Daniel Hahn	infra-d261a7ab
app-ea1fca65	Tivoli Identity Manager	COTS_VENDOR	Pre-compiled Binary	v7.0.1	HIGH	Enterprise Vendor Applications Team	Brenda Taylor	infra-a7cad415
app-e5d7b875	svc-notification-certainly	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	MEDIUM	Digital Engineering Hub	Heidi Osborn	infra-434308bc
app-27209bdf	GlobalPayrollEngine-798	LEGACY_MONOLITH	COBOL	IBM Enterprise v4.2	HIGH	Global Wealth Management DevTeam	Rebecca Henderson	infra-c17af08a
app-405cacec	CoreBillingLedger-564	LEGACY_MONOLITH	Java 6	1.6.0_45	MEDIUM	Digital Channel Delivery DevTeam	Shannon Smith	infra-988c24c9
app-c4c2e2e3	Internal-AssetTracker	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Ashley Graham	infra-e2817efd
app-f8cda88b	Internal-SurveyCollector	INTERNAL_TOOL	PHP	7.4.33 (Legacy)	LOW	Corporate IT Utilities	Cassandra Gaines	infra-b8db0672
app-32ebd689	LegacyClearingHouse-119	LEGACY_MONOLITH	Java 6	1.6.0_45	MEDIUM	Enterprise Risk Ops DevTeam	Phillip Ryan	infra-d777a477
app-7d154385	svc-payment-api-theory	MODERN_MICROSERVICE	Python	3.11.5	HIGH	Digital Engineering Hub	Timothy Koch	infra-eb2263dd
app-f26b4776	Oracle Access Manager	COTS_VENDOR	Pre-compiled Binary	12c R2	HIGH	Enterprise Vendor Applications Team	Nicholas Cabrera	infra-0ed42f1a
app-79ac1b1e	CoreBillingLedger-652	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Digital Channel Delivery DevTeam	Carmen Rose	infra-c40db9b4
app-badcc32a	Internal-TechSupportLogs	INTERNAL_TOOL	Python (Flask)	2.3.2	LOW	Corporate IT Utilities	Michelle Ross	infra-36386821
app-1efa2197	svc-auth-once	MODERN_MICROSERVICE	Node.js	v20.9.0	HIGH	Digital Engineering Hub	Austin Smith	infra-702753a1
app-0f1259e0	SAP ERP Central Component	COTS_VENDOR	Pre-compiled Binary	ECC 6.0 EHP8	MISSION_CRITICAL	Enterprise Vendor Applications Team	Taylor Heath	infra-01d74256
app-8a0b3c33	Secure-KyvValidationLedger	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Timothy Duncan	infra-474a493b
app-1825bc54	Internal-OfficeFloorMapper	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Jeffrey Henderson	infra-7914c120
app-a56c0941	SAP ERP Central Component	COTS_VENDOR	Pre-compiled Binary	ECC 6.0 EHP8	MISSION_CRITICAL	Enterprise Vendor Applications Team	James Morgan	infra-0dde29a6
app-23e2fcb4	SAP ERP Central Component	COTS_VENDOR	Pre-compiled Binary	ECC 6.0 EHP8	HIGH	Enterprise Vendor Applications Team	Donald Wright	infra-310c0c00
app-19108be5	svc-notification-better	MODERN_MICROSERVICE	Node.js	v20.9.0	LOW	Digital Engineering Hub	Zachary Huff	infra-ceda8bbb
app-7b3a4e3e	svc-payment-api-hundred	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	HIGH	Digital Engineering Hub	James Brown	infra-3c835dc0
app-747b6dba	Internal-OfficeFloorMapper	INTERNAL_TOOL	PHP	7.4.33 (Legacy)	LOW	Corporate IT Utilities	Michael Cross	infra-43e458fc
app-4bf50b52	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Anthony Fitzgerald	infra-b7e99aca
app-80bacd64	Tivoli Identity Manager	COTS_VENDOR	Pre-compiled Binary	v7.0.1	HIGH	Enterprise Vendor Applications Team	Kim Brown	infra-0ea2622b
app-acdabacc	Carbon Black App Control	COTS_VENDOR	Pre-compiled Binary	v8.9.2	HIGH	Enterprise Vendor Applications Team	Jennifer David	infra-2f923996
app-6b5252e3	Internal-TechSupportLogs	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Krystal Stewart	infra-98326856
app-655238a6	CoreBillingLedger-159	LEGACY_MONOLITH	COBOL	IBM Enterprise v4.2	HIGH	Enterprise Risk Ops DevTeam	Matthew Bryant	infra-b758588d
app-ff9ab5c2	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Ariel Medina	infra-12922f83
app-e117dac3	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Dustin Kim	infra-eeea163e
app-a76afde6	LegacyClearingHouse-222	LEGACY_MONOLITH	COBOL	IBM Enterprise v4.2	MISSION_CRITICAL	Core Banking Platform DevTeam	Mary Spencer	infra-9c96e9ec
app-1d8cbbac	svc-auth-father	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	MEDIUM	Digital Engineering Hub	Natalie Moore	infra-f05db76e
app-da587e8a	Carbon Black App Control	COTS_VENDOR	Pre-compiled Binary	v8.9.2	MISSION_CRITICAL	Enterprise Vendor Applications Team	John Whitehead	infra-57c700aa
app-0b49452d	GlobalPayrollEngine-109	LEGACY_MONOLITH	C++ / MFC	Native v140	HIGH	Enterprise Risk Ops DevTeam	Ray Walsh	infra-a2607723
app-8f9797b0	Carbon Black App Control	COTS_VENDOR	Pre-compiled Binary	v8.9.2	MISSION_CRITICAL	Enterprise Vendor Applications Team	Benjamin Ware	infra-711c21c9
app-8d7248e2	CoreBillingLedger-548	LEGACY_MONOLITH	COBOL	IBM Enterprise v4.2	HIGH	Enterprise Risk Ops DevTeam	Cameron Parker	infra-093923de
app-5b9962c6	PolicyBatchProcessor-406	LEGACY_MONOLITH	Java 6	1.6.0_45	MEDIUM	HR Services Tech DevTeam	David Garcia	infra-f8e1daa7
app-bfddc3d9	PolicyBatchProcessor-259	LEGACY_MONOLITH	.NET Framework 4.0	4.0.30319	MISSION_CRITICAL	HR Services Tech DevTeam	Timothy Hancock	infra-dfed2c43
app-2dea9493	MainframeSettlementWrapper-617	LEGACY_MONOLITH	C++ / MFC	Native v140	MISSION_CRITICAL	HR Services Tech DevTeam	Evelyn Galvan	infra-2d534dd0
app-28c13091	svc-notification-town	MODERN_MICROSERVICE	Node.js	v20.9.0	HIGH	Digital Engineering Hub	Ashley Brennan	infra-bc2cbb0d
app-4e20fd1a	LegacyClearingHouse-664	LEGACY_MONOLITH	C++ / MFC	Native v140	HIGH	Core Banking Platform DevTeam	Shelby Walker	infra-d10bd1d0
app-f7860b50	GlobalPayrollEngine-954	LEGACY_MONOLITH	.NET Framework 4.0	4.0.30319	HIGH	Supply Chain Logistics DevTeam	Heather Hicks	infra-5408f9ac
app-1d870966	Internal-AssetTracker	INTERNAL_TOOL	Python (Flask)	2.3.2	LOW	Corporate IT Utilities	Debbie Carpenter	infra-89456f27
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dependencies (id, source_app_id, target_app_id, protocol, criticality) FROM stdin;
dep-1bc044fc	app-23b8c1e9	app-b45ed1f0	gRPC	LOW
dep-ba81edd9	app-23b8c1e9	app-badcc32a	MQ	HIGH
dep-9b3080d5	app-23b8c1e9	app-27209bdf	HTTPS	LOW
dep-629c2ae3	app-23b8c1e9	app-7b3a4e3e	HTTPS	LOW
dep-41357e8c	app-815ef6d1	app-7d154385	HTTPS	HIGH
dep-006ed6e3	app-815ef6d1	app-e117dac3	MQ	HIGH
dep-89d7fd6c	app-815ef6d1	app-8a0b3c33	HTTPS	LOW
dep-bdf070aa	app-de8a774b	app-19108be5	HTTPS	MEDIUM
dep-5d3d9e56	app-de8a774b	app-66b2bc5b	HTTPS	LOW
dep-aa0b7b14	app-de8a774b	app-28c13091	HTTPS	MEDIUM
dep-505cc686	app-17be3111	app-4e20fd1a	HTTPS	MEDIUM
dep-b841d0a0	app-17be3111	app-f91e1d4c	HTTPS	HIGH
dep-4f2d4796	app-17be3111	app-32ebd689	JDBC	MEDIUM
dep-6703b636	app-f91e1d4c	app-ff9ab5c2	JDBC	HIGH
dep-2095eef6	app-f91e1d4c	app-28c13091	HTTPS	MEDIUM
dep-f0bbac67	app-f91e1d4c	app-f7860b50	HTTPS	MEDIUM
dep-e71e43a6	app-b45ed1f0	app-4e20fd1a	HTTPS	MEDIUM
dep-4d0b0d1a	app-b45ed1f0	app-e117dac3	HTTPS	MEDIUM
dep-001a9a8b	app-b45ed1f0	app-ff9ab5c2	MQ	MEDIUM
dep-6e0d2648	app-47294739	app-4e20fd1a	JDBC	MEDIUM
dep-a79ac9aa	app-47294739	app-1efa2197	gRPC	MEDIUM
dep-71316269	app-47294739	app-655238a6	HTTPS	MEDIUM
dep-7922bac2	app-47294739	app-f26b4776	HTTPS	MEDIUM
dep-cbc84759	app-12476f57	app-19108be5	gRPC	MEDIUM
dep-15b52908	app-12476f57	app-a76afde6	MQ	HIGH
dep-a2086977	app-12476f57	app-28c13091	HTTPS	HIGH
dep-d1843324	app-b02b61c4	app-a56c0941	HTTPS	HIGH
dep-ac3c5640	app-b02b61c4	app-32ebd689	gRPC	MEDIUM
dep-32fa2de8	app-b02b61c4	app-e5d7b875	HTTPS	MEDIUM
dep-3eae0032	app-66b2bc5b	app-1efa2197	HTTPS	LOW
dep-d98868dd	app-66b2bc5b	app-47294739	MQ	MEDIUM
dep-6a18ce4c	app-66b2bc5b	app-23b8c1e9	HTTPS	MEDIUM
dep-31c681ec	app-66b2bc5b	app-27209bdf	HTTPS	MEDIUM
dep-7e8f8095	app-66b2bc5b	app-0f1259e0	gRPC	MEDIUM
dep-a7f36ae9	app-ea1fca65	app-e117dac3	gRPC	LOW
dep-c03f3538	app-ea1fca65	app-8d7248e2	MQ	LOW
dep-1b494e15	app-ea1fca65	app-8f9797b0	gRPC	HIGH
dep-2d06e8cf	app-e5d7b875	app-a56c0941	HTTPS	MEDIUM
dep-8498e113	app-e5d7b875	app-bfddc3d9	MQ	HIGH
dep-3fcb7546	app-e5d7b875	app-47294739	HTTPS	MEDIUM
dep-74daaebf	app-27209bdf	app-12476f57	HTTPS	MEDIUM
dep-aae65fc1	app-27209bdf	app-bfddc3d9	HTTPS	MEDIUM
dep-986f9025	app-27209bdf	app-405cacec	gRPC	HIGH
dep-e4347d51	app-405cacec	app-2dea9493	HTTPS	LOW
dep-b8225688	app-405cacec	app-bfddc3d9	JDBC	MEDIUM
dep-d4a02e53	app-c4c2e2e3	app-0f1259e0	gRPC	LOW
dep-e5af6e39	app-f8cda88b	app-1d870966	HTTPS	MEDIUM
dep-79844388	app-f8cda88b	app-6b5252e3	HTTPS	MEDIUM
dep-3f4b1a70	app-32ebd689	app-5b9962c6	MQ	MEDIUM
dep-c40c5d91	app-7d154385	app-19108be5	gRPC	HIGH
dep-a07295e9	app-7d154385	app-2dea9493	gRPC	HIGH
dep-13d5f2f7	app-7d154385	app-1efa2197	HTTPS	MEDIUM
dep-458f1f19	app-7d154385	app-28c13091	HTTPS	MEDIUM
dep-8a476a87	app-f26b4776	app-4bf50b52	gRPC	HIGH
dep-3b33f3d8	app-f26b4776	app-acdabacc	JDBC	HIGH
dep-b4d7e28e	app-f26b4776	app-ea1fca65	HTTPS	HIGH
dep-68586eba	app-79ac1b1e	app-de8a774b	HTTPS	LOW
dep-6a702e2f	app-badcc32a	app-2dea9493	HTTPS	HIGH
dep-6b8e869f	app-1efa2197	app-f7860b50	MQ	MEDIUM
dep-95863a76	app-1efa2197	app-0b49452d	HTTPS	LOW
dep-db52ca58	app-1efa2197	app-6b5252e3	HTTPS	MEDIUM
dep-6160a6b4	app-1efa2197	app-1d8cbbac	HTTPS	MEDIUM
dep-5a0cdd7c	app-0f1259e0	app-a56c0941	MQ	MEDIUM
dep-da7b9095	app-0f1259e0	app-23e2fcb4	HTTPS	MEDIUM
dep-6b44fa8d	app-8a0b3c33	app-1825bc54	gRPC	HIGH
dep-8bcf53a1	app-8a0b3c33	app-ff9ab5c2	HTTPS	MEDIUM
dep-3875394c	app-8a0b3c33	app-e117dac3	gRPC	MEDIUM
dep-6f92f25e	app-1825bc54	app-6b5252e3	JDBC	LOW
dep-560c95ee	app-1825bc54	app-79ac1b1e	JDBC	MEDIUM
dep-67814c1f	app-a56c0941	app-23e2fcb4	HTTPS	LOW
dep-77a6e17c	app-a56c0941	app-0f1259e0	HTTPS	MEDIUM
dep-9f4c3b79	app-a56c0941	app-b45ed1f0	JDBC	MEDIUM
dep-64de82e6	app-23e2fcb4	app-da587e8a	HTTPS	MEDIUM
dep-06f028ff	app-23e2fcb4	app-405cacec	JDBC	MEDIUM
dep-22bd3388	app-23e2fcb4	app-80bacd64	HTTPS	MEDIUM
dep-0cdf742b	app-19108be5	app-ea1fca65	HTTPS	HIGH
dep-362f5e5c	app-19108be5	app-7d154385	gRPC	MEDIUM
dep-c2dff335	app-19108be5	app-47294739	HTTPS	MEDIUM
dep-c083b73a	app-19108be5	app-8d7248e2	HTTPS	MEDIUM
dep-4094dded	app-19108be5	app-23b8c1e9	JDBC	MEDIUM
dep-04f64d86	app-7b3a4e3e	app-e5d7b875	MQ	HIGH
dep-fff9f585	app-7b3a4e3e	app-a56c0941	HTTPS	MEDIUM
dep-a66fd7f7	app-7b3a4e3e	app-47294739	HTTPS	MEDIUM
dep-a6d964a3	app-7b3a4e3e	app-19108be5	JDBC	MEDIUM
dep-f319c125	app-747b6dba	app-1efa2197	HTTPS	MEDIUM
dep-05379ff6	app-4bf50b52	app-8a0b3c33	MQ	LOW
dep-20500494	app-4bf50b52	app-b45ed1f0	gRPC	HIGH
dep-90604f62	app-80bacd64	app-da587e8a	HTTPS	LOW
dep-b31022f0	app-80bacd64	app-23e2fcb4	HTTPS	LOW
dep-2af43ab7	app-acdabacc	app-ea1fca65	HTTPS	HIGH
dep-bf780e3f	app-acdabacc	app-b02b61c4	JDBC	LOW
dep-d1bdb8c0	app-6b5252e3	app-12476f57	JDBC	MEDIUM
dep-1bac5c15	app-655238a6	app-8d7248e2	gRPC	HIGH
dep-4fdc6e1b	app-655238a6	app-0b49452d	JDBC	LOW
dep-f54ad0a2	app-655238a6	app-f7860b50	HTTPS	MEDIUM
dep-b70b3420	app-ff9ab5c2	app-12476f57	MQ	HIGH
dep-b0cc1b3b	app-ff9ab5c2	app-c4c2e2e3	MQ	HIGH
dep-1a16342c	app-e117dac3	app-b45ed1f0	gRPC	MEDIUM
dep-d9acd158	app-e117dac3	app-ff9ab5c2	gRPC	HIGH
dep-1efd76e9	app-a76afde6	app-405cacec	MQ	LOW
dep-c85aca46	app-1d8cbbac	app-1825bc54	gRPC	HIGH
dep-6daa2e68	app-1d8cbbac	app-1d870966	HTTPS	MEDIUM
dep-8186a576	app-1d8cbbac	app-79ac1b1e	HTTPS	LOW
dep-d97dc9cd	app-da587e8a	app-a56c0941	gRPC	HIGH
dep-1b049863	app-0b49452d	app-79ac1b1e	HTTPS	MEDIUM
dep-a2b5b498	app-0b49452d	app-28c13091	gRPC	MEDIUM
dep-b5122df8	app-0b49452d	app-655238a6	JDBC	HIGH
dep-bbda0242	app-8f9797b0	app-b02b61c4	JDBC	HIGH
dep-45241ea6	app-8f9797b0	app-badcc32a	HTTPS	MEDIUM
dep-89c5b31a	app-8d7248e2	app-405cacec	gRPC	LOW
dep-6f81cf4f	app-8d7248e2	app-0b49452d	gRPC	MEDIUM
dep-44b591f7	app-8d7248e2	app-4e20fd1a	HTTPS	MEDIUM
dep-d4aac9a3	app-5b9962c6	app-7b3a4e3e	gRPC	MEDIUM
dep-e1b294de	app-bfddc3d9	app-acdabacc	gRPC	HIGH
dep-76f72255	app-bfddc3d9	app-de8a774b	HTTPS	MEDIUM
dep-6105716b	app-2dea9493	app-23b8c1e9	gRPC	HIGH
dep-d9d80b8d	app-2dea9493	app-1d8cbbac	JDBC	MEDIUM
dep-364d7c87	app-28c13091	app-12476f57	HTTPS	HIGH
dep-57207246	app-28c13091	app-19108be5	MQ	MEDIUM
dep-b380c73a	app-28c13091	app-66b2bc5b	HTTPS	MEDIUM
dep-0299436a	app-28c13091	app-1efa2197	HTTPS	MEDIUM
dep-15eabb27	app-4e20fd1a	app-27209bdf	MQ	LOW
dep-7d137018	app-4e20fd1a	app-ea1fca65	gRPC	LOW
dep-b0cbc61f	app-4e20fd1a	app-f91e1d4c	HTTPS	MEDIUM
dep-7da67785	app-f7860b50	app-655238a6	gRPC	MEDIUM
dep-17d2582e	app-f7860b50	app-0f1259e0	gRPC	HIGH
dep-b118f68d	app-1d870966	app-f8cda88b	HTTPS	LOW
dep-94e0d3ba	app-1d870966	app-79ac1b1e	JDBC	HIGH
dep-87ea7ff5	app-1d870966	app-80bacd64	HTTPS	HIGH
\.


--
-- Data for Name: operational_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operational_metrics (id, application_id, incidents_last_quarter, mttr_hours, availability_pct, cpu_utilization_pct) FROM stdin;
metric-b3a7d0e0	app-23b8c1e9	0	0.14	99.971	17.52
metric-a6a27967	app-815ef6d1	1	0.24	99.965	24.43
metric-b888f6ed	app-de8a774b	0	0.45	99.956	25.09
metric-73991a47	app-17be3111	5	18.78	95.816	79.86
metric-56c438e4	app-f91e1d4c	8	17.71	96.243	66.47
metric-6a7e4c36	app-b45ed1f0	0	1.02	99.954	50.35
metric-6d4067f4	app-47294739	1	0.31	99.962	14.41
metric-5fd23109	app-12476f57	9	8.88	95.613	88.36
metric-ec48bf55	app-b02b61c4	2	6.58	99.261	43.6
metric-d4ef00aa	app-66b2bc5b	1	0.4	99.957	17.6
metric-18b87245	app-ea1fca65	2	5	99.75	64.19
metric-cfd01cbd	app-e5d7b875	0	0.26	99.98	18.72
metric-96229348	app-27209bdf	8	22.74	97.586	77.27
metric-5463adc7	app-405cacec	9	14.47	96.92	68.69
metric-5a856750	app-c4c2e2e3	1	4.17	97.487	4.21
metric-c012a0ff	app-f8cda88b	2	7.68	98.034	2.45
metric-b8976ec5	app-32ebd689	8	21.51	95.73	77.67
metric-99b479d4	app-7d154385	0	0.26	99.962	16.79
metric-93f277cc	app-f26b4776	3	6.67	99.069	59
metric-a81fdec3	app-79ac1b1e	9	16.16	97.718	70.48
metric-1bb43332	app-badcc32a	2	11.67	97.968	1.59
metric-5e187b24	app-1efa2197	0	0.16	99.958	22.05
metric-92f837d4	app-0f1259e0	1	3.06	99.696	54.82
metric-d85c16bd	app-8a0b3c33	1	1.52	99.985	49.29
metric-d1846c39	app-1825bc54	2	6.59	98.456	2.26
metric-a487eeab	app-a56c0941	4	2.41	99.398	49.08
metric-edd877c8	app-23e2fcb4	3	5.55	99.317	42.23
metric-44777442	app-19108be5	1	0.28	99.952	26.63
metric-b3e4110a	app-7b3a4e3e	0	0.36	99.989	11.81
metric-56febfb9	app-747b6dba	2	8.06	97.694	3.22
metric-deaf528d	app-4bf50b52	0	1.17	99.982	49.56
metric-6699cd99	app-80bacd64	3	5.63	99.451	68.73
metric-a2178f84	app-acdabacc	4	2.62	99.809	50.3
metric-bf012e32	app-6b5252e3	2	4.67	97.969	1.16
metric-6b7a2460	app-655238a6	10	15	96.318	75.68
metric-5ebbcca5	app-ff9ab5c2	0	1.05	99.987	41.62
metric-c6deb2f0	app-e117dac3	1	1.52	99.952	48.93
metric-15bfbe97	app-a76afde6	7	9.05	95.284	80.35
metric-284c03d2	app-1d8cbbac	1	0.2	99.984	29.29
metric-ac8936bc	app-da587e8a	2	4	99.524	44.24
metric-a974d079	app-0b49452d	7	12.96	96.968	79.86
metric-7129cec7	app-8f9797b0	2	5.57	99.844	49.29
metric-c143f426	app-8d7248e2	8	18.3	95.985	63.83
metric-6e0ed1e8	app-5b9962c6	10	21.26	97.216	80.56
metric-adb14670	app-bfddc3d9	9	9.5	97.011	75.25
metric-aac93316	app-2dea9493	5	13.8	95.541	66.43
metric-652ffb49	app-28c13091	1	0.18	99.99	13.1
metric-01f7c7ec	app-4e20fd1a	7	21.51	95.303	83.13
metric-36136e15	app-f7860b50	10	22.14	95.113	70.1
metric-4169b9fc	app-1d870966	2	5.05	97.565	1.65
\.


--
-- Data for Name: waves; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.waves (id, wave_number, theme, target_start_date, target_end_date) FROM stdin;
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendations (id, application_id, readiness_score, sixr_decision, confidence_score, reasoning, dependency_warnings, wave_id) FROM stdin;
\.


--
-- Data for Name: security_findings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.security_findings (id, application_id, cve_id, title, severity, cvss_score, discovered_date, remediation_available, remediation_steps, mitigation_status) FROM stdin;
vuln-bef59fe6	app-23b8c1e9	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-07-29	t	Vendor patch available	\N
vuln-7428a656	app-815ef6d1	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2024-12-24	t	Vendor patch available	\N
vuln-1ee34dc4	app-815ef6d1	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-12-09	t	Vendor patch available	\N
vuln-be2d740a	app-de8a774b	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-07-18	t	Vendor patch available	\N
vuln-2f65fafa	app-17be3111	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-10-23	f	\N	Isolated from public internet
vuln-46c8adfe	app-17be3111	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-12-11	t	Vendor patch available	\N
vuln-864e9a13	app-17be3111	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-09-03	t	Vendor patch available	\N
vuln-d52721e7	app-17be3111	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2024-10-25	t	Vendor patch available	\N
vuln-2defe193	app-17be3111	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-01-17	f	\N	Isolated from public internet
vuln-2067bdac	app-17be3111	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-12-27	t	Vendor patch available	\N
vuln-8da8eee4	app-17be3111	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-01-09	f	\N	Isolated from public internet
vuln-a34b6cf6	app-17be3111	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2026-04-02	f	\N	Isolated from public internet
vuln-df6a8f93	app-f91e1d4c	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-06-06	f	\N	Isolated from public internet
vuln-7a8d03aa	app-f91e1d4c	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-05-05	t	Vendor patch available	\N
vuln-0d270659	app-f91e1d4c	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-12-10	f	\N	Isolated from public internet
vuln-1d34d08e	app-f91e1d4c	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2026-02-25	t	Vendor patch available	\N
vuln-12f70c97	app-f91e1d4c	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-08-19	t	Vendor patch available	\N
vuln-26d794d3	app-f91e1d4c	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-09-20	f	\N	Isolated from public internet
vuln-4dc82a1e	app-f91e1d4c	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-08-02	f	\N	Isolated from public internet
vuln-8edddfcd	app-f91e1d4c	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2026-01-11	t	Vendor patch available	\N
vuln-ca6dfda1	app-f91e1d4c	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-09-20	f	\N	Isolated from public internet
vuln-61607459	app-b45ed1f0	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-05-12	f	\N	Isolated from public internet
vuln-dc33e1f9	app-47294739	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-08-28	t	Vendor patch available	\N
vuln-9191b363	app-12476f57	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-09-22	f	\N	Isolated from public internet
vuln-bd767e35	app-12476f57	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-08-13	t	Vendor patch available	\N
vuln-a021c0ca	app-12476f57	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-11-07	t	Vendor patch available	\N
vuln-2834e4c0	app-12476f57	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-11-30	f	\N	Isolated from public internet
vuln-2812859a	app-12476f57	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-05-30	f	\N	Isolated from public internet
vuln-980402a2	app-12476f57	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-05-27	f	\N	Isolated from public internet
vuln-49c13de7	app-b02b61c4	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-11-28	f	\N	Isolated from public internet
vuln-743b65a2	app-b02b61c4	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-07-22	f	\N	Isolated from public internet
vuln-43b9da13	app-ea1fca65	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2026-01-29	t	Vendor patch available	\N
vuln-a9434aa0	app-ea1fca65	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-02-11	t	Vendor patch available	\N
vuln-1d61fac3	app-ea1fca65	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-07-24	t	Vendor patch available	\N
vuln-e88da719	app-ea1fca65	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-12-20	t	Vendor patch available	\N
vuln-0f44704f	app-ea1fca65	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-10-03	t	Vendor patch available	\N
vuln-bfbbb17f	app-e5d7b875	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2026-02-27	f	\N	Isolated from public internet
vuln-706c5c56	app-27209bdf	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-09-01	f	\N	Isolated from public internet
vuln-b321bf21	app-27209bdf	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-04-05	t	Vendor patch available	\N
vuln-8a3c3b5e	app-27209bdf	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-06-15	f	\N	Isolated from public internet
vuln-0a3450fc	app-27209bdf	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2026-04-18	t	Vendor patch available	\N
vuln-9a8cfa3c	app-27209bdf	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-12-08	t	Vendor patch available	\N
vuln-f63fce41	app-405cacec	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-11-02	f	\N	Isolated from public internet
vuln-964db03f	app-405cacec	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-06-13	t	Vendor patch available	\N
vuln-d248a9a7	app-405cacec	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-12-23	t	Vendor patch available	\N
vuln-c19ad58c	app-405cacec	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-10-11	t	Vendor patch available	\N
vuln-7135f221	app-405cacec	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-12-30	t	Vendor patch available	\N
vuln-6f962882	app-405cacec	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-10-03	f	\N	Isolated from public internet
vuln-175ba98d	app-c4c2e2e3	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-05-28	t	Vendor patch available	\N
vuln-5230dfbd	app-c4c2e2e3	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-10-30	t	Vendor patch available	\N
vuln-546e035a	app-c4c2e2e3	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-04-12	t	Vendor patch available	\N
vuln-a99f1318	app-c4c2e2e3	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-04-04	t	Vendor patch available	\N
vuln-0964fbbf	app-f8cda88b	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-05-16	t	Vendor patch available	\N
vuln-52c21221	app-f8cda88b	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-08-26	f	\N	Isolated from public internet
vuln-dd6ac7b8	app-f8cda88b	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-07-01	f	\N	Isolated from public internet
vuln-a85c6e4a	app-32ebd689	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2026-04-03	f	\N	Isolated from public internet
vuln-0de051a6	app-32ebd689	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-10-20	f	\N	Isolated from public internet
vuln-c1a6423b	app-32ebd689	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-06-19	f	\N	Isolated from public internet
vuln-0d366dfc	app-32ebd689	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-11-02	f	\N	Isolated from public internet
vuln-ed7bf656	app-32ebd689	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-01-06	t	Vendor patch available	\N
vuln-7c16128d	app-32ebd689	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-08-30	f	\N	Isolated from public internet
vuln-9bdf0377	app-f26b4776	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2026-02-07	f	\N	Isolated from public internet
vuln-4f8d5238	app-f26b4776	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-07-29	f	\N	Isolated from public internet
vuln-17dc8eff	app-f26b4776	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-11-18	f	\N	Isolated from public internet
vuln-1d0bc9bd	app-79ac1b1e	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-05-21	t	Vendor patch available	\N
vuln-d50755d9	app-79ac1b1e	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-09-24	t	Vendor patch available	\N
vuln-4ab7706e	app-79ac1b1e	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-06-27	t	Vendor patch available	\N
vuln-d5b077e0	app-79ac1b1e	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-06-06	f	\N	Isolated from public internet
vuln-74eff545	app-79ac1b1e	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-07-30	t	Vendor patch available	\N
vuln-ebff8d15	app-badcc32a	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-09-05	t	Vendor patch available	\N
vuln-22f235f2	app-badcc32a	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-03-30	t	Vendor patch available	\N
vuln-ca3dd859	app-badcc32a	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2026-03-22	t	Vendor patch available	\N
vuln-c9a7d91f	app-1efa2197	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-06-26	t	Vendor patch available	\N
vuln-486822b9	app-0f1259e0	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-12-12	f	\N	Isolated from public internet
vuln-9475dbc9	app-0f1259e0	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-10-22	t	Vendor patch available	\N
vuln-7250ee18	app-0f1259e0	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-07-20	f	\N	Isolated from public internet
vuln-8d4a75b8	app-0f1259e0	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2026-01-10	f	\N	Isolated from public internet
vuln-eecf67d2	app-8a0b3c33	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-02-01	t	Vendor patch available	\N
vuln-b28f41de	app-1825bc54	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-11-29	f	\N	Isolated from public internet
vuln-db23aa8c	app-1825bc54	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2026-01-20	f	\N	Isolated from public internet
vuln-bea4ff31	app-a56c0941	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-05-30	t	Vendor patch available	\N
vuln-61985d54	app-a56c0941	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-03-23	t	Vendor patch available	\N
vuln-d21c82f8	app-a56c0941	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-10-16	f	\N	Isolated from public internet
vuln-f6febc0e	app-a56c0941	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-06-25	f	\N	Isolated from public internet
vuln-9716108e	app-a56c0941	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-02-09	t	Vendor patch available	\N
vuln-d85480f0	app-a56c0941	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-05-04	f	\N	Isolated from public internet
vuln-74f93d17	app-23e2fcb4	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-06-08	t	Vendor patch available	\N
vuln-def57689	app-23e2fcb4	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-10-18	f	\N	Isolated from public internet
vuln-78308930	app-23e2fcb4	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2026-01-25	t	Vendor patch available	\N
vuln-9f8ded97	app-23e2fcb4	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-11-17	f	\N	Isolated from public internet
vuln-da0d4a5f	app-7b3a4e3e	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-02-07	f	\N	Isolated from public internet
vuln-889b78d5	app-7b3a4e3e	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-03-19	f	\N	Isolated from public internet
vuln-b7fddd71	app-747b6dba	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2026-04-17	t	Vendor patch available	\N
vuln-8a80068d	app-747b6dba	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-06-24	f	\N	Isolated from public internet
vuln-a193c4b2	app-747b6dba	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-11-10	t	Vendor patch available	\N
vuln-3a3c8a71	app-4bf50b52	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-12-29	t	Vendor patch available	\N
vuln-1933918c	app-80bacd64	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2026-01-08	t	Vendor patch available	\N
vuln-19bad7ae	app-80bacd64	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-05-07	f	\N	Isolated from public internet
vuln-e746ccb9	app-80bacd64	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2024-06-19	t	Vendor patch available	\N
vuln-0e5dd462	app-80bacd64	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-01-10	t	Vendor patch available	\N
vuln-25440fe0	app-80bacd64	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-12-03	t	Vendor patch available	\N
vuln-ae8a7813	app-80bacd64	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2026-02-02	t	Vendor patch available	\N
vuln-14374509	app-acdabacc	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-09-13	t	Vendor patch available	\N
vuln-aee1e86b	app-acdabacc	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-12-01	f	\N	Isolated from public internet
vuln-24a35cf2	app-acdabacc	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-11-24	f	\N	Isolated from public internet
vuln-75a66981	app-acdabacc	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-12-12	t	Vendor patch available	\N
vuln-cdfc6ee0	app-acdabacc	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-05-24	f	\N	Isolated from public internet
vuln-8beddb12	app-6b5252e3	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-09-27	t	Vendor patch available	\N
vuln-5876fd09	app-6b5252e3	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-08-27	t	Vendor patch available	\N
vuln-6c9f82b9	app-6b5252e3	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-11-15	f	\N	Isolated from public internet
vuln-4d57d880	app-655238a6	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-10-29	t	Vendor patch available	\N
vuln-7bb38605	app-655238a6	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-08-18	t	Vendor patch available	\N
vuln-5be4bf51	app-655238a6	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-08-17	f	\N	Isolated from public internet
vuln-4b943e30	app-655238a6	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-06-14	f	\N	Isolated from public internet
vuln-6553867d	app-655238a6	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-12-27	t	Vendor patch available	\N
vuln-af908e3c	app-655238a6	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2026-01-22	f	\N	Isolated from public internet
vuln-e91e314e	app-655238a6	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-09-11	t	Vendor patch available	\N
vuln-e776b886	app-a76afde6	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-04-29	f	\N	Isolated from public internet
vuln-3ae909fe	app-a76afde6	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-09-11	t	Vendor patch available	\N
vuln-a2f963a3	app-a76afde6	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-10-22	t	Vendor patch available	\N
vuln-c16d83ed	app-a76afde6	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-12-08	t	Vendor patch available	\N
vuln-d69d42f1	app-a76afde6	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-09-11	t	Vendor patch available	\N
vuln-a0a11839	app-a76afde6	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-10-12	f	\N	Isolated from public internet
vuln-70d9c9f8	app-da587e8a	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-06-22	f	\N	Isolated from public internet
vuln-21a4344f	app-da587e8a	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-08-06	t	Vendor patch available	\N
vuln-bf5ae7e6	app-da587e8a	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-04-15	t	Vendor patch available	\N
vuln-c958e75e	app-0b49452d	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-07-20	f	\N	Isolated from public internet
vuln-87e5f0fe	app-0b49452d	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-06-21	t	Vendor patch available	\N
vuln-2a1f955a	app-0b49452d	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-12-13	f	\N	Isolated from public internet
vuln-7b5a611a	app-0b49452d	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2026-02-13	t	Vendor patch available	\N
vuln-56b60afc	app-0b49452d	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2026-02-11	t	Vendor patch available	\N
vuln-1346d1a9	app-0b49452d	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-09-14	t	Vendor patch available	\N
vuln-dc322c97	app-8f9797b0	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-11-04	t	Vendor patch available	\N
vuln-65bcc272	app-8f9797b0	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-03-15	f	\N	Isolated from public internet
vuln-171e16cc	app-8f9797b0	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-02-01	t	Vendor patch available	\N
vuln-895ccd99	app-8f9797b0	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-08-31	t	Vendor patch available	\N
vuln-bfbf397b	app-8f9797b0	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-11-01	t	Vendor patch available	\N
vuln-d289f0ab	app-8f9797b0	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-10-05	f	\N	Isolated from public internet
vuln-acc216a0	app-8d7248e2	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-11-25	t	Vendor patch available	\N
vuln-e25d36eb	app-8d7248e2	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-08-07	t	Vendor patch available	\N
vuln-38ab854c	app-8d7248e2	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-10-13	f	\N	Isolated from public internet
vuln-76da3ca0	app-8d7248e2	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-11-23	t	Vendor patch available	\N
vuln-1dde7969	app-8d7248e2	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-09-13	t	Vendor patch available	\N
vuln-4dead645	app-8d7248e2	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-06-14	f	\N	Isolated from public internet
vuln-e3236d1a	app-8d7248e2	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-07-19	t	Vendor patch available	\N
vuln-5efa9c5b	app-5b9962c6	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-10-30	t	Vendor patch available	\N
vuln-f22b5b98	app-5b9962c6	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-07-21	f	\N	Isolated from public internet
vuln-ba0266ef	app-5b9962c6	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-09-25	t	Vendor patch available	\N
vuln-19597b5a	app-5b9962c6	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2026-03-06	f	\N	Isolated from public internet
vuln-f065c817	app-5b9962c6	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-12-31	t	Vendor patch available	\N
vuln-379efc6e	app-5b9962c6	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-05-07	f	\N	Isolated from public internet
vuln-dafec8a9	app-5b9962c6	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-03-05	t	Vendor patch available	\N
vuln-5e09a9ee	app-bfddc3d9	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-07-24	t	Vendor patch available	\N
vuln-5bd20c98	app-bfddc3d9	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-07-14	f	\N	Isolated from public internet
vuln-f7dc67e0	app-bfddc3d9	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-08-30	t	Vendor patch available	\N
vuln-74685b98	app-bfddc3d9	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-08-07	t	Vendor patch available	\N
vuln-a3b5cece	app-bfddc3d9	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-09-03	f	\N	Isolated from public internet
vuln-c96b5edb	app-bfddc3d9	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-02-11	f	\N	Isolated from public internet
vuln-c9776598	app-2dea9493	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-08-09	f	\N	Isolated from public internet
vuln-c3e15a85	app-2dea9493	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-08-01	f	\N	Isolated from public internet
vuln-d0243d72	app-2dea9493	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2026-04-03	t	Vendor patch available	\N
vuln-25c61c45	app-2dea9493	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-01-30	f	\N	Isolated from public internet
vuln-46fb7bf3	app-2dea9493	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2026-03-25	t	Vendor patch available	\N
vuln-21472a15	app-2dea9493	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-07-21	t	Vendor patch available	\N
vuln-1c24220e	app-2dea9493	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-10-23	t	Vendor patch available	\N
vuln-03cde2e3	app-2dea9493	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-03-02	t	Vendor patch available	\N
vuln-96bf10ab	app-28c13091	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-02-03	f	\N	Isolated from public internet
vuln-0d6a05b3	app-28c13091	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-09-03	t	Vendor patch available	\N
vuln-1d181ee9	app-4e20fd1a	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-12-28	t	Vendor patch available	\N
vuln-c72c1fe3	app-4e20fd1a	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-03-05	t	Vendor patch available	\N
vuln-73b6a09b	app-4e20fd1a	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-06-23	t	Vendor patch available	\N
vuln-0b19f88e	app-4e20fd1a	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-12-13	t	Vendor patch available	\N
vuln-a8addf36	app-f7860b50	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-07-07	t	Vendor patch available	\N
vuln-f6ca6b8b	app-f7860b50	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-06-21	t	Vendor patch available	\N
vuln-d8e88ebb	app-f7860b50	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-04-04	f	\N	Isolated from public internet
vuln-7d824264	app-f7860b50	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-12-02	f	\N	Isolated from public internet
vuln-e63658c9	app-f7860b50	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-07-29	t	Vendor patch available	\N
vuln-10d08d11	app-f7860b50	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-09-03	t	Vendor patch available	\N
vuln-95da75c1	app-f7860b50	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-07-27	t	Vendor patch available	\N
vuln-fe9fecaa	app-f7860b50	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-09-04	f	\N	Isolated from public internet
vuln-816bcb9f	app-1d870966	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-09-10	f	\N	Isolated from public internet
\.


--
-- PostgreSQL database dump complete
--

\unrestrict 50ZE1LXMyLKpUKSjFHvJPOSrTeQWq5HgO8iJ3igTxam96YfYDYx4Oo5RAqDRHqG

