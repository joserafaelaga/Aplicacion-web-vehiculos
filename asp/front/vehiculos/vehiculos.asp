<% @ CODEPAGE = 65001 %>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- #include file="../func_front.asp" -->
	<!-- #include file="../../func_gene.asp" -->
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/jquery-3.1.1.min.js"></script>
    <link href="../../../bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/bootstrap.min.js"></script>
    <link href="../../../styles/estilos.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<title>Vehículos</title>
	<%
		sesion_abierta()
		seguridad()
		if (Len(Request.QueryString("c"))>0) then
			cerrar_sesion()
		end if
	%>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<h1>Vehículos</h1>
		<div class="row">
		<form action="#" method="POST">
			 <div class="col-lg-6">
			    <div class="input-group">
			      <input type="text" name="busqueda" class="form-control" placeholder="Introduzca la matrícula, modelo o marca del vehículo...">
			      <span class="input-group-btn">
			        <button class="btn btn-default" name="buscar" type="submit">Buscar</button>
			      </span>
			    </div>
			  </div>
		 </form>
		</div>
		<div class="margin_sup">
		<%
			set con = Server.CreateObject("ADODB.Connection")
				con.Open("vehiculos")

				
				' Si existe un envío del buscador muestra los datos buscados, sino toda la tabla de Vehículos
				if (Len(request.form("busqueda"))>0) then
					consult="select * from vehiculo where marca like '%"&request.form("busqueda")&"%' or modelo like '%"&request.form("busqueda")&"%' or matricula like '%"&request.form("busqueda")&"%' ORDER BY marca asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Matrícula</td>")
										response.write("<th>Modelo</td>")
										response.write("<th>Marca</td>")
										response.write("<th>Nº de puertas</td>")
										response.write("<th>Categoría</td>")
										response.write("<th>Precio</td>")
									
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("matricula")&"</td>")
										response.write("<td>"&datos("modelo")&"</td>")
										response.write("<td>"&datos("marca")&"</td>")
										response.write("<td>"&datos("n_puertas")&"</td>")
										response.write("<td>"&datos("categoria")&"</td>")
										response.write("<td>"&datos("precio")&"</td>")
									response.write("</tr>")
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
					else
						response.write("<div class='alert alert-danger'> <strong>No hay coincidencias en la búsqueda</strong></div>")
					end if

				else
					consult="select * from vehiculo ORDER BY marca asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Matrícula</td>")
										response.write("<th>Modelo</td>")
										response.write("<th>Marca</td>")
										response.write("<th>Nº de puertas</td>")
										response.write("<th>Categoría</td>")
										response.write("<th>Precio</td>")
									
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("matricula")&"</td>")
										response.write("<td>"&datos("modelo")&"</td>")
										response.write("<td>"&datos("marca")&"</td>")
										response.write("<td>"&datos("n_puertas")&"</td>")
										response.write("<td>"&datos("categoria")&"</td>")
										response.write("<td>"&datos("precio")&"</td>")
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
						
					else
						response.write("<div class='alert alert-danger'> <strong>No hay vehículos actualmente</strong></div>")
					end if
				
				end if 'Cierre if busqueda o listado completo
				con.close
		%>
		</div>
	</div>
	
</body>
</html>