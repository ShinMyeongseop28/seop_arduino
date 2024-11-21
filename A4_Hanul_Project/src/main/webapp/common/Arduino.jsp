<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="common.Common1DTO"%>
<%@ page import="common.Common2DTO"%>
<jsp:useBean id="Common1DTO" class="common.Common1DTO"/>
<jsp:useBean id="Common2DTO" class="common.Common2DTO"/>
<jsp:useBean id="CommonDao"  class="common.CommonDAO"/>
<jsp:setProperty  name="Common1DTO" property="*"/>

<%
	request.setCharacterEncoding("UTF-8");
	String gubun = request.getParameter("gubun");
	
	String v01 = Common1DTO.getF01();   // MAC Address
	String v02 = Common1DTO.getF02();   // WiFi 수신감도 (-100 이하가 적정함)
	String v03 = Common1DTO.getF03();   // 온도
	String v04 = Common1DTO.getF04();   // 습도
	String v05 = Common1DTO.getF05();   // 조도

	if (gubun.equals("data_insert")) {
		System.out.println("insert : " + v01 + "  " + v02 + "  " + v03 + "  " + v04 + "  " + v05);

		// 자료 추가
		boolean result1 = CommonDao.Arduino_Insert(Common1DTO);
		// 자료 수정
		boolean result2 = CommonDao.Arduino_Update(Common1DTO);
	}
	
	if (gubun.equals("data_select")) {
		Vector<Common2DTO> vlist = null;
		String msg = "";

		//System.out.println("select : " + v01);
		
		vlist = CommonDao.Arduino_Get1(v01);
		if (vlist.isEmpty()) {
			out.println("자료가 없습니다.");
		} else {
			//System.out.println("자료 : " + vlist.size());
			for (int i = 0;i<vlist.size(); i++) {
				Common2DTO bean = vlist.get(i);
				//int numb = bean.getNumb();
	 			//String s01  = bean.getS01();
				//String s02  = bean.getS02();
				//String s03  = bean.getS03();
				//String s04  = bean.getS04();
				String s05  = bean.getS05();
				msg += s05;
			}
			System.out.println("select : " + v01 + "  " + msg);
			out.println(msg);
		}
	}
%>