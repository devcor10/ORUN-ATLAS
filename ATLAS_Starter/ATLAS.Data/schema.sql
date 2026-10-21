-- ATLAS Local SQLite Schema (encrypted at rest by application)
-- Minimum starter set: roster, keep-separates, observation ticks, append-only event log
-- Designed for offline-first; later sync to Azure SQL

PRAGMA foreign_keys = ON;

-- Roster
CREATE TABLE IF NOT EXISTS Inmates (
    Id TEXT PRIMARY KEY,                -- facility inmate ID
    LastName TEXT NOT NULL,
    FirstName TEXT NOT NULL,
    Bunk TEXT,
    Classification TEXT,
    Status TEXT DEFAULT 'Active',       -- Active, Released, Transferred
    CreatedAt TEXT NOT NULL DEFAULT (datetime('now')),
    UpdatedAt TEXT NOT NULL DEFAULT (datetime('now'))
);

-- Keep-separates (bidirectional pairs)
CREATE TABLE IF NOT EXISTS KeepSeparates (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    InmateIdA TEXT NOT NULL,
    InmateIdB TEXT NOT NULL,
    Reason TEXT,
    Active INTEGER NOT NULL DEFAULT 1,
    CreatedAt TEXT NOT NULL DEFAULT (datetime('now')),
    FOREIGN KEY (InmateIdA) REFERENCES Inmates(Id),
    FOREIGN KEY (InmateIdB) REFERENCES Inmates(Id),
    UNIQUE(InmateIdA, InmateIdB)
);

-- Observation ticks (personal observation checks)
CREATE TABLE IF NOT EXISTS ObservationTicks (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    InmateId TEXT,                      -- null = unit-wide
    DeputyId TEXT NOT NULL,
    Timestamp TEXT NOT NULL DEFAULT (datetime('now')),
    Note TEXT,
    RouteHint TEXT,                     -- for varied route proof
    FOREIGN KEY (InmateId) REFERENCES Inmates(Id)
);

-- Append-only event log (immutable)
CREATE TABLE IF NOT EXISTS EventLog (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    EventType TEXT NOT NULL,            -- OBSERVATION, KEEP_SEPARATE, BOOST, CONDUCT, etc.
    Payload TEXT NOT NULL,              -- JSON
    DeputyId TEXT,
    Timestamp TEXT NOT NULL DEFAULT (datetime('now')),
    Synced INTEGER NOT NULL DEFAULT 0   -- 0 = local only, 1 = synced to Azure
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_inmates_bunk ON Inmates(Bunk);
CREATE INDEX IF NOT EXISTS idx_keepseparates_active ON KeepSeparates(Active);
CREATE INDEX IF NOT EXISTS idx_eventlog_type ON EventLog(EventType);
CREATE INDEX IF NOT EXISTS idx_eventlog_synced ON EventLog(Synced);
