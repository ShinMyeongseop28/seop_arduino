<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="arduino.Test_arduinoDTO"%>
<jsp:useBean id="ArduinoDao" class="arduino.Test_arduinoDAO"/>

<%
    Vector<Test_arduinoDTO> vlist = null;
    int totalRecord = 0; // 전체 레코드 수
    int listSize = 0;    // 현재 읽어온 게시물의 수

    String perm1 = request.getParameter("perm1") != null ? request.getParameter("perm1") : "Z";  // 승인 여부 값
    String perm2 = request.getParameter("perm2") != null ? request.getParameter("perm2") : "Z";  // 클릭 여부
    int recnum = request.getParameter("numb") != null ? Integer.parseInt(request.getParameter("numb")) : 0;

    // 승인 여부에 따라 업데이트 수행
    if ("GG".equals(perm2)) {
        ArduinoDao.Arduino_Update_Perm(recnum, perm1);
    }

    // 데이터 가져오기
    vlist = ArduinoDao.Arduino_Get();
    listSize = vlist.size(); // 브라우저 화면에 보여질 게시물 수
%>

<script type="text/javascript">
function Arduino00_p(numb, control) {
    document.readFrm.numb.value = numb;
    document.readFrm.perm1.value = control;
    document.readFrm.perm2.value = "GG";
    document.readFrm.action = "Arduino_list.jsp";
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
    <h2>LED ON+OFF 제어관리</h2>
    <br>
    <table align="center" width="800" cellpadding="3" border="1">
        <tr>
            <td align="center" colspan="3">
                <%
                    if (vlist.isEmpty()) {
                        out.println("등록된 게시물이 없습니다.");
                    } else {
                %>
                <table width="100%" cellpadding="2" cellspacing="0" border="1">
                    <tr align="center" bgcolor="#D0D0D0">
                        <td>번 호</td>
                        <td>맥어드레스</td>
                        <td>핀번호</td>
                        <td>핀명칭</td>
                        <td>제어값</td>
                    </tr>
                    <%
                        for (int i = 0; i < listSize; i++) {
                            Test_arduinoDTO bean = vlist.get(i);
                            int numb = bean.getNumb();
                            String usma = bean.getUsma();
                            String pin = bean.getPin();
                            String name = bean.getName();
                            String control = bean.getControl();
                    %>
                    <tr>
                        <td align="center"><%=numb%></td>
                        <td align="center"><%=usma%></td>
                        <td align="center"><%=pin%></td>
                        <td align="center"><%=name%></td>
                        <td align="center">
                            <a href="javascript:Arduino00_p('<%=numb%>', '<%=control%>')"><%=control%></a>
                        </td>
                    </tr>
                    <% } // for %>
                </table>
                <% } // if %>
            </td>
        </tr>
    </table>
    <form name="readFrm" method="get">
        <input type="hidden" name="numb"> 
        <input type="hidden" name="perm1"> 
        <input type="hidden" name="perm2"> 
    </form>
</div>
</body>
</html>