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
	<title>Vehículos</title>
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
					'Consulta los vehículos y los muestra en formato tabla
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

										response.write("<td><a href='#'><span class='glyphicon glyphicon-pencil' aria-hidden='true' data-toggle='modal' data-target='#editar"&datos("matricula")&"'></span></td>")
									response.write("</tr>")

									'Creo modal para edición del vehículo
									response.write("<div class='modal fade' tabindex='-1' role='dialog' aria-labelledby='gridSystemModalLabel' id='editar"&datos("matricula")&"'>") %>
										  <div class="modal-dialog" role="document">
										    <div class="modal-content">
										      <div class="modal-header">
										        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										        <h4 class="modal-title" id="gridSystemModalLabel">Modificar vehículo</h4>
										      </div>
										      <div class="modal-body">
												<form action="#" method="POST" class="col-md-11">
											  <div class="form-group">
											    <label for="exampleInputMatricula">Matrícula</label>
											    <input type="text" name="matricula" class="form-control" value='<% response.write(datos("matricula")) %>' id="exampleInputMatricula" size='15' maxlength='15' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputModelo">Modelo</label>
											    <input type="text" name="modelo" class="form-control" id="exampleInputModelo" value='<% response.write(datos("modelo")) %>' size='20' maxlength='20' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputMarca">Marca</label>
											    <input type="text" name="marca" class="form-control" id="exampleInputMarca" value='<% response.write(datos("marca")) %>' size='15' maxlength='30' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputPuertas">Número de puertas</label>
											    <input type="number" name="puertas" class="form-control" id="exampleInputPuertas" value='<% response.write(datos("n_puertas")) %>' size='15' maxlength='30' required>
											  </div>
											   <div class="form-group">
											    <label for="exampleInputCategoria">Categoría</label>
											    <input type="number" name="categoria" class="form-control" id="exampleInputCategoria" value='<% response.write(datos("categoria")) %>' size='15' maxlength='30' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputPrecio">Precio por día</label>
											    <input type="number" name="precio" class="form-control" id="exampleInputPrecio" value='<% response.write(datos("precio")) %>' size='15' maxlength='30' required>
											  </div>
												
										      </div>
										      <div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
										        <button type="submit" name="actualizar" class="btn btn-primary">Guardar cambios</button>
											</form>
										      </div>

										    </div><!-- /.modal-content -->
										  </div><!-- /.modal-dialog -->
										</div><!-- /.modal -->	
									<%

									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
					else
						response.write("<div class='alert alert-danger'> <strong>No hay coincidencias en la búsqueda</strong></div>")
					end if

				else
					'Consulta los vehículos sin haber búsqueda y los muestra
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
										response.write("<td><a href='#'><span class='glyphicon glyphicon-pencil' aria-hidden='true' data-toggle='modal' data-target='#editar"&datos("matricula")&"'></span></td>")
									response.write("</tr>")


									response.write("<div class='modal fade' tabindex='-1' role='dialog' aria-labelledby='gridSystemModalLabel' id='editar"&datos("matricula")&"'>") %>
										  <div class="modal-dialog" role="document">
										    <div class="modal-content">
										      <div class="modal-header">
										        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
										        <h4 class="modal-title" id="gridSystemModalLabel">Modificar vehículo</h4>
										      </div>
										      <div class="modal-body">
												<form action="#" method="POST" class="col-md-11">
											  <div class="form-group">
											    <label for="exampleInputMatricula">Matrícula</label>
											    <input type="text" name="matricula" class="form-control" id='disabledInput' value='<% response.write(datos("matricula")) %>' id="exampleInputMatricula" size='15' maxlength='15' readonly>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputModelo">Modelo</label>
											    <input type="text" name="modelo" class="form-control" id="exampleInputModelo" value='<% response.write(datos("modelo")) %>' size='20' maxlength='20' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputMarca">Marca</label>
											    <input type="text" name="marca" class="form-control" id="exampleInputMarca" value='<% response.write(datos("marca")) %>' size='15' maxlength='30' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputPuertas">Número de puertas</label>
											    <input type="number" name="puertas" class="form-control" id="exampleInputPuertas" value='<% response.write(datos("n_puertas")) %>' size='15' maxlength='30' required>
											  </div>
											   <div class="form-group">
											    <label for="exampleInputCategoria">Categoría</label>
											    <input type="number" name="categoria" class="form-control" id="exampleInputCategoria" value='<% response.write(datos("categoria")) %>' size='15' maxlength='30' required>
											  </div>
											  <div class="form-group">
											    <label for="exampleInputPrecio">Precio por día</label>
											    <input type="number" name="precio" class="form-control" id="exampleInputPrecio" value='<% response.write(datos("precio")) %>' size='15' maxlength='30' required>
											  </div>
												
										      </div>
										      <div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
										        <button type="submit" name="actualizar" class="btn btn-primary">Guardar cambios</button>
											</form>
										      </div>

										    </div><!-- /.modal-content -->
										  </div><!-- /.modal-dialog -->
										</div><!-- /.modal -->	
									<%
									
									datos.movenext
							loop

							response.write("</table>")
						response.write("</div>")
						
					else
						response.write("<div class='alert alert-danger'> <strong>No hay vehículos actualmente</strong></div>")
					end if
				
				end if 'Cierre if busqueda o listado completo
				con.close
				if (Len(Request.Form("matricula"))>0) then
					matricula=Request.Form("matricula")
					modelo=Request.Form("modelo")
					marca=Request.Form("marca")
					puertas=Request.Form("puertas")
					categoria=Request.Form("categoria")
					precio=Request.Form("precio")
					if (Len(matricula)>0 and Len(modelo)>0 and Len(marca)>0 and Len(puertas)>0 and Len(categoria)>0) and Len(precio)>0 then
						set con = Server.CreateObject("ADODB.Connection")
						con.Open("vehiculos")
						consult="update vehiculo set matricula='"&matricula&"', modelo='"&modelo&"', marca='"&marca&"', n_puertas='"&puertas&"', categoria='"&categoria&"', precio='"&precio&"' where matricula='"&matricula&"';"
						con.Execute consult, filas
						con.close
						response.AddHeader "REFRESH","0;URL='#'"
					end if
				end if
		%>
		</div>
	</div>
	


</body>
</html>