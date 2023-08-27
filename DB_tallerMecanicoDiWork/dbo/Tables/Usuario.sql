CREATE TABLE [dbo].[Usuario] (
    [IdUsuario] INT          IDENTITY (1, 1) NOT NULL,
    [UserName]  VARCHAR (50) NULL,
    [Password]  VARCHAR (20) NULL,
    PRIMARY KEY CLUSTERED ([IdUsuario] ASC)
);

