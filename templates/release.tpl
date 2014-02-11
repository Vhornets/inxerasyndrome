<script type="text/javascript">
    var disqus_shortname = 'inxerasyndrome'; 

    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<div id="release-full">
	<% if(release.images.length > 1 && release.images[1] != null) { %>
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	  <!-- Wrapper for slides -->
	  <div class="carousel-inner">
	    <div class="item active">
	      <img src="img/uploads/<%= release.images[0] %>"/>
	    </div>
	    <div class="item">
	      <img src="img/uploads/<%= release.images[1] %>">
	    </div>
	  </div>
	  <!-- Controls -->
	  <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left"></span>
	  </a>
	  <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right"></span>
	  </a>
	</div>
	<% } else {%>
		<img src="img/uploads/<%= release.images[0] %>">
	<% } %>
	<div class="btn-group">
	  <button type="button" class="btn inverse btn-download dropdown-toggle" data-toggle="dropdown">
	    <h4><span class="glyphicon glyphicon-cloud-download"></span> Download <span class="caret"></span></h4>
	  </button>
	  <ul class="dropdown-menu" role="menu">
	    <li><a href="<%= release.links.mp3 %>">[mp3 320 kbps]</a></li>
	    <li><a href="<%= release.links.flac %>">[FLAC]</a></li>
	  </ul>
	</div>	
	<div class="release-description">
		<p>Year: <%= release.year %></p>
		<p>Duration: <%= release.duration %></p>
		<p>Tracklist: </p>
		<%= release.tracklist %>
		<h3>Say something: </h3>
	</div>
    <div id="disqus_thread"></div>	
</div>