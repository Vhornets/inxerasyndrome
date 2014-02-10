<?php

function json_response() {
    $app = \Slim\Slim::getInstance();
    $app->response->headers->set('Content-Type', 'application/json');
}

function auth() {
    $app = \Slim\Slim::getInstance();
    
    if($app->getCookie('password', false) != SUPERUSER_PWD){
        $app->redirect('/api/login');
    }
}

function isJson($string) {
    json_decode($string);
    return (json_last_error() == JSON_ERROR_NONE);
}
// Декодирует значения полей ДБ из json в объект
function decodeFieldsFromJson($object) {
    foreach($object->toArray() as $key => $val) {
        if(isJson($val)) {
            $object[$key] = json_decode($val);
        }
    }

    return $object;
}

function readDirectory($directory) {
    $dir = opendir($directory);
    $files = array();

    while (($entry = readdir($dir)) !== false) {
        if($entry != '.' && $entry != '..') $files[] = $entry;
    }

    closedir($dir);

    return $files;
}

function processFileUpload($dir, $file, $time = true, $remove = false) {
    if($remove) {
        unlink($dir.'/'.$file);
        return;
    }

    if(!$file["tmp_name"]) {
        return false;
    }
    
    $random = $time ? time() . '-' : '';
    $name = $random.$file["name"];
    move_uploaded_file($file["tmp_name"], $dir.'/'.$name);

    return $name;
}

function makeReleaseArr($params) {
    $coversDir = ROOT.'/img/covers';

    $links = [
        'mp3' => $params['links']['mp3'],
        'flac' => $params['links']['flac']
    ];
    $playlists = [
        'soundcloud' => $params['playlist']['soundcloud'],
        'bandcamp' => $params['playlist']['bandcamp']
    ];
    $tracklist = explode("\n", $params['tracklist']);

    $release = [
        'project' => $params['project'],
        'title' => $params['title'],
        'slug' => $params['slug'],
        'year' => $params['year'],
        'duration' => $params['duration'],
        'tracklist' => json_encode($tracklist),
        'links' => json_encode($links),
        'playlists' => json_encode($playlists),
        'images' => json_encode($params['covers'])
    ];

    return $release;
}

function sanitize($param) {
    $sanitized = strip_tags($param);
    $sanitized = htmlentities($param, ENT_QUOTES, "UTF-8");
    $sanitized = htmlspecialchars($param, ENT_QUOTES);

    return $sanitized;
}