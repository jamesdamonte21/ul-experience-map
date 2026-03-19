-- ============================================================
-- Certification Experience Map — Seed Data
-- Run AFTER schema.sql in: Supabase → SQL Editor → New query
-- Data sourced from certification_experience_map_1.html
-- ============================================================

-- ============================================================
-- 1. PHASES
-- ============================================================
INSERT INTO phases (sort_order, short_id, name, color_bg, color_text) VALUES
  (1, 'P1', 'Intake & Scoping',    '#EEEDFE', '#3C3489'),
  (2, 'P2', 'Project Setup',       '#E1F5EE', '#085041'),
  (3, 'P3', 'Evaluation',          '#E6F1FB', '#0C447C'),
  (4, 'P4', 'Testing',             '#FAEEDA', '#633806'),
  (5, 'P5', 'Reporting & Cert',    '#FAECE7', '#712B13'),
  (6, 'P6', 'Surveillance',        '#FBEAF0', '#72243E'),
  (7, 'P7', 'Closure',             '#EAF3DE', '#27500A');

-- ============================================================
-- 2. CELLS — summary (grid) and detail (panel)
-- ============================================================

-- P1: Intake & Scoping
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (1, 'desc',
   'Customer inquiry → PSN/Oracle → COU determination → journey type (New/Alt/STT/Ongoing/R&D). DAP eligibility, ML requirements, and customer support level documented.',
   'Customer inquiry → PSN/Oracle → COU determination → journey type (New/Alt/STT/Ongoing/R&D). DAP eligibility, ML requirements, and customer support level documented.'),
  (1, 'humans',
   'Sales / Sales Ops, Project Handlers (COU-specific), Engineers L2–L4 (GMA, High Speed Team)',
   E'1. Sales / Sales Operations / Inside Sales\n2. Project Handlers (COU-specific)\n3. Project Engineers (L2/L3/L4) — Global Market Access, High Speed Team'),
  (1, 'systems',
   'Salesforce, Oracle, Flex, ECM, IFVS, Workbench, Standards Hub, DCS, Product IQ, CTR, ERIS + 20 more',
   'Salesforce, Oracle, Flex, ECM, IFVS, Workbench, Standards Hub, DCS, Product IQ, CTR, ERIS + 20 more'),
  (1, 'pain',
   '9+ disconnected systems, manual re-entry, Flex↔Oracle gap, COU edge cases unclear, DAP/ML not standardized',
   E'• 9+ systems with scattered info; manual re-entry; Flex disconnected from Oracle/Sales\n• Variable doc quality; personal workarounds compensate; low trust in systems/AI\n• COU logic unclear for edge cases; DAP/Multiple Listing not standardized'),
  (1, 'works',
   'Auto-populate data (directionally right), standardized intake checklist, journey recommendation engine, COU assignment engine, early clause mapping',
   'Auto-populate data (directionally right), standardized intake checklist, journey recommendation engine, COU assignment engine, early clause mapping'),
  (1, 'work',
   'New engineers struggle with journey type; experienced engineers waste time on manual compensations',
   'New engineers struggle with journey type determination; experienced engineers spend significant time compensating for system gaps with personal workarounds.'),
  (1, 'qs',
   'Right COU? Journey type? Sufficient info? DAP qualified? Capacity available?',
   E'Is this the correct COU?\nRight journey type?\nSufficient info to proceed?\nDAP qualified?\nCapacity available?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (1, 'future',
   '9+ disconnected systems. Manual re-entry. Personal workarounds pervasive.',
   'Unified intake. Journey/COU recommendation engines. Single source of truth.',
   '9+ disconnected systems. Manual re-entry. → Unified intake. Journey/COU recommendation engines.',
   E'CURRENT:\n9+ disconnected systems. Manual re-entry. Personal workarounds pervasive.\n\nFUTURE:\nUnified intake. Journey/COU recommendation engines. Single source of truth.');

