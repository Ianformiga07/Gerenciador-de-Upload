USE [Teste]
GO
/****** Object:  Table [dbo].[GU_Arquivos]    Script Date: 18/05/2021 12:08:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GU_Arquivos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](80) NOT NULL,
	[Descricao] [varchar](100) NOT NULL,
	[cpf] [varchar](15) NOT NULL,
	[Arquivo] [varchar](100) NOT NULL,
 CONSTRAINT [PK_GU_Arquivos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GU_CadPessoasUp]    Script Date: 18/05/2021 12:08:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GU_CadPessoasUp](
	[CPF] [varchar](15) NOT NULL,
	[Nome] [varchar](100) NOT NULL,
	[CodPrograma] [int] NOT NULL,
	[idPerfil] [int] NOT NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_GU_CadPessoasUp] PRIMARY KEY CLUSTERED 
(
	[CPF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GU_Perfil]    Script Date: 18/05/2021 12:08:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GU_Perfil](
	[idPerfil] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GU_Perfil] PRIMARY KEY CLUSTERED 
(
	[idPerfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GU_Programas]    Script Date: 18/05/2021 12:08:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GU_Programas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Programas] [varchar](80) NOT NULL,
 CONSTRAINT [PK_GU_Programas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[GU_Arquivos] ON 

INSERT [dbo].[GU_Arquivos] ([id], [Titulo], [Descricao], [cpf], [Arquivo]) VALUES (17, N'Teste 1', N'Arquivo novo', N'78945612356', N'.\upload\Nubank_2021-05-20.pdf')
SET IDENTITY_INSERT [dbo].[GU_Arquivos] OFF
GO
INSERT [dbo].[GU_CadPessoasUp] ([CPF], [Nome], [CodPrograma], [idPerfil], [status]) VALUES (N'78945612356', N'Ian Leandro Cardoso Formiga', 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[GU_Perfil] ON 

INSERT [dbo].[GU_Perfil] ([idPerfil], [Perfil]) VALUES (1, N'Administrador')
INSERT [dbo].[GU_Perfil] ([idPerfil], [Perfil]) VALUES (2, N'Técnico')
SET IDENTITY_INSERT [dbo].[GU_Perfil] OFF
GO
SET IDENTITY_INSERT [dbo].[GU_Programas] ON 

INSERT [dbo].[GU_Programas] ([id], [Programas]) VALUES (1, N'CTI')
INSERT [dbo].[GU_Programas] ([id], [Programas]) VALUES (2, N'PESA')
INSERT [dbo].[GU_Programas] ([id], [Programas]) VALUES (3, N'Febre Aftosa')
INSERT [dbo].[GU_Programas] ([id], [Programas]) VALUES (4, N'Brucelose')
INSERT [dbo].[GU_Programas] ([id], [Programas]) VALUES (5, N'Raiva Herbívoros')
SET IDENTITY_INSERT [dbo].[GU_Programas] OFF
GO
ALTER TABLE [dbo].[GU_Arquivos]  WITH CHECK ADD  CONSTRAINT [FK_GU_Arquivos_GU_CadPessoasUp] FOREIGN KEY([cpf])
REFERENCES [dbo].[GU_CadPessoasUp] ([CPF])
GO
ALTER TABLE [dbo].[GU_Arquivos] CHECK CONSTRAINT [FK_GU_Arquivos_GU_CadPessoasUp]
GO
ALTER TABLE [dbo].[GU_CadPessoasUp]  WITH CHECK ADD  CONSTRAINT [FK_GU_CadPessoasUp_GU_Perfil] FOREIGN KEY([idPerfil])
REFERENCES [dbo].[GU_Perfil] ([idPerfil])
GO
ALTER TABLE [dbo].[GU_CadPessoasUp] CHECK CONSTRAINT [FK_GU_CadPessoasUp_GU_Perfil]
GO
ALTER TABLE [dbo].[GU_CadPessoasUp]  WITH CHECK ADD  CONSTRAINT [FK_GU_CadPessoasUp_GU_Programas] FOREIGN KEY([CodPrograma])
REFERENCES [dbo].[GU_Programas] ([id])
GO
ALTER TABLE [dbo].[GU_CadPessoasUp] CHECK CONSTRAINT [FK_GU_CadPessoasUp_GU_Programas]
GO
