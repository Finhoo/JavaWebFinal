<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:directive.page import="com.wy.form.ArticleTypeForm"/>
<jsp:directive.page import="com.wy.form.ArticleForm"/>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="CSS/style.css" type="text/css" rel="stylesheet">
    <title>前台-全部文章</title>
    <%@ page language="java" import="java.util.*" %>
    <style type="text/css">
        <!--
        body {
            background-image: url(images/bg_01.gif);
        }

        .style6 {
            color: #77642c
        }

        .style7 {
            color: #7f5809
        }

        -->
    </style>
</head>
<jsp:useBean id="pagination" class="com.wy.tool.MyPagination" scope="session"></jsp:useBean>
<jsp:useBean id="articleTypeDao" scope="session" class="com.wy.dao.ArticleTypeDao"></jsp:useBean>
<jsp:useBean id="articleDao" scope="session" class="com.wy.dao.ArticleDao"></jsp:useBean>
<jsp:useBean id="restoreDao" scope="session" class="com.wy.dao.RestoreDao"></jsp:useBean>
<%
    Integer typeId = null;
    if (request.getParameter("typeId") != null) {
        typeId = Integer.valueOf(request.getParameter("typeId"));
    }
    String str = (String) request.getParameter("Page");
    int Page = 1;
    List articleList = null;
    if (str == null) {
        articleList = articleDao.queryArticle(typeId);
        int pagesize = 5;      //指定每页显示的记录数
        articleList = pagination.getInitPage(articleList, Page, pagesize);     //初始化分页信息
    } else {
        Page = pagination.getPage(str);
        articleList = pagination.getAppointPage(Page);     //获取指定页的数据
    }


%>
<body>
<!--网页头部分-->
<jsp:include page="head_top.jsp" flush="true"/>


<table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="74"><img src="images/head_06.jpg" width="74" height="846"></td>
        <td height="846" valign="top" background="images/head_07.jpg">
            <!--登录用户部分-->
            <br>

            <table width="390" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center">
                        <%
                            List list = articleTypeDao.queryArticleType();
                            for (int i = 0; i < list.size(); i++) {
                                ArticleTypeForm articleTypeForm = (ArticleTypeForm) list.get(i);
                        %>
                        <a href="head_ArticleList.jsp?typeId=<%=articleTypeForm.getId()%>">
                            [<%=articleTypeForm.getTypeName()%>]</a>&nbsp;
                        <%}%>

                    </td>
                </tr>
            </table>


            <%
                for (int articleI = 0; articleI < articleList.size(); articleI++) {
                    ArticleForm articleForm = (ArticleForm) articleList.get(articleI);
                    String articleContent = articleForm.getContent();
                    if (articleContent.length() > 100) {
                        articleContent = articleContent.substring(0, 100) + "...";
                    }
            %>
            <table width="380" border="0" align="center">
                <tr>
                    <td width="377" height="22"><font color="BE9110"><b><%=articleForm.getTitle()%>
                    </b></font></td>
                </tr>
                <tr>
                    <td valign="top"><span class="style7"><%=articleContent%></span></td>
                </tr>
                <tr>
                    <td height="17" class="head-02"><a href="head_ArticleForm.jsp?id=<%=articleForm.getId()%>"
                                                       class="head-02">阅读全文&gt;&gt;</a></td>
                </tr>
                <tr>
                    <td height="17"
                        align="right"><%=articleForm.getPhTime()%>&nbsp;|&nbsp;阅读（<%=articleForm.getNumber()%>）&nbsp;|&nbsp回复（<%=restoreDao.queryRestore(articleForm.getId()).size()%>
                        ）
                    </td>
                </tr>
            </table>
            <div align="right" class="style6">
                <hr>
            </div>
            <%} %>

            <%=pagination.printCtrl(Page) %>
        </td>
        <td width="10" background="images/head_07.jpg"><img src="images/head_08.jpg" width="13" height="846"></td>
        <td width="184" valign="top">


            <!--右侧操作部分-->
            <jsp:include page="head_right.jsp" flush="true"/>


        </td>
        <td width="122"><img src="images/head_10.jpg" width="122" height="846"></td>
    </tr>
</table>
<!--网页尾部分-->
<jsp:include page="head_down.jsp" flush="true"/>


</body>
</html>