-- P2: Project Setup
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (2, 'desc',
   'Kickoff, template selection, engineer assignment, Flex setup with orderlines, standards/clause mapping, test plan dev & approval, lab scheduling, sample requirements communicated.',
   'Kickoff, template selection, engineer assignment, Flex setup with orderlines, standards/clause mapping, test plan dev & approval, lab scheduling, sample requirements communicated.'),
  (2, 'humans',
   'Handlers/Managers, Engineers L2–L4, Lab Managers, DAP Admins, Regional Specialists',
   E'1. Project Handlers, Managers, Order/Program Managers\n2. Project Engineers (L2/L3/L4) — lead standards mapping and test plan\n3. Lab Managers, Coordinators, DAP Admins, Regional Specialists'),
  (2, 'systems',
   'Flex, LabWare, ECM, Workbench, EPIC, Competency DB, Standards Hub, DCS, Oracle, SharePoint',
   'Flex, LabWare, ECM, Workbench, EPIC, Competency DB, Standards Hub, DCS, Oracle, SharePoint'),
  (2, 'pain',
   'Manual standards/clause mapping, template variance, long review cycles, no cross-COU capacity visibility, disconnected lab scheduling',
   E'• Standards ID and clause mapping manual; test plan templates vary; customer review cycles lengthy\n• No cross-COU capacity visibility; lab scheduling disconnected from Flex; data re-entry from Phase 1'),
  (2, 'works',
   'Kickoffs surface gaps early, DCS templates useful, Lab Managers effective within COU, Flex orderlines structured',
   'Kickoffs surface gaps early, DCS templates useful, Lab Managers effective within COU, Flex orderlines structured'),
  (2, 'work',
   'Personal test plan libraries, Excel milestone trackers, capacity spreadsheets, informal lab scheduling',
   'Personal test plan libraries, Excel milestone trackers, capacity spreadsheets, informal lab scheduling arrangements.'),
  (2, 'qs',
   'All standards captured? Right template? Lab capacity? Customer responsive? TAT realistic?',
   E'All standards captured?\nRight template selected?\nLab capacity available?\nCustomer responsive?\nTAT realistic?\nScope complete?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (2, 'future',
   'Manual standards/clause mapping. Templates vary. No cross-COU visibility. Phase 1→2 handoff manual.',
   'Automated standards mapping. Smart templates. Cross-COU dashboards. Automated phase handoffs.',
   'Manual standards/clause mapping. Templates vary. → Automated standards mapping. Smart templates.',
   E'CURRENT:\nManual standards/clause mapping. Templates vary. No cross-COU visibility. Phase 1→2 handoff manual.\n\nFUTURE:\nAutomated standards mapping. Smart templates. Cross-COU dashboards. Automated phase handoffs.');

