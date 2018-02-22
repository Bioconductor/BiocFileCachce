-- IF UPDATE SCHEME CHANGE VARIABLES IN utilities.R
-- METADATA
CREATE TABLE metadata (
    key TEXT UNIQUE NOT NULL,
    value TEXT
);
-- INSERT_METADATA
INSERT INTO metadata (
    key, value
) VALUES (:key, :value);
-- TABLE
CREATE TABLE resource (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rid TEXT,
    rname TEXT,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    access_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    rpath TEXT,
    rtype TEXT,
    fpath TEXT,
    last_modified_time DATETIME DEFAULT NA,
    etag TEXT DEFAULT NA
);
-- INSERT
SELECT rid FROM resource;
INSERT INTO resource (
    rname, rpath, rtype, fpath, last_modified_time, etag
) VALUES (
    :rname, :rpath, :rtype, :fpath, :last_modified_time, :etag
);
UPDATE resource SET rid = "BFC" || id;
SELECT rid, rname FROM resource;
-- REMOVE
DELETE FROM resource WHERE rid IN (%s);
-- UPDATE_PATH
UPDATE resource
SET rpath = :rpath, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- UPDATE_TIME
UPDATE resource
SET access_time = CURRENT_TIMESTAMP
WHERE rid IN (%s);
-- UPDATE_RNAME
UPDATE resource
SET rname = :rname, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- UPDATE_RTYPE
UPDATE resource
SET rtype = :rtype, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- UPDATE_MODIFIED
UPDATE resource
SET last_modified_time  = :last_modified_time, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- UPDATE_FPATH
UPDATE resource
SET fpath = :fpath, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- UPDATE_ETAG
UPDATE resource
SET etag  = :etag, access_time = CURRENT_TIMESTAMP
WHERE rid = :rid;
-- MIGRATION_0_99_1_to_0_99_2
-- MIGRATION_0_99_2_to_0_99_3
ALTER TABLE resource
ADD etag TEXT;
-- MIGRATION_UPDATE_METADATA
UPDATE metadata
SET value = :value
WHERE key = :key
