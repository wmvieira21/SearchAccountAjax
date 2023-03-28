<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONArray"%>
<%
    try {
        JSONArray jsonResponse = new JSONArray();
        JSONObject obj = new JSONObject();
        String account = request.getParameter("accont");

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/student", "root", "");

        PreparedStatement pst = conn.prepareStatement("select * from accounts where cd_account = ?");
        pst.setString(1, account);

        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            obj.put("name", rs.getString("name"));
            obj.put("balance", rs.getString("balance"));
            jsonResponse.add(obj);
        }

        out.println(jsonResponse.toJSONString());
        out.flush();
    } catch (Exception ecx) {
        ecx.printStackTrace();
        throw new ServletException(ecx.getMessage());
    }
%>