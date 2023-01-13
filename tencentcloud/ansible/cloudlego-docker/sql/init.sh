#!/bin/bash
mysql -hlocalhost -uroot --default-character-set=utf8 -p${MYSQL_ROOT_PASSWORD} -e "
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
"
for i in $(find /docker-entrypoint-initdb.d -type f -name "*.sql.gz" | sort);do echo -e "\n"$i && gunzip < $i | mysql -hlocalhost -u${MYSQL_USER} --default-character-set=utf8 -p${MYSQL_PASSWORD};done
