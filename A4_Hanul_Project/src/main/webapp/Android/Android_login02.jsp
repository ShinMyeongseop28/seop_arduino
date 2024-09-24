<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="Android.Android1DTO"%>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>

<%
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];

	request.setCharacterEncoding("UTF-8");
	String usid = request.getParameter("id");
	String uspw = request.getParameter("pwd");
	
	System.out.println(usid + "  :  " + uspw);
	
	boolean result = AndroidDao.Member_login(usid, uspw);
	
	if(result) {
		Android1DTO admin = AndroidDao.Member_get(usid);  //회원자료 가져오기
		String name = admin.getF03();
		String tel = admin.getF04();
		out.print("T로그인 성공 " + name + tel);
	} else {
		out.print("F실패 false");
	}

	// 호출 http://192.168.0.7:8080/A0_Hanul_Android/Android/Android_login02.jsp?id=user01&pwd=1234
%>