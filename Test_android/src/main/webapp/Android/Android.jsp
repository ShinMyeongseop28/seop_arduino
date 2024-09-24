<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.Vector"%>
<%@ page import="Android.Android1DTO"%>
<jsp:useBean id="Android1DTO" class="Android.Android1DTO"/>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>
<jsp:setProperty  name="Android1DTO" property="*"/>

<%
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];
	// 호출 http://192.168.0.27:8080/A0_Hanul_Android/Android/Android.jsp?id=user01&pwd=1234
	
	request.setCharacterEncoding("UTF-8");
	String gubun = request.getParameter("gubun");
	System.out.println("gubun : " + gubun);
	
	if (gubun.equals("g_login")) {
		String usid = request.getParameter("usid");
		String uspw = request.getParameter("uspw");
	
		boolean result = AndroidDao.Member_login(usid, uspw);
	
		if(result) {
			Android1DTO admin = AndroidDao.Member_get(usid);  //회원자료 가져오기
			String name = admin.getName();
			String tel = admin.getUstel();
			out.print("T로그인 성공 " + name + tel);
		} else {
			out.print("F실패 false");
		}
		
	} else if (gubun.equals("g_select")) {
		String id_user = request.getParameter("id_user");
		
		Android1DTO admin = AndroidDao.Member_get(id_user);  //회원자료 가져오기
		String numb = String.format("%10s",admin.getNumb());
		String usid = String.format("%10s",admin.getUsid());
		String uspw = String.format("%10s",admin.getUspw());
		String name = String.format("%10s",admin.getName());
		String ustel = String.format("%20s",admin.getUstel());
		System.out.println(numb + usid + uspw + name + ustel);
		out.print(numb + usid + uspw + name + ustel);
		
	} else if (gubun.equals("g_insert")) {
		String usid = Android1DTO.getUsid();
		String uspw = Android1DTO.getUspw();
		String name = Android1DTO.getName();
		String ustel = Android1DTO.getUstel();

		System.out.println(usid + uspw + name + ustel);
		
		boolean result = AndroidDao.Android_Insert(Android1DTO);
		
		if(result) {
			out.print("회원가입 성공");
		} else {
			out.print("회원가입 실패");
		}
		
	} else if (gubun.equals("g_update")) {
		int numb = Android1DTO.getNumb();
		String usid = Android1DTO.getUsid();
		String uspw = Android1DTO.getUspw();
		String name = Android1DTO.getName();
		String ustel = Android1DTO.getUstel();

		System.out.println(numb + usid + uspw + name + ustel);
		
		boolean result = AndroidDao.Android_Update(Android1DTO);
	
		if(result) {
			out.print("회원 정보 수정 성공");
		} else {
			out.print("회원 정보 수정 실패");
		}
		
	} else if (gubun.equals("g_delete")) {
		int numb = Android1DTO.getNumb();
		String usid = Android1DTO.getUsid();
		String uspw = Android1DTO.getUspw();
		String name = Android1DTO.getName();
		String ustel = Android1DTO.getUstel();

		System.out.println(numb + usid + uspw + name + ustel);
		
		boolean result = AndroidDao.Android_Delete(numb);
	
		if(result) {
			out.print("회원 정보 삭제 성공");
		} else {
			out.print("회원 정보 삭제 실패");
		}
		
	} else {
	}

%>