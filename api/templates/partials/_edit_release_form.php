<form role="form" method="post" action="" enctype="multipart/form-data">
	<input type="hidden" name="_METHOD" value="PUT"/>
	<div class="form-group">
		<label for="project">Project</label>
		<input type="text" class="form-control input-sm" placeholder="Project" name="project" value="<?php echo $release->project; ?>">
	</div>

	<div class="form-group">
		<label for="title">Title</label>
		<input type="text" class="form-control input-sm" placeholder="Title" name="title" value="<?php echo $release->title; ?>">
	</div>

	<div class="form-group">
		<label for="slug">Slug</label>
		<input type="text" class="form-control input-sm" placeholder="Slug" name="slug" value="<?php echo $release->slug; ?>">
	</div>
	
	<div class="form-group">
		<label for="year">Year</label>
		<input type="text" class="form-control input-sm" placeholder="Year" name="year" value="<?php echo $release->year; ?>">
	</div>

	<div class="form-group">
		<label for="duration">Duration</label>
		<input type="text" class="form-control input-sm" placeholder="Duration" name="duration" value="<?php echo $release->duration; ?>">
	</div>

	<div class="form-group">
		<label for="tracklist">Tracklist</label>
		<textarea rows="10" class="form-control input-sm" placeholder="Tracklist" name="tracklist"><?php foreach ($release->tracklist as $track) {
			echo $track . "\n";
		} ?></textarea>
	</div>

	<div class="form-group">
		<label for="covers">Cover</label>
		<select multiple name="covers[]" class="form-control" size="10">
			<?php foreach($images as $image): ?>
				<option value="<?php echo $image->src; ?>" <?php if($image->selected) echo 'selected="selected"'; ?>>
					<?php echo $image->name; ?>
				</option>
			<?php endforeach; ?>
		</select>
	</div>	

<!-- 	<div class="form-group">
		<div class="row">
		<?php if(@$release->images[1]): ?>
			<div class="col-xs-6">
				<label>Front cover</label>
				<img class="thumbnail" src="/img/covers/<?php echo $release->images[0]; ?>">
			</div>
			<div class="col-xs-6">
				<label>Back cover</label>
				<img class="thumbnail" src="/img/covers/<?php echo $release->images[1]; ?>">
			</div>
		<?php else: ?>
			<div class="col-xs-12">
				<label>Cover</label>
				<img class="thumbnail" src="/img/covers/<?php echo $release->images[0]; ?>">
			</div>
		<?php endif; ?>
		</div>
	</div> -->
	
<!-- 	<div class="form-group">
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
		    <div class="panel-heading">
		      <h4 class="panel-title">
		        <a data-toggle="collapse" data-parent="#accordion" href="#covers">
		          Replace covers
		        </a>
		      </h4>
		    </div>
		    <div id="covers" class="panel-collapse collapse">
		      <div class="panel-body">
				<p class="help-block">Front cover</p>
				<input type="file" name="images_front">
				<p class="help-block">Back cover</p>
				<input type="file" name="images_back">
		      </div>
		    </div>
		  </div>
		</div>
	</div> -->

	<div class="form-group">
		<label for="links[mp3]">Links (mp3)</label>
		<input type="text" class="form-control input-sm" placeholder="Link (mp3)" name="links[mp3]" value="<?php echo $release->links->mp3; ?>">
		<hr>
		<label for="links[flac]">Links (flac)</label>
		<input type="text" class="form-control input-sm" placeholder="Link (FLAC)" name="links[flac]" value="<?php echo $release->links->flac; ?>">
		<hr>
	</div>

	<div class="form-group">
		<label for="playlist[soundcloud]">Playlist (soundcloud)</label>
		<input type="text" class="form-control input-sm" placeholder="Playlist (Soundcloud)" name="playlist[soundcloud]" value="<?php echo $release->playlists->soundcloud; ?>">
		<hr>
		<label for="duration">Playlist (bandcamp)</label>
		<input type="playlist[bandcamp]" class="form-control input-sm" placeholder="Playlist (Bandcamp)" name="playlist[bandcamp]" value="<?php echo $release->playlists->bandcamp; ?>">
	</div>

	<div class="form-group">
		<button type="submit" class="btn btn-default">Save</button>
	</div>
</form>