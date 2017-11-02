<%
'Procedimiento cerrar sesión
	sub cerrar_sesion()
		Session.Abandon
		response.cookies("transport_user").expires=date()-1
		response.cookies("transport_name").expires=date()-1
		response.redirect "../../../index.asp"
	end sub

'Procedimiento iniciar sesión
	sub iniciar_sesion(usuario, nombre, abierta)
		session("usuario")=usuario
		session("nombre")=nombre
		if (abierta= true) then
			response.cookies("transport_user")=usuario
			response.cookies("transport_user").expires = date()+3
			response.cookies("transport_name")=nombre
			response.cookies("transport_name").expires = date()+3
		end if
		
		if (usuario="admin") then
			response.redirect "asp/back/reservas/reservas.asp"
		else
			response.redirect "asp/front/reservas/reservas.asp"
		end if
	end sub

'Procedimiento comprobar si el usuario ha deseado mantener la sesión abierta
	sub sesion_abierta()
		sesion=session("usuario")
			if (Len(sesion) = 0 ) then
				user = request.cookies("transport_user")
				name = request.cookies("transport_name")
				if (Len(user)>0 and Len(name)>0) then
					session("usuario")=user
					session("nombre")=name
				end if
		end if
	end sub

'Procedimiento comprobar seguridad área administrador
sub seguridad_index()
	usuario = session("usuario")
	if (Len(usuario)>0) then
		if (usuario = "admin") then
			response.redirect "asp/back/reservas/reservas.asp"
		else
			response.redirect "asp/front/reservas/reservas.asp"
		end if
	end if
end sub
	
%>