-- P3: Evaluation
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (3, 'desc',
   'Engineer evaluates product vs standards. IFVS component lookup. Construction review. FU/NCR loops for clarifications & design changes. Report drafted → peer reviewed → issued.',
   'Engineer evaluates product vs standards. IFVS component lookup. Construction review. FU/NCR loops for clarifications & design changes. Report drafted → peer reviewed → issued.'),
  (3, 'humans',
   'Engineers L2–L4, Peer Reviewers, Handlers (FU/NCR comms), Customers, ML/Regional/DAP specialists',
   E'1. Project Engineers (L2/L3/L4) — lead evaluation, draft report\n2. Peer Reviewers / Senior Engineers — internal review and sign-off\n3. Project Handlers — track status, manage FU/NCR communication\n4. Customers — respond to FUs/NCRs; ML/Regional/DAP specialists'),
  (3, 'systems',
   'Workbench (primary), IFVS, ECM, Standards Hub, Product IQ, DCS, Listing Card, Flex, LabWare, Adobe PDF',
   'Workbench (primary), IFVS, ECM, Standards Hub, Product IQ, DCS, Listing Card, Flex, LabWare, Adobe PDF'),
  (3, 'pain',
   'IFVS slow, manual standards judgment, fragmented FU/NCR tracking, informal peer review bandwidth-limited, no pre-population',
   E'• IFVS lookup slow; standards application manual/judgment-dependent; customer doc navigation complex\n• FU/NCR tracking fragmented; re-evaluation loops unpredictable; peer review informal and bandwidth-limited\n• Report templates vary; multi-COU coordination manual; no pre-population from prior work'),
  (3, 'works',
   'Experienced engineer instincts, Workbench provides structure, IFVS centralized, peer review improves quality',
   'Experienced engineer instincts, Workbench provides structure, IFVS centralized, peer review improves quality'),
  (3, 'work',
   'Personal product libraries, cheat sheets, Excel FU/NCR trackers, direct customer calls, informal peer networks',
   'Personal product libraries, cheat sheets, FU/NCR Excel trackers, direct customer calls, informal peer networks for guidance.'),
  (3, 'qs',
   'All clauses identified? Docs complete? IFVS current? Customer responsive? Peer reviewer available?',
   E'All standards/clauses identified?\nDocs complete?\nIFVS current?\nCustomer responsive?\nPeer reviewer available?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (3, 'future',
   'Manual evaluation, fragmented FU/NCR tracking, variable templates, informal peer review.',
   'Automated component lookup. Integrated FU/NCR workflow. Standardized templates with pre-population.',
   'Manual evaluation, fragmented FU/NCR. → Automated component lookup. Integrated FU/NCR workflow.',
   E'CURRENT:\nManual evaluation, fragmented FU/NCR tracking, variable templates, informal peer review.\n\nFUTURE:\nAutomated component lookup. Integrated FU/NCR workflow. Standardized templates with pre-population.');

-- P4: Testing
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (4, 'desc',
   'Test plan confirmed → lab scheduled → sample inspected → testing per clauses → real-time data → results branch (pass → P5; fail → re-test loop).',
   'Test plan confirmed → lab scheduled → sample inspected → testing per clauses → real-time data → results branch (pass → P5; fail → re-test loop).'),
  (4, 'humans',
   'Engineers, Lab Techs/Test Engineers, Lab Managers, Handlers, Customers, Peer Reviewers',
   E'1. Project Engineers — oversee testing, validate data, draft report\n2. Lab Technicians / Test Engineers — execute testing, record data\n3. Lab Managers — scheduling, equipment, operations\n4. Handlers, Customers, Peer Reviewers, DAP/Listing/Regional specialists'),
  (4, 'systems',
   'LabWare (primary), Workbench, ECM, Flex, DCS, IFVS, Sample Mgmt, Fulcrum, Power BI, DMS',
   'LabWare (primary), Workbench, ECM, Flex, DCS, IFVS, Sample Mgmt, Fulcrum, Power BI, DMS'),
  (4, 'pain',
   'Lab scheduling disconnected, fragmented sample tracking, setup errors cause restarts, test data unstandardized, calibration gaps',
   E'• Lab scheduling disconnected from milestones; sample tracking fragmented; test data formats unstandardized\n• Setup errors require restart; failures slow to resolve; report templates vary; equipment calibration gaps'),
  (4, 'works',
   'Experienced Lab Tech expertise, LabWare structured, DCS templates useful, direct Engineer–Tech communication quick',
   'Experienced Lab Tech expertise, LabWare structured, DCS templates useful, direct Engineer–Tech communication quick'),
  (4, 'work',
   'Personal setup libraries, equipment spreadsheets, handwritten→digital transcription, informal scheduling',
   'Personal test setup libraries, equipment spreadsheets, informal scheduling, handwritten-to-digital transcription, informal customer calls.'),
  (4, 'qs',
   'Lab timing right? Sample OK? Setup correct? Data accurate? Equipment calibrated?',
   E'Lab timing right?\nSample condition OK?\nSetup correct?\nData accurate?\nEquipment calibrated?\nCustomer responsive to failures?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (4, 'future',
   'Lab scheduling disconnected. Sample tracking fragmented. Manual transcription. Slow failure resolution.',
   'Integrated scheduling. Automated sample tracking. Digital data recording. Intelligent report pre-population.',
   'Lab scheduling disconnected. Manual transcription. → Integrated scheduling. Digital data recording.',
   E'CURRENT:\nLab scheduling disconnected. Sample tracking fragmented. Manual transcription. Slow failure resolution.\n\nFUTURE:\nIntegrated scheduling. Automated sample tracking. Digital data recording. Intelligent report pre-population.');

