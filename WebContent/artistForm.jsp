<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Create</title>
	<link rel="stylesheet" type="text/css" href="css/style.css" />
</head>
<body>
	<h1><a href="/Inventory/">RecordCrate</a></h1>
	
	<c:choose>
		<c:when test="${update == true}">
			<h2>Update Artist</h2>
		</c:when>
		<c:otherwise>
			<h2>Create Artist</h2>
		</c:otherwise>
	</c:choose>
	
	
	<form action="createArtist.do" method="POST">
 		<ul>
			<li><label>Artist Name<input type="text" name="name" <c:if test="${update == true}"> value="<c:out value="${theArtist.name}"/>"</c:if>></label></li>
			<li><label>Sort Name<input type="text" name="sortName" <c:if test="${update == true}"> value="<c:out value="${theArtist.sortName}"/>"</c:if>></label></li>
	 		<li><label>Short Bio<textarea name="bioText"> <c:if test="${update == true}"><c:out value="${theArtist.bioText}"/></c:if></textarea></label></li>
			<li><label>WWW Link<input type="text" name="link" <c:if test="${update == true}"> value="<c:out value="${theArtist.link}"/>"</c:if>></label></li>
			<li><label>Image Path<input type="text" name="image" <c:if test="${update == true}"> value="<c:out value="${theArtist.image}"/>"</c:if>></label></li>
			<li><label>Thumbnail Path<input type="text" name="thumbnail" <c:if test="${update == true}"> value="<c:out value="${theArtist.thumbnail}"/>"</c:if>></label></li>
		</ul>
		<c:choose>
			<c:when test="${update == true}">
 				<input type="hidden" name="id" value="<c:out value="${theArtist.id}"/>">
				<button>Update Artist</button>
			</c:when>
			<c:otherwise>
				<button>Add Artist</button>
			</c:otherwise>
		</c:choose>
	</form>
	
	<c:if test="${update == true}">
	<form action="destroyArtist.do" method="POST">
		<input type="hidden" name="id" value="<c:out value="${theArtist.id}"/>">
		<button class="deleteButton">Delete Artist</button>
		<label><input type="checkbox">safety switch</label>
	</form>
	</c:if>

</body>
</html>