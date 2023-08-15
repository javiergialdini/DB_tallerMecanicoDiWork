CREATE TABLE [dbo].[Automovil] (
    [Id]              BIGINT   IDENTITY (1, 1) NOT NULL,
    [idVehiculo]      BIGINT   NULL,
    [Tipo]            SMALLINT NULL,
    [CantidadPuertas] SMALLINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Automovil_idVehiculo] FOREIGN KEY ([idVehiculo]) REFERENCES [dbo].[Vehiculo] ([Id])
);