-- P5: Reporting & Cert
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (5, 'desc',
   'Results compiled → compliance determined → docs assembled → Listing Card created → Certificate issued → UL Mark confirmed → billing reconciled → archived.',
   'Results compiled → compliance determined → docs assembled → Listing Card created → Certificate issued → UL Mark confirmed → billing reconciled → archived.'),
  (5, 'humans',
   'Engineers, Peer Reviewers, Handlers, Certification Office, Finance, ML/Regional/DAP specialists',
   E'1. Project Engineers, Peer Reviewers — compliance determination and sign-off\n2. Project Handlers — documentation, communication, Flex closure\n3. Certification Office — Listing Cards, Certificates, UL Mark\n4. Finance — billing reconciliation; ML/Regional/DAP specialists'),
  (5, 'systems',
   'Workbench, ECM, Listing Card, DMS, Cert Office DB, Flex, Oracle, CTR, IFVS, Adobe PDF',
   'Workbench, ECM, Listing Card, DMS, Cert Office DB, Flex, Oracle, CTR, IFVS, Adobe PDF'),
  (5, 'pain',
   'Manual compliance cross-ref, multi-system doc assembly, Listing Card re-entry, billing discrepancies, delayed closure',
   E'• Compliance cross-referencing manual; documentation assembly across systems; version control unreliable\n• Listing Card re-entry; certificate issuance not integrated with Flex; billing discrepancies common\n• Closure delayed; archiving inconsistent'),
  (5, 'works',
   'Experienced engineer efficiency for familiar categories, Cert Office structured, peer review improves quality, ECM centralized',
   'Experienced engineer efficiency for familiar categories, Cert Office structured, peer review improves quality, ECM centralized'),
  (5, 'work',
   'Personal template libraries, Excel checklists, manual consolidation, informal Cert Office notifications',
   'Personal template libraries, Excel checklists, manual doc consolidation, informal Cert Office notifications, direct Finance communication.'),
  (5, 'qs',
   'Results compiled? Compliance defensible? Listing Card accurate? Certificate timely? Billing correct?',
   E'All results compiled?\nCompliance defensible?\nDocs complete?\nListing Card accurate?\nCertificate timely?\nBilling correct?\nProperly archived?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (5, 'future',
   'Manual compliance aggregation. Multi-system doc assembly. Listing Card re-entry. Billing manual. Archiving inconsistent.',
   'Automated compliance aggregation. Single-click packaging. Integrated Listing Card/Certificate. Automated billing. Systematic archiving.',
   'Manual compliance aggregation. Multi-system assembly. → Single-click packaging. Integrated cert/billing.',
   E'CURRENT:\nManual compliance aggregation. Multi-system doc assembly. Listing Card re-entry. Billing manual. Archiving inconsistent.\n\nFUTURE:\nAutomated compliance aggregation. Single-click packaging. Integrated Listing Card/Certificate. Automated billing. Systematic archiving.');

