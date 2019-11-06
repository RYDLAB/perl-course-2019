# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

perl -Mutf8 -Mopen=':encoding(cp1251)' -C -pe '/[жш]ы or $_ = "" ' russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -C -pe '/[чщ][яю]/ or $_= "" ' russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -C -pe '/чь[кн]|ньч/ or $_= "" ' russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -C -pe '/цы.+/ or $_= "" ' russian.txt
