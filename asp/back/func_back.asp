<%
'Procedimiento comprobar seguridad área administrador
	sub seguridad()
		usuario = session("usuario")
		if (Len(usuario)>0) then
			if (usuario <> "admin") then
				response.redirect "../../front/reservas/reservas.asp"
			end if
		else
				response.redirect "../../../index.asp"
		end if
	end sub

'Menú backend
	sub menu()
			response.write("<nav class='navbar navbar-default color'>")
			  response.write("<div class='container-fluid'>")
			    response.write("<div class='navbar-header'>")
			    response.write("<button type='button' class='navbar-toggle collapsed' data-toggle='collapse' data-target='#bs-example-navbar-collapse-1' aria-expanded='false'>")
			          response.write("<span class='sr-only'>Toggle navigation</span>")
			          response.write("<span class='icon-bar'></span>")
			          response.write("<span class='icon-bar'></span>")
			          response.write("<span class='icon-bar'></span>")
			        response.write("</button>")
			 
						response.write("<a class='navbar-brand' href='../reservas/reservas.asp'><img id='logo' src='../../../img/logo.png'></a>")
			 	response.write("</div>")
			 	response.write("<div class='collapse navbar-collapse' id='bs-example-navbar-collapse-1'>")
				  response.write("<ul class='nav navbar-nav'>")
					  		response.write("<li role='presentation' class='dropdown'>")
							    response.write("<a class='dropdown-toggle' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'>Clientes<span class='caret'></span></a>")
							    response.write("<ul class='dropdown-menu'>")
							      response.write("<li><a href='../clientes/ncliente.asp'>Nuevo</a></li>")
							      response.write("<li><a href='../clientes/clientes.asp'>Listado</a></li>")
							    response.write("</ul>")
							  response.write("</li>")

							  response.write("<li role='presentation' class='dropdown'>")
							    response.write("<a class='dropdown-toggle' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'>Vehículos<span class='caret'></span></a>")
							    response.write("<ul class='dropdown-menu'>")
							      response.write("<li><a href='../vehiculos/nvehiculo.asp'>Nuevo</a></li>")
							      response.write("<li><a href='../vehiculos/vehiculos.asp'>Listado</a></li>")
							    response.write("</ul>")
							  response.write("</li>")

							  response.write("<li role='presentation' class='dropdown'>")
							    response.write("<a class='dropdown-toggle' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'>Reservas<span class='caret'></span></a>")
							    response.write("<ul class='dropdown-menu'>")
							      response.write("<li><a href='../reservas/nreserva.asp'>Nueva</a></li>")
							      response.write("<li><a href='../reservas/reservas.asp'>Listado</a></li>")
							    response.write("</ul>")
							response.write("</ul>")
							    response.write("<ul class='nav navbar-nav navbar-right'>")
			  						response.write("<li><a href='?c=true'>Cerrar sesión '"&session("nombre")&"'</a></li>")
								response.write("</ul>")
			  response.write("</div>")
			response.write("</nav>")
		
	end sub
%>