<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.Vector"%>
<%@ page import="Android.Android1DTO"%>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>

<%
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
%>