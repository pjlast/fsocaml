-- Write your up migration here
CREATE TABLE IF NOT EXISTS dream_session (
  id TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  expires_at REAL NOT NULL,
  payload TEXT NOT NULL
)