-- P6: Surveillance
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (6, 'desc',
   'Three surveillance types: Factory Inspection, Desktop, DAP. Findings → FU/NCR/escalation. Standards changes and product changes assessed, records updated.',
   'Three surveillance types: Factory Inspection, Desktop, DAP. Findings → FU/NCR/escalation. Standards changes and product changes assessed, records updated.'),
  (6, 'humans',
   'Engineers, Field Inspectors, Handlers, Lab Managers, DAP Admins, Standards team, Cert Office',
   E'1. Project Engineers, Field Engineers / Inspectors\n2. Project Handlers, Lab Managers, DAP Admins\n3. Standards Monitoring Team, Cert Office, Finance\n4. Customers, ML/Regional/GMA specialists'),
  (6, 'systems',
   'Flex, LabWare, ECM, Fulcrum (field data), Oracle (billing), Standards Hub, AirTable, MS Project',
   'Flex, LabWare, ECM, Fulcrum (field data), Oracle (billing), Standards Hub, AirTable, MS Project'),
  (6, 'pain',
   'Scheduling disconnected, outdated field prep docs, manual standards monitoring, heavy DAP coordination, billing misaligned',
   E'• Scheduling disconnected; field prep docs not current; Fulcrum back-end integration limited\n• Standards monitoring manual; product change notification ad-hoc; FU/NCR tracking fragmented\n• DAP coordination heavy; Listing Card updates manual; recurring billing misaligned'),
  (6, 'works',
   'FE expertise and relationships, Fulcrum captures field data, DAP reduces resource burden, Standards team centralized',
   'FE expertise and relationships, Fulcrum captures field data, DAP reduces resource burden, Standards team centralized'),
  (6, 'work',
   'Personal inspection checklists, surveillance spreadsheets, informal standards subscriptions, separate DAP tracking',
   'Personal inspection checklists, surveillance spreadsheets, informal standards subscriptions, separate DAP tracking, manual billing reconciliation.'),
  (6, 'qs',
   'Schedule current? Standards changes identified? Product changes disclosed? FUs resolved? Billing aligned?',
   E'Schedule current?\nPrep docs accessible?\nStandards changes identified?\nProduct changes disclosed?\nFUs resolved?\nDAP compliant?\nBilling aligned?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (6, 'future',
   'Scheduling disconnected. Field prep scattered. Standards monitoring manual. FU/NCR fragmented. Billing misaligned.',
   'Integrated scheduling. Mobile inspection tools. Automated standards alerting. Customer change portal. Automated FU/NCR workflow.',
   'Scheduling disconnected. Standards monitoring manual. → Mobile inspection tools. Automated alerting.',
   E'CURRENT:\nScheduling disconnected. Field prep scattered. Standards monitoring manual. FU/NCR fragmented. Billing misaligned.\n\nFUTURE:\nIntegrated scheduling. Mobile inspection tools. Automated standards alerting. Customer change portal. Automated FU/NCR workflow.');

-- P7: Closure
INSERT INTO cells (phase_id, row_key, summary, detail) VALUES
  (7, 'desc',
   'Activities confirmed complete → closure type branch (Standard/Withdrawal/Ongoing) → docs archived → lessons learned → final invoice → customer follow-up.',
   'Activities confirmed complete → closure type branch (Standard/Withdrawal/Ongoing) → docs archived → lessons learned → final invoice → customer follow-up.'),
  (7, 'humans',
   'Engineers, Handlers, Managers, Cert Office, Finance/Billing, Order/Program Managers',
   E'1. Project Engineers, Project Handlers, Managers\n2. Certification Office, Finance / Billing Teams\n3. Order/Program Manager; Field/DAP/Listing/Regional specialists (if applicable)'),
  (7, 'systems',
   'Flex (closure), ECM (archiving), Oracle (billing), Listing Card, Cert Office DB, DMS, SharePoint',
   'Flex (closure), ECM (archiving), Oracle (billing), Listing Card, Cert Office DB, DMS, SharePoint'),
  (7, 'pain',
   'Delayed closure (projects left open), inconsistent lessons learned, manual doc assembly, billing discrepancies, informal handoff',
   E'• Closure delayed — projects left open; lessons learned inconsistent; documentation assembly manual\n• Billing discrepancies; customer follow-up relationship-dependent; surveillance handoff informal'),
  (7, 'works',
   'Handler–customer relationships, Cert Office structured, Finance effective when entries accurate, ECM centralized when used',
   'Handler–customer relationships, Cert Office structured, Finance effective when entries accurate, ECM centralized when used'),
  (7, 'work',
   'Personal closure checklists, backup email archives, informal lessons sharing, manager-prompted closures',
   'Personal closure checklists, backup email archives, informal lessons sharing, manager prompts for closure, informal surveillance handoff.'),
  (7, 'qs',
   'All complete? Items resolved? Docs archived? Billing accurate? Lessons captured? Handoff clear?',
   E'All activities complete?\nItems resolved?\nDocs archived?\nBilling accurate?\nCustomer satisfied?\nLessons captured?\nSurveillance handoff clear?');

