<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="Android.Android1DTO"%>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>

<%
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];

	request.setCharacterEncoding("UTF-8");
	String usid = request.getParameter("id_user");
	
	Android1DTO admin = AndroidDao.Member_get(usid);  //회원자료 가져오기
	String f01 = String.format("%10s",admin.getF01());
	String f02 = String.format("%10s",admin.getF02());
	String f03 = String.format("%10s",admin.getF03());
	String f04 = String.format("%20s",admin.getF04());
	out.print(f01 + f02 + f03 + f04);

	// 호출 http://192.168.0.163:8080/A0_Hanul_Android/Android/Android_login02.jsp?id=user01&pwd=1234
%>