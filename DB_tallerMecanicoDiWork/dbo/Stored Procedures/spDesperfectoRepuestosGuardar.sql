-- =============================================
-- Author:		Javier Gialdini
-- Create date: 13/08/2023
-- Description:	Guarda Desperfecto y Repuestos para el desperfecto. Permite cargar Repuestos nuevos si vienen con id 0
-- =============================================

/*
	declare @repuestos Repuestos; insert into @repuestos (Id, Nombre, Precio) values (0, 'J123456789', 19.19 ), (43, 'B252543362', 16.98)

	exec spDesperfectoRepuestosGuardar 1, 'Nuevo desperfecto', 32.50, 2, @repuestos

	select * from Repuesto
	select * from Desperfecto
	select * from DesperfectoRepuesto

*/
CREATE PROCEDURE [dbo].[spDesperfectoRepuestosGuardar] 
	@idPresupuesto bigint,
	@Descripcion varchar(100),
    @ManoDeObra decimal(10,2),
    @Tiempo int,
	@Repuestos Repuestos readonly
AS
BEGIN
	BEGIN TRY
		declare @idDesperfecto bigint
		
		INSERT INTO Desperfecto (idPresupuesto, Descripcion, ManodeObra, Tiempo)
		VALUES (@idPresupuesto, @Descripcion, @ManoDeObra, @Tiempo)
		SET @idDesperfecto = SCOPE_IDENTITY()

		IF EXISTS (SELECT TOP 1 1 FROM @Repuestos)
		BEGIN
			-- Guardo relación DespefectoRepuesto
			INSERT INTO DesperfectoRepuesto (IdDesperfecto, IdRepuesto)
			SELECT @idDesperfecto, Id
			FROM @Repuestos
			WHERE Id > 0

			-- Si vienen registros de Repuestos nuevos (Id = 0). Los guardo en la tabla Repuesto y genero la relación DesperfectoRepuesto
			DECLARE @TempRepuestos TABLE (
				Id bigint,
				Nombre varchar(100),
				Precio decimal(10, 2)
			);

			INSERT INTO Repuesto (Nombre, Precio)
			OUTPUT INSERTED.Id, INSERTED.Nombre, INSERTED.Precio INTO @TempRepuestos
			SELECT Nombre, Precio
			FROM @Repuestos
			WHERE Id = 0;

			-- Insertar relaciones Desperfecto-Repuesto
			INSERT INTO DesperfectoRepuesto (IdDesperfecto, IdRepuesto)
			SELECT @idDesperfecto, Id
			FROM @TempRepuestos;

			--
			UPDATE Presupuesto
			SET Total = Total +
							(select
							d.ManoDeObra + 
							(d.Tiempo*130) + 
							(select SUM(r.Precio)
								from Repuesto r 
								inner join DesperfectoRepuesto dr on r.Id = dr.idRepuesto
								where dr.idDesperfecto = d.Id) Total
							from
							Desperfecto d
							where
							d.Id = @idDesperfecto)
			where
				Id = @idPresupuesto

		END

	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ErrorMessage
	END CATCH
END