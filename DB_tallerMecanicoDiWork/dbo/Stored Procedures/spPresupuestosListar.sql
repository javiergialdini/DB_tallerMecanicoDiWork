-- =============================================
-- Author:		Javier Gialdini
-- Create date: 13/08/2023
-- Description:	Obtiene lista de presupuestos
-- =============================================
/*
exec spPresupuestosListar 1,null

*/
CREATE PROCEDURE [dbo].[spPresupuestosListar]
	@vehiculosIds listaIds readonly
AS
BEGIN
	BEGIN TRY
		SELECT 
			p.Id AS presupuestoId, 
			p.Nombre, 
			p.Apellido, 
			p.EMail, 
			p.Total, 
			p.idVehiculo,
			JSON_QUERY((
				SELECT 
					d.Id, 
					d.Descripcion, 
					d.ManoDeObra,
					d.Tiempo,
					(
						SELECT 
							r.Nombre,
							r.Id AS repuestoId,
							r.Precio
						FROM Repuesto r
						INNER JOIN DesperfectoRepuesto dr ON r.Id = dr.idRepuesto
						WHERE dr.idDesperfecto = d.Id
						FOR JSON PATH
					) AS repuestos
				FROM Desperfecto d 
				WHERE d.idPresupuesto = p.Id
				FOR JSON PATH
			)) AS desperfectos
		FROM Presupuesto p
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM @vehiculosIds)
			OR p.idVehiculo IN (SELECT id FROM @vehiculosIds)
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END