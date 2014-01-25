<?php

require 'vendor/autoload.php';

$app = new \Slim\Slim(['debug' => true]);

$app->response->headers->set('Content-Type', 'application/json');

$app->get('/releases', function () {
    echo json_encode( file_get_contents('../data/releases.json') );
});

$app->run();