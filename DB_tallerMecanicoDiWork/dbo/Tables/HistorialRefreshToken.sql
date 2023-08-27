CREATE TABLE [dbo].[HistorialRefreshToken] (
    [IdHistorialToken] INT           IDENTITY (1, 1) NOT NULL,
    [IdUsuario]        INT           NULL,
    [Token]            VARCHAR (500) NULL,
    [RefreshToken]     VARCHAR (200) NULL,
    [FechaCreacion]    DATETIME      NULL,
    [FechaExpiracion]  DATETIME      NULL,
    [EsActivo]         AS            (case when [FechaExpiracion]<getdate() then CONVERT([bit],(0)) else CONVERT([bit],(1)) end),
    PRIMARY KEY CLUSTERED ([IdHistorialToken] ASC),
    FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuario] ([IdUsuario])
);

