<%@page import="Android.AndroidDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="Android1DTO" class="Android.Android1DTO"/>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>
<jsp:setProperty  name="Android1DTO" property="*"/>

<%
	// 안드로이드에서 보낸 sendMsg = "f01="+strings[0]+"&f02="+strings[1]+"&f03="+strings[2];

	int numb = Integer.parseInt(request.getParameter("numb"));

	System.out.println(numb);
	
	boolean result = AndroidDao.Android_Delete(numb);
	
	if(result) {
		out.print("회원 정보 삭제 성공");
	} else {
		out.print("회원 정보 삭제 실패");
	}

%>