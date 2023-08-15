-- =============================================
-- Author:		Javier Gialdini
-- Create date: 14/08/2023
-- Description:	Lista de repuestos
-- =============================================
CREATE PROCEDURE [dbo].[spRepuestosListar] 
AS
BEGIN
	SELECT Id, Nombre, Precio FROM Repuesto
END