<form role="form" method="post" action="" enctype="multipart/form-data">
	<input type="hidden" name="_METHOD" value="PUT"/>
	<div class="form-group">
		<label for="name">Image name</label>
		<input type="text" class="form-control input-sm" name="name" value="<?php echo $image->name; ?>">
	</div>

<!-- 	<div class="form-group">
		<p class="help-block">Image</p>
		<input type="file" name="image">
	</div> -->

	<div class="form-group">
		<button type="submit" class="btn btn-default">Edit</button>
	</div>
</form>