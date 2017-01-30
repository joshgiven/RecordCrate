<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Create</title>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<h1><a href="/Inventory/">Record Bin</a></h1>
	
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
				<label>Artist
					<select name="artistId">
					<c:forEach var="artist" items="${artists}">
						<option value="<c:out value="${artist.id}" />" <c:if test="${artist.id == theAlbum.artist.id }">selected</c:if> ><c:out value="${artist.name}" /></option>
					</c:forEach>
					</select>
				</label>
			</li>
			
			<li><label>Title<input type="text" name="title" <c:if test="${update == true}"> value="<c:out value="${theAlbum.title}"/>"</c:if>></label></li>
			<li><label>Year<input type="number" name="year" min="1950" max="2020" <c:if test="${update == true}"> value="<c:out value="${theAlbum.year}"/>"</c:if>></label></li>
	 		<li><label>Genre<input type="text" name="genre" <c:if test="${update == true}"> value="<c:out value="${theAlbum.genre}"/>"</c:if>></label></li>
			<li><label>Image Path<input type="text" name="coverImage" <c:if test="${update == true}"> value="<c:out value="${theAlbum.coverImage}"/>"</c:if>></label></li>
			<li><label>Thumbnail Path<input type="text" name="coverThumbnail" <c:if test="${update == true}"> value="<c:out value="${theAlbum.coverThumbnail}"/>"</c:if>></label></li>
		</ul>
		<c:choose>
			<c:when test="${update == true}">
				<input type="hidden" name="id" value="<c:out value="${theAlbum.id}"/>">
				<button>Update Album</button>
			</c:when>
			<c:otherwise>
				<button>Add Album</button>
			</c:otherwise>
		</c:choose>
	</form>
	
	<c:if test="${update == true}">
	<form action="destroyAlbum.do" method="POST">
		<input type="hidden" name="id" value="<c:out value="${theAlbum.id}"/>">
		<button class="deleteButton">Delete Album</button>
		<label><input type="checkbox">safety switch</label>
	</form>
	</c:if>
	
</body>
</html>