-- <Summary>
---- 
-- <History>
---- Create on 15/02/2017 by Kim Vũ Table lưu lịch sử In/Excel báo cáo
---- Modified on ... by ...
---- <Example>


GO

/****** Object:  Table [dbo].[HistoryPrintReport]    Script Date: 16/02/2017 15:39:06 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HistoryPrintReport]') AND type in (N'U'))
CREATE TABLE [dbo].[HistoryPrintReport](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[FormID] [nvarchar](50) NOT NULL,
	[FormName] [nvarchar](250) NULL,
	[Action] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NOT NULL,
	[CreateDate] DateTime NOT NULL
 CONSTRAINT [PK_HistoryPrintReport] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HistoryPrintReport]    Script Date: 07/22/2010 15:39:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
