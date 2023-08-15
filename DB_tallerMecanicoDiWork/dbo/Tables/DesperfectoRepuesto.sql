CREATE TABLE [dbo].[DesperfectoRepuesto] (
    [idDesperfecto] BIGINT NOT NULL,
    [idRepuesto]    BIGINT NOT NULL,
    CONSTRAINT [PK_DesperfectoRepuesto] PRIMARY KEY CLUSTERED ([idDesperfecto] ASC, [idRepuesto] ASC),
    CONSTRAINT [FK_DesperfectoRepuesto_idDesperfecto] FOREIGN KEY ([idDesperfecto]) REFERENCES [dbo].[Desperfecto] ([Id]),
    CONSTRAINT [FK_DesperfectoRepuesto_idRepuesto] FOREIGN KEY ([idRepuesto]) REFERENCES [dbo].[Repuesto] ([Id])
);

