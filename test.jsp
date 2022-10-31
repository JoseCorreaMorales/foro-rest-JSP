<%@ page import="javax.naming.*"%>
<%@ page import="java.sql.*"%>

<%
    out.println("<h1>Hola</h1>");

    String bdconexion  = "jdbc:mysql://127.0.0.1/foro?user='root'&password=''";
    try{
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection c = DriverManager.getConnection(bdconexion, "root", "");
        out.println("conexion realizada");
        c.close();
    }catch(SQLException e){
        out.println(e);
    }


%>