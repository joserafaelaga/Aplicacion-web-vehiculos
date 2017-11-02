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
	<title>Nueva reserva</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<h1>Nueva reserva</h1>
		<form action="#" method="POST" class="col-md-4">
		<div class="form-group">
	    <label for="exampleInputCliente">Cliente</label>
	    <select name=cliente>
	    	<option selected value='0'>Selecciona un cliente</option>
		  <%
			set con = Server.CreateObject("ADODB.Connection")
			con.Open("vehiculos")
			consult="select codigo, nombre from cliente"
			set datos=con.Execute (consult)
			do while not datos.Eof
				response.write("<option value='"&datos("codigo")&"'>"&datos("nombre")&"</option>")
			datos.movenext
			loop
		  %>
		</select>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputVehiculo">Vehículo</label>
	    <select name=vehiculo>
	    	<option selected value='0'>Selecciona un vehículo</option>
		  <%
			consult="select matricula, modelo, marca from vehiculo;"
			set datos=con.Execute (consult)
			do while not datos.Eof
				response.write("<option value='"&datos("matricula")&"'>"&datos("modelo")&" - "&datos("marca")&"</option>")
			datos.movenext
			loop
			con.close
		  %>
		</select>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputInicio">Fecha de inicio</label>
	    <input type="date" name="inicio" class="form-control" id="exampleInputInicio" placeholder="Fecha de inicio"required>
	  </div>
	   <div class="form-group">
	    <label for="exampleInputFin">Fecha de fin</label>
	    <input type="date" name="fin" class="form-control" id="exampleInputFin" placeholder="Fecha de fin"required>
	  </div>
		
	  <input type="submit" name='enviar' value="Crear reserva">
	</form>
	</div>
	<div class="container margin_sup">
	<%
		if (Len(Request.Form("enviar"))>0) then
			cliente=Request.Form("cliente")
			vehiculo=Request.Form("vehiculo")
			inicio=Request.Form("inicio")
			fin=Request.Form("fin")
			'Comprobar si alguno de los datos está en blanco
			if (Len(cliente)>0 and Len(vehiculo)>0 and Len(inicio)>0 and Len(fin)>0) then
				'Obtener fecha acutal y convertir a tipo date
				fecha_actual=date()
				inicio=cdate(inicio)
				fin=cdate(fin)
				'Comprueba si las fechas introducidas son válidas
				if (inicio >= fecha_actual and fin>= fecha_actual) then
					'Comprueba que la fecha de unicio sea menor que la de fin
					if (inicio<fin) then 
						set con = Server.CreateObject("ADODB.Connection")
						con.Open("vehiculos")
						consult_e="select inicio from reservas where cliente="&cliente&" and vehiculo='"&vehiculo&"' and  inicio like '%"&inicio&"%';"
						set datos=con.Execute (consult_e)
						if (not datos.eof) then
							response.write("<div class='alert alert-success'> <strong>Ya existe una reserva con los datos indicados</strong></div>")
							con.close
						else
						
							consult="insert into reservas values ("&cliente&",'"&vehiculo&"','"&inicio&"','"&fin&"');"
							con.Execute consult,filas
							con.close
							if (filas = 1) then
								response.write("<div class='alert alert-success'> <strong>¡Reserva creada correctamente!</strong></div>")
							else
								response.write("<div class='alert alert-danger'> <strong>Error creando reserva</strong></div>")
							end if
							
						end if
					else
						response.write("<div class='alert alert-warning'> <strong>La fecha de fin no puede ser inferior a la de inicio</strong></div>")
					end if
				else
					response.write("<div class='alert alert-warning'> <strong>No se puede crear una reserva con fecha de inicio o fin pasada</strong></div>")
				end if
			else
				response.write("<div class='alert alert-warning'> <strong>Datos introducidos incorrectos</strong></div>")
			end if

		end if
	%>
	</div>
</body>
</html>