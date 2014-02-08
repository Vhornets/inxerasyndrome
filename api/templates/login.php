<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Administrator</title>
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/style.css" rel="stylesheet">
	<link href="/css/admin/releases.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<?php if($flash['info']): ?>
					<div class="alert alert-success">
						<?php echo $flash['info']; ?>
					</div>
				<?php elseif ($flash['error']): ?>
					<div class="alert alert-danger">
						<?php echo $flash['error']; ?>
					</div>
				<?php endif; ?>
			</div>
			<div class="col-xs-12">
				<form role="form" method="post">
					<h2>Log In</h2>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Login" name="user">
					</div>

					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password" name="password">
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-default">Log In</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>