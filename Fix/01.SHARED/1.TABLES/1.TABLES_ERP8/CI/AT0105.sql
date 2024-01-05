-- <Summary>
---- 
-- <History>
---- Create on 13/06/2017 by Tiểu Mai: Tạo table lưu lại giá trị thiết lập TK - MPT nghiệp vụ
---- Modified on ... by ...
-- <Example>
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0105]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0105](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[AccountID] [nvarchar](50) NULL,
	[IsPeriod] TINYINT NULL,
	[IsAnaType01] TINYINT NULL,
	[IsAnaType02] TINYINT NULL,
	[IsAnaType03] TINYINT NULL,
	[IsAnaType04] TINYINT NULL,
	[IsAnaType05] TINYINT NULL,
	[IsAnaType06] TINYINT NULL,
	[IsAnaType07] TINYINT NULL,
	[IsAnaType08] TINYINT NULL,
	[IsAnaType09] TINYINT NULL,
	[IsAnaType10] TINYINT NULL
)
END

---Modified by Tiểu Mai on 19/05/2017: Bổ sung cột DivisionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0105' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT0105' AND col.name = 'DivisionID') 
	ALTER TABLE AT0105 ADD DivisionID NVARCHAR(50) NULL 
END



