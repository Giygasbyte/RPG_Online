CREATE DATABASE RPG_Online;
GO

USE RPG_Online;
GO

-- 1. Usuarios: um usuario pode possuir varios personagens.
CREATE TABLE Usuarios (
    UsuarioId INT IDENTITY(1,1) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Senha NVARCHAR(255) NOT NULL,

    CONSTRAINT PK_Usuarios PRIMARY KEY (UsuarioId),
    CONSTRAINT UQ_Usuarios_Email UNIQUE (Email)
);
GO

-- 2. Classes: uma classe pode estar associada a varios personagens.
CREATE TABLE Classes (
    ClasseId INT IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,
    Descricao NVARCHAR(500) NULL,

    CONSTRAINT PK_Classes PRIMARY KEY (ClasseId)
);
GO

-- 3. Personagens: cada personagem pertence a um usuario e a uma classe.
CREATE TABLE Personagens (
    PersonagemId INT IDENTITY(1,1) NOT NULL,
    NomePersonagem NVARCHAR(100) NOT NULL,
    UsuarioId INT NOT NULL,
    ClasseId INT NOT NULL,

    CONSTRAINT PK_Personagens PRIMARY KEY (PersonagemId),
    CONSTRAINT FK_Personagens_Usuarios
        FOREIGN KEY (UsuarioId) REFERENCES Usuarios (UsuarioId),
    CONSTRAINT FK_Personagens_Classes
        FOREIGN KEY (ClasseId) REFERENCES Classes (ClasseId)
);
GO

-- 4. Habilidades: catalogo de habilidades disponiveis.
CREATE TABLE Habilidades (
    HabilidadeId INT IDENTITY(1,1) NOT NULL,
    Nome NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Habilidades PRIMARY KEY (HabilidadeId)
);
GO

-- 5. Classes_Habilidades: resolve o relacionamento N:N entre
--    Classes e Habilidades. A chave primaria e composta pelas duas FKs.
CREATE TABLE Classes_Habilidades (
    ClasseId INT NOT NULL,
    HabilidadeId INT NOT NULL,

    CONSTRAINT PK_Classes_Habilidades
        PRIMARY KEY (ClasseId, HabilidadeId),
    CONSTRAINT FK_Classes_Habilidades_Classes
        FOREIGN KEY (ClasseId) REFERENCES Classes (ClasseId),
    CONSTRAINT FK_Classes_Habilidades_Habilidades
        FOREIGN KEY (HabilidadeId) REFERENCES Habilidades (HabilidadeId)
);
GO
