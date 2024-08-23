<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "java.util.Vector" %>
<%@ page import= "arduino.Test_arduinoDTO" %>
<jsp:useBean id="ArduinoDao" class="arduino.Test_arduinoDAO"/>

<%
	Vector<Test_arduinoDTO> vlist = null;
	String msg = "";

	String v01 = request.getParameter("usma");	//	MAC address
	System.out.println(v01);

	vlist = ArduinoDao.Arduino_Get();
	if (vlist.isEmpty()) {
		out.println("자료가 없습니다.");
	} else {
		//System.out.println("자료 : " + vlist.size());
		for (int i = 0; i<vlist.size(); i++) {
			Test_arduinoDTO bean = vlist.get(i);
			int numb = bean.getNumb();
			String usma = bean.getUsma();
			String pin = bean.getPin();
			String name = bean.getName();
			String control = bean.getControl();
			msg += control;
		}
		System.out.println(msg);
		out.println(msg);
	}

%>