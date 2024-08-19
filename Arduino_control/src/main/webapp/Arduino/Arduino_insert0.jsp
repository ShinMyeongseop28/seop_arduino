<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="ArduinoDao" class="Arduino.ArduinoDAO"/>

<%
	String v01 = request.getParameter("f01");
	String v02 = request.getParameter("f02");
	String v03 = request.getParameter("f03");
	String v04 = request.getParameter("f04");
	System.out.println(v01 + "  " + v02 + "  " + v03 + "  " + v04);
	
	//boolean result = ArduinoDao.Arduino_Save(v01, v02, v03, v04);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=v01%> <%=v02%> <%=v03%> <%=v04%></h1>
</body>
</html>