-- =============================================
-- Author:		Javier Gialdini
-- Create date: 14/08/2023
-- Description:	Lista los presupuesto por Marca/Modelo
-- =============================================
/*

exec spPresupuestoListarPorMarcaModelo 'Suzuki', null

exec spPresupuestoListarPorMarcaModelo null, 'Vitara'
*/
CREATE PROCEDURE [dbo].[spPresupuestoListarPorMarcaModelo]
	@Marca varchar(50) = NULL,
	@Modelo varchar(50) = NULL
AS
BEGIN
	BEGIN TRY
		SELECT 
			v.Marca,
			v.Modelo,
			p.Total
		FROM
			Presupuesto p
			inner join Vehiculo v on p.idVehiculo = v.Id
		WHERE
			(@Marca is null or @Marca = v.Marca)
			and
			(@Modelo is null or @Modelo = v.Modelo)
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END