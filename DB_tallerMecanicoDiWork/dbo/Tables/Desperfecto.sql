CREATE TABLE [dbo].[Desperfecto] (
    [Id]            BIGINT          IDENTITY (1, 1) NOT NULL,
    [idPresupuesto] BIGINT          NULL,
    [Descripcion]   VARCHAR (100)   NULL,
    [ManoDeObra]    DECIMAL (10, 2) NULL,
    [Tiempo]        INT             NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Desperfecto_idPresupuesto] FOREIGN KEY ([idPresupuesto]) REFERENCES [dbo].[Presupuesto] ([Id])
);

