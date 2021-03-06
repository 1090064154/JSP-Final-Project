<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/31
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 ORDER BY id DESC LIMIT "+ Integer.toString((currentPage-1)*10) +",10";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-success text-center' role='alert'>以下是所有成果的信息</div>
            <div class='container text-center'>
                <table class="table table-hover">
            <%
                while (resultSet.next()){
                    int id = resultSet.getInt("id");
                    String title = resultSet.getString("title");
                    String createTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
            %>
                    <tr id="achievement<%=id%>" class="achievementTr" style="cursor: pointer">
                        <td><%=title%></td>
                        <td style="text-align: right"><%=createTime%></td>
                    </tr>
            <%
                }
            %>
                    </table>
            
            
            </div>
<%
        }
        else{
            out.println("<div class='container alert alert-warning text-center' role='alert'>未查询到信息</div>");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
<script>
    $(".achievementTr").click(function () {
        var achievementId = this.id.replace(/achievement/,"");
        location.href = "achievementDetail.jsp?achievementId="+achievementId;
    })
</script>