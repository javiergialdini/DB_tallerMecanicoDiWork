CREATE TABLE [dbo].[Vehiculo] (
    [Id]      BIGINT       IDENTITY (1, 1) NOT NULL,
    [Marca]   VARCHAR (50) NULL,
    [Modelo]  VARCHAR (50) NULL,
    [Patente] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

