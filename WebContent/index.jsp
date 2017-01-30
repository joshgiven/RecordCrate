<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Record Bin</title>
	
	<link href="https://fonts.googleapis.com/css?family=Righteous" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<h1><a href="/RecordBin/">RecordBin</a></h1>
	
	<h2>Album Gallery</h2>
	<ul class="gallery">
	<c:forEach var="album" items="${albums}">
		<li>
			<figure>
			<a href="displayAlbum.do?id=<c:out value="${album.id}" />">
				<img src="<c:out value="${album.coverThumbnail}" />" />
			</a>
			<figcaption>
			<a class="albumTitle" href="displayAlbum.do?id=<c:out value="${album.id}" />">
				<c:out value="${album.title}" />
			</a>
			<a class="artistName" href="displayArtist.do?id=<c:out value="${album.artist.id}" />">
				<c:out value="${album.artist.name}" />
			</a>
			</figcaption>
			</figure>
		</li>
	</c:forEach>
	</ul>
	
	<h2>Artists</h2>
	<ul class="gallery">
	<c:forEach var="artist" items="${artists}">
		<li>
		<figure>
			<a href="displayArtist.do?id=<c:out value="${artist.id}" />">
				<img src="<c:out value="${artist.thumbnail}" />" />
			</a>
			<figcaption>
				<a href="displayArtist.do?id=<c:out value="${artist.id}" />">
					<c:out value="${artist.name}" />
				</a>
			</figcaption>
		</figure>
		</li>
	</c:forEach>
	</ul>
	
	<h2>Add Items</h2>
	<ul class="buttonBar">
		<li><a class="mutator" href="createArtistForm.do">add an artist</a></li>
		<li><a class="mutator" href="createAlbumForm.do">add an album</a></li>
	</ul>
	
	<p class="clear"></p>
</body>
</html>