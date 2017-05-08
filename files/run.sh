#/bin/bash
apachectl start
service apache2 restart
/wait-for-it.sh db:3306
/wait-for-it.sh 127.0.0.1:80
./vendor/bin/codecept run
