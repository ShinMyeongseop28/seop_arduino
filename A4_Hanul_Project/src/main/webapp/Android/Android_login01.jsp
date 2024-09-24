<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>

<%
	// CustomTask_001_Login.java 에서 아래 두 줄만 수정하면 됨.
	// 호출 "http://192.168.0.7:8080/A0_Hanul_Android/Android/Android_login01.jsp"
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];
	// http://192.168.0.7:8080/A0_Hanul_Android/Android/Android_login01.jsp?id=a1234&pwd=1234

	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	System.out.println(id + "  :  " + pwd);
	
	if(id.equals("a1234") && pwd.equals("1234")) {
		out.print("T : 로그인 성공 true");
	} else {
		out.print("F : 로그인 실패 false");
	}
	
%>