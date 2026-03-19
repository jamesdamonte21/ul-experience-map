-- ============================================================
-- Certification Experience Map — Supabase Schema
-- Run this once in: Supabase → SQL Editor → New query
-- ============================================================

-- 1. Phases (7 rows)
CREATE TABLE IF NOT EXISTS phases (
  id          SERIAL PRIMARY KEY,
  sort_order  INT  NOT NULL,
  short_id    TEXT NOT NULL,   -- 'P1'..'P7'
  name        TEXT NOT NULL,
  color_bg    TEXT NOT NULL,   -- e.g. '#E1F5EE'
  color_text  TEXT NOT NULL    -- e.g. '#085041'
);

-- 2. Content cells (7 phases × 8 row types = 56 rows)
--    row_key values: desc | humans | systems | pain | works | work | qs | future
CREATE TABLE IF NOT EXISTS cells (
  id              SERIAL PRIMARY KEY,
  phase_id        INT  NOT NULL REFERENCES phases(id) ON DELETE CASCADE,
  row_key         TEXT NOT NULL,
  summary         TEXT,          -- shown truncated in the map grid
  detail          TEXT,          -- shown in the slide-in detail panel
  future_current  TEXT,          -- only used when row_key = 'future'
  future_state    TEXT,          -- only used when row_key = 'future'
  UNIQUE(phase_id, row_key)
);

-- 3. Pain heatmap dimensions (8 rows)
CREATE TABLE IF NOT EXISTS heat_dimensions (
  id          SERIAL PRIMARY KEY,
  sort_order  INT  NOT NULL,
  label       TEXT NOT NULL
);

-- 4. Pain heatmap scores (8 dimensions × 7 phases = 56 scores)
CREATE TABLE IF NOT EXISTS heat_scores (
  id            SERIAL PRIMARY KEY,
  dimension_id  INT NOT NULL REFERENCES heat_dimensions(id) ON DELETE CASCADE,
  phase_id      INT NOT NULL REFERENCES phases(id) ON DELETE CASCADE,
  score         INT NOT NULL CHECK (score BETWEEN 1 AND 5),
  UNIQUE(dimension_id, phase_id)
);

-- 5. System clusters (groupings for the System Landscape view)
CREATE TABLE IF NOT EXISTS system_clusters (
  id          SERIAL PRIMARY KEY,
  sort_order  INT  NOT NULL,
  name        TEXT NOT NULL,
  dot_color   TEXT NOT NULL
);

-- 6. Systems (individual tools/platforms)
CREATE TABLE IF NOT EXISTS systems (
  id          SERIAL PRIMARY KEY,
  cluster_id  INT  NOT NULL REFERENCES system_clusters(id) ON DELETE CASCADE,
  sort_order  INT  NOT NULL,
  name        TEXT NOT NULL
);

-- 7. Which phases each system appears in
CREATE TABLE IF NOT EXISTS system_phases (
  system_id  INT NOT NULL REFERENCES systems(id) ON DELETE CASCADE,
  phase_id   INT NOT NULL REFERENCES phases(id) ON DELETE CASCADE,
  PRIMARY KEY (system_id, phase_id)
);

-- 8. Key enablers — one per phase (used in the Roadmap view)
CREATE TABLE IF NOT EXISTS enablers (
  id        SERIAL PRIMARY KEY,
  phase_id  INT  NOT NULL REFERENCES phases(id) ON DELETE CASCADE UNIQUE,
  content   TEXT NOT NULL
);

-- ============================================================
-- Row-level security — public read, authenticated write
-- ============================================================

ALTER TABLE phases          ENABLE ROW LEVEL SECURITY;
ALTER TABLE cells           ENABLE ROW LEVEL SECURITY;
ALTER TABLE heat_dimensions ENABLE ROW LEVEL SECURITY;
ALTER TABLE heat_scores     ENABLE ROW LEVEL SECURITY;
ALTER TABLE system_clusters ENABLE ROW LEVEL SECURITY;
ALTER TABLE systems         ENABLE ROW LEVEL SECURITY;
ALTER TABLE system_phases   ENABLE ROW LEVEL SECURITY;
ALTER TABLE enablers        ENABLE ROW LEVEL SECURITY;

-- Anyone can read
CREATE POLICY "public_read" ON phases          FOR SELECT USING (true);
CREATE POLICY "public_read" ON cells           FOR SELECT USING (true);
CREATE POLICY "public_read" ON heat_dimensions FOR SELECT USING (true);
CREATE POLICY "public_read" ON heat_scores     FOR SELECT USING (true);
CREATE POLICY "public_read" ON system_clusters FOR SELECT USING (true);
CREATE POLICY "public_read" ON systems         FOR SELECT USING (true);
CREATE POLICY "public_read" ON system_phases   FOR SELECT USING (true);
CREATE POLICY "public_read" ON enablers        FOR SELECT USING (true);

-- Only authenticated users (admins) can write
CREATE POLICY "auth_write" ON phases          FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON cells           FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON heat_dimensions FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON heat_scores     FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON system_clusters FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON systems         FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON system_phases   FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "auth_write" ON enablers        FOR ALL USING (auth.role() = 'authenticated');
