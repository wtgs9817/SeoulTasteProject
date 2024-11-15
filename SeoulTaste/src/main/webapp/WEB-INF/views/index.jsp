<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>웹페이지 제목</title>
</head>
<body>
	<h1>성공</h1>

    <>
        <c:forEach var="list" items="${list}">
            <td> <c:out value="${list.title}"/></td>
            <td> <c:out value="${list.content}"/></td>
            <td> <c:out value="${list.writer}"/></td>
        </c:forEach>



    </ul>

</body>
</html>