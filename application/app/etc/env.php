<?php
return array(
    'backend' =>
        array(
            'frontName' => getenv('ADMIN_PANEL_PATH'),
        ),
    'install' =>
        array(
            'date' => 'Fri, 22 Jan 2016 11:46:19 +0000',
        ),
    'crypt' =>
        array(
            'key' => getenv('CRYPT_KEY'),
        ),
    'session' =>
        array(
            'save' => getenv('SESSION_SAVE_TYPE'),
            'save_path' => getenv('SESSION_SAVE_PATH')
        ),
    'db' =>
        array(
            'table_prefix' => '',
            'connection' =>
                array(
                    'default' =>
                        array(
                            'host' => getenv('DATABASE_HOST'),
                            'dbname' => getenv('DATABASE_NAME'),
                            'username' => getenv('DATABASE_USERNAME'),
                            'password' => getenv('DATABASE_PASSWORD'),
                        ),
                ),
        ),
    'resource' =>
        array(
            'default_setup' =>
                array(
                    'connection' => 'default',
                ),
        ),
    'x-frame-options' => 'SAMEORIGIN',
    'MAGE_MODE' => 'production',
    'cache_types' =>
        array(
            'config' => 1,
            'layout' => 1,
            'block_html' => 1,
            'collections' => 1,
            'reflection' => 1,
            'db_ddl' => 1,
            'eav' => 1,
            'config_integration' => 1,
            'config_integration_api' => 1,
            'full_page' => 1,
            'translate' => 1,
            'config_webservice' => 1,
            'compiled_config' => 1,
        ),
    'cache' => [
        'frontend' => [
            'default' => [
                'backend' => 'Cm_Cache_Backend_Redis',
                'backend_options' => [
                    'server' => getenv('CACHE_SERVER'),
                    'port' => getenv('CACHE_PORT'),
                    'persistent' => '',
                    'database' => '1',
                    'force_standalone' => '0',
                    'connect_retries' => getenv('CACHE_CONNECT_RETRIES'),
                    'read_timeout' => getenv('CACHE_READ_TIMEOUT'),
                    'automatic_cleaning_factor' => '0',
                    'compress_data' => '1',
                    'compress_tags' => '1',
                    'compress_threshold' => '20480',
                    'compression_lib' => 'gzip'
                ],
                'page_cache' => [
                    'backend' => 'Cm_Cache_Backend_Redis',
                    'backend_options' => [
                        'server' => getenv('CACHE_SERVER'),
                        'port' => getenv('CACHE_PORT'),
                        'persistent' => '',
                        'database' => '2',
                        'force_standalone' => '0',
                        'connect_retries' => getenv('CACHE_CONNECT_RETRIES'),
                        'read_timeout' => getenv('CACHE_READ_TIMEOUT'),
                        'automatic_cleaning_factor' => '0',
                        'compress_data' => '1',
                        'compress_tags' => '1',
                        'compress_threshold' => '20480',
                        'compression_lib' => 'gzip'
                    ]
                ]
            ]
        ]
    ]
);
