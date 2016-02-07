<?php
return array (
  'backend' => 
  array (
    'frontName' => 'admin',
  ),
  'install' => 
  array (
    'date' => 'Fri, 22 Jan 2016 11:46:19 +0000',
  ),
  'crypt' => 
  array (
    'key' => 'abcdefghjijlmnop',
  ),
  'session' => 
  array (
    'save' => 'files',
  ),
  'db' => 
  array (
    'connection' => 
    array (
      'default' => 
      array (
        'host' => '127.0.0.1',
        'dbname' => 'magento2',
        'username' => 'root',
        'password' => 'my-secret-password',
      ),
    ),
  ),
  'resource' => 
  array (
    'default_setup' => 
    array (
      'connection' => 'default',
    ),
  ),
  'x-frame-options' => 'SAMEORIGIN',
  'MAGE_MODE' => 'default',
  'cache_types' => 
  array (
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
);
