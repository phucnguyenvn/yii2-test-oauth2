<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => sprintf("%s:host=%s;dbname=%s", DB_TYPE, DB_HOST, DB_NAME),
    'username' => DB_USER,
    'password' => DB_PASS,
    'charset' => 'utf8',
];
