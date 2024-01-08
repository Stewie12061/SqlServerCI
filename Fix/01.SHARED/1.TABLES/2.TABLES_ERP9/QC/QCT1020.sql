---- Create by Le Hoang on 01/10/2020
---- Định nghĩa tiêu chuẩn cho từng mặt hàng (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT1020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT1020](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[InventoryID] [varchar](50) NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Notes03] [nvarchar](250) NULL,
	[Disabled] [tinyint] DEFAULT 0 NOT NULL,
	[IsCommon] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT1020] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

---------------- 10/04/2023 - Hoàng Long: Bổ sung cột UpdateDate ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1020' AND col.name = 'UpdateDate')
BEGIN
	ALTER TABLE QCT1020 ADD UpdateDate [datetime] DEFAULT GETDATE() NULL
END