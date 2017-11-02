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
	<title>Nuevo vehículo</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<h1>Nuevo vehículo</h1>
		<form action="#" method="POST" class="col-md-4">
	  <div class="form-group">
	    <label for="exampleInputMatriucla">Matrícula</label>
	    <input type="text" name="matricula" class="form-control" id="exampleInputMatricula" placeholder="Matrícula" size='15' maxlength='15' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputModelo">Modelo</label>
	    <input type="text" name="modelo" class="form-control" id="exampleInputModelo" placeholder="Modelo" size='20' maxlength='20' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputMarca">Marca</label>
	    <input type="text" name="marca" class="form-control" id="exampleInputMarca" placeholder="Marca" size='15' maxlength='30' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputPuertas">Número de puertas</label>
	    <input type="number" name="puertas" class="form-control" id="exampleInputPuertas" placeholder="Nº de puertas" size='15' maxlength='30' required>
	  </div>
	   <div class="form-group">
	    <label for="exampleInputCategoria">Categoría</label>
	    <input type="number" name="categoria" class="form-control" id="exampleInputCategoria" placeholder="Categoría" size='15' maxlength='30' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputPrecio">Precio por día</label>
	    <input type="number" name="precio" class="form-control" id="exampleInputPrecio" placeholder="Precio por día" size='15' maxlength='30' required>
	  </div>
	 <input type="submit" name='enviar' value='Crear vehículo'>
	</form>
	</div>
	<div class="container margin_sup">
	<%
		'Comprueba que se ha enviado el formulario y recoge los datos
		if (Len(Request.Form("enviar"))>0) then
			matricula=Request.Form("matricula")
			modelo=Request.Form("modelo")
			marca=Request.Form("marca")
			puertas=Request.Form("puertas")
			categoria=Request.Form("categoria")
			precio=Request.Form("precio")
			'Comprueba si los datos están vacíos
			if (Len(matricula)>0 and Len(modelo)>0 and Len(marca)>0 and Len(puertas)>0 and Len(categoria)>0) and Len(precio)>0 then
				'Inserto el vehículo en la BD
				set con = Server.CreateObject("ADODB.Connection")
				con.Open("vehiculos")
				consult="select matricula from vehiculo where matricula='"&matricula&"'"
				set datos=con.Execute (consult)
				if (not datos.eof) then
					response.write("<div class='alert alert-danger'> <strong>Ya existe un vehículo con esa matrícula</strong></div>")
				else
					consult="insert into vehiculo values ('"&matricula&"','"&modelo&"','"&marca&"','"&puertas&"','"&categoria&"','"&precio&"');"
					con.Execute consult,filas
					con.close
					if (filas = 1) then
						response.write("<div class='alert alert-success'> <strong>¡Vehículo creado correctamente!</strong></div>")
					else
						response.write("<div class='alert alert-danger'> <strong>Error creando vehículo</strong></div>")
					end if
				end if

			end if

		end if
	%>
	</div>
</body>
</html>