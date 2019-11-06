# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

perl -Mutf8 -Mopen=':encoding(cp-1251)' -C -pe '$_="" unless /[чщ][яю]/' russian.txt
perl -Mutf8 -Mopen=':encoding(cp-1251)' -C -pe '$_="" unless /[жш][ы]/' russian.txt
perl -Mutf8 -Mopen=':encoding(cp-1251)' -C -pe '$_="" unless /[ч]ь[нк]/' russian.txt
perl -Mutf8 -Mopen=':encoding(cp-1251)' -C -pe '$_="" unless /ъ[^ёеюя]/' russian.txt






