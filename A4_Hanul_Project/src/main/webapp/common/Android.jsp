<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="common.Common1DTO"%>
<jsp:useBean id="Common1DTO" class="common.Common1DTO"/>
<jsp:useBean id="CommonDao"  class="common.CommonDAO"/>
<jsp:setProperty  name="Common1DTO" property="*"/>

<%
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];
	// 호출 http://192.168.0.27:8080/A0_Hanul_Android/Android/Android.jsp?id=user01&pwd=1234
	// int numb = Integer.parseInt(request.getParameter("numb"));

	request.setCharacterEncoding("UTF-8");
	String gubun = request.getParameter("gubun");
	System.out.println("gubun : " + gubun);
	
	
	
	if (gubun.equals("g_login")) {
		String usid = request.getParameter("usid");
		String uspw = request.getParameter("uspw");
	
		boolean result = CommonDao.Member_login(usid, uspw);
	
		if(result) {
			Common1DTO admin = CommonDao.Member_get(usid);  //회원자료 가져오기
			String name = admin.getF01();
			String tel = admin.getF03();
			out.print("T로그인 성공 " + name + tel);
		} else {
			out.print("F실패 false");
		}
		
	} else if (gubun.equals("g_select")) {
		String usid = request.getParameter("id_user");
		
		Common1DTO admin = CommonDao.Member_get(usid);  //회원자료 가져오기
		//String f01 = String.format("%10s",admin.getNumb());
		String f02 = String.format("%10s",admin.getF01());
		String f03 = String.format("%10s",admin.getF02());
		String f04 = String.format("%10s",admin.getF03());
		String f05 = String.format("%20s",admin.getF04());
		System.out.println(f02 + f03 + f04 + f05);
		out.print(f02 + f03 + f04 + f05);
		
	} else if (gubun.equals("g_insert")) {
		String usid = Common1DTO.getF01();
		String uspw = Common1DTO.getF02();
		String name = Common1DTO.getF03();

		System.out.println(usid + uspw + name);
		
		boolean result = CommonDao.Android_Insert(Common1DTO);
		
		if(result) {
			out.print("회원가입 성공");
		} else {
			out.print("회원가입 실패");
		}
		
	} else if (gubun.equals("g_update")) {
		int numb = Common1DTO.getNumb();
		String usid = Common1DTO.getF01();
		String uspw = Common1DTO.getF02();
		String name = Common1DTO.getF03();
		String telp = Common1DTO.getF04();

		System.out.println(numb + usid + uspw + name + telp);
		
		boolean result = CommonDao.Android_Update(Common1DTO);
		
		if(result) {
			out.print("회원 정보 수정 성공");
		} else {
			out.print("회원 정보 수정 실패");
		}
		
	} else if (gubun.equals("g_control")) {
		int numb = Integer.parseInt(request.getParameter("numb"));
		String perm = request.getParameter("perm");

		System.out.println("JSP : " + gubun + numb + perm);
		
		boolean result = CommonDao.Arduino_Update_Perm(numb, perm);

/* 		if(result) {
			System.out.println("LED : 수정성공 ");
			//	out.print("회원 정보 수정 성공");
		} else {
			System.out.println("LED : 수정실패 ");
		//	out.print("회원 정보 수정 실패");
		}
 */		
	} else if (gubun.equals("g_delete")) {
		int numb = Common1DTO.getNumb();
		String usid = Common1DTO.getF01();
		String uspw = Common1DTO.getF02();
		String name = Common1DTO.getF03();
		String telp = Common1DTO.getF04();

		System.out.println(numb + usid + uspw + name + telp);
		
		boolean result = CommonDao.Android_Delete(numb);
	
		if(result) {
			out.print("회원 정보 삭제 성공");
		} else {
			out.print("회원 정보 삭제 실패");
		}
		
	} else {
	
		JSONObject jsonList = new JSONObject();
		JSONArray itemList = new JSONArray();
		//JSONObject android_Json = new JSONObject();

		Vector<Common1DTO> vlist = null;
		String msg = "";
		
		vlist = CommonDao.Android_GetList();  //회원자료 가져오기

		for (int i = 0; i<vlist.size(); i++) {
			Common1DTO bean = vlist.get(i);
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
	}

%>