INSERT INTO cells (phase_id, row_key, future_current, future_state, summary, detail) VALUES
  (7, 'future',
   'Closure delayed. Lessons inconsistent. Docs manual. Billing manual. Follow-up ad-hoc. Handoff informal.',
   'Systematic closure prompts. Structured lessons platform. Automated packaging/billing. Standardized follow-up. Structured handoff.',
   'Closure delayed. Lessons inconsistent. → Systematic closure prompts. Structured lessons platform.',
   E'CURRENT:\nClosure delayed. Lessons inconsistent. Docs manual. Billing manual. Follow-up ad-hoc. Handoff informal.\n\nFUTURE:\nSystematic closure prompts. Structured lessons platform. Automated packaging/billing. Standardized follow-up. Structured handoff.');

-- ============================================================
-- 3. HEAT DIMENSIONS
-- ============================================================
INSERT INTO heat_dimensions (sort_order, label) VALUES
  (1, 'System fragmentation'),
  (2, 'Manual data re-entry'),
  (3, 'Template variance'),
  (4, 'FU/NCR tracking'),
  (5, 'Scheduling gaps'),
  (6, 'Billing & closure'),
  (7, 'Peer review bottlenecks'),
  (8, 'Cross-team comms');

-- ============================================================
-- 4. HEAT SCORES (dimension_id × phase_id)
-- ============================================================
INSERT INTO heat_scores (dimension_id, phase_id, score) VALUES
  -- System fragmentation
  (1,1,5),(1,2,3),(1,3,3),(1,4,3),(1,5,4),(1,6,3),(1,7,3),
  -- Manual data re-entry
  (2,1,5),(2,2,4),(2,3,3),(2,4,4),(2,5,5),(2,6,3),(2,7,4),
  -- Template variance
  (3,1,2),(3,2,4),(3,3,4),(3,4,3),(3,5,3),(3,6,2),(3,7,2),
  -- FU/NCR tracking
  (4,1,1),(4,2,2),(4,3,5),(4,4,3),(4,5,3),(4,6,4),(4,7,3),
  -- Scheduling gaps
  (5,1,2),(5,2,4),(5,3,1),(5,4,5),(5,5,1),(5,6,4),(5,7,1),
  -- Billing & closure
  (6,1,1),(6,2,1),(6,3,1),(6,4,1),(6,5,5),(6,6,4),(6,7,4),
  -- Peer review bottlenecks
  (7,1,1),(7,2,2),(7,3,4),(7,4,3),(7,5,3),(7,6,2),(7,7,2),
  -- Cross-team comms
  (8,1,3),(8,2,3),(8,3,4),(8,4,3),(8,5,3),(8,6,3),(8,7,3);

-- ============================================================
-- 5. SYSTEM CLUSTERS
-- ============================================================
INSERT INTO system_clusters (sort_order, name, dot_color) VALUES
  (1, 'Core workflow',            '#534AB7'),
  (2, 'Engineering & standards',  '#0C447C'),
  (3, 'Lab & testing',            '#633806'),
  (4, 'Certification',            '#712B13'),
  (5, 'Reporting & analytics',    '#0F6E56');

