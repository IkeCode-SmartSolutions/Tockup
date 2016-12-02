USE [master]
GO
/****** Object:  Database [PassarinhoContou]    Script Date: 02/12/2016 08:59:59 ******/
CREATE DATABASE [PassarinhoContou]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PassarinhoContou', FILENAME = N'C:\Databases\Data\PassarinhoContou.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PassarinhoContou_log', FILENAME = N'C:\Databases\Data\PassarinhoContou_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PassarinhoContou].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PassarinhoContou] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PassarinhoContou] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PassarinhoContou] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PassarinhoContou] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PassarinhoContou] SET ARITHABORT OFF 
GO
ALTER DATABASE [PassarinhoContou] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PassarinhoContou] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PassarinhoContou] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PassarinhoContou] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PassarinhoContou] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PassarinhoContou] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PassarinhoContou] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PassarinhoContou] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PassarinhoContou] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PassarinhoContou] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PassarinhoContou] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PassarinhoContou] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PassarinhoContou] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PassarinhoContou] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PassarinhoContou] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PassarinhoContou] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PassarinhoContou] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PassarinhoContou] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PassarinhoContou] SET  MULTI_USER 
GO
ALTER DATABASE [PassarinhoContou] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PassarinhoContou] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PassarinhoContou] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PassarinhoContou] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PassarinhoContou] SET DELAYED_DURABILITY = DISABLED 
GO
USE [PassarinhoContou]
GO
/****** Object:  User [sql]    Script Date: 02/12/2016 09:00:01 ******/
CREATE USER [sql] FOR LOGIN [sql] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [sql]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [sql]
GO
ALTER ROLE [db_datareader] ADD MEMBER [sql]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [sql]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 02/12/2016 09:00:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConnectedDevices]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ConnectedDevices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ConfirmationCode] [varchar](500) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[DeviceId] [varchar](500) NOT NULL,
	[Owner] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_ConnectedDevices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MessagePrefixes]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MessagePrefixes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_MessagePrefixes_CreationDate]  DEFAULT (getdate()),
	[Name] [varchar](100) NOT NULL,
	[Owner] [int] NOT NULL,
	[PrefixCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_MessagePrefixes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[FromUserId] [int] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[MessageType] [int] NOT NULL,
	[Owner] [int] NOT NULL,
	[SelectedPrefixId] [int] NOT NULL,
	[SelectedSuffixId] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ToUserId] [int] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageSuffixes]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MessageSuffixes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_MessageSuffixes_CreationDate]  DEFAULT (getdate()),
	[Name] [varchar](100) NOT NULL,
	[Owner] [int] NOT NULL,
	[SuffixCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_MessageSuffixes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrefixCategories]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrefixCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Owner] [int] NOT NULL,
 CONSTRAINT [PK_PrefixCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrefixCategoryTranslations]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrefixCategoryTranslations](
	[Id] [int] NOT NULL,
	[CategoryText] [varchar](100) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Owner] [int] NOT NULL,
	[PrefixCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_PrefixCategoryTranslations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrefixesTranslations]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrefixesTranslations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[MessageText] [text] NOT NULL,
	[Owner] [int] NOT NULL,
	[PrefixId] [int] NOT NULL,
 CONSTRAINT [PK_PrefixesTranslations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SuffixCategories]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuffixCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL CONSTRAINT [DF_SuffixCategories_CreationDate]  DEFAULT (getdate()),
	[Name] [varchar](100) NOT NULL,
	[Owner] [int] NOT NULL,
 CONSTRAINT [PK_SuffixCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SuffixCategoryTranslations]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SuffixCategoryTranslations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryText] [varchar](100) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[Owner] [int] NOT NULL,
	[PrefixCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_SuffixCategoryTranslations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SuffixesTranslations]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuffixesTranslations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LanguageId] [int] NOT NULL,
	[MessageText] [text] NOT NULL,
	[Owner] [int] NOT NULL,
	[SuffixId] [int] NOT NULL,
 CONSTRAINT [PK_SuffixesTranslations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/12/2016 09:00:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[FullName] [varchar](500) NOT NULL,
	[NickName] [varchar](50) NOT NULL,
	[Owner] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_ConnectedDevices_UserId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_ConnectedDevices_UserId] ON [dbo].[ConnectedDevices]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MessagePrefixes_PrefixCategoryId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_MessagePrefixes_PrefixCategoryId] ON [dbo].[MessagePrefixes]
