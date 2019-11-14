-- 1 up
do $$
  BEGIN
    CREATE TABLE snippets (
      snippet_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
      path_to text NOT NULL,
      language text NOT NULL,
      is_hide boolean
  );
  END
$$;
-- 1 down
BEGIN;
  drop table snippets;
END;
