-- <Summary>
---- Script bảng động T1.
-- <History>
---- Create on 10/09/2020 by Văn Tài
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[T1]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[T1]
     (
      DivisionID NVARCHAR(50)
     )
END

 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
     ON col.id = tab.id WHERE tab.name = 'T1' AND col.name = 'DivisionID')
	ALTER TABLE T1 ADD DivisionID NVARCHAR(50)  NULL