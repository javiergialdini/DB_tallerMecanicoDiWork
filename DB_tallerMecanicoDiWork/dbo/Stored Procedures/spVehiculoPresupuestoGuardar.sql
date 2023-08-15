-- =============================================
-- Author:		Javier Gialdini
-- Create date: 13/08/2023
-- Description:	Crea y actualiza un automovil y su presupuesto
-- =============================================
/*

exec spVehiculoPresupuestoGuardar 'Suzuki', 'Vitara', 'ABC 123', null, 3, 5, 'Javier', 'Gialdini', 'jngialdini19@gmail.com'

select * from Automovil
select * from Vehiculo
select * from Presupuesto


*/
CREATE PROCEDURE [dbo].[spVehiculoPresupuestoGuardar]
	@Marca varchar(50),
	@Modelo varchar(50),
	@Patente varchar(50),
	@Cilindrada varchar(50) = null,
	@TipoAutomovil smallint = null,
	@CantidadPuertasAuto smallint = null,
	@Nombre varchar(50),
	@Apellido varchar(50),
	@Email varchar (50)
AS
BEGIN
	BEGIN TRY
		declare @idVehiculo bigint;
		
		declare @idPresupuesto bigint;
		
		INSERT INTO Vehiculo (Marca, Modelo, Patente)
		VALUES (@Marca, @Modelo, @Patente)
		SET @idVehiculo = SCOPE_IDENTITY()

		IF(@Cilindrada is not null)
		BEGIN
			INSERT INTO Moto (idVehiculo, Cilindrada)
			VALUES (@idVehiculo, @Cilindrada)
		END

		IF(@TipoAutomovil is not null or @CantidadPuertasAuto is not null)
		BEGIN
			INSERT INTO Automovil (idVehiculo, Tipo, CantidadPuertas)
			VALUES (@idVehiculo, @TipoAutomovil, @CantidadPuertasAuto)
		END

		BEGIN
			INSERT INTO Presupuesto (Nombre, Apellido, EMail, Total, idVehiculo)
			VALUES (@Nombre, @Apellido, @Email, 0, @idVehiculo)
			SET @idPresupuesto = SCOPE_IDENTITY()

			return @idPresupuesto
		END

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END