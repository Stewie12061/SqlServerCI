---- Create by Le Hoang on 01/10/2020
---- Edit by nhttai on 17/10/2020
---- Danh mục Chi tiết thông số Máy

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1151]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1151](
	[APK] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[DivisionID] [varchar](50) NOT NULL,
	[MachineID] [varchar](50) NULL,
	[StandardID] [varchar](50) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NULL DEFAULT (getdate()),
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL DEFAULT (getdate()),
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_CIT1151] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END


