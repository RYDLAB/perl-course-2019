#!/usr/bin/env bash

perl -I local/lib/perl5 ./megacode/script/megacode eval "app->db->migrations->migrate(0)"
