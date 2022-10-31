<%@ page import="javax.naming.*"%>
<%@ page import="java.sql.*"%>
<%
String nc, nom, sem;
String metodo, sql;
//Datos de conexion a la bd jsptest (127.0.0.1 es similar a localhost)

String bdconexion = "jdbc:mysql://127.0.0.1/foro?user='root'&password=";
//String bduser = "root";
//String bdpass = "";
//Se otiene el metodo de peticion
metodo = request.getMethod();
if(metodo.equalsIgnoreCase("GET")){
    //Se usa out.print Para imprimir texto o codigo html y generar la pagina de respuesta al cliente
    out.print("Metodo consultar REST<br>");
    try{
    //conexion a la base de datos
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    Connection con = DriverManager.getConnection(bdconexion);
    Statement st = con.createStatement();
    //Se revisa si llega el numero de control se hace filtrando este con where sino se consultan toda la tabla
    if((nc = request.getParameter("nc")) != null)
    sql = "SELECT * FROM alumnos WHERE control='" + nc + "'";
    else
    sql = "SELECT * FROM alumnos";
    //executeQuery es para consultas SELECT y devuelve los datos a un ResultSet
    ResultSet res = st.executeQuery(sql);
    //Se imprimer una tabla para dar formato a los datos consultados
    out.print("<table border=1>");
    out.print("<tr><th>NC</th><th>Nombre</th><th>Semestre</th></tr>");
    //Se recorren todas las filas consultadas del resulset
    while(res.next()){
    //Se imprime cada una de las columnas de la tabla alumnos consultada
    out.print("<tr><td>" + res.getString("control") + "</td>");
    out.print("<td>" + res.getString("nombre") + "</td>");
    out.print("<td>" + res.getString("semestre") + "</td></tr>");
    }
    out.print("</table>");
    con.close();
    }catch(SQLException e){

        out.print(e);
    }
}else if(metodo.equalsIgnoreCase("POST")){
    out.print("Metodo agregar REST<br>");
    try{
    Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
    Connection con =
    DriverManager.getConnection(bdconexion);
    Statement st = con.createStatement();
    nc = request.getParameter("nc");
    nom = request.getParameter("nombre");
    sem = request.getParameter("semestre");
    //Falta realizar validacion que los campos no esten vacios
    sql = "INSERT INTO alumnos VALUES('" + nc + "','" + nom + "'," + sem + ")";
    //executeUpdate se utiliza para INSERT, UPDATE, DELETE y devuelve el numero de filas afectadas
    int res=st.executeUpdate(sql);
    if (res > 0)
    out.print("Datos guardados.");
    else
    out.print("No se pudo guardar, vuelva intentarlo.");
    con.close();
    }catch(SQLException e){
    out.print(e);
    }
}else if(metodo.equalsIgnoreCase("PUT")){
    out.print("Metodo actualizar REST");

}else if(metodo.equalsIgnoreCase("DELETE")){
    out.print("Metodo eliminar REST");

}else{
//Se manda un mensaje de error a nivel http
response.sendError(response.SC_METHOD_NOT_ALLOWED,"Only GET requests are allowed.");
}
%>