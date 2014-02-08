<form role="form" method="post" action="" enctype="multipart/form-data">
	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Project" name="project">
	</div>

	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Title" name="title">
	</div>

	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Slug" name="slug">
	</div>
	
	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Year" name="year">
	</div>

	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Duration" name="duration">
	</div>

	<div class="form-group">
		<textarea rows="10" class="form-control input-sm" placeholder="Tracklist" name="tracklist"></textarea>
	</div>

<!-- 	<div class="form-group">
		<p class="help-block">Front cover</p>
		<input type="file" name="images_front">
		<p class="help-block">Back cover</p>
		<input type="file" name="images_back">
	</div> -->

	<div class="form-group">
		<label for="covers">Cover</label>
		<select multiple name="covers[]" class="form-control" size="10">
			<?php foreach($images as $image): ?>
				<option value="<?php echo $image->src; ?>">
					<?php echo $image->name; ?>
				</option>
			<?php endforeach; ?>
		</select>
	</div>

	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Link (mp3)" name="links[mp3]">
		<hr>
		<input type="text" class="form-control input-sm" placeholder="Link (FLAC)" name="links[flac]">
		<hr>
	</div>

	<div class="form-group">
		<input type="text" class="form-control input-sm" placeholder="Playlist (Soundcloud)" name="playlist[soundcloud]">
		<hr>
		<input type="text" class="form-control input-sm" placeholder="Playlist (Bandcamp)" name="playlist[bandcamp]">
	</div>

	<div class="form-group">
		<button type="submit" class="btn btn-default">Add</button>
	</div>
</form>