CREATE TABLE [dbo].[Repuesto] (
    [Id]     BIGINT          IDENTITY (1, 1) NOT NULL,
    [Nombre] VARCHAR (100)   NULL,
    [Precio] DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

