<% @ CODEPAGE = 65001 %>
<!-- #include file="../func_back.asp" -->
<!-- #include file="../../func_gene.asp" -->
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
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/jquery-3.1.1.min.js"></script>
    <link href="../../../bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <script type="text/javascript" src="../../../bootstrap/bootstrap.min.js"></script>
    <link href="../../../styles/estilos.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<title>Reservas</title>
</head>
<body>
	<%
	call menu()
	%>
	<%		
			if (Len(request.Querystring("v"))>0) then
				vehiculo=request.Querystring("v")
				inicio=request.Querystring("f")
				set con = Server.CreateObject("ADODB.Connection")
				con.Open("vehiculos")
				consult="delete from reservas where vehiculo='"&vehiculo&"' and inicio like '"&inicio&"'"
				con.Execute (consult)
				con.close
			end if
		%>
	<div class="container">
	<h1>Reservas</h1>
	
		<div class="row">
		<form action="#" method="POST">
			 <div class="col-lg-6">
			    <div class="input-group">
			      <input type="text" name="busqueda" class="form-control" placeholder="Introduce el cliente, matrícula o fecha de inicio de la reserva...">
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
				'Obtenemos fecha actual para comprobar más adelante cuales reservas pueden ser borradas
				fecha_actual=date()
				
				' Si existe un envío del buscador muestra los datos buscados, sino toda la tabla de reservas
				if (Len(request.form("busqueda"))>0) then
					consult="select r.vehiculo, r.inicio, r.fin, c.nombre, v.modelo, v.marca from reservas r, cliente c, vehiculo v where c.codigo=r.cliente and v.matricula=r.vehiculo and (c.nombre like '%"&request.form("busqueda")&"%' or r.vehiculo like '%"&request.form("busqueda")&"%' or r.inicio like '%"&request.form("busqueda")&"%') ORDER BY r.inicio asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Cliente</td>")
										response.write("<th>Modelo</td>")
										response.write("<th>Marca</td>")
										response.write("<th>Matrícula</td>")
										response.write("<th>Fecha de inicio</td>")
										response.write("<th>Fecha de fin</td>")
										
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("nombre")&"</td>")
										response.write("<td>"&datos("modelo")&"</td>")
										response.write("<td>"&datos("marca")&"</td>")
										response.write("<td>"&datos("vehiculo")&"</td>")
										response.write("<td>"&datos("inicio")&"</td>")
										response.write("<td>"&datos("fin")&"</td>")
										'Convierto fecha de inicio a date
										fecha_inicio=cdate(datos("inicio"))
										if (fecha_actual<fecha_inicio) then
											response.write("<td><a href='reservas.asp?v="&datos("vehiculo")&"&f="&datos("inicio")&"'><span class='glyphicon glyphicon-trash rojo' aria-hidden='true'></span></td>")
										end if
									response.write("</tr>")
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
					else
						response.write("<div class='alert alert-danger'> <strong>No hay coincidencias en la búsqueda</strong></div>")
					end if

				else
					consult="select r.vehiculo, r.inicio, r.fin, c.nombre, v.modelo, v.marca from reservas r, cliente c, vehiculo v where c.codigo=r.cliente and v.matricula=r.vehiculo ORDER BY  r.inicio asc;"
					set datos=con.Execute (consult)
					if (not datos.eof) then
						response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Cliente</td>")
										response.write("<th>Modelo</td>")
										response.write("<th>Marca</td>")
										response.write("<th>Matrícula</td>")
										response.write("<th>Fecha de inicio</td>")
										response.write("<th>Fecha de fin</td>")
										
									
									response.write("</tr>")
							do while not datos.Eof
									response.write("<tr>")
										response.write("<td>"&datos("nombre")&"</td>")
										response.write("<td>"&datos("modelo")&"</td>")
										response.write("<td>"&datos("marca")&"</td>")
										response.write("<td>"&datos("vehiculo")&"</td>")
										response.write("<td>"&datos("inicio")&"</td>")
										response.write("<td>"&datos("fin")&"</td>")
										'Convierto fecha de inicio a date
										fecha_inicio=cdate(datos("inicio"))
										if (fecha_actual<fecha_inicio) then
											response.write("<td><a href='reservas.asp?v="&datos("vehiculo")&"&f="&datos("inicio")&"'><span class='glyphicon glyphicon-trash rojo' aria-hidden='true'></span></td>")
										end if
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