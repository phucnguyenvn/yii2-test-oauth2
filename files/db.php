<?php

return [
    'class' => 'yii\db\Connection',
    'dsn' => sprintf("mysql:host=%s;dbname=%s", $_ENV["DB_HOST"], $_ENV["DB_NAME"]),
    'username' => $_ENV["DB_USER"],
    'password' => $_ENV["DB_PASS"],
    'charset' => 'utf8',
];
