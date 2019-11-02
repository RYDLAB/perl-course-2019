# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

cat russian.txt | perl -ne 'binmode STDIN, cp1251; print if /^.*(жы|шы).*$/'
cat russian.txt | perl -ne 'binmode STDIN, cp1251; print if /^.*(чя|щя).*$/'
cat russian.txt | perl -ne 'binmode STDIN, cp1251; print if /^.*(чьк|чьн|ньч).*$/'
cat russian.txt | perl -ne 'binmode STDIN, cp1251; print if /^.*(чю|щю).*$/'
