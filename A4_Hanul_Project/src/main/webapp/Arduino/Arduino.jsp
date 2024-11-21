<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.Vector"%>
<%@ page import="Arduino.Arduino1DTO"%>
<jsp:useBean id="Arduino1DTO" class="Arduino.Arduino1DTO"/>
<jsp:useBean id="ArduinoDao" class="Arduino.ArduinoDAO"/>
<jsp:setProperty  name="Arduino1DTO" property="*"/>

<%
	// 안드로이드에서 보낸 sendMsg = "id="+strings[0]+"&pwd="+strings[1];
	// 호출 http://192.168.0.27:8080/A0_Hanul_Android/Android/Android.jsp?id=user01&pwd=1234
	
	request.setCharacterEncoding("UTF-8");
	String gubun = request.getParameter("gubun");
	System.out.println("gubun : " + gubun);
	
	if (gubun.equals("data_insert")) {
		String v01 = Arduino1DTO.getF01();
		String v02 = Arduino1DTO.getF02();
		String v03 = Arduino1DTO.getF03();
		String v04 = Arduino1DTO.getF04();
		String v05 = Arduino1DTO.getF05();
		String v07 = Arduino1DTO.getF07();

		System.out.println(gubun + v01 + v02 + v03 + v04 + v05 + v07);
		
		boolean result = ArduinoDao.Arduino_Insert(Arduino1DTO);
	}
%>