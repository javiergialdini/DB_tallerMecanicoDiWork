-- =============================================
-- Author:		Javier Gialdini
-- Create date: 26/08/2023
-- Description:	Guardar historial refresh token
-- =============================================
CREATE PROCEDURE [dbo].[spGuardarHistorialRefreshToken] 
	@IdUsuario int,
	@Token varchar(500),
	@RefreshToken varchar(200),
	@FechaCreacion DateTime,
	@FechaExpiracion DateTime
AS
BEGIN
	INSERT INTO HistorialRefreshToken (IdUsuario, Token, RefreshToken, FechaCreacion, FechaExpiracion)
	VALUES (@IdUsuario, @Token, @RefreshToken, @FechaCreacion, @FechaExpiracion)
END