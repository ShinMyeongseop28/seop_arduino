<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="Arduino.Arduino1DTO"%>
<%@ page import="Arduino.Arduino2DTO"%>
<jsp:useBean id="Arduino1Dto" class="Arduino.Arduino1DTO"/>
<jsp:useBean id="Arduino2Dto" class="Arduino.Arduino2DTO"/>
<jsp:useBean id="ArduinoDao"  class="Arduino.ArduinoDAO"/>
<jsp:setProperty  name="Arduino1Dto" property="*"/>

<%
	request.setCharacterEncoding("UTF-8");
	String gubun = request.getParameter("gubun");
	
	String v01 = Arduino1Dto.getF01();  // MAC Address
	String v02 = Arduino1Dto.getF02();  // WiFi 수신감도 (-100 이하가 적정함)
	String v03 = Arduino1Dto.getF03();  // 온도
	String v04 = Arduino1Dto.getF04();  // 습도
	String v05 = Arduino1Dto.getF05();  // 조도

	if (gubun.equals("data_insert")) {
		System.out.println("insert : " + v01 + "  " + v02 + "  " + v03 + "  " + v04 + "  " + v05);

		// 자료 추가
		boolean result1 = ArduinoDao.Arduino_Insert(Arduino1Dto);
		// 자료 수정1
		boolean result2 = ArduinoDao.Arduino_Update1(Arduino1Dto);
		// 자료 수정2
		boolean result3 = ArduinoDao.Arduino_Update2(Arduino1Dto);
	}
	
	if (gubun.equals("data_select")) {
		Vector<Arduino2DTO> vlist = null;
		String msg = "";

		// System.out.println("select : " + v01);
		
		vlist = ArduinoDao.Arduino_Get2(v01);
		if (vlist.isEmpty()) {
			out.println("자료가 없습니다.");
		} else {
			// System.out.println("자료 : " + vlist.size());
			for (int i = 0;i<vlist.size(); i++) {
				Arduino2DTO bean = vlist.get(i);
				int numb = bean.getNumb();
	 			String s01  = bean.getS01();
				String s02  = bean.getS02();
				String s03  = bean.getS03();
				String s04  = bean.getS04();
				String s05  = bean.getS05();
				msg += s05;
			}
			System.out.println("select : " + v01 + "  " + msg);
			out.println(msg);
		}
	}
%>
