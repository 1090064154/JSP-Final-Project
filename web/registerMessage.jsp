<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/27
  Time: 21:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="sweetalert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="sweetalert/dist/sweetalert.css">

<body>
<%
    String message = (String)request.getAttribute("message");
    boolean isError = (Boolean) request.getAttribute("isError");
    if(isError){
%>
    <script>
        swal({
            title: "对不起",
            text: "<%=message%>",
            type: "error",
            confirmButtonColor: "#79c9e0",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function(){
            window.location.href="register.jsp";
        });
    </script>
<%
    }
    else {
%>
    <script>
        swal({
            title: "成功",
            text: "<%=message%>",
            type: "success",
            confirmButtonColor: "#79c9e0",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function(){
            window.location.href="index.jsp";
        });
    </script>
<%
    }
%>


</body>