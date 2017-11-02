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
	<title>Factura</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<%
		id=session("usuario")
		set con = Server.CreateObject("ADODB.Connection")
		con.Open("vehiculos")	
		response.write ("<h1>Factura</h1>")
		fecha_actual=date()
		consult="select c.nombre, c.telefono, v.modelo, v.marca, v.precio, r.inicio, r.fin from cliente c, reservas r, vehiculo v where r.cliente="&id&" and r.cliente=c.codigo and r.vehiculo=v.matricula order by r.inicio asc;"
		set datos=con.Execute (consult)	
		if (not datos.eof) then
			fecha_inicio=cdate(datos("inicio"))
				if (fecha_inicio<fecha_actual) then
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
			do while not datos.Eof
				'Convierto cadena fecha a formato fecha
				fecha_inicio=cdate(datos("inicio"))
				if (fecha_inicio<fecha_actual) then
					'Calculo de días
					dias=datediff("d",datos("inicio"),datos("fin"))
					'Calculo de coste de cada reserva
					total_r=dias*datos("precio")
					'Calculo del total de las reservas
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
			else
				response.write("<div class='alert alert-danger'>")
				  response.write("<strong>No tiene reservas a facturar</strong>")
				response.write("</div>")
			end if
					response.write("</div>")
		else
			response.write("<div class='alert alert-danger'>")
				  response.write("<strong>No tiene reservas a facturar</strong>")
			response.write("</div>")
		end if

		con.close	
	%>
	</div>
</body>
</html>