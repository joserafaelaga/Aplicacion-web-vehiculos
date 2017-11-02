<%
'Procedimiento comprobar seguridad área administrador
	sub seguridad()
		usuario = session("usuario")
		if (Len(usuario)>0) then
			if (usuario = "admin") then
				response.redirect "../../back/reservas/reservas.asp"
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
		  			response.write("<li><a href='../vehiculos/vehiculos.asp'>Vehículos</a></li>")
			  		response.write("<li><a href='../reservas/reservas.asp'>Mis reservas</a></li>")
			  		response.write("<li><a href='../facturas/factura.asp'>Factura</a></li>")
			  		response.write("</ul>")
			  		response.write("<ul class='nav navbar-nav navbar-right'>")
			  		response.write("<li><a href='?c=true'>Cerrar sesión '"&session("nombre")&"'</a></li>")
				response.write("</ul>")
			  response.write("</div>")
			response.write("</nav>")
		
	end sub
%>