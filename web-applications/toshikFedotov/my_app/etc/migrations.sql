-- 1 up
BEGIN;
    CREATE TABLE snippets (
        id            BIGINT      PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        title         TEXT        NOT NULL,
        language_id   SMALLINT    REFERENCES languages (id),
        is_hide       BOOLEAN     NOT NULL,
        creating_date TIMESTAMPTZ NOT NULL 
    );

    CREATE TABLE languages (
        id   SMALLINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        name TEXT     NOT NULL UNIQUE
    );
    
    CREATE TABLE codefiles (
        id          BIGINT   PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
        snippet_id  BIGINT   REFERENCES snippets (id) ON DELETE CASCADE,
        title       TEXT     NOT NULL,
        queue_num   SMALLINT NOT NULL,
        content     TEXT     NOT NULL 
    );

    CREATE TABLE encrypted_keys (
        encrypted_key  TEXT   PRIMARY KEY
        id             BIGINT REFERENCES snippets(id) ON DELETE CASCADE
    );
END;
-- 1 down
BEGIN;
    DROP TABLE snippets;
    DROP TABLE languages;
    DROP TABLE codefiles;
END;
