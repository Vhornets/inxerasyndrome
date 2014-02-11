<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Inxera Syndrome > Manage releases</title>
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/admin/releases.css" rel="stylesheet">
	<script src="/js/vendor/jquery.min.js"></script>
	<script src="/js/vendor/bootstrap.min.js"></script>
	<script src="/js/admin/tinymce/tinymce.min.js"></script>
	<script src="/js/admin/main.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
		<?php if($flash['info']): ?>
			<div class="col-xs-12">
				<p class="alert alert-success"><?php echo $flash['info']; ?></p>
			</div>
		<?php endif; ?>
			<div class="col-xs-12">
				<a href="/api/admin" class="btn btn-default btn-xs">< Back</a>
			</div>
			<div class="col-xs-12">
				<h1><?php echo $title; ?></h1>
				<hr>
				<?php
					if(isset($new)) include 'partials/_new_release_form.php';
					if(isset($edit)) include 'partials/_edit_release_form.php'; 
				?>
			</div>
		</div>
	</div>
</body>
</html>