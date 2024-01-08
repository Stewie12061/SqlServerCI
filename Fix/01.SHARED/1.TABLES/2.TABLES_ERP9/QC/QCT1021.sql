---- Create by Le Hoang on 01/10/2020
---- Định nghĩa tiêu chuẩn cho mặt hàng (Detail)
---- Bổ sung cột thứ tự bản vẽ, Dụng cụ đo, Loại.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT1021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT1021](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[StandardID] [varchar](50) NOT NULL,
	[StandardUnitID] [varchar](50) NULL,
	[SRange01] [nvarchar](50) NULL,
	[SRange02] [nvarchar](50) NULL,
	[SRange03] [nvarchar](50) NULL,
	[SRange04] [nvarchar](50) NULL,
	[SRange05] [nvarchar](50) NULL,
	[Disabled] [tinyint] DEFAULT 0 NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT1021] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--Bổ sung cột Thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT1021' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'Orders')
   ALTER TABLE QCT1021 ADD Orders INT NULL
END

--Chỉnh sửa kích thước chuỗi
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT1021' AND xtype = 'U')
BEGIN
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange01')
   ALTER TABLE QCT1021 ALTER COLUMN SRange01 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange02')
   ALTER TABLE QCT1021 ALTER COLUMN SRange02 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange03')
   ALTER TABLE QCT1021 ALTER COLUMN SRange03 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange04')
   ALTER TABLE QCT1021 ALTER COLUMN SRange04 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange05')
   ALTER TABLE QCT1021 ALTER COLUMN SRange05 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange06')
   ALTER TABLE QCT1021 ALTER COLUMN SRange06 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange07')
   ALTER TABLE QCT1021 ALTER COLUMN SRange07 nvarchar(MAX) NULL
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange08')
   ALTER TABLE QCT1021 ALTER COLUMN SRange08 nvarchar(MAX) NULL
END

--Bổ sung cột Thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT1021' AND xtype = 'U')
BEGIN
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'StandardUnitID')
   ALTER TABLE QCT1021 ALTER COLUMN StandardUnitID [nvarchar](50) NULL
END

---------------- 07/05/2021 - Đình Hòa: Bổ sung cột MathFormula(MECI) ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'MathFormula')
BEGIN
	ALTER TABLE QCT1021 ADD MathFormula NVARCHAR(500) NULL
END

---------------- 01/04/2023 - Hoàng Long: Bổ sung cột Dụng cụ đo ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange06')
BEGIN
	ALTER TABLE QCT1021 ADD SRange06 NVARCHAR(50) NULL
END
---------------- 01/04/2023 - Hoàng Long: Bổ sung cột Loại ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange07')
BEGIN
	ALTER TABLE QCT1021 ADD SRange07 NVARCHAR(50) NULL
END
---------------- 10/04/2023 - Hoàng Long: Bổ sung cột Thứ tự bản vẽ ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange08')
BEGIN
	ALTER TABLE QCT1021 ADD SRange08 NVARCHAR(50) NULL
END
---------------- 11/09/2023 - Viết Toàn: Bổ sung cột Tần suất đo ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'QCT1021' AND col.name = 'SRange09')
BEGIN
	ALTER TABLE QCT1021 ADD SRange09 NVARCHAR(50) NULL
END