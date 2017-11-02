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
	<title>Factura</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<%
		'Recojo el ID del usuario
		id=Request.QueryString("cli") 
		'Conecto con la base de datos
		set con = Server.CreateObject("ADODB.Connection")
		con.Open("vehiculos")	
		'Consulto si el usuario existe
		consult="select nombre from cliente where codigo="&id&";"
		set datos=con.Execute (consult)
		if (not datos.eof) then
			response.write ("<h1>Factura de "&datos("nombre")&"</h1>")
			fecha_actual=date()
			'Consulto las reservas del cliente
			consult="select c.nombre, c.telefono, v.modelo, v.marca, v.precio, r.inicio, r.fin from cliente c, reservas r, vehiculo v where r.cliente="&id&" and r.cliente=c.codigo and r.vehiculo=v.matricula order by r.inicio asc;"
			set datos=con.Execute (consult)	
			if (not datos.eof) then
				response.write ("<p><strong>Nombre:</strong> "&datos("nombre")&"</p>")
				response.write ("<p><strong>Teléfono:</strong> "&datos("telefono")&"</p>")
				response.write("<div class='table-responsive'>")
							response.write("<table class='table table-hover table-striped'>")
								response.write("<tr>")
										response.write("<th>Inicio reserva</td>")
										response.write("<th>Fin reserva</td>")
										response.write("<th>Modelo</td>")
										response.write("<th>Marca</td>")
										response.write("<th>Precio/día</td>")
										response.write("<th>Días</td>")
										response.write("<th>Total</td>")
									response.write("</tr>")
				total=0
				do while not datos.Eof
					'Convierto cadena fecha a formato fecha
					fecha_inicio=cdate(datos("inicio"))
					if (fecha_inicio<fecha_actual) then
						'Calculo de días
						fecha_fin=datos("fin")
						dias=datediff("d",fecha_inicio,fecha_fin)
						'Calculo de precio por reserva
						total_r=dias*datos("precio")
						'Calculo del precio total
						total=total+total_r
						response.write("<tr>")
							response.write("<td>"&datos("inicio")&"</td>")
							response.write("<td>"&datos("fin")&"</td>")
							response.write("<td>"&datos("modelo")&"</td>")
							response.write("<td>"&datos("marca")&"</td>")
							response.write("<td>"&datos("precio")&"€</td>")
							response.write("<td>"&dias&"</td>")
							response.write("<td>"&total_r&"€</td>")
						response.write("</tr>")
					end if
					datos.movenext
				loop
				response.write("<tr>")
						response.write("<td></td>")
						response.write("<td></td>")
						response.write("<td></td>")
						response.write("<td></td>")
						response.write("<td></td>")
						response.write("<td><strong>Total a pagar:</strong></td>")
						response.write("<td><strong>"&total&"€</strong></td>")
					response.write("</tr>")
				response.write("</table>")
				response.write("</div>")

			else
				response.write("<div class='alert alert-danger'>")
				  response.write("<strong>Este cliente no tiene reservas a facturar</strong>")
				response.write("</div>")
			end if
		else
			response.write("<div class='alert alert-danger'>")
				  response.write("<strong>No se puede generar la factura de un cliente inexistente</strong>")
				response.write("</div>")
		end if		

		con.close	
	%>
	</div>
</body>
</html>