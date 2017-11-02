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
	<title>Nuevo clientes</title>
</head>
<body>
	<%
	call menu()
	%>
	<div class="container">
	<h1>Nuevo cliente</h1>
		<form action="#" method="POST" class="col-md-4">
	  <div class="form-group">
	    <label for="exampleInputNick">Nick</label>
	    <input type="text" name="nick" class="form-control" id="exampleInputNick" placeholder="Nick" size='15' maxlength='15' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputContrasena">Contraseña</label>
	    <input type="text" name="contrasena" class="form-control" id="exampleInputContrasena" placeholder="Contraseña" size='20' maxlength='20' required>
	  </div>
	  <div class="form-group">
	    <label for="exampleInputNombre">Nombre</label>
	    <input type="text" name="nombre" class="form-control" id="exampleInputNombre" placeholder="Nombre" size='15' maxlength='30' required>
	  </div>
	   <div class="form-group">
	    <label for="exampleInputTelefono">Teléfono</label>
	    <input type="text" name="tel" class="form-control" id="exampleInputTelefono" placeholder="Contraseña" size='9' maxlength='9' pattern="[0-9]{9}" required>
	  </div>
	 <input type="submit" name='enviar' value='Crear cliente'>
	</form>
	</div>
	<div class="container margin_sup">
	<%
		'Compruebo si se ha enviado el formulario y recojo los datos
		if (Len(Request.Form("enviar"))>0) then
			nombre=Request.Form("nombre")
			nick=Request.Form("nick")
			contrasena=Request.Form("contrasena")
			tel=Request.Form("tel")
			if (Len(nombre)>0 and Len(nick)>0 and Len(contrasena)>0 and Len(tel)>0) then
				set con = Server.CreateObject("ADODB.Connection")
					con.Open("vehiculos")
				consult_e="select nombre from cliente where nick='"&nick&"'"
				set datos=con.Execute (consult_e)
				'Compruebo si el nick está en uso
				if (not datos.eof) then
					response.write("<div class='alert alert-danger'> <strong>El nick está ocupado</strong></div>")
					con.close
				else
					'Inserto los datos si está todo correcto
					consult="insert into cliente (nombre, telefono, nick, pass) values ('"&nombre&"','"&tel&"','"&nick&"','"&contrasena&"');"
					con.Execute consult,filas
					con.close
					if (filas = 1) then
						response.write("<div class='alert alert-success'> <strong>¡Cliente creado correctamente!</strong></div>")
					else
						response.write("<div class='alert alert-danger'> <strong>Error creando cliente</strong></div>")
					end if
				end if

			end if

		end if
	%>
	</div>
</body>
</html>