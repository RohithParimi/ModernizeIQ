--
-- PostgreSQL database dump
--

\restrict O0jV3NUkbuyC2fgClkJRSYbkyi8IxyRzOShTbyJv3Q4LIOFemhHSjLeuOosIviT

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
infra-bdd640fb	ON_PREM_VM	Windows Server 2019	2029-01-09	8	16	Hyderabad DC	Enterprise Systems Hosting
infra-0822e8f3	ON_PREM_VM	Debian 11	2026-06-30	1	4	Shared Internal Support Cluster	IT Infrastructure Support
infra-6b65a6a4	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	32	On-Prem East	Windows Core OS Team
infra-47229389	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	8	128	Mumbai DC	Windows Core OS Team
infra-43b7a3a6	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-9e574f7a	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-146d3f31	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	32	64	On-Prem East	Windows Core OS Team
infra-35a240ae	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-29d4beef	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	4	32	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-c6a7ee39	ON_PREM_VM	Windows Server 2019	2029-01-09	4	64	Hyderabad DC	Enterprise Systems Hosting
infra-e059a0ee	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-434308bc	ON_PREM_VM	Debian 11	2026-06-30	2	4	Shared Internal Support Cluster	IT Infrastructure Support
infra-1745d6d8	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-61b1cd22	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-ae849217	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	8	64	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-f42d47cc	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	32	Hyderabad DC	Windows Core OS Team
infra-4c66e0a8	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-00257ad1	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	16	128	Mumbai DC	Windows Core OS Team
infra-0ed42f1a	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	16	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-c40db9b4	ON_PREM_VM	Debian 11	2026-06-30	1	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-36386821	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-702753a1	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	16	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-38602ab6	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	128	Hyderabad DC	Windows Core OS Team
infra-3ceddf2d	ON_PREM_VM	Debian 11	2026-06-30	2	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-c8dcd19f	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	8	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-0dde29a6	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	128	On-Prem East	Windows Core OS Team
infra-310c0c00	ON_PREM_VM	Windows Server 2019	2029-01-09	4	16	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-ceda8bbb	ON_PREM_VM	Windows Server 2019	2029-01-09	4	64	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-c0e9ab30	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	64	Mumbai DC	Windows Core OS Team
infra-63f2ae24	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-a97065e1	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	64	Hyderabad DC	Windows Core OS Team
infra-504867ba	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	16	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-d9f195d0	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	32	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-94340a03	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	32	Mumbai DC	Windows Core OS Team
infra-ab73295b	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	4	16	AWS ap-south-1 (EC2)	Enterprise Systems Hosting
infra-ef8c485b	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-e117dac3	ON_PREM_VM	Debian 11	2026-06-30	1	2	Shared Internal Support Cluster	IT Infrastructure Support
infra-a76afde6	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	32	Mumbai DC	Windows Core OS Team
infra-1d8cbbac	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	8	32	Hyderabad DC	Enterprise Systems Hosting
infra-a25d6b29	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	8	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-0b49452d	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-8f9797b0	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	4	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-25e97977	KUBERNETES	Ubuntu Server 22.04 LTS	2027-04-30	1	4	AWS ap-south-1 (EKS)	Cloud Platform Engineering
infra-ae9bec36	ON_PREM_VM	Hardened RedHat Enterprise Linux 8	2029-05-31	8	64	Isolated Secure Vault Zone	SecOps Core Infrastructure
infra-ecfedb99	ON_PREM_VM	Windows Server 2008 R2	2020-01-14	32	128	Hyderabad DC	Windows Core OS Team
infra-ecab3301	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	16	128	Mumbai DC	Windows Core OS Team
infra-b386f7a4	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	128	Mumbai DC	Windows Core OS Team
infra-d20eac17	ON_PREM_VM	RedHat Enterprise Linux 6	2020-11-30	8	128	Hyderabad DC	Windows Core OS Team
infra-c5f8bc16	ON_PREM_VM	Windows Server 2012 R2	2023-10-10	8	64	Hyderabad DC	Windows Core OS Team
infra-e08596db	ON_PREM_VM	RedHat Enterprise Linux 7	2024-06-30	4	16	Hyderabad DC	Enterprise Systems Hosting
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, name, archetype, language, runtime_version, criticality, owner_team, app_owner_name, infrastructure_id) FROM stdin;
app-23b8c1e9	SAP ERP Central Component	COTS_VENDOR	Pre-compiled Binary	ECC 6.0 EHP8	HIGH	Enterprise Vendor Applications Team	Megan Mcclain	infra-bdd640fb
app-3b8faa18	Internal-AssetTracker	INTERNAL_TOOL	PHP	7.4.33 (Legacy)	LOW	Corporate IT Utilities	Alyssa Gonzalez	infra-0822e8f3
app-47378190	PolicyBatchProcessor-529	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Core Banking Platform DevTeam	Abigail Shaffer	infra-6b65a6a4
app-c37459ee	MainframeSettlementWrapper-259	LEGACY_MONOLITH	Java 7	1.7.0_80	MEDIUM	Enterprise Risk Ops DevTeam	Brandon Davis	infra-47229389
app-759cde66	svc-user-profile-old	MODERN_MICROSERVICE	Node.js	v20.9.0	MEDIUM	Digital Engineering Hub	Valerie Gray	infra-43b7a3a6
app-93cd59bf	Internal-AssetTracker	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Benjamin Stanley	infra-9e574f7a
app-19db3ad0	GlobalPayrollEngine-146	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Core Banking Platform DevTeam	Jesse Flowers	infra-146d3f31
app-efc89849	Secure-PciTransactionTunnel	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Andrea Reid	infra-35a240ae
app-fd5166e6	Carbon Black App Control	COTS_VENDOR	Pre-compiled Binary	v8.9.2	HIGH	Enterprise Vendor Applications Team	Melissa Robinson	infra-29d4beef
app-0837b8a3	Oracle Access Manager	COTS_VENDOR	Pre-compiled Binary	12c R2	MISSION_CRITICAL	Enterprise Vendor Applications Team	Jennifer Jones	infra-c6a7ee39
app-a7cad415	Secure-KyvValidationLedger	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Dr. Marvin Thomas Jr.	infra-e059a0ee
app-e5d7b875	Internal-OfficeFloorMapper	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Heidi Osborn	infra-434308bc
app-1c11f735	Internal-ShiftScheduler	INTERNAL_TOOL	Python (Flask)	2.3.2	LOW	Corporate IT Utilities	Christopher Becker	infra-1745d6d8
app-877409a9	Internal-OfficeFloorMapper	INTERNAL_TOOL	PHP	7.4.33 (Legacy)	LOW	Corporate IT Utilities	Juan Dunlap	infra-61b1cd22
app-444ea7c8	Tivoli Identity Manager	COTS_VENDOR	Pre-compiled Binary	v7.0.1	HIGH	Enterprise Vendor Applications Team	Gina Carter	infra-ae849217
app-436d76e2	CoreBillingLedger-911	LEGACY_MONOLITH	C++ / MFC	Native v140	HIGH	Core Banking Platform DevTeam	Pamela Romero	infra-f42d47cc
app-9be578c7	svc-user-profile-start	MODERN_MICROSERVICE	Python	3.11.5	MEDIUM	Digital Engineering Hub	James Martin	infra-4c66e0a8
app-04fc6d82	MainframeSettlementWrapper-545	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Global Wealth Management DevTeam	Jack Galloway	infra-00257ad1
app-f26b4776	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Nicholas Cabrera	infra-0ed42f1a
app-79ac1b1e	Internal-OfficeFloorMapper	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Carmen Rose	infra-c40db9b4
app-badcc32a	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Michelle Ross	infra-36386821
app-1efa2197	Secure-KyvValidationLedger	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Austin Smith	infra-702753a1
app-a18ff6b6	LegacyClearingHouse-662	LEGACY_MONOLITH	Java 7	1.7.0_80	MISSION_CRITICAL	Core Banking Platform DevTeam	Austin Johnson	infra-38602ab6
app-36d8393a	Internal-OfficeFloorMapper	INTERNAL_TOOL	JavaScript (Express)	4.18.2	LOW	Corporate IT Utilities	Miranda Khan	infra-3ceddf2d
app-30beb45f	svc-notification-item	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	HIGH	Digital Engineering Hub	Matthew Gomez	infra-c8dcd19f
app-a56c0941	PolicyBatchProcessor-325	LEGACY_MONOLITH	Java 6	1.6.0_45	MISSION_CRITICAL	Core Banking Platform DevTeam	James Morgan	infra-0dde29a6
app-23e2fcb4	Informatica PowerCenter	COTS_VENDOR	Pre-compiled Binary	v10.5	MISSION_CRITICAL	Enterprise Vendor Applications Team	Donald Wright	infra-310c0c00
app-19108be5	Oracle Access Manager	COTS_VENDOR	Pre-compiled Binary	12c R2	HIGH	Enterprise Vendor Applications Team	Zachary Huff	infra-ceda8bbb
app-680ac07a	LegacyClearingHouse-578	LEGACY_MONOLITH	Java 6	1.6.0_45	HIGH	Digital Channel Delivery DevTeam	Mr. James Brown	infra-c0e9ab30
app-c8fe3ccd	Secure-PciTransactionTunnel	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Jay Bernard	infra-63f2ae24
app-309d258c	CoreBillingLedger-385	LEGACY_MONOLITH	C++ / MFC	Native v140	MISSION_CRITICAL	Digital Channel Delivery DevTeam	Wayne Riley	infra-a97065e1
app-7a0ecfea	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Sarah Moore	infra-504867ba
app-1165e210	Secure-HipaaRecordEncryptor	COMPLIANCE_CRITICAL	C# / .NET 8	v8.0.100	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Cynthia Wilson	infra-d9f195d0
app-14fcdd54	LegacyClearingHouse-371	LEGACY_MONOLITH	C++ / MFC	Native v140	MISSION_CRITICAL	Global Wealth Management DevTeam	Kevin Mills	infra-94340a03
app-43ff5011	SAP ERP Central Component	COTS_VENDOR	Pre-compiled Binary	ECC 6.0 EHP8	MISSION_CRITICAL	Enterprise Vendor Applications Team	Michael Evans	infra-ab73295b
app-9f044aed	svc-auth-worker	MODERN_MICROSERVICE	Java 21	Spring Boot 3.2.0	MEDIUM	Digital Engineering Hub	Dr. Angel Lewis MD	infra-ef8c485b
app-286218b8	Internal-AssetTracker	INTERNAL_TOOL	PHP	7.4.33 (Legacy)	LOW	Corporate IT Utilities	Joshua Turner	infra-e117dac3
app-d12dbc9a	PolicyBatchProcessor-352	LEGACY_MONOLITH	COBOL	IBM Enterprise v4.2	HIGH	Global Wealth Management DevTeam	Tara Garcia	infra-a76afde6
app-8da01097	Carbon Black App Control	COTS_VENDOR	Pre-compiled Binary	v8.9.2	MISSION_CRITICAL	Enterprise Vendor Applications Team	Douglas Clark	infra-1d8cbbac
app-7d106c60	svc-notification-protect	MODERN_MICROSERVICE	Node.js	v20.9.0	LOW	Digital Engineering Hub	Terry Williams	infra-a25d6b29
app-217d65a0	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Deborah Figueroa	infra-0b49452d
app-f1eedba3	svc-user-profile-they	MODERN_MICROSERVICE	Python	3.11.5	LOW	Digital Engineering Hub	Stephanie Gardner	infra-8f9797b0
app-4eea04e7	svc-cart-service-among	MODERN_MICROSERVICE	Node.js	v20.9.0	MEDIUM	Digital Engineering Hub	Timothy Stanton	infra-25e97977
app-5a8aaeca	Secure-AuditTrailVault	COMPLIANCE_CRITICAL	Java 17	OpenJDK 17.0.9 (Hardened)	MISSION_CRITICAL	SecOps Risk Compliance Engineering	Stacey Russell	infra-ae9bec36
app-2999b735	MainframeSettlementWrapper-719	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Enterprise Risk Ops DevTeam	Rita Keith	infra-ecfedb99
app-696608aa	GlobalPayrollEngine-194	LEGACY_MONOLITH	C++ / MFC	Native v140	HIGH	Enterprise Risk Ops DevTeam	Sharon Cochran	infra-ecab3301
app-09e9db0a	LegacyClearingHouse-664	LEGACY_MONOLITH	C++ / MFC	Native v140	HIGH	Core Banking Platform DevTeam	Courtney Velasquez	infra-b386f7a4
app-39118497	PolicyBatchProcessor-665	LEGACY_MONOLITH	Java 7	1.7.0_80	HIGH	Enterprise Risk Ops DevTeam	Corey Murphy	infra-d20eac17
app-8268690b	CoreBillingLedger-782	LEGACY_MONOLITH	Java 6	1.6.0_45	MISSION_CRITICAL	HR Services Tech DevTeam	William Herrera	infra-c5f8bc16
app-94a1875d	Oracle Access Manager	COTS_VENDOR	Pre-compiled Binary	12c R2	MISSION_CRITICAL	Enterprise Vendor Applications Team	Deborah Rodriguez	infra-e08596db
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dependencies (id, source_app_id, target_app_id, protocol, criticality) FROM stdin;
dep-c9535b63	app-23b8c1e9	app-1165e210	gRPC	LOW
dep-fbf6e16f	app-23b8c1e9	app-79ac1b1e	gRPC	HIGH
dep-e645f129	app-23b8c1e9	app-0837b8a3	gRPC	MEDIUM
dep-0b5cea6a	app-3b8faa18	app-36d8393a	HTTPS	MEDIUM
dep-85197ff4	app-47378190	app-36d8393a	gRPC	MEDIUM
dep-afd5dea5	app-47378190	app-14fcdd54	JDBC	MEDIUM
dep-bcae8081	app-c37459ee	app-a18ff6b6	HTTPS	MEDIUM
dep-6e6981a3	app-759cde66	app-f1eedba3	HTTPS	MEDIUM
dep-ebb7a385	app-759cde66	app-4eea04e7	JDBC	HIGH
dep-a9d3c2e6	app-759cde66	app-309d258c	HTTPS	MEDIUM
dep-e6697833	app-759cde66	app-286218b8	HTTPS	MEDIUM
dep-aab97e49	app-93cd59bf	app-04fc6d82	JDBC	MEDIUM
dep-b27c4026	app-93cd59bf	app-3b8faa18	HTTPS	MEDIUM
dep-311c6eb6	app-93cd59bf	app-680ac07a	HTTPS	MEDIUM
dep-610faa3f	app-19db3ad0	app-680ac07a	gRPC	MEDIUM
dep-2c8d0e44	app-19db3ad0	app-e5d7b875	HTTPS	MEDIUM
dep-67f48ad5	app-19db3ad0	app-2999b735	HTTPS	MEDIUM
dep-4dcabfb7	app-efc89849	app-1efa2197	gRPC	MEDIUM
dep-c9277d9b	app-efc89849	app-7a0ecfea	MQ	HIGH
dep-527eecfa	app-fd5166e6	app-877409a9	HTTPS	LOW
dep-acf5e81e	app-fd5166e6	app-a18ff6b6	HTTPS	MEDIUM
dep-cb323e35	app-fd5166e6	app-43ff5011	HTTPS	LOW
dep-bc67f831	app-0837b8a3	app-23e2fcb4	HTTPS	MEDIUM
dep-48a639d0	app-0837b8a3	app-39118497	MQ	MEDIUM
dep-9e87e04c	app-a7cad415	app-7d106c60	gRPC	HIGH
dep-f3b63fe1	app-a7cad415	app-badcc32a	MQ	MEDIUM
dep-4f77a665	app-a7cad415	app-23b8c1e9	HTTPS	MEDIUM
dep-25b8fd4b	app-a7cad415	app-19db3ad0	HTTPS	MEDIUM
dep-fbe33b24	app-e5d7b875	app-5a8aaeca	gRPC	MEDIUM
dep-c4bbb7a9	app-e5d7b875	app-286218b8	MQ	LOW
dep-e2d9de5d	app-1c11f735	app-5a8aaeca	MQ	LOW
dep-b7e58481	app-1c11f735	app-93cd59bf	gRPC	HIGH
dep-664fa663	app-877409a9	app-30beb45f	JDBC	MEDIUM
dep-b00805cc	app-444ea7c8	app-fd5166e6	HTTPS	MEDIUM
dep-dc45d539	app-444ea7c8	app-79ac1b1e	JDBC	HIGH
dep-c7468f59	app-436d76e2	app-696608aa	HTTPS	MEDIUM
dep-cdda24ba	app-9be578c7	app-9f044aed	gRPC	LOW
dep-76ecbdd6	app-9be578c7	app-7d106c60	JDBC	LOW
dep-eadf5085	app-04fc6d82	app-43ff5011	gRPC	HIGH
dep-222282e1	app-f26b4776	app-1165e210	JDBC	LOW
dep-87f8424d	app-f26b4776	app-43ff5011	gRPC	HIGH
dep-513a7052	app-f26b4776	app-5a8aaeca	gRPC	MEDIUM
dep-714c7df4	app-79ac1b1e	app-36d8393a	gRPC	LOW
dep-e45b712e	app-79ac1b1e	app-436d76e2	JDBC	MEDIUM
dep-e827a1b9	app-badcc32a	app-efc89849	HTTPS	HIGH
dep-28be9288	app-badcc32a	app-1165e210	gRPC	MEDIUM
dep-7337c599	app-badcc32a	app-217d65a0	gRPC	MEDIUM
dep-d701410d	app-1efa2197	app-1165e210	HTTPS	LOW
dep-c715b2b9	app-1efa2197	app-a7cad415	HTTPS	HIGH
dep-3d3f3799	app-1efa2197	app-5a8aaeca	HTTPS	MEDIUM
dep-b6aae05b	app-a18ff6b6	app-47378190	HTTPS	HIGH
dep-55fa1ab8	app-a18ff6b6	app-9be578c7	MQ	HIGH
dep-14a0bccb	app-a18ff6b6	app-1c11f735	HTTPS	MEDIUM
dep-620e99d3	app-36d8393a	app-436d76e2	HTTPS	LOW
dep-36c59dac	app-36d8393a	app-0837b8a3	HTTPS	MEDIUM
dep-54b4a482	app-30beb45f	app-7d106c60	HTTPS	HIGH
dep-0ff0a55c	app-30beb45f	app-4eea04e7	HTTPS	LOW
dep-63b4c08b	app-30beb45f	app-f1eedba3	JDBC	LOW
dep-f2311f17	app-30beb45f	app-39118497	JDBC	MEDIUM
dep-e172b725	app-a56c0941	app-2999b735	MQ	MEDIUM
dep-7a1b5806	app-a56c0941	app-14fcdd54	gRPC	LOW
dep-4c71e0fe	app-23e2fcb4	app-43ff5011	MQ	HIGH
dep-e4429ebb	app-23e2fcb4	app-286218b8	HTTPS	MEDIUM
dep-89c8d2ab	app-19108be5	app-4eea04e7	HTTPS	LOW
dep-ccc42903	app-19108be5	app-286218b8	HTTPS	HIGH
dep-7cfc9b79	app-19108be5	app-23e2fcb4	gRPC	HIGH
dep-7c5308bf	app-680ac07a	app-2999b735	gRPC	LOW
dep-ab3b4d37	app-680ac07a	app-47378190	HTTPS	MEDIUM
dep-b963f37f	app-c8fe3ccd	app-23e2fcb4	HTTPS	HIGH
dep-eb67146a	app-c8fe3ccd	app-1efa2197	MQ	MEDIUM
dep-88bc539c	app-c8fe3ccd	app-5a8aaeca	JDBC	MEDIUM
dep-978648f8	app-309d258c	app-696608aa	HTTPS	MEDIUM
dep-157d94a1	app-309d258c	app-09e9db0a	HTTPS	MEDIUM
dep-dde9f863	app-309d258c	app-04fc6d82	JDBC	MEDIUM
dep-42999aa4	app-7a0ecfea	app-1165e210	HTTPS	HIGH
dep-74672cd9	app-7a0ecfea	app-696608aa	HTTPS	MEDIUM
dep-e1301617	app-7a0ecfea	app-217d65a0	MQ	MEDIUM
dep-f3821cfd	app-7a0ecfea	app-1efa2197	MQ	HIGH
dep-d5bcb8d0	app-1165e210	app-a18ff6b6	JDBC	HIGH
dep-bfc00dc8	app-1165e210	app-4eea04e7	HTTPS	LOW
dep-f3b1025b	app-14fcdd54	app-19db3ad0	JDBC	HIGH
dep-1190f938	app-14fcdd54	app-696608aa	HTTPS	LOW
dep-0a4e5b70	app-43ff5011	app-e5d7b875	JDBC	HIGH
dep-3f4df561	app-43ff5011	app-7d106c60	gRPC	MEDIUM
dep-9f0fda8d	app-43ff5011	app-23b8c1e9	HTTPS	LOW
dep-793b4c32	app-9f044aed	app-14fcdd54	HTTPS	HIGH
dep-f2a03459	app-9f044aed	app-759cde66	JDBC	LOW
dep-41992fdf	app-9f044aed	app-4eea04e7	HTTPS	LOW
dep-9b1bc895	app-286218b8	app-1c11f735	JDBC	MEDIUM
dep-b7e6427c	app-d12dbc9a	app-309d258c	JDBC	LOW
dep-29ec8e49	app-d12dbc9a	app-8268690b	HTTPS	MEDIUM
dep-9424aed5	app-d12dbc9a	app-39118497	HTTPS	MEDIUM
dep-93676a02	app-8da01097	app-04fc6d82	MQ	HIGH
dep-60141de9	app-8da01097	app-badcc32a	HTTPS	HIGH
dep-32c5bd89	app-7d106c60	app-9f044aed	HTTPS	HIGH
dep-d4a057a7	app-7d106c60	app-f1eedba3	HTTPS	MEDIUM
dep-b27b3d90	app-7d106c60	app-759cde66	gRPC	HIGH
dep-af2b99b4	app-217d65a0	app-39118497	gRPC	HIGH
dep-cbd58bf6	app-217d65a0	app-444ea7c8	HTTPS	MEDIUM
dep-0a8381be	app-f1eedba3	app-93cd59bf	HTTPS	MEDIUM
dep-a9597663	app-f1eedba3	app-30beb45f	HTTPS	MEDIUM
dep-a5c5650c	app-f1eedba3	app-7d106c60	HTTPS	MEDIUM
dep-6b88f83d	app-f1eedba3	app-7a0ecfea	gRPC	MEDIUM
dep-6efb63b1	app-4eea04e7	app-9f044aed	JDBC	LOW
dep-e43e4288	app-4eea04e7	app-696608aa	MQ	LOW
dep-272a6d8e	app-4eea04e7	app-759cde66	JDBC	HIGH
dep-859131d2	app-4eea04e7	app-f1eedba3	HTTPS	MEDIUM
dep-9dac6e83	app-4eea04e7	app-5a8aaeca	MQ	MEDIUM
dep-c64ee6e3	app-5a8aaeca	app-7a0ecfea	HTTPS	MEDIUM
dep-d36357b6	app-5a8aaeca	app-7d106c60	HTTPS	MEDIUM
dep-52828d80	app-5a8aaeca	app-8da01097	HTTPS	MEDIUM
dep-ef43613c	app-2999b735	app-d12dbc9a	HTTPS	MEDIUM
dep-7367c28d	app-2999b735	app-759cde66	gRPC	LOW
dep-91e1aa96	app-2999b735	app-a18ff6b6	HTTPS	MEDIUM
dep-561e16d1	app-696608aa	app-47378190	MQ	MEDIUM
dep-533420e6	app-696608aa	app-a18ff6b6	HTTPS	HIGH
dep-5ad5cf06	app-696608aa	app-4eea04e7	JDBC	HIGH
dep-4797b2c9	app-09e9db0a	app-2999b735	MQ	MEDIUM
dep-e14eb70d	app-09e9db0a	app-47378190	HTTPS	MEDIUM
dep-8441aefd	app-39118497	app-309d258c	HTTPS	MEDIUM
dep-3dc98290	app-39118497	app-436d76e2	HTTPS	MEDIUM
dep-8e200724	app-8268690b	app-2999b735	HTTPS	MEDIUM
dep-79e13cea	app-94a1875d	app-8da01097	gRPC	HIGH
dep-72bb912d	app-94a1875d	app-79ac1b1e	JDBC	MEDIUM
dep-4b5305e5	app-94a1875d	app-0837b8a3	HTTPS	LOW
\.


