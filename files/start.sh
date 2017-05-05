#/bin/bash
export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')
[ -n "${DB_TYPE}" ] && /wait-for-it.sh -s ${DB_HOST}:${DB_PORT}
su www-data -s /bin/bash -c 'mkdir -p runtime/logs && touch runtime/logs/app.log runtime/logs/console.log'
tail -F runtime/logs/*.log &
su www-data -s /bin/bash -c 'php yii migrate/up --migrationPath=@vendor/macfly/yii2-oauth2-server/src/migrations --interactive=0'
## Add/Update rbac permissions/roles
su www-data -s /bin/bash -c '[ -d migrations ] && php yii migrate/up --interactive=0'
su www-data -s /bin/bash -c 'ls'
su www-data -s /bin/bash -c './vendor/bin/codecept run'
exec "apache2-foreground"
