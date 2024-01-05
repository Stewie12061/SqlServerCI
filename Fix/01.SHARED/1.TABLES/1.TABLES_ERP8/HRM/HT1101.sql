-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified on 26/07/2013 by Bao Anh
---- Modified on 09/08/2017 by Hoàng vũ: Bổ sung các Người liên hệ, Gắn vào sơ đồ tổ chức
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1101]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1101](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,	
	[DepartmentID] [nvarchar](50) NOT NULL,
	[TeamID] [nvarchar](50) NOT NULL,
	[TeamName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Notes] [nvarchar](250) NULL,
	[Notes01] [nvarchar](250) NULL,
 CONSTRAINT [PK_HT1101] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[DepartmentID] ASC,
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT1101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1101'  and col.name = 'AccountID')
           Alter Table  HT1101 Add AccountID nvarchar(50) NULL
END
If Exists (Select * From sysobjects Where name = 'HT1101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1101'  and col.name = 'WorkID')
           Alter Table  HT1101 Add WorkID nvarchar(50) Null
End 

---Drop khóa
	IF EXISTS (SELECT Top 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'HT1101')
		Begin
			--Thay đối khóa chính từ 2 khóa sang 1 khóa (DivisionID,DepartmentID,TeamID) -> (DepartmentID, TeamID)
			ALTER TABLE HT1101 DROP CONSTRAINT pk_HT1101
			ALTER TABLE HT1101 ADD CONSTRAINT pk_HT1101 PRIMARY KEY (DepartmentID, TeamID)
		End

--Bổ sung người liên hệ (Là người đại diện chính của phòng ban)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1101' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'HT1101' AND col.name = 'ContactPerson')
   ALTER TABLE HT1101 ADD ContactPerson VARCHAR(50) NULL
END

--Bổ sung Gắn vào sơ đồ tổ chức --Date 10/10/2017
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1101' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'HT1101' AND col.name = 'IsOrganizationDiagram')
   ALTER TABLE HT1101 ADD IsOrganizationDiagram TINYINT NULL
END

---Thị Phượng bổ sung script Xương Rồng fix lỗi cũ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT1101' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1101' AND col.name='TeamLeaderID')
		ALTER TABLE HT1101 ADD TeamLeaderID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT1101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1101' AND col.name='BranchID')
	ALTER TABLE HT1101 ADD BranchID VARCHAR(50) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT1101' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1101' AND col.name='IsShow')
		ALTER TABLE HT1101 ADD IsShow TINYINT NULL
	END
