<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/28
  Time: 19:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>成果</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <style>
        .commentAvatarImage{
            width:80px;
            height:80px;
            line-height: 0;	
            display: inline-block;	
            border-radius: 50%;	
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
        }
        .authorAvatarImage{
            width:120px;
            height:120px;
            line-height: 0;
            display: inline-block;
            border-radius: 50%;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
        }
        #canvas{
            width: 100%;
            height: 100%;
            position:fixed;
            z-index:-1;
        }
        #achievementBackground{
            background-color: rgba(255, 255, 255, 0.9);
        }
        .thumbnail{
            border: 0;
            background-color: rgba(255, 255, 255, 0.9);
        }
    </style>
</head>
<body>

<%--彩带背景--%>
<canvas id="canvas"></canvas>
<script src="js/ribbon.js"></script>

<%@include file="navbar.jsp"%>
<%
    String achievementId = request.getParameter("achievementId");
    String achievementTitle = null;
    String achievementContent = null;
    String createDate = null;
    String createTime = null;
    Integer achievementAuthor = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 AND id="+achievementId;
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            achievementTitle = resultSet.getString("title");
            achievementContent = resultSet.getString("content");
            createTime = String.valueOf(resultSet.getTime("createTime"));
            createDate = String.valueOf(resultSet.getDate("createTime"));
            achievementAuthor = resultSet.getInt("userId");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
    String authorName = null;
    String authorImage = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT headImage,name FROM user WHERE id="+achievementAuthor;
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            authorImage = resultSet.getString("headImage");
            authorName = resultSet.getString("name");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
<%--成果标题--%>
<div class="container text-center">
    <div class="title">
        <h1><%=achievementTitle%></h1>
        <img class="authorAvatarImage" src="<%=authorImage%>">
        <h4><%=authorName%></h4>
        <div>
            <span class="post-time">发表于
                <span><%=createDate%> <%=createTime%></span>
            </span>
        </div>
    </div>
</div>

<%--成果内容--%>
<div class="container" id="achievementBackground"><%=achievementContent%></div>

<div class="container" style="margin-top: 5%;margin-bottom: 5%">
    <a id="previousAchievement" type="button" class="btn btn-info btn-lg">上一篇</a>
    <a id="nextAchievement" type="button" class="btn btn-info btn-lg" style="float: right">下一篇</a>
</div>

<%--评论--%>
<div class="container">
    <div class="row" id="comment">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail col-md-12">
                <div class="caption">
                    <h3>评论</h3>
                    <%
                        //    先判断有没有评论
                        boolean isExistComment = false;
                        try {
                            DbConnection existCommentDbConnection = new DbConnection();
                            Statement existCommentStatement = existCommentDbConnection.connection.createStatement();
                            String exitsCommentSql = "SELECT count(id) FROM achievementComment WHERE isDeleted=0 AND achievementId="+achievementId;
                            ResultSet existCommentResultSet = existCommentStatement.executeQuery(exitsCommentSql);
                            if(existCommentResultSet != null){
                                existCommentResultSet.next();
                                isExistComment = existCommentResultSet.getInt("count(id)") > 0;
                            }
                            existCommentDbConnection.closeConnection();
                        }catch (SQLException e){
                            e.printStackTrace();
                        }
