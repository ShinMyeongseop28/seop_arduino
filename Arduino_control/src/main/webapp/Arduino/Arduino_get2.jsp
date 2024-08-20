<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "java.util.Vector" %>
<%@ page import= "Arduino.Arduino2DTO" %>
<jsp:useBean id="ArduinoDao" class="Arduino.ArduinoDAO"/>

<%
	Vector<Arduino2DTO> vlist = null;
	String msg = "";

	String v01 = request.getParameter("f01");	//	제어값 리스트에서 읽어오기
	System.out.println(v01);

	vlist = ArduinoDao.Arduino_Get2(v01);
	if (vlist.isEmpty()) {
		out.println("자료가 없습니다.");
	} else {
		//System.out.println("자료 : " + vlist.size());
		for (int i = 0; i<vlist.size(); i++) {
			Arduino2DTO bean = vlist.get(i);
			//int numb = bean.getNumb();
			//String s01 = bean.getS01();
			//String s02 = bean.getS02();
			//String s03 = bean.getS03();
			//String s04 = bean.getS04();
			String s05 = bean.getS05();
			msg += s05;
		}
		System.out.println(msg);
		out.println(msg);
	}

%>