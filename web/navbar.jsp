<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
<script src="sweetalert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
<%--导航条--%>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarCollapse1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp"><i class="fa fa-leaf" aria-hidden="true"></i>学生展示平台</a>
            </div>

            <div class="collapse navbar-collapse" id="navbarCollapse1">
                <ul class="nav navbar-nav navbar-right">
                    <%
                        //为了命名不同,不然会冲突
                        String userNameNavBar = (String)session.getAttribute("userName");
                        if(userNameNavBar == null){
                            out.println("<button type='button' class='btn btn-primary navbar-btn' data-toggle='modal' data-target='#loginModal'>登陆</button>");
                            out.println("<a type='button' class='btn btn-primary navbar-btn' href='register.jsp'>注册</a>");
                        }
                        else{
                            if((Integer)session.getAttribute("isManager")==1){
                                out.println("<a type='button' class='btn btn-primary navbar-btn' href='logout.jsp'>退出</a>");
                                out.println("<li class='naviButton' id='navIndex'><a href='index.jsp'>主页</a></li>");
                                %>
                                <li class="dropdown" id="navUser">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">成员管理 <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="verificationUserList.jsp">成员审核</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="userList.jsp">成员信息</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="achievementList.jsp">成果管理</a></li>
                                    </ul>
                                </li>

                                <li class="dropdown" id="navNews">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">新闻管理 <span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="addNews.jsp">添加新闻</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="newsList.jsp">新闻修改</a></li>
                                    </ul>
                                </li>

                                <li class="dropdown" id="navShare">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">资源<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="photoList.jsp">图片库</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="fileList.jsp">文件库</a></li>
                                    </ul>
                                </li>

                                <%
                                out.println("<li class='naviButton' id='navMyInfo'><a href='editMyInfo.jsp'>个人信息</a></li>");
                            }
                            else{
                                out.println("<a type='button' class='btn btn-primary navbar-btn' href='logout.jsp'>退出</a>");
                                out.println("<li class='naviButton' id='navIndex'><a href='index.jsp'>主页</a></li>");
                                %>
                                <li class="dropdown" id="navAchievement">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">成果<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="addAchievement.jsp">发表成果</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="myAchievementList.jsp">我的成果</a></li>
                                    </ul>
                                </li>
                                <li class="dropdown" id="navShare">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">资源<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="photoList.jsp">图片库</a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="fileList.jsp">文件库</a></li>
                                    </ul>
                                </li>
                    <%
                                out.println("<li class='naviButton' id='navMyInfo'><a href='editMyInfo.jsp'>个人信息</a></li>");
                            }
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>
</nav>
<!--登陆框-->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title text-center" id="loginModalLabel">登陆</h3>
            </div>
            <div class="modal-body">
                <form method="post">
                    <label for="userNameNavBar" class="sr-only">用户名</label>
                    <input type="text" name="userNameNavBar" id="userNameNavBar" class="form-control" placeholder="用户名" required autofocus>
                    <label for="passwordNavBar" class="sr-only">密码</label>
                    <input type="password" name="passwordNavBar" id="passwordNavBar" class="form-control" placeholder="密码" required>
                    <div class="text-center" id="loginButtons">
                        <button type="button" class="btn btn-success" id="loginButton">登陆</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    #loginButtons{
        margin-top: 3%;
    }
    #userNameNavBar{
        margin-bottom: 3%;
    }
</style>
<script>
    $("#loginButton").click(function () {
        var userName = $("#userNameNavBar").val();
        var password = $("#passwordNavBar").val();
        if( !!userName && !!password){
            $.post("/login",{userNameNavBar:userName,passwordNavBar:password},function (data) {
                if(data == "success"){
                    location.reload();
                }
                else{
                    swal("错误",data,"warning");
                }
            })
        }
    });

    $(function () {
        //获取url最后一个参数
        var url= window.location.href;
        var rawIndex = url.substring(url.lastIndexOf('/'));
        var indexArr = rawIndex.split('?');
        //地址栏最后一个值如 /index.jsp
        var navLocation = indexArr[0];
        if(navLocation == "/" || navLocation == "/index.jsp"){
            $("#navIndex").addClass("active");
        }
        else if(navLocation == "/editMyInfo.jsp"){
            $("#navMyInfo").addClass("active");
        }
        else if(navLocation == "/verificationUserList.jsp" || navLocation == "/userList.jsp" || navLocation == "/achievementList.jsp" || navLocation == "/userInfoEdit.jsp" || navLocation == "/userInfo.jsp"){
            $("#navUser").addClass("active");
        }
        else if(navLocation == "/addNews.jsp" || navLocation == "/newsList.jsp" || navLocation == "/newsEdit.jsp"){
            $("#navNews").addClass("active");
        }
        else if(navLocation == "/photoList.jsp" || navLocation == "/fileList.jsp"){
            $("#navShare").addClass("active");
        }
        else if(navLocation == "/addAchievement.jsp" || navLocation == "/myAchievementList.jsp" || navLocation == "/achievementEdit.jsp"){
            $("#navAchievement").addClass("active");
        }
    })


</script>
