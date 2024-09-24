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
			String name = admin.getF03();
			String tel = admin.getF04();
			out.print("T로그인 성공 " + name + tel);
		} else {
			out.print("F실패 false");
		}
		
	} else if (gubun.equals("g_json")) {
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();
		//JSONObject android_Json = new JSONObject();

		Vector<Android1DTO> vlist = null;
		String msg = "";
		
		vlist = AndroidDao.Android_GetList();  //회원자료 가져오기

		for (int i = 0;i<vlist.size(); i++) {
			Android1DTO bean = vlist.get(i);
			int numb = bean.getNumb();
			String f01 = bean.getF01();
			String f02 = bean.getF02();
			String f03 = bean.getF03();
			String f04 = bean.getF04();
			String f05 = bean.getF05();
			String f06 = bean.getF06();
			String f07 = bean.getF07();
				
			JSONObject tempJson = new JSONObject();
			tempJson.put("numb", Integer.toString(numb));
			tempJson.put("f01", f01);
			tempJson.put("f02", f02);
			tempJson.put("f03", f03);
			tempJson.put("f04", f04);
			tempJson.put("f07", f07);
			itemList.add(tempJson);
		}
		
		jsonList.put("TOTAL",vlist.size());
		jsonList.put("ITEMS",itemList);

		System.out.println("자료수 : " + itemList.size());
		System.out.println(jsonList);
		out.println(jsonList);
		
	} else if (gubun.equals("g_select")) {
		String usid = request.getParameter("id_user");
		
		Android1DTO admin = AndroidDao.Member_get(usid);  //회원자료 가져오기
		String f01 = String.format("%10s",admin.getF01());
		String f02 = String.format("%10s",admin.getF02());
		String f03 = String.format("%10s",admin.getF03());
		String f04 = String.format("%20s",admin.getF04());
		System.out.println(f01 + f02 + f03 + f04);
		out.print(f01 + f02 + f03 + f04);
		
	} else if (gubun.equals("g_insert")) {
		String usid = Android1DTO.getF01();
		String uspw = Android1DTO.getF02();
		String name = Android1DTO.getF03();
		String ustel = Android1DTO.getF04();

		System.out.println(usid + uspw + name + ustel);
		
		boolean result = AndroidDao.Android_Insert(Android1DTO);
		
		if(result) {
			out.print("회원가입 성공");
		} else {
			out.print("회원가입 실패");
		}
		
	} else if (gubun.equals("g_update")) {
		int numb = Android1DTO.getNumb();
		String usid = Android1DTO.getF01();
		String uspw = Android1DTO.getF02();
		String name = Android1DTO.getF03();
		String telp = Android1DTO.getF04();

		System.out.println(numb + usid + uspw + name + telp);
		
		boolean result = AndroidDao.Android_Update(Android1DTO);
	
		if(result) {
			out.print("회원 정보 수정 성공");
		} else {
			out.print("회원 정보 수정 실패");
		}
		
	} else if (gubun.equals("g_delete")) {
		int numb = Android1DTO.getNumb();
		String usid = Android1DTO.getF01();
		String uspw = Android1DTO.getF02();
		String name = Android1DTO.getF03();
		String telp = Android1DTO.getF04();

		System.out.println(numb + usid + uspw + name + telp);
		
		boolean result = AndroidDao.Android_Delete(numb);
	
		if(result) {
			out.print("회원 정보 삭제 성공");
		} else {
			out.print("회원 정보 삭제 실패");
		}
		
	} else {
	}

%>