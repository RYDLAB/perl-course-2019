# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /[^а-яё\n-]/i'              russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /^-|--|-$/i'                russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /^[-аяоёуюыиэе]+$/i'        russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /^[^аяоёуюыиэе]+$/i'        russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /чьк|чьн|ньч|ньщ|щьн|рьщ/i' russian.txt
perl -Mutf8 -Mopen=':encoding(cp1251)' -CO -ne 'print if /[жчщ][ыяэю]|ш[ыяэ]/i'      russian.txt
