<div class="col-xs-12">
		<div class="row top-controls">
			<div class="col-xs-2 text-left">
				<ul class="pagination">
				<% for(var i = 0; i < pages; i++) { %>
					<li>
						<a href="#/page/<%= i+1 %>" class="page-num-<%= i+1 %>">
							<%= i+1 %>
						</a>
					</li>
				<% } %>
				</ul>
			</div>

			<div class="col-xs-6 text-left">
				<div class="btn-group">
				  <button type="button" class="btn inverse btn-filter dropdown-toggle" data-toggle="dropdown">
				  Filter (<%= currentFilter %>) <span class="caret"></span>
				  </button>
				  <ul class="dropdown-menu project-filter" role="menu">
					    <li class="divider"></li>
					    <li><a href="#/filter/All">All</a></li>
					    <li class="divider"></li>
					  <% _.each(projects, function(project) { %>
						    <li><a href="#/filter/<%= project.project %>"><%= project.project %></a></li>
						    <li class="divider"></li>
					  <% }); %>
				  </ul>
				</div>	
				<div class="btn-group">
				  <button type="button" class="btn inverse btn-filter dropdown-toggle" data-toggle="dropdown">
				   Per page (<%= perPage %>) <span class="caret"></span>
				  </button>
				  <ul class="dropdown-menu per-page" role="menu">
					<% for(var i = 1; i <= pages; i++) { %>
						<li>
							<a href="#<%= i+1 %>" data-perpage="<%= i+1 %>">
								<%= i+1 %>
							</a>
						</li>
					<% } %>				    
				  </ul>
				</div>			
			</div>

			<div class="col-xs-4 text-right controls">
				<a href="#" data-show=".large-view" data-hide=".compact-view" title="Show as panels"><span class="glyphicon glyphicon-th-large"></span></a>
				<a href="#" data-show=".compact-view" data-hide=".large-view" title="Show detailed description"><span class="glyphicon glyphicon-list"></span></a>
			</div>
			<div class="col-xs-12 divider"></div>
		</div>

		<div class="row releases">
			<% _.each(releases, function(release) {%>
			<div class="large-view">
				<div class="col-xs-6 cover">
					<a href="#/downloads/<%= release.slug %>">
						<img src="img/uploads/<%= release.images[0] %>" class="col-xs-6" title="<%= release.project %> - <%= release.title %> (<%= release.year %>)"/>
						<% if(release.playlists.soundcloud) {%>
						<div class="cover-expand">
							<a href="#/downloads/<%= release.slug %>"><span class="glyphicon glyphicon-fullscreen"></span></a>
							<a href="#/play/<%= release.playlists.soundcloud %>">
							<span class="glyphicon glyphicon-play"></span>
							</a>
						</div> 
						<% } else {%>
						<div class="cover-expand one-control">
							<a href="#/downloads/<%= release.slug %>">
							<span class="glyphicon glyphicon-fullscreen"></span>
							</a>
						</div> 
						<% } %> 
						<div class="cover-hover-description">
							<p>
								<%= release.project %> - <%= release.title %>
							</p>
						</div>
					</a>
				</div>
			</div>
			<div class="compact-view">
				<div class="row">
					<div class="col-xs-5 cover">
							<a href="#/downloads/<%= release.slug %>">
							<img src="img/uploads/<%= release.images[0] %>" title="<%= release.project %> - <%= release.title %> (<%= release.year %>)"  />
							</a>
					</div>

					<div class="col-xs-7">
						<h3><%= release.project %> - <%= release.title %></h3>
						<div class="row">
							<div class="col-xs-6">
								<p>Year: <%= release.year %></p>
								<p>Duration: <%= release.duration %></p>
								<div class="btn-group">
								  <button type="button" class="btn inverse btn-download dropdown-toggle" data-toggle="dropdown">
								   <span class="glyphicon glyphicon-cloud-download"></span> Download <span class="caret"></span>
								  </button>
								  <ul class="dropdown-menu" role="menu">
								    <li>
										<a href="<%= release.links.mp3 %>">
											 [mp3 320 kbps]
										 </a>
									 </li>
								    <li>
										<a href="<%= release.links.flac %>">
										[FLAC]
										</a>
								    </li>
								  </ul>
								</div>
								<br>
								<div class="btn-group">
									<a 
										href="#/play/<%= release.playlists.soundcloud %>"
										class="btn inverse btn-download">
										<span class="glyphicon glyphicon-play"></span> Listen
									</a>
								</div>
							</div>
							<div class="col-xs-6 text-left">
								<p>Tracklist: </p>
								<%= release.tracklist %>

								<div class="socials">
									<% var link = release.project.toLowerCase().replace(' ', '') %>
									<a href="http://facebook.com/<%= link %>">
										<img src="img/socials/fb.png" />
									</a>
									<a href="http://last.fm/music/<%= link %>">
										<img src="img/socials/lf.png" />
									</a>
									<% if(link == 'inxerasyndrome' || link == 'segentot') { %>
									<a href="http://souncloud.com/vhornets">
										<img src="img/socials/sc.png" />
									</a>
									<% } else { %>
									<a href="http://souncloud.com/<%= link %>">
										<img src="img/socials/sc.png" />
									</a>
									<% } %>
								</div>	
							</div>
						</div>					
					</div>
				</div>
			</div>
			<% }); %>
		</div>
</div>