<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%  request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.Vector"%>
<%@ page import="Arduino.Arduino2DTO"%>
<jsp:useBean id="ArduinoDao" class="Arduino.ArduinoDAO"/>

<%
	request.setCharacterEncoding("UTF-8");
	Vector<Arduino2DTO> vlist = null;

    int totalRecord=0; //전체레코드수
    int listSize=0;    //현재 읽어온 게시물의 수

	//String check = request.getParameter("check");
	String perm1 = request.getParameter("perm1");
	String perm2 = request.getParameter("perm2");
	int recnum = 0;
	if (request.getParameter("numb") == null) {
		recnum = 0;
	} else {
		recnum = Integer.parseInt(request.getParameter("numb"));
	}
	
	//if (check == null) check = "N";  // 구분값
	if (perm1 == null) perm1 = "Z";  // 승인여부 값
	if (perm2 == null) perm2 = "Z";  // 클릭 여부

	if (perm2.equals("GG")) {
		ArduinoDao.Arduino_Update_Perm(recnum, perm1);
	}

%>

<script type="text/javascript">
function Arduino00_p(numb, s05){
	document.readFrm.numb.value=numb;
	document.readFrm.perm1.value=s05;
	document.readFrm.perm2.value="GG";
	document.readFrm.action="Arduino_list.jsp";
	document.readFrm.submit();
}
</script>

<html>
<head>
	<link href="../main/style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">
<div align="center">
    <br/>
		<h2>LED  ON+OFF  제어관리</h2>
    <br>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				  vlist = ArduinoDao.Arduino_Get3();
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>번 호</td>
						<td>맥어드레스</td>
						<td>수신감도</td>
						<td>핀번호</td>
						<td>핀명칭</td>
						<td>제어값</td>
						<td>제어일시</td>
					</tr>
					<%
						  for (int i = 0;i<listSize; i++) {
							Arduino2DTO bean = vlist.get(i);
							int numb = bean.getNumb();
							String s01 = bean.getS01();
							String s02 = bean.getS02();
							String s03 = bean.getS03();
							String s04 = bean.getS04();
							String s05 = bean.getS05();
							String s06 = bean.getS06();
					%>
					<tr>
						<td align="center">
						   <%=numb%>
						</td>
						<td align="center">
						   <%=s01%>
						</td>
						<td align="center">
						   <%=s02%>
						</td>
						<td align="center">
						   <%=s03%>
						</td>
						<td align="center">
						   <%=s04%>
						</td>
						<td align="center">
 						   <a href="javascript:Arduino00_p('<%=numb%>', '<%=s05%>')" ><%=s05%></a>
						</td>
						<td align="center">
						   <%=s06%>
						</td>
					</tr>
					<% } //for %>
				</table>
				<% } //if %>
			</td>
		</tr>
	</table>
	<form name="readFrm" method="get">
	    <br>
		<input type="hidden" name="numb"> 
		<input type="hidden" name="perm1"> 
		<input type="hidden" name="perm2"> 
	</form>
</div>
</body>
</html>