(
	[PrefixCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_FromUserId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_Messages_FromUserId] ON [dbo].[Messages]
(
	[FromUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_SelectedPrefixId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_Messages_SelectedPrefixId] ON [dbo].[Messages]
(
	[SelectedPrefixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_SelectedSuffixId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_Messages_SelectedSuffixId] ON [dbo].[Messages]
(
	[SelectedSuffixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Messages_ToUserId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_Messages_ToUserId] ON [dbo].[Messages]
(
	[ToUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MessageSuffixes_SuffixCategoryId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_MessageSuffixes_SuffixCategoryId] ON [dbo].[MessageSuffixes]
(
	[SuffixCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PrefixCategoryTranslations_PrefixCategoryId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_PrefixCategoryTranslations_PrefixCategoryId] ON [dbo].[PrefixCategoryTranslations]
(
	[PrefixCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PrefixesTranslations_PrefixId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_PrefixesTranslations_PrefixId] ON [dbo].[PrefixesTranslations]
(
	[PrefixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SuffixCategoryTranslations_PrefixCategoryId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_SuffixCategoryTranslations_PrefixCategoryId] ON [dbo].[SuffixCategoryTranslations]
(
	[PrefixCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_SuffixesTranslations_SuffixId]    Script Date: 02/12/2016 09:00:03 ******/
CREATE NONCLUSTERED INDEX [IX_SuffixesTranslations_SuffixId] ON [dbo].[SuffixesTranslations]
(
	[SuffixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConnectedDevices]  WITH CHECK ADD  CONSTRAINT [FK_ConnectedDevices_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[ConnectedDevices] CHECK CONSTRAINT [FK_ConnectedDevices_Users]
GO
ALTER TABLE [dbo].[MessagePrefixes]  WITH CHECK ADD  CONSTRAINT [FK_MessagePrefixes_PrefixCategories] FOREIGN KEY([PrefixCategoryId])
REFERENCES [dbo].[PrefixCategories] ([Id])
GO
ALTER TABLE [dbo].[MessagePrefixes] CHECK CONSTRAINT [FK_MessagePrefixes_PrefixCategories]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_FromUser] FOREIGN KEY([FromUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_FromUser]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_MessagePrefixes] FOREIGN KEY([SelectedPrefixId])
REFERENCES [dbo].[MessagePrefixes] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_MessagePrefixes]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_MessageSuffixes] FOREIGN KEY([SelectedSuffixId])
REFERENCES [dbo].[MessageSuffixes] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_MessageSuffixes]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_ToUser] FOREIGN KEY([ToUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_ToUser]
GO
ALTER TABLE [dbo].[MessageSuffixes]  WITH CHECK ADD  CONSTRAINT [FK_MessageSuffixes_SuffixCategories] FOREIGN KEY([SuffixCategoryId])
REFERENCES [dbo].[SuffixCategories] ([Id])
GO
ALTER TABLE [dbo].[MessageSuffixes] CHECK CONSTRAINT [FK_MessageSuffixes_SuffixCategories]
GO
ALTER TABLE [dbo].[PrefixCategoryTranslations]  WITH CHECK ADD  CONSTRAINT [FK_PrefixCategoryTranslations_PrefixCategories] FOREIGN KEY([PrefixCategoryId])
REFERENCES [dbo].[PrefixCategories] ([Id])
GO
ALTER TABLE [dbo].[PrefixCategoryTranslations] CHECK CONSTRAINT [FK_PrefixCategoryTranslations_PrefixCategories]
GO
ALTER TABLE [dbo].[PrefixesTranslations]  WITH CHECK ADD  CONSTRAINT [FK_PrefixesTranslations_MessagePrefixes] FOREIGN KEY([PrefixId])
REFERENCES [dbo].[MessagePrefixes] ([Id])
GO
ALTER TABLE [dbo].[PrefixesTranslations] CHECK CONSTRAINT [FK_PrefixesTranslations_MessagePrefixes]
GO
ALTER TABLE [dbo].[SuffixCategoryTranslations]  WITH CHECK ADD  CONSTRAINT [FK_SuffixCategoryTranslations_SuffixCategories] FOREIGN KEY([PrefixCategoryId])
REFERENCES [dbo].[SuffixCategories] ([Id])
GO
ALTER TABLE [dbo].[SuffixCategoryTranslations] CHECK CONSTRAINT [FK_SuffixCategoryTranslations_SuffixCategories]
GO
ALTER TABLE [dbo].[SuffixesTranslations]  WITH CHECK ADD  CONSTRAINT [FK_SuffixesTranslations_MessageSuffixes] FOREIGN KEY([SuffixId])
REFERENCES [dbo].[MessageSuffixes] ([Id])
GO
ALTER TABLE [dbo].[SuffixesTranslations] CHECK CONSTRAINT [FK_SuffixesTranslations_MessageSuffixes]
GO
USE [master]
GO
ALTER DATABASE [PassarinhoContou] SET  READ_WRITE 
GO
