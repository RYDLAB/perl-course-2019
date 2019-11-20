-- 1 up (create all tables)
create table snippets (
    id              bigint      primary key generated always as identity,
    creation_time   timestamptz not null default CURRENT_TIMESTAMP,
    is_public       boolean     not null default true
);

create table languages (
    id      smallint    primary key generated always as identity,
    name    text        not null unique
);

create table sources (
    id      smallint    primary key generated always as identity,
    name    text        not null unique
);

create table text_blocks (
    id          bigint      primary key generated always as identity,
    snippet_id  bigint      not null references snippets(id)    on delete cascade,
    language_id smallint    not null references languages(id)   on delete restrict,
    source_id   smallint    not null references sources(id)     on delete restrict,
    title       text        not null,
    body        text        not null
);

-- 1 down (destroy all tables)
drop table text_blocks;
drop table sources;
drop table languages;
drop table snippets;
