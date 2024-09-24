<%@page import="Android.AndroidDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="Android1DTO" class="Android.Android1DTO"/>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>
<jsp:setProperty  name="Android1DTO" property="*"/>

<%
	// 안드로이드에서 보낸 sendMsg = "f01="+strings[0]+"&f02="+strings[1]+"&f03="+strings[2];

	//request.setCharacterEncoding("UTF-8");
	//String usid = request.getParameter("f01");
	//String uspw = request.getParameter("f02");
	//String name = request.getParameter("f03");

	String usid = Android1DTO.getF01();
	String uspw = Android1DTO.getF02();
	String name = Android1DTO.getF03();

	System.out.println(usid + uspw + name);
	
	boolean result = AndroidDao.Android_Insert(Android1DTO);
	
	if(result) {
		out.print("회원가입 성공");
	} else {
		out.print("회원가입 실패");
	}

%>