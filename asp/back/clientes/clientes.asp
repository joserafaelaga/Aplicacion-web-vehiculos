<% @ CODEPAGE = 65001 %>
<%
	sesion_abierta()
	seguridad()
	if (Len(Request.QueryString("c"))>0) then
		cerrar_sesion()
	end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- #include file="../func_back.asp" -->
	<!-- #include file="../../func_gene.asp" -->
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/jquery-3.1.1.min.js"></script>
    <link href="../../../bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/bootstrap.min.js"></script>
    <link href="../../../styles/estilos.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<title>Clientes</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<h1>Clientes</h1>
		<div class="row">
		<form action="#" method="POST">
			 <div class="col-lg-6">
			    <div class="input-group">
			      <input type="text" name="busqueda" class="form-control" placeholder="Introduce el nombre del cliente...">
			      <span class="input-group-btn">
			        <button class="btn btn-default" name="buscar" type="submit">Buscar</button>
			      </span>
			    </div>
			  </div>
		 </form>
		</div>
		<div class="margin_sup">
		<%
			'Conexión BD
			set con = Server.CreateObject("ADODB.Connection")
				con.Open("vehiculos")

				
				' Si existe un envío del buscador muestra los datos buscados, sino toda la tabla de clientes
				if (Len(request.form("busqueda"))>0) then
					consult="select * from cliente where nombre like '%"&request.form("busqueda")&"%' ORDER BY nombre asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Nombre</td>")
										response.write("<th>Nick</td>")
										response.write("<th>Contraseña</td>")
										response.write("<th>Teléfono</td>")
										response.write("<th>Factura</td>")
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("nombre")&"</td>")
										response.write("<td>"&datos("nick")&"</td>")
										response.write("<td>"&datos("pass")&"</td>")
										response.write("<td>"&datos("telefono")&"</td>")
										response.write("<td><a href='factura.asp?cli="&datos("codigo")&"'><button type='button' class='btn btn-default btn-sm'>Ver</button></a></td>")
									response.write("</tr>")
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
					else
						response.write("<div class='alert alert-danger'> <strong>No hay coincidencias en la búsqueda</strong></div>")
					end if

				else
					'Consulto todo los clientes y los muestro
					consult="select * from cliente ORDER BY nombre asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Nombre</td>")
										response.write("<th>Nick</td>")
										response.write("<th>Contraseña</td>")
										response.write("<th>Teléfono</td>")
										response.write("<th>Factura</td>")
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("nombre")&"</td>")
										response.write("<td>"&datos("nick")&"</td>")
										response.write("<td>"&datos("pass")&"</td>")
										response.write("<td>"&datos("telefono")&"</td>")
										response.write("<td><a href='factura.asp?cli="&datos("codigo")&"'><button type='button' class='btn btn-default btn-sm'>Ver</button></a></td>")
									response.write("</tr>")
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
						
					else
						response.write("<div class='alert alert-danger'> <strong>No hay clientes actualmente</strong></div>")
					end if
				
				end if 'Cierre if busqueda o listado completo
				con.close
		%>
		</div>
	</div>
</body>
</html>