BEGIN TRANSACTION;
CREATE TABLE [Departments] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Budget] decimal(18,2) NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [DepartmentHeadId] int NULL,
    CONSTRAINT [PK_Departments] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Departments_Instructors_DepartmentHeadId] FOREIGN KEY ([DepartmentHeadId]) REFERENCES [Instructors] ([Id])
);

CREATE INDEX [IX_Departments_DepartmentHeadId] ON [Departments] ([DepartmentHeadId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251001015949_AddDepartment', N'9.0.9');

COMMIT;
GO

