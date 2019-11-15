-- 1 up
create table snippets (
  snippet_id bigint primary key generated always as identity,
  path_to text,
  language varchar(30),
  is_hide boolean,
  creating_date timestamptz
);
-- 1 down
drop table snippets;