//    如果没有评论则输出提示语句,有评论则输出内容
                        if(!isExistComment){
                            out.print("<div class='alert alert-info' role='alert'>暂时还没有评论,快来添加第一个评论吧</div>");
                        }else{
                            try {
                                DbConnection dbConnection = new DbConnection();
                                Statement statement = dbConnection.connection.createStatement();
                                DbConnection userDbConnection = new DbConnection();
                                Statement userStatement = userDbConnection.connection.createStatement();

                                String sql = "SELECT * FROM achievementComment WHERE isDeleted=0 AND achievementId="+achievementId;
                                ResultSet resultSet = statement.executeQuery(sql);
                                if(resultSet != null && achievementTitle != null){
                                    while (resultSet.next()){
                                        int commentId = resultSet.getInt("id");
                                        int commentUserId = resultSet.getInt("userId");
                                        String userSql = "SELECT name,headImage FROM user WHERE id="+Integer.toString(commentUserId);
                                        ResultSet userResultSet = userStatement.executeQuery(userSql);
                                        if(userResultSet != null){
                                            userResultSet.next();
                                            String commentUserName = userResultSet.getString("name");
                                            String commentHeadImage = userResultSet.getString("headImage");
                                            String achievementComment = resultSet.getString("content");
                                            String commentCreateTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
                    %>

                                            <!--媒体对象,一头像一评论-->
                                            <div class="media" style="margin-top: 3%;margin-bottom: 3%" id="comment<%=commentId%>">
                                                <div class="media-left media-middle">
                                                    <img class="media-object commentAvatarImage" src="<%=commentHeadImage%>" alt="...">
                                                </div>
                                                <div class="media-body">
                                                    <%
                                                        //管理员和发布该成果的用户有权删除所有评论,其余的用户指能删除自己的评论
                                                        if(session.getAttribute("userName")!= null &&( commentUserId == (Integer)session.getAttribute("userId") || 1 == (Integer)session.getAttribute("isManager") || achievementAuthor.equals((Integer) session.getAttribute("userId")))){
                                                            out.print("<button class='btn btn-danger deleteButton' id='delete"+commentId+"' style='float: right'>删除</button>");
                                                        }
                                                    %>
                                                    <h4 class="media-heading"><%=commentUserName%></h4>
                                                    <%=commentCreateTime%><br>
                                                    <div style="word-wrap:break-word;word-break:break-all; "><%=achievementComment%></div>
                                                </div>
                                            </div>

                    <%
                                        }
                                    }
                                }
                                dbConnection.closeConnection();
                                userDbConnection.closeConnection();
                            }catch (SQLException e){
                                e.printStackTrace();
                            }
                        }

                    %>
                </div>
            </div>
        </div>
    </div>
</div>


<%--添加评论框--%>
<div class="container" style="margin-bottom: 10%">
    <div class="row">
        <div class="col-lg-12">
            <div class="input-group input-group-lg">
                <input type="text" class="form-control" placeholder="说一句吧" id="achievementComment">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" id="addComment">评论</button>
                </span>
            </div>
        </div>
    </div>
</div>
<script>
    //前一篇成果
    $("#previousAchievement").click(function () {
        $.post("/previousNextAchievement",{choice:"previous",currentAchievementId:'<%=achievementId%>'},function (data) {
            if(data != "noAchievement" && data != "null"){
                location.href = "achievementDetail.jsp?achievementId="+data;
            }
            else if(data == "noAchievement"){
                swal("警告", "没有文章了", "warning");
            }
            else if(data == "null"){
                swal("失败", "发生错误", "error");
            }
        })
    });

    //后一篇成果
    $("#nextAchievement").click(function () {
        $.post("/previousNextAchievement",{choice:"next",currentAchievementId:'<%=achievementId%>'},function (data) {
            if(data != "noAchievement" && data != "null"){
                location.href = "achievementDetail.jsp?achievementId="+data;
            }
            else if(data == "noAchievement"){
                swal("警告", "没有文章了", "warning");
            }
            else if(data == "null"){
                swal("失败", "发生错误", "error");
            }
        })
    });


    //删除评论
    $(".deleteButton").click(function () {
        var achievementCommentId = this.id.replace(/delete/,"");
        swal({
            title: "警告",
            text: "您确定要删除此评论?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function(){
            $.post("/deleteAchievementComment",{achievementCommentId:achievementCommentId,achievementAuthor:'<%=achievementAuthor%>'},function (data) {
                if(data == "success"){
                    swal("成功", "已删除该评论", "success");
                    var deleteButton = $("#delete"+achievementCommentId);
                    deleteButton.addClass("disabled");
                    deleteButton.html("已删除");
                    deleteButton.unbind("click");
                    $("#comment"+achievementCommentId).remove();
                }
                else{
                    swal("失败", data, "error");
                }
            })
        });
    });


    //添加评论
    $("#addComment").click(function () {
        if(<%=session.getAttribute("userName") == null%>){
            //没有登录
            swal("评论失败", "请先登录", "warning");
            return;
        }
        var achievementId = <%=achievementId%>;
        var achievementComment = $("#achievementComment").val();
        if(achievementComment.length > 0){
            $.post("/addAchievementComment",{achievementId:achievementId,achievementComment:achievementComment},function (data) {
                if(data == "success"){
                    swal({
                        title: "成功",
                        text: "添加评论成功",
                        type: "success",
                        confirmButtonColor: "#79c9e0",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function(){
                        location.reload();
                    });
                }
                else{
                    swal("失败", "添加评论失败", "error");
                }
            })
        }else{
            swal("评论失败", "请填写评论内容", "warning");
        }

    })
</script>


</body>
</html>
