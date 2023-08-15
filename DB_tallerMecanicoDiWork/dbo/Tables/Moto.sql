CREATE TABLE [dbo].[Moto] (
    [Id]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [idVehiculo] BIGINT       NULL,
    [Cilindrada] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Moto_idVehiculo] FOREIGN KEY ([idVehiculo]) REFERENCES [dbo].[Vehiculo] ([Id])
);

