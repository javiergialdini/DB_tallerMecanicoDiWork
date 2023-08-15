-- =============================================
-- Author:		Javier Gialdini
-- Create date: 13/08/2023
-- Description:	Obtiene detalle presupuesto
-- =============================================
/*
exec spPresupuestoDetalleObtener 1, 1

*/
CREATE PROCEDURE [dbo].[spPresupuestoDetalleObtener]
	@presupuestoId bigint = null,
	@idVehiculo bigint = null
AS
BEGIN
	BEGIN TRY
		SELECT 
			p.Id presupuestoId, 
			p.Nombre, 
			p.Apellido, 
			p.EMail, 
			p.Total, 
			p.idVehiculo,
			(select 			
				d.Id, 
				d.Descripcion, 
				d.ManoDeObra,
				d.Tiempo,
				(select r.Nombre,
						r.Id,
						r.Precio
					from Repuesto r
					inner join DesperfectoRepuesto dr on r.Id = dr.idRepuesto
					where
					dr.idDesperfecto = d.Id for json path) repuestos
			from Desperfecto d 
			where d.idPresupuesto = p.Id 
			for json path) desperfectos,
			v.Marca,
			v.Modelo,
			v.Patente
		FROM 
			Presupuesto p
			inner join Vehiculo v on v.Id = p.idVehiculo
		where
			(@presupuestoId is null or p.Id = @presupuestoId)
			and
			(@idVehiculo is null or p.Id = @idVehiculo)
			and
			(@presupuestoId is not null or @idVehiculo is not null)
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END