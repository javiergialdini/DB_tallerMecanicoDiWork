CREATE TABLE [dbo].[Presupuesto] (
    [Id]         BIGINT          IDENTITY (1, 1) NOT NULL,
    [Nombre]     VARCHAR (50)    NULL,
    [Apellido]   VARCHAR (50)    NULL,
    [EMail]      VARCHAR (50)    NULL,
    [Total]      DECIMAL (12, 2) NULL,
    [idVehiculo] BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Presupuesto_idVehiculo] FOREIGN KEY ([idVehiculo]) REFERENCES [dbo].[Vehiculo] ([Id])
);

