# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, ":encoding(WINDOWS-1251)"); while(<>) {print $_ if $_ =~ /чьт|чьк|чьн|ньч|ньщ|щьн|рьщ/}'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, ":encoding(WINDOWS-1251)"); while(<>) {print $_ if $_ =~ /жы|шы/}'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, ":encoding(WINDOWS-1251)"); while(<>) {print $_ if $_ =~ /(о|е)ва$/}'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, ":encoding(WINDOWS-1251)"); while(<>) {print $_ if $_ =~ /^раз(п|ф|к|т|ш|с|х|ц|ч|щ)/}'
