<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<c:choose>
	<c:when test="${update == true}">
		<title>Update Album</title>
	</c:when>
	<c:otherwise>
		<title>Create Album</title>
	</c:otherwise>
	</c:choose>
	
	<link href="https://fonts.googleapis.com/css?family=Righteous" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<h1><a href="/RecordBin/">RecordBin</a></h1>
	
	<c:choose>
		<c:when test="${update == true}">
			<h2>Update Album</h2>
		</c:when>
		<c:otherwise>
			<h2>Create Album</h2>
		</c:otherwise>
	</c:choose>
	
	<form action="createAlbum.do" method="POST">
		<ul>
		<!-- 	
		private String title;
		private Artist artist;
		private int year;
		private String genre;
		private List<Track> tracks;
		private int rating;
		private boolean compilation;
		private String coverImage;
		private String coverThumbnail;
		 -->
			<li>
				<label for="artistId">Artist</label>
					<select name="artistId">
					<c:forEach var="artist" items="${artists}">
						<option value="<c:out value="${artist.id}" />" <c:if test="${artist.id == theAlbum.artist.id }">selected</c:if> ><c:out value="${artist.name}" /></option>
					</c:forEach>
					</select>
			</li>
			
			<li><label for="title">Title</label><input type="text" name="title" <c:if test="${update == true}"> value="<c:out value="${theAlbum.title}"/>"</c:if>></li>
			<li><label for="year">Year</label><input type="number" name="year" min="1950" max="2020" <c:if test="${update == true}"> value="<c:out value="${theAlbum.year}"/>"</c:if>></li>
	 		<li><label for="genre">Genre</label><input type="text" name="genre" <c:if test="${update == true}"> value="<c:out value="${theAlbum.genre}"/>"</c:if>></li>
			<li><label for="coverImage">Image Path</label><input type="text" name="coverImage" <c:if test="${update == true}"> value="<c:out value="${theAlbum.coverImage}"/>"</c:if>></li>
			<li><label for="coverThumbnail">Thumbnail Path</label><input type="text" name="coverThumbnail" <c:if test="${update == true}"> value="<c:out value="${theAlbum.coverThumbnail}"/>"</c:if>></li>
		</ul>
		<c:choose>
			<c:when test="${update == true}">
				<input type="hidden" name="id" value="<c:out value="${theAlbum.id}"/>">
				<button>update album</button>
			</c:when>
			<c:otherwise>
				<button>add album</button>
			</c:otherwise>
		</c:choose>
	</form>
	
	<c:if test="${update == true}">
	<form action="destroyAlbum.do" method="POST">
		<input type="hidden" name="id" value="<c:out value="${theAlbum.id}"/>">
		<button class="deleteButton">delete album</button>
	</form>
	</c:if>
		
	<p class="clear"></p>
	
</body>
</html>