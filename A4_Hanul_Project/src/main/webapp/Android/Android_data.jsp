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
	System.out.println(usid + uspw);
	
	Vector<Android1DTO> vlist = null;
	String msg = "";
	
	vlist = AndroidDao.Android_GetList();  //회원자료 가져오기

	if (vlist.isEmpty()) {
		out.println("자료가 없습니다.");
	} else {
		for (int i = 0;i<vlist.size(); i++) {
			Android1DTO bean = vlist.get(i);
			int numb = bean.getNumb();
			String f01 = bean.getF01();
			String f02 = bean.getF02();
			String f03 = String.format("%10s",bean.getF03());
			String f04 = bean.getF04();
			String f05 = bean.getF05();
			String f06 = bean.getF06();
			String f07 = bean.getF07();
			msg += f03;  // 이름만 전송할 경우
		}
		System.out.println(msg);
		out.println(msg);
	}
%>