-- =============================================
-- Author:		Javier Gialdini
-- Create date: 14/08/2023
-- Description:	Totales para Autos y para Motos
-- =============================================
/*

exec spPresupuestoTotalesAutosMotos
*/
CREATE PROCEDURE [dbo].[spPresupuestoTotalesAutosMotos]

AS
BEGIN
	BEGIN TRY
		SELECT 
			'moto' vehiculo,
			sum(p.Total*1.10) total
		FROM
			Presupuesto p
			inner join Vehiculo v on p.idVehiculo = v.Id
			inner join Moto m on v.Id = m.idVehiculo
		UNION SELECT 
				'auto' vehiculo,
				sum(p.Total*1.10) total
			FROM
				Presupuesto p
				inner join Vehiculo v on p.idVehiculo = v.Id
				inner join Automovil a on v.Id = a.idVehiculo

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END