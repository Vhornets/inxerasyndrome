<?php
require 'vendor/autoload.php';
require 'settings.php';
require 'ORMbootstrap.php';
require 'utils.php';

session_cache_limiter(false);
session_start();

$app = new \Slim\Slim([
	'debug' => true,
	'templates.path' => './templates',
	'cookies.encrypt' => true,
	'cookies.secret_key'  => 'KJHDHSFSDFVC786&^&5svhgvb',
	'cookies.lifetime' => time() + (0.5 * 24 * 60 * 60), // = 1 day
	'cookies.cipher' => MCRYPT_RIJNDAEL_256,
	'cookies.cipher_mode' => MCRYPT_MODE_CBC	
]);

$app->get('/login', function() use ($app) {
	$app->render('login.php');
});

$app->post('/login', function() use($app) {
	$username = sanitize($app->request->params('user'));
	$password = sanitize($app->request->params('password'));
	
	if($username && $password) {
		$app->setCookie('password', $password);
		$app->setCookie('user', $username);
		$app->redirect('/api/admin');
	} 
	else {
		$app->redirect('/api/login');
	}
});

$app->get('/logout', function() use($app) {
	$app->deleteCookie('user');
	$app->deleteCookie('password');
	$app->flash('info', 'Successfully logged out.');
	$app->redirect('/api/login');
});

$app->get('/releases', function () {
	$releases = Release::orderBy('id', 'desc')->get();

	echo $releases->toJson();
});

$app->get('/releases/:slug', function($slug) {
	$release = Release::where('slug', '=', $slug)->get();

	echo $release->toJson();
});


$app->group('/admin', 'auth', function() use($app) {
					/*-----* Main admin page. *------*/
	// GET /api/admin
	$app->get('/', function() use($app) {
		$releases = Release::orderBy('id', 'desc')->get();
		$images = Image::orderBy('created_at', 'desc')->get();

		$releasesArr =[];

		foreach ($releases as $key => $value) {
			$releasesArr[] = decodeFieldsFromJson($value);
		}

		$app->render('admin.php', [
			'releases' => $releasesArr,
			'images' => $images,
			'user' => $app->getCookie('user')
		]);
	})->name('admin');

					/*-----* Releases section. *------*/
	// GET /api/admin/releases/add
	$app->get('/releases/add', function() use($app) {
		$images = Image::all();

		$app->render('releases.php', [
			'images' => $images,
			'title' => 'Add new release', 
			'new' => true
		]);
	});
	// POST /api/admin/releases/add
	$app->post('/releases/add', function() use($app) {
		$release = new Release(makeReleaseArr($app->request->params()));

		if($release->save()) {
			$app->flash('info', 'Release was successfully added.');
			$app->redirect( $app->urlFor('admin') );
		}
	});
	// GET /api/admin/releases/exampleRelease/edit
	$app->get('/releases/:slug/edit', function($slug) use($app) {
		$release = Release::where('slug', '=', $slug)->first();
		$images = Image::all();

		$release = decodeFieldsFromJson($release);

		foreach($images as $image){
			foreach($release->images as $cover) {
				if($cover == $image->src) {
					$image->selected = 'selected';
					continue;
				}
			}
		}

		$app->render('releases.php', [
			'release' => $release,
			'images' => $images,
			'title' => 'Edit release',
			'edit' => true
		]);
	});
	// PUT /api/admin/releases/exampleRelease/edit
	$app->put('/releases/:slug/edit', function($slug) use($app) {
		$release = Release::where('slug', '=', $slug)->first();

		if($release->update(makeReleaseArr($app->request->params()))) {
			$app->flash('info', 'Release was successfully updated.');
			$app->redirect( $app->urlFor('admin') );
		}
	});
	// GET /api/admin/releases/exampleRelease/delete
	$app->get('/releases/:slug/delete', function($slug) use($app) {
		$release = Release::where('slug', '=', $slug)->first();

		if($release->delete()) {
			$app->flash('info', 'Release was successfully deleted.');
			$app->redirect($app->urlFor('admin'));
		}
	});

					/*-----* Images section. *------*/
	// GET /api/admin/images/add
	$app->get('/images/add', function() use($app) {
		$app->render('images.php', [
			'new' => true,
			'title' => 'Upload new image.'
		]);
	})->name('image.add');;
	// POST /api/admin/images/add
	$app->post('/images/add', function() use($app) {
		$image = new Image([
			'name' => $app->request->params('name'),
			'src' => processFileUpload(ROOT.'/img/uploads', $_FILES['image'])
		]);

		if($image->save()) {
			$app->flash('info', 'Image was successfully added.');
			$app->redirect($app->urlFor('image.add'));
		}
	});
	// GET /api/admin/images/ID/edit
	$app->get('/images/:id/edit', function($id) use($app) {
		$image = Image::find($id);

		$app->render('images.php', [
			'image' => $image,
			'edit' => true,
			'title' => 'Edit image.'
		]);
	});
	// PUT /api/admin/images/ID/edit
	$app->put('/images/:id/edit', function($id) use($app) {
		$image = Image::find($id);

		if($image->update(['name' => $app->request->params('name')])) {
			$app->flash('info', 'Image was successfully updated.');
			$app->redirect($app->urlFor('admin'));
		}
	});
	// GET /api/admin/images/ID/delete
	$app->get('/images/:id/delete', function($id) use($app) {
		$image = Image::find($id);

		processFileUpload(ROOT.'/img/uploads/', $image->src, true, true);

		if($image->delete()) {
			$app->flash('info', 'Image was successfully deleted.');
			$app->redirect($app->urlFor('admin'));
		}
	});
});

$app->run();