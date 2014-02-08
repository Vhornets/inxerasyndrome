<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Inxera Syndrome > Administrator</title>
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'>
	<link href="/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/admin/admin.css" rel="stylesheet">
	<script src="/js/vendor/jquery.min.js"></script>
	<script src="/js/vendor/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row">
			<?php if($flash['info']): ?>
				<div class="col-xs-12">
					<p class="alert alert-success">
						<?php echo $flash['info']; ?>
					</p>
				</div>
			<?php endif; ?>
			<div class="col-xs-12 text-left">
				<a class="btn btn-default btn-sm" href="/">Main Page</a>
				<a class="btn btn-default btn-sm" href="/api/logout">
					Log Out (<?php echo $user; ?>)
				</a>
			<hr>
			</div>
		</div>
		<div class="row item-header" data-toggle="collapse" data-target="#releases">
			<div class="col-xs-12">
				<h2 class="bg-primary">
					Releases <a class="btn btn-primary btn-xs add-release" href="/api/admin/releases/add">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
				</h2>
			</div>
		</div>
		<div class="row collapse in" id="releases">
			<?php foreach ($releases as $release): ?>
				<div class="col-xs-3 item">
					<p>
						<a href="/api/admin/releases/<?php echo $release->slug; ?>/edit">
							<?php echo $release->project.' - '.$release->title.' ('.$release->year.')'; ?>
						</a>
					</p>
					<a href="/api/admin/releases/<?php echo $release->slug; ?>/edit">
						<img class="img-thumbnail" src="/img/uploads/<?php echo $release->images[0]; ?>">
					</a>
					<div class="controls btn-group btn-group-xs">
						<a class="btn btn-default" href="/#/downloads/<?php echo $release->slug; ?>">
							<span class="glyphicon glyphicon-eye-open"></span>
						</a>
						<a class="btn btn-default" href="/api/admin/releases/<?php echo $release->slug; ?>/edit">
							<span class="glyphicon glyphicon-pencil"></span>
						</a>
						<a class="btn btn-default" href="/api/admin/releases/<?php echo $release->slug; ?>/delete">
							<span class="glyphicon glyphicon-remove"></span>
						</a>
					</div>

				</div>
			<?php endforeach; ?>
		</div>
		<hr>
		<div class="row item-header" data-toggle="collapse" data-target="#images">
			<div class="col-xs-12">
				<h2 class="bg-primary">Media 
					<a class="btn btn-primary btn-xs add-release" href="/api/admin/images/add">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
				</h2>
			</div>
		</div>

		<div class="row collapse" id="images">
			<?php foreach ($images as $image): ?>
				<div class="col-xs-2 item">
					<p><?php echo $image->name; ?></p>
					<a href="/img/uploads/<?php echo $image->src; ?>">
						<img class="img-thumbnail" src="/img/uploads/<?php echo $image->src; ?>">
					</a>
					<div class="controls btn-group btn-group-xs">
						<a class="btn btn-default" href="/api/admin/images/<?php echo $image->id; ?>/edit">
							<span class="glyphicon glyphicon-pencil"></span>
						</a>
						<a class="btn btn-default" href="/api/admin/images/<?php echo $image->id; ?>/delete">
							<span class="glyphicon glyphicon-remove"></span>
						</a>
					</div>

				</div>
			<?php endforeach; ?>			
		</div>
	</div>
</body>
</html>