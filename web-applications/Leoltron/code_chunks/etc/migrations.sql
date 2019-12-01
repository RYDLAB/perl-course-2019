-- 1 up
create table snippets
(
    snippet_id serial not null
        constraint snippets_pk
            primary key,
    url varchar(8) not null,
    creation_date timestamp default now() not null,
    text text not null
);

create unique index ui_snippets_url
    on snippets (url);

-- 1 down
drop table snippets;

-- 2 up
alter table snippets
    add private boolean default false not null;
-- 2 down
alter table snippets
    drop column private;