--
-- Data for Name: operational_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operational_metrics (id, application_id, incidents_last_quarter, mttr_hours, availability_pct, cpu_utilization_pct) FROM stdin;
metric-6dda4f8d	app-23b8c1e9	2	4.37	99.539	40.23
metric-c4767556	app-3b8faa18	1	11.56	98.151	4.06
metric-accb461a	app-47378190	7	13.25	95.023	82.41
metric-9be71737	app-c37459ee	6	10.07	96.598	66.9
metric-b18753e6	app-759cde66	1	0.13	99.984	10.85
metric-45f50c52	app-93cd59bf	0	7.68	97.117	2.25
metric-ebe9e207	app-19db3ad0	8	17.17	97.128	72.53
metric-2e709838	app-efc89849	0	1.11	99.989	35.16
metric-a847bce7	app-fd5166e6	4	6.99	99.828	42.64
metric-bdb025ff	app-0837b8a3	1	3.46	99.53	55.72
metric-177d6e7e	app-a7cad415	1	1.81	99.98	36.65
metric-604e46cb	app-e5d7b875	0	4.61	97.95	3.12
metric-284bf962	app-1c11f735	0	11.25	97.524	3.91
metric-530ac1c7	app-877409a9	2	10.52	97.354	1.59
metric-98a21f1c	app-444ea7c8	2	3.04	99.138	62.77
metric-27d415b6	app-436d76e2	5	10.83	97.319	74.82
metric-0cbd3c03	app-9be578c7	1	0.37	99.985	22.86
metric-716fda0a	app-04fc6d82	9	13.17	97.913	69.48
metric-9b69554d	app-f26b4776	1	0.6	99.968	39.08
metric-372f871a	app-79ac1b1e	1	8.73	97.528	1.3
metric-585d3f86	app-badcc32a	1	1.18	99.952	54.95
metric-ad9fb00d	app-1efa2197	0	1.47	99.989	32.71
metric-86e52753	app-a18ff6b6	9	16.11	96.388	76.63
metric-3873e57f	app-36d8393a	2	11.17	97.675	4.24
metric-0e0630cd	app-30beb45f	0	0.23	99.969	13.02
metric-f200c261	app-a56c0941	5	15.21	97.433	85.12
metric-c3a00c6f	app-23e2fcb4	1	5.03	99.155	47.43
metric-1eb74b56	app-19108be5	4	7.95	99.472	58.29
metric-6e3f683a	app-680ac07a	7	13.97	95.849	72.26
metric-88575117	app-c8fe3ccd	1	1.52	99.952	48.93
metric-8f0881ee	app-309d258c	7	9.05	95.284	80.35
metric-5aaab32f	app-7a0ecfea	1	0.88	99.984	58.93
metric-bdf66ba5	app-1165e210	0	1	99.973	34.24
metric-75b27455	app-14fcdd54	7	12.96	96.968	79.86
metric-5024bdc6	app-43ff5011	2	5.57	99.844	49.29
metric-67884209	app-9f044aed	1	0.36	99.963	12.56
metric-4a1dab32	app-286218b8	2	10.63	98.108	3.74
metric-f758dce2	app-d12dbc9a	9	9.5	97.011	75.25
metric-f296d9f0	app-8da01097	1	4.18	99.162	46.43
metric-b08a4895	app-7d106c60	1	0.18	99.99	13.1
metric-6fcc57dd	app-217d65a0	1	1.77	99.954	53.13
metric-6f887f28	app-f1eedba3	0	0.36	99.985	22.36
metric-1422373f	app-4eea04e7	1	0.16	99.957	23.86
metric-beed10b6	app-5a8aaeca	0	1.58	99.952	40.93
metric-c77444cb	app-2999b735	10	11.8	96.333	68.55
metric-a21b0307	app-696608aa	10	20.54	95.702	67.18
metric-31a3ac4d	app-09e9db0a	8	22.46	95.582	80.35
metric-59e1ac09	app-39118497	9	23.75	96.385	68.45
metric-a53bc024	app-8268690b	8	16.05	96.256	64.86
metric-1a5165ca	app-94a1875d	2	6.81	99.125	47.5
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
vuln-3e493f43	app-23b8c1e9	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-01-19	f	\N	Isolated from public internet
vuln-79279973	app-23b8c1e9	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-07-30	t	Vendor patch available	\N
vuln-ff233d5f	app-23b8c1e9	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-12-27	f	\N	Isolated from public internet
vuln-b3ee4d3b	app-23b8c1e9	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-05-14	t	Vendor patch available	\N
vuln-3b048a8b	app-3b8faa18	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-08-28	f	\N	Isolated from public internet
vuln-1e9b23bc	app-3b8faa18	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-12-25	t	Vendor patch available	\N
vuln-b0ae8f08	app-3b8faa18	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-10-17	t	Vendor patch available	\N
vuln-7bf47042	app-47378190	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2024-12-27	f	\N	Isolated from public internet
vuln-c29cfc0c	app-47378190	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-07-08	f	\N	Isolated from public internet
vuln-19bc143e	app-47378190	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2026-03-04	t	Vendor patch available	\N
vuln-5c62b3a2	app-47378190	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-10-13	t	Vendor patch available	\N
vuln-88bd13d1	app-47378190	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-09-02	f	\N	Isolated from public internet
vuln-0df56ac6	app-47378190	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-07-30	t	Vendor patch available	\N
vuln-2053da42	app-47378190	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-10-04	t	Vendor patch available	\N
vuln-1a432f0a	app-47378190	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-04-04	t	Vendor patch available	\N
vuln-782a65e0	app-c37459ee	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-06-02	t	Vendor patch available	\N
vuln-f72ada9b	app-c37459ee	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-07-05	t	Vendor patch available	\N
vuln-7a4c75d4	app-c37459ee	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-08-23	f	\N	Isolated from public internet
vuln-7de31a51	app-c37459ee	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2024-07-23	t	Vendor patch available	\N
vuln-0db95301	app-c37459ee	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-09-21	f	\N	Isolated from public internet
vuln-f2f9e5fa	app-c37459ee	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-01-17	t	Vendor patch available	\N
vuln-1e52d770	app-c37459ee	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-08-03	t	Vendor patch available	\N
vuln-989bc4da	app-c37459ee	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-01-31	f	\N	Isolated from public internet
vuln-85c7504b	app-c37459ee	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-03-18	f	\N	Isolated from public internet
vuln-4c1f55ab	app-c37459ee	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2026-03-26	t	Vendor patch available	\N
vuln-4e2d6645	app-759cde66	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-08-11	f	\N	Isolated from public internet
vuln-f5c9b047	app-93cd59bf	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-12-22	f	\N	Isolated from public internet
vuln-3531968d	app-93cd59bf	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-09-24	t	Vendor patch available	\N
vuln-14c8b3b4	app-93cd59bf	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2024-09-25	t	Vendor patch available	\N
vuln-1337739e	app-93cd59bf	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-09-25	f	\N	Isolated from public internet
vuln-b07aa066	app-19db3ad0	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-08-31	t	Vendor patch available	\N
vuln-3b4206c5	app-19db3ad0	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-01-05	f	\N	Isolated from public internet
vuln-dc0f2fcf	app-19db3ad0	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-05-14	f	\N	Isolated from public internet
vuln-ec856f37	app-19db3ad0	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2024-12-18	f	\N	Isolated from public internet
vuln-96fc734d	app-19db3ad0	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-10-22	t	Vendor patch available	\N
vuln-6cd5e859	app-19db3ad0	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-08-24	t	Vendor patch available	\N
vuln-26242b40	app-19db3ad0	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2026-05-02	t	Vendor patch available	\N
vuln-1247ea4e	app-19db3ad0	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-07-12	t	Vendor patch available	\N
vuln-9854ce4e	app-19db3ad0	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-12-29	t	Vendor patch available	\N
vuln-49e2623d	app-19db3ad0	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-05-03	t	Vendor patch available	\N
vuln-4dd8eb85	app-efc89849	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-11-21	t	Vendor patch available	\N
vuln-801ef1da	app-fd5166e6	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-07-20	f	\N	Isolated from public internet
vuln-9918ee46	app-fd5166e6	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-06-26	t	Vendor patch available	\N
vuln-5283aac7	app-fd5166e6	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-09-07	t	Vendor patch available	\N
vuln-3a9aca5e	app-0837b8a3	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-11-01	f	\N	Isolated from public internet
vuln-964db03f	app-0837b8a3	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-06-12	t	Vendor patch available	\N
vuln-d248a9a7	app-0837b8a3	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-12-22	t	Vendor patch available	\N
vuln-c19ad58c	app-0837b8a3	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-10-10	t	Vendor patch available	\N
vuln-7135f221	app-0837b8a3	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2026-05-08	t	Vendor patch available	\N
vuln-95d82980	app-0837b8a3	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-04-30	t	Vendor patch available	\N
vuln-f8140102	app-a7cad415	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-08-05	t	Vendor patch available	\N
vuln-5553b2fe	app-e5d7b875	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-01-31	f	\N	Isolated from public internet
vuln-292bd156	app-e5d7b875	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-02-07	f	\N	Isolated from public internet
vuln-49c8a43f	app-1c11f735	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-10-23	t	Vendor patch available	\N
vuln-c2b01cfd	app-1c11f735	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-07-28	f	\N	Isolated from public internet
vuln-50843242	app-1c11f735	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-12-09	t	Vendor patch available	\N
vuln-c5c5b37a	app-877409a9	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-04-05	t	Vendor patch available	\N
vuln-fcf56188	app-877409a9	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2024-05-27	t	Vendor patch available	\N
vuln-764414fd	app-877409a9	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-04-12	t	Vendor patch available	\N
vuln-5c9d927d	app-877409a9	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-09-22	f	\N	Isolated from public internet
vuln-71299889	app-444ea7c8	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2026-01-07	t	Vendor patch available	\N
vuln-8c99a894	app-444ea7c8	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-09-05	t	Vendor patch available	\N
vuln-e17f29e1	app-436d76e2	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-11-20	t	Vendor patch available	\N
vuln-f920264c	app-436d76e2	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-09-28	t	Vendor patch available	\N
vuln-b5b453ca	app-436d76e2	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-09-27	t	Vendor patch available	\N
vuln-8d605936	app-436d76e2	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-04-08	f	\N	Isolated from public internet
vuln-d7665cda	app-436d76e2	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2026-05-06	f	\N	Isolated from public internet
vuln-1e1242e3	app-436d76e2	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-10-12	f	\N	Isolated from public internet
vuln-eec259dc	app-436d76e2	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-12-04	t	Vendor patch available	\N
vuln-45ff2c83	app-436d76e2	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-04-14	t	Vendor patch available	\N
vuln-78e3654b	app-436d76e2	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-12-02	f	\N	Isolated from public internet
vuln-6232b17a	app-436d76e2	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-10-22	t	Vendor patch available	\N
vuln-bf0d073d	app-9be578c7	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2026-04-09	t	Vendor patch available	\N
vuln-46b82659	app-04fc6d82	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2026-01-17	t	Vendor patch available	\N
vuln-57021049	app-04fc6d82	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2026-05-22	f	\N	Isolated from public internet
vuln-d20f87d0	app-04fc6d82	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-05-28	t	Vendor patch available	\N
vuln-d664d264	app-04fc6d82	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-08-25	f	\N	Isolated from public internet
vuln-7d5911c6	app-04fc6d82	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2026-03-30	f	\N	Isolated from public internet
vuln-7bfdcc12	app-04fc6d82	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-02-19	t	Vendor patch available	\N
vuln-8b1e3b9d	app-04fc6d82	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-03-15	f	\N	Isolated from public internet
vuln-de9e3757	app-04fc6d82	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-10-20	t	Vendor patch available	\N
vuln-9261549d	app-04fc6d82	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-03-20	f	\N	Isolated from public internet
vuln-69288e92	app-f26b4776	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2024-06-29	t	Vendor patch available	\N
vuln-b489d070	app-79ac1b1e	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2026-05-06	f	\N	Isolated from public internet
vuln-fd08b32c	app-1efa2197	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-10-24	f	\N	Isolated from public internet
vuln-fb16e5db	app-a18ff6b6	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-09-22	t	Vendor patch available	\N
vuln-2051acef	app-a18ff6b6	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-06-21	t	Vendor patch available	\N
vuln-dea4ae17	app-a18ff6b6	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-08-12	f	\N	Isolated from public internet
vuln-1986b4b2	app-a18ff6b6	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-07-09	t	Vendor patch available	\N
vuln-b8f21423	app-a18ff6b6	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-09-15	t	Vendor patch available	\N
vuln-f84f16b3	app-a18ff6b6	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-09-23	f	\N	Isolated from public internet
vuln-f81dbaa1	app-36d8393a	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-12-18	t	Vendor patch available	\N
vuln-65c17795	app-36d8393a	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-10-13	f	\N	Isolated from public internet
vuln-da330aa1	app-36d8393a	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-11-01	f	\N	Isolated from public internet
vuln-f4427e0b	app-30beb45f	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-01-27	f	\N	Isolated from public internet
vuln-c268283e	app-a56c0941	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-06-10	f	\N	Isolated from public internet
vuln-9e11d2cd	app-a56c0941	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2024-07-19	t	Vendor patch available	\N
vuln-ebc2026f	app-a56c0941	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-01-05	t	Vendor patch available	\N
vuln-1723199d	app-a56c0941	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-04-29	t	Vendor patch available	\N
vuln-a23d4c2f	app-a56c0941	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-11-24	f	\N	Isolated from public internet
vuln-2a96e1e2	app-a56c0941	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-11-17	t	Vendor patch available	\N
vuln-0bc61066	app-a56c0941	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-02-02	t	Vendor patch available	\N
vuln-5bc440f1	app-a56c0941	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-03-14	f	\N	Isolated from public internet
vuln-87fa841a	app-a56c0941	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-04-12	f	\N	Isolated from public internet
vuln-2e183554	app-23e2fcb4	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-10-06	f	\N	Isolated from public internet
vuln-deef580f	app-23e2fcb4	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-03-20	f	\N	Isolated from public internet
vuln-7f671eec	app-23e2fcb4	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-05-06	f	\N	Isolated from public internet
vuln-760debbb	app-23e2fcb4	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-10-04	f	\N	Isolated from public internet
vuln-aab612c9	app-23e2fcb4	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-06-03	t	Vendor patch available	\N
vuln-e6b5a92c	app-23e2fcb4	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-01-05	f	\N	Isolated from public internet
vuln-12e89d10	app-19108be5	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-05-05	f	\N	Isolated from public internet
vuln-966b1964	app-19108be5	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-01-14	t	Vendor patch available	\N
vuln-b0b862ef	app-19108be5	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2024-12-07	f	\N	Isolated from public internet
vuln-32ffe294	app-680ac07a	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-03-21	f	\N	Isolated from public internet
vuln-3cb98350	app-680ac07a	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-03-19	f	\N	Isolated from public internet
vuln-4bbe4aff	app-680ac07a	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-11-21	t	Vendor patch available	\N
vuln-d47d577b	app-680ac07a	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-10-20	t	Vendor patch available	\N
vuln-90e0b95f	app-680ac07a	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2026-03-29	f	\N	Isolated from public internet
vuln-f93e08d5	app-680ac07a	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-07-04	f	\N	Isolated from public internet
vuln-7f2984f5	app-680ac07a	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2026-03-04	t	Vendor patch available	\N
vuln-c696f5e6	app-680ac07a	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2026-02-06	t	Vendor patch available	\N
vuln-5a31b4cc	app-309d258c	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2024-11-13	f	\N	Isolated from public internet
vuln-402913ec	app-309d258c	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-11-04	t	Vendor patch available	\N
vuln-a8c01f05	app-309d258c	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-11-06	t	Vendor patch available	\N
vuln-18dfbc3c	app-309d258c	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2026-04-28	f	\N	Isolated from public internet
vuln-4f1639a0	app-309d258c	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2026-01-29	f	\N	Isolated from public internet
vuln-5d678bb1	app-309d258c	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-12-16	t	Vendor patch available	\N
vuln-4b8c5bdc	app-309d258c	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-02-04	f	\N	Isolated from public internet
vuln-336749b5	app-309d258c	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-09-06	t	Vendor patch available	\N
vuln-f8b38a8b	app-309d258c	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-03-07	f	\N	Isolated from public internet
vuln-45c45a3e	app-309d258c	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-03-03	t	Vendor patch available	\N
vuln-d31edf1a	app-7a0ecfea	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-06-05	f	\N	Isolated from public internet
vuln-bf1e8366	app-1165e210	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2026-04-03	t	Vendor patch available	\N
vuln-77e490c7	app-14fcdd54	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-07-24	t	Vendor patch available	\N
vuln-39c1e262	app-14fcdd54	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-03-26	t	Vendor patch available	\N
vuln-fadd7ea3	app-14fcdd54	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-03-31	t	Vendor patch available	\N
vuln-8eac0a33	app-14fcdd54	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-03-07	t	Vendor patch available	\N
vuln-03902c5d	app-43ff5011	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-12-18	f	\N	Isolated from public internet
vuln-5e5ba13d	app-43ff5011	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-10-31	f	\N	Isolated from public internet
vuln-95a5bafa	app-43ff5011	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2025-03-18	f	\N	Isolated from public internet
vuln-5f18e583	app-43ff5011	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2024-08-19	t	Vendor patch available	\N
vuln-066803ee	app-43ff5011	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-09-20	f	\N	Isolated from public internet
vuln-53f8382b	app-43ff5011	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2026-05-07	t	Vendor patch available	\N
vuln-102efde5	app-9f044aed	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-10-02	t	Vendor patch available	\N
vuln-b379cb1e	app-286218b8	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-01-16	f	\N	Isolated from public internet
vuln-23c86d30	app-d12dbc9a	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-07-01	t	Vendor patch available	\N
vuln-fef518a6	app-d12dbc9a	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2025-06-13	f	\N	Isolated from public internet
vuln-e3236d1a	app-d12dbc9a	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-07-18	t	Vendor patch available	\N
vuln-5efa9c5b	app-d12dbc9a	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-10-29	t	Vendor patch available	\N
vuln-f22b5b98	app-d12dbc9a	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-07-20	f	\N	Isolated from public internet
vuln-ba0266ef	app-d12dbc9a	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-09-24	t	Vendor patch available	\N
vuln-19597b5a	app-d12dbc9a	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2026-03-05	t	Vendor patch available	\N
vuln-f065c817	app-8da01097	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-12-30	f	\N	Isolated from public internet
vuln-379efc6e	app-8da01097	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-05-06	t	Vendor patch available	\N
vuln-dafec8a9	app-8da01097	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-03-04	t	Vendor patch available	\N
vuln-5e09a9ee	app-8da01097	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-07-23	t	Vendor patch available	\N
vuln-5bd20c98	app-8da01097	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-07-13	t	Vendor patch available	\N
vuln-f7dc67e0	app-8da01097	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2024-08-29	t	Vendor patch available	\N
vuln-74685b98	app-7d106c60	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2024-08-06	t	Vendor patch available	\N
vuln-a3b5cece	app-217d65a0	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-09-02	f	\N	Isolated from public internet
vuln-c96b5edb	app-f1eedba3	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2025-02-10	f	\N	Isolated from public internet
vuln-c9776598	app-4eea04e7	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-08-08	t	Vendor patch available	\N
vuln-c3e15a85	app-2999b735	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-07-31	t	Vendor patch available	\N
vuln-d0243d72	app-2999b735	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2026-04-02	t	Vendor patch available	\N
vuln-25c61c45	app-2999b735	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2026-01-29	t	Vendor patch available	\N
vuln-46fb7bf3	app-2999b735	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-03-24	f	\N	Isolated from public internet
vuln-21472a15	app-696608aa	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-07-20	f	\N	Isolated from public internet
vuln-1c24220e	app-696608aa	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-10-22	t	Vendor patch available	\N
vuln-03cde2e3	app-696608aa	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-03-01	t	Vendor patch available	\N
vuln-96bf10ab	app-696608aa	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-02-02	t	Vendor patch available	\N
vuln-0d6a05b3	app-696608aa	CVE-2021-26855	Microsoft Exchange SSRF (ProxyLogon)	CRITICAL	9.1	2024-09-02	f	\N	Isolated from public internet
vuln-1d181ee9	app-696608aa	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-12-27	t	Vendor patch available	\N
vuln-c72c1fe3	app-696608aa	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-03-04	t	Vendor patch available	\N
vuln-73b6a09b	app-696608aa	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-06-22	f	\N	Isolated from public internet
vuln-0b19f88e	app-09e9db0a	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-12-12	f	\N	Isolated from public internet
vuln-a8addf36	app-09e9db0a	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2025-07-06	f	\N	Isolated from public internet
vuln-f6ca6b8b	app-09e9db0a	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2024-06-20	f	\N	Isolated from public internet
vuln-d8e88ebb	app-09e9db0a	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-04-03	f	\N	Isolated from public internet
vuln-7d824264	app-09e9db0a	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-12-01	f	\N	Isolated from public internet
vuln-e63658c9	app-09e9db0a	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2024-07-28	t	Vendor patch available	\N
vuln-10d08d11	app-39118497	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2024-09-02	t	Vendor patch available	\N
vuln-95da75c1	app-39118497	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-07-26	f	\N	Isolated from public internet
vuln-fe9fecaa	app-39118497	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-09-03	t	Vendor patch available	\N
vuln-816bcb9f	app-39118497	CVE-2021-44228	Log4Shell Remote Code Execution	CRITICAL	9.8	2025-09-09	t	Vendor patch available	\N
vuln-b3a7d0e0	app-39118497	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2024-08-23	t	Vendor patch available	\N
vuln-e0b15aba	app-39118497	CVE-2023-50164	Apache Struts File Upload	CRITICAL	9.8	2026-01-14	f	\N	Isolated from public internet
vuln-370bc063	app-39118497	CVE-2024-3094	XZ Utils Backdoor	CRITICAL	10	2025-04-26	t	Vendor patch available	\N
vuln-69efafb1	app-39118497	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-02-14	f	\N	Isolated from public internet
vuln-6a7e4c36	app-39118497	CVE-2022-30190	Follina MSDT RCE	HIGH	7.8	2025-12-14	t	Vendor patch available	\N
vuln-50018b7b	app-8268690b	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-10-25	f	\N	Isolated from public internet
vuln-2713582c	app-8268690b	CVE-2017-5638	Apache Struts2 RCE	CRITICAL	10	2025-11-11	t	Vendor patch available	\N
vuln-175a81ec	app-8268690b	CVE-2023-22515	Confluence Broken Access Control	CRITICAL	9.1	2026-03-04	f	\N	Isolated from public internet
vuln-18b87245	app-8268690b	CVE-2022-26134	Confluence OGNL Injection	CRITICAL	9.8	2025-12-26	t	Vendor patch available	\N
vuln-214f3f12	app-8268690b	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-08-02	t	Vendor patch available	\N
vuln-8fc42092	app-8268690b	CVE-2023-4863	WebP Heap Overflow	HIGH	8.8	2025-08-06	t	Vendor patch available	\N
vuln-692ac139	app-8268690b	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2025-02-25	t	Vendor patch available	\N
vuln-c012a0ff	app-94a1875d	CVE-2020-1472	Zerologon Privilege Escalation	CRITICAL	10	2025-04-20	t	Vendor patch available	\N
vuln-0d2b91ef	app-94a1875d	CVE-2019-19781	Citrix Path Traversal	CRITICAL	9.8	2025-01-05	t	Vendor patch available	\N
vuln-1a85910d	app-94a1875d	CVE-2014-0160	Heartbleed Memory Disclosure	HIGH	7.5	2025-08-18	f	\N	Isolated from public internet
vuln-a81fdec3	app-94a1875d	CVE-2022-22965	Spring4Shell RCE	CRITICAL	9.8	2025-06-05	t	Vendor patch available	\N
vuln-59a1120e	app-94a1875d	CVE-2023-46604	Apache ActiveMQ RCE	CRITICAL	10	2026-03-14	t	Vendor patch available	\N
vuln-c33a1f6c	app-94a1875d	CVE-2023-38831	WinRAR Remote Code Execution	HIGH	7.8	2024-12-29	t	Vendor patch available	\N
\.


--
-- PostgreSQL database dump complete
--

\unrestrict O0jV3NUkbuyC2fgClkJRSYbkyi8IxyRzOShTbyJv3Q4LIOFemhHSjLeuOosIviT

