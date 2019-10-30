# 1. Скачайте файл russian.txt с репозитория
# https://github.com/danakt/russian-words
# 2. Напишите ряд однострочников (минимум 4), которые помогут найти ошибки в словах.
# Результат выводится в STDOUT. Вывод может быть избыточен (т.е. содержать и правильные слова тоже).

cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /[^а-яё\n-]/i }'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /^-|--|-$/i }'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /^[-аяоёуюыиэе]+$/i }'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /^[^аяоёуюыиэе]+$/i }'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /чьк|чьн|ньч|ньщ|щьн|рьщ/i }'
cat russian.txt | perl -Mutf8 -CO -e 'binmode(STDIN, "encoding(Windows-1251)"); while(<>){ print if /жы|шы|чы|щы|жя|шя|чя|щя|жэ|шэ|чэ|щэ|жю|чю|щю/i }'
