#/bin/bash
# export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')
# [ -n "${DB_TYPE}" ] && /wait-for-it.sh -s ${DB_HOST}:${DB_PORT}
# su www-data -s /bin/bash -c 'mkdir -p runtime/logs && touch runtime/logs/app.log runtime/logs/console.log'
# tail -F runtime/logs/*.log &
# su www-data -s /bin/bash -c 'php yii migrate/up --migrationPath=@vendor/dektrium/yii2-user/migrations --interactive=0'
# su www-data -s /bin/bash -c 'php yii migrate/up --migrationPath=@yii/rbac/migrations --interactive=0'
# su www-data -s /bin/bash -c 'php yii migrate/up --migrationPath=@vendor/macfly/yii2-oauth2-server/src/migrations --interactive=0'
# ## Add/Update rbac permissions/roles
# su www-data -s /bin/bash -c 'php yii rbac rbac.yml'
# su www-data -s /bin/bash -c '[ -d migrations ] && php yii migrate/up --interactive=0'
/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

# if [ -z "${MYSQL_PASS}" ]
# then
#   PASS="admin"
# else
#   PASS=${MYSQL_PASS}
# fi

_word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "default" )
echo "=> Creating MySQL admin user with ${_word} password"

mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"


echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
#echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'admin' has password '$PASS'"
echo "MySQL user 'root' has password 'root' but only allows local connections"
echo "========================================================================"


mysql -uadmin -p$PASS
CREATE DATABASE IF NOT EXISTS authmanager;