-- ============================================================
-- 6. SYSTEMS
-- ============================================================
INSERT INTO systems (cluster_id, sort_order, name) VALUES
  -- Core workflow (cluster 1)
  (1, 1, 'Flex'),
  (1, 2, 'Oracle'),
  (1, 3, 'ECM'),
  (1, 4, 'SharePoint/Teams'),
  -- Engineering & standards (cluster 2)
  (2, 1, 'Workbench'),
  (2, 2, 'IFVS'),
  (2, 3, 'Standards Hub'),
  (2, 4, 'DCS'),
  (2, 5, 'Product IQ'),
  -- Lab & testing (cluster 3)
  (3, 1, 'LabWare'),
  (3, 2, 'Sample Mgmt'),
  (3, 3, 'Fulcrum'),
  (3, 4, 'DMS'),
  -- Certification (cluster 4)
  (4, 1, 'Listing Card'),
  (4, 2, 'Cert Office DB'),
  (4, 3, 'CTR'),
  (4, 4, 'ERIS'),
  -- Reporting & analytics (cluster 5)
  (5, 1, 'Power BI'),
  (5, 2, 'AirTable'),
  (5, 3, 'MS Project'),
  (5, 4, 'Adobe PDF');

-- ============================================================
-- 7. SYSTEM PHASES
-- ============================================================
-- Flex (system 1): all phases
INSERT INTO system_phases (system_id, phase_id) VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7);
-- Oracle (system 2): P1,P2,P5,P6,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (2,1),(2,2),(2,5),(2,6),(2,7);
-- ECM (system 3): all phases
INSERT INTO system_phases (system_id, phase_id) VALUES (3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7);
-- SharePoint/Teams (system 4): P1,P2,P5,P6,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (4,1),(4,2),(4,5),(4,6),(4,7);
-- Workbench (system 5): P2,P3,P4,P5,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (5,2),(5,3),(5,4),(5,5),(5,6);
-- IFVS (system 6): P1,P3,P4,P5,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (6,1),(6,3),(6,4),(6,5),(6,6);
-- Standards Hub (system 7): P1,P2,P3,P4,P5,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (7,1),(7,2),(7,3),(7,4),(7,5),(7,6);
-- DCS (system 8): P1,P2,P3,P4
INSERT INTO system_phases (system_id, phase_id) VALUES (8,1),(8,2),(8,3),(8,4);
-- Product IQ (system 9): P1,P2,P3,P4,P5,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (9,1),(9,2),(9,3),(9,4),(9,5),(9,6);
-- LabWare (system 10): P2,P4,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (10,2),(10,4),(10,6);
-- Sample Mgmt (system 11): P2,P4
INSERT INTO system_phases (system_id, phase_id) VALUES (11,2),(11,4);
-- Fulcrum (system 12): P4,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (12,4),(12,6);
-- DMS (system 13): P3,P4,P5,P6,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (13,3),(13,4),(13,5),(13,6),(13,7);
-- Listing Card (system 14): P3,P5,P6,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (14,3),(14,5),(14,6),(14,7);
-- Cert Office DB (system 15): P5,P6,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (15,5),(15,6),(15,7);
-- CTR (system 16): P1,P5
INSERT INTO system_phases (system_id, phase_id) VALUES (16,1),(16,5);
-- ERIS (system 17): P1
INSERT INTO system_phases (system_id, phase_id) VALUES (17,1);
-- Power BI (system 18): P1,P4,P5,P6
INSERT INTO system_phases (system_id, phase_id) VALUES (18,1),(18,4),(18,5),(18,6);
-- AirTable (system 19): P6
INSERT INTO system_phases (system_id, phase_id) VALUES (19,6);
-- MS Project (system 20): P6
INSERT INTO system_phases (system_id, phase_id) VALUES (20,6);
-- Adobe PDF (system 21): P3,P5,P7
INSERT INTO system_phases (system_id, phase_id) VALUES (21,3),(21,5),(21,7);

-- ============================================================
-- 8. ENABLERS (one per phase)
-- ============================================================
INSERT INTO enablers (phase_id, content) VALUES
  (1, 'Journey/COU engine + unified intake'),
  (2, 'Automated standards mapping + smart templates'),
  (3, 'Integrated FU/NCR + automated IFVS lookup'),
  (4, 'Connected scheduling + digital data capture'),
  (5, 'Single-click packaging + automated billing'),
  (6, 'Mobile inspection + standards alerting'),
  (7, 'Systematic closure prompts + structured handoff');
