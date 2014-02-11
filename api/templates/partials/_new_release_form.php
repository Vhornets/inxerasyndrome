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
		<label for="tracklist">Tracklist</label>
		<textarea rows="10" class="form-control input-sm" name="tracklist"></textarea>
	</div>

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

	<div class="form-group row">
		<label class="col-xs-12">Download links</label>
		<div class="col-xs-6">
			<input type="text" class="form-control input-sm" placeholder="mp3" name="links[mp3]">
		</div>
		<div class="col-xs-6">
			<input type="text" class="form-control input-sm" placeholder="FLAC" name="links[flac]">
		</div>
	</div>
	<hr>
	<div class="form-group row">
		<label class="col-xs-12">Playlists</label>
		<div class="col-xs-6">
			<input type="text" class="form-control input-sm col-xs-6" placeholder="Soundcloud" name="playlist[soundcloud]">
		</div>
		<div class="col-xs-6">
			<input type="text" class="form-control input-sm col-xs-6" placeholder="Bandcamp" name="playlist[bandcamp]">
		</div>
	</div>

	<div class="form-group">
		<button type="submit" class="btn btn-default">Add</button>
	</div>
</form>