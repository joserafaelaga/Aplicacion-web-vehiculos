<% @ CODEPAGE = 65001 %>
<!-- #include file="asp/func_gene.asp" -->
<!DOCTYPE html>
<%
	sesion_abierta()
	seguridad_index()
%>
<html lang="en">
<head>
	<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <script type="text/javascript" src="bootstrap/jquery-3.1.1.min.js"></script>
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <script type="text/javascript" src="bootstrap/bootstrap.min.js"></script>
    <link href="styles/estilos.css" rel="stylesheet" type="text/css">
	<meta charset="UTF-8">
	<title>Iniciar sesión</title>
</head>
<body>
	<div class="container col-md-offset-4">
	<h1>Inicio de sesión</h1>
		<form class="col-md-4" action="#" method="POST">
		  <div class="form-group">
		    <label for="exampleInputNick1">Usuario</label>
		    <input type="text" name="nick" class="form-control" id="exampleInputEmail1" placeholder="Usuario">
		  </div>
		  <div class="form-group">
		    <label for="exampleInputPassword1">Contraseña</label>
		    <input type="password" name="contrasena" class="form-control" id="exampleInputPassword1" placeholder="Contraseña">
		  </div>
		  <div class="checkbox">
		    <label>
		      <input name='check' type="checkbox"> Mantener la sesión abierta
		    </label>
	  	  </div>
		   <input type="submit" name='enviar' value='Iniciar sesión'>
	  </form>
	</div>

	<%
		if (Len(Request.Form("enviar"))>0) then
			nick=Request.Form("nick")
			contrasena=Request.Form("contrasena")
			abierta=Request.Form("check")
			if (nick="admin") then
				if (contrasena="admin") then
					if (abierta = "on") then	
						call iniciar_sesion ("admin","Administrador", true)
					else
						call iniciar_sesion ("admin","Administrador", false)
					end if
				else
					response.write("<div class='alert alert-danger col-md-4 col-md-offset-4 margin_sup'> <strong>Error en el usuario o la contraseña</strong></div>")
				end if
			else
				set con = Server.CreateObject("ADODB.Connection")
				con.Open("vehiculos")
				consult="select codigo, pass, nombre from cliente where nick='"&nick&"'"
				set datos=con.Execute (consult)
				if (not datos.eof) then
					if (datos("pass") = contrasena) then
						if (abierta = "on") then
							call iniciar_sesion (datos("codigo"), datos("nombre"),true)
						else
							call iniciar_sesion (datos("codigo"), datos("nombre"),false)
						end if
					else
						response.write("<div class='alert alert-danger col-md-4 col-md-offset-4 margin_sup'> <strong>Error en el usuario o la contraseña</strong></div>")
					end if 

				end if
				con.close
			end if
		end if
	%>
</body>
</html>