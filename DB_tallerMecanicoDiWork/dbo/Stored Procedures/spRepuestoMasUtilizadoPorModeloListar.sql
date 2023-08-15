-- =============================================
-- Author:		Javier Gialdini
-- Create date: 13/08/2023
-- Description:	Obtiene lista de repuesto mas utilizado por Modelo
-- =============================================
/*
exec spRepuestoMasUtilizadoObtener

*/
CREATE PROCEDURE [dbo].[spRepuestoMasUtilizadoPorModeloListar]
AS
BEGIN
	BEGIN TRY
		SELECT Marca, Modelo, Id, Nombre, cantidad
		FROM (
			SELECT
				max(v.Marca) AS Marca,
				v.Modelo,
				r.Id,
				max(r.Nombre) AS Nombre,
				COUNT(r.Nombre) AS cantidad,
				ROW_NUMBER() OVER (PARTITION BY v.Modelo ORDER BY COUNT(r.Nombre) DESC) AS RowNum
			FROM Repuesto r
			INNER JOIN DesperfectoRepuesto dr ON r.Id = dr.idRepuesto
			INNER JOIN Desperfecto d ON d.Id = dr.idDesperfecto
			INNER JOIN Presupuesto p ON d.idPresupuesto = p.Id
			INNER JOIN Vehiculo v ON p.idVehiculo = v.Id
			GROUP BY v.Modelo, r.Id
		) AS RankedRepuestos
		WHERE RowNum = 1;
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END