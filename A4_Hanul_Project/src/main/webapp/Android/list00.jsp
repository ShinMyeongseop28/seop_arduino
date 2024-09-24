<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="Android.Android1DTO"%>
<jsp:useBean id="Android1DTO" class="Android.Android1DTO"/>
<jsp:useBean id="AndroidDao" class="Android.AndroidDAO"/>

<%
	// http://localhost:8080/A0_Hanul_Android/Hanrasan/list00.jsp
	// http://jiguin1175.cafe24.com/A0_Hanul_Android/Hanrasan/list00.jsp
	
	request.setCharacterEncoding("UTF-8");
	String usid = (String) session.getAttribute("idKey");
	//DTO_admin adminBean = DAO_econavi.Member_GetList(usid, 0);    //회원자료 가져오기
	//String macadd = adminBean.getMacadd();

	Vector<Android1DTO> vlist = null;
    int listSize=0;    //현재 읽어온 게시물의 수
%>

<html>
<head>
	<title>수집자료관리</title>
	<link href="../main/style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">
<div align="center">
    <br/>
		<h2>수집자료 조회</h2>
    <br>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				vlist = AndroidDao.Android_GetList();
					listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
					if (vlist.isEmpty()) {
						out.println("등록된 게시물이 없습니다.");
					} else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>번 호</td>
						<td>아이디</td>
						<td>비밀번호</td>
						<td>이름</td>
						<td>전화번호</td>
						<td>LED1</td>
						<td>LED2</td>
						<td>기록일시</td>
					</tr>
					<%
						for (int i = 0;i<listSize; i++) {
							Android1DTO bean = vlist.get(i);
							int numb = bean.getNumb();
							String f01 = bean.getF01();
							String f02 = bean.getF02();
							String f03 = bean.getF03();
							String f04 = bean.getF04();
							String f05 = bean.getF05();
							String f06 = bean.getF06();
							String f07 = bean.getF07();
					%>
					<tr>
						<td align="center">
						   <%=numb%>
						</td>
						<td align="center">
 						   <%=f01%>
						</td>
						<td align="center">
						   <%=f02%>
						</td>
						<td align="center">
						   <%=f03%>
						</td>
						<td align="center">
						   <%=f04%>
						</td>
						<td align="center">
						   <%=f05%>
						</td>
						<td align="center">
						   <%=f06%>
						</td>
						<td align="center">
						   <%=f07%>
						</td>
					</tr>
					<% } //for %>
				</table>
				<% } //if %>
			</td>
		</tr>
	</table>
</div>
</body>
</html>