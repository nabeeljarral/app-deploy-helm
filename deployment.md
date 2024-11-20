

## Server setup
- Web Server
- PHP 8.0
- NodeJs v14.20.1
- NPM v6.14.17
- composer.phar v2.4.2 
- MySql Server
- Redis Server
- Supervisor

## Config

### .env
```
    APP_URL=...
    
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=username
    DB_USERNAME=dbname
    DB_PASSWORD=password
    
    CACHE_DRIVER=redis
    QUEUE_CONNECTION=database
    
    REDIS_HOST=127.0.0.1
    REDIS_PASSWORD=null
    REDIS_PORT=6379
    REDIS_CLIENT=predis
```

### config/project/google.php
```php
    
<?php

use Google\Service\Drive;
use Google\Service\Sheets;

return [
    "api"   => [
        "config_file"   => "client_secret_583777094252-e5ug059a13amsvf93obu5iv18fna4rjs.apps.googleusercontent.com.json",
        'callback_uri'  => "/api/google/oauth/callback",
        'scopes'        => [
            Drive::DRIVE,
            Drive::DRIVE_FILE,
            Drive::DRIVE_METADATA,
            Drive::DRIVE_APPDATA,
            Sheets::SPREADSHEETS,
        ],
    ],
    'drive' => [

        'meta' => [
            "mime" => [
                "folder" => "application/vnd.google-apps.folder",
            ]
        ],

        "templates_folder_id"   => "1g3_ZAKnnDmKE5m9vvwIToa-t0ARK8Vgc",
        "templates_file_prefix" => "template_",
        "clients_folder_id"     => "1tY-8VxQbhtw9Uo0kaPSN-5gXmMtEECTq",
        "clients_folder_prefix" => "client_",
    ],
];
```
