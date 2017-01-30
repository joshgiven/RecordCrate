<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Album View</title>
	
	<link href="https://fonts.googleapis.com/css?family=Righteous" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<h1><a href="/RecordBin/">RecordBin</a></h1>
	
	<h2>Album View</h2>
	
	<div class="viewBox">
	<img class="albumCover" src="${album.coverImage}" alt="<c:out value="${album.title}" />" />
	
	<div class="statBox">
	<table class="albumStats">
		<caption>Vital Stats</caption>
		<tr>
			<td>Title:</td>
			<td><c:out value="${album.title}" /></td>
		</tr>
		<tr>
			<td>Artist</td>
			<td><a href="displayArtist.do?id=<c:out value="${album.artist.id}" />"><c:out value="${album.artist.name}" /></a></td>
		</tr>
		<tr>
			<td>Year:</td>
			<td><c:out value="${album.year}" /></td>
		</tr>
		<tr>
			<td>Genre:</td>
			<td><c:out value="${album.genre}" /></td>
		</tr>
	</table>
	
	<table class="trackListing">
		<caption>Tracks</caption>
		<thead>
			<tr>
				<td>Track</td><td>Title</td><td>Time</td>
			</tr>
		</thead>
		<c:forEach var="track" items="${album.tracks}">
			<tr>
				<td><c:out value="${track.index}" /></td>
				<td><c:out value="${track.title}" /></td>
				<td><c:out value="${track.time}" /></td>
			</tr>
		</c:forEach>
		<tfoot>
			<tr>
				<td colspan="2">Total Time</td><td>${album.time}</td>
			</tr>
		</tfoot>
	</table>
	</div>
	</div>

	<h2>Add/Modify Items</h2>
	<ul class="buttonBar">
		<li><a class="mutator" href="updateAlbumForm.do?id=<c:out value="${album.id}" />">edit this album</a></li>
		<li><a class="mutator" href="createArtistForm.do">add an artist</a></li>
		<li><a class="mutator" href="createAlbumForm.do">add an album</a></li>
	</ul>
		
	<p class="clear"></p>
	
</body>
</html>