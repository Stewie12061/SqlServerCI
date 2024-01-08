---- Create by truong ngoc phuong thao on 04/01/2016 5:33:27 PM
---- Quyết định Bổ nhiệm/ Bãi nhiệm/ Điều chỉnh cấp bậc

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0362]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0362]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [DecideNo] NVARCHAR(50) NOT NULL,
      [DecideType] NVARCHAR(50) NULL,
      [DecideDate] DATETIME NULL,
      [DecidePerson] NVARCHAR(50) NULL,
      [Proposer] NVARCHAR(100) NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [DutyID] NVARCHAR(50) NULL,
      [Level] NVARCHAR(50) NULL,
      [NewDutyID] NVARCHAR(50) NULL,
      [NewLevel] NVARCHAR(50) NULL,
      [Notes] NVARCHAR(250) NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME DEFAULT getdate() NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME DEFAULT getdate() NULL
    CONSTRAINT [PK_HT0362] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [DecideNo]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified on 31/05/2016 by Bảo Thy: Add column EffectiveDate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0362' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0362' AND col.name = 'EffectiveDate')
        ALTER TABLE HT0362 ADD EffectiveDate DATETIME NULL

		--- Modified on 10/01/2019 by Bảo Anh: Bổ sung mức lương cũ và mới (dùng cho quyết định tăng lương)
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0362' AND col.name = 'Salary')
        ALTER TABLE HT0362 ADD Salary DECIMAL(28,8) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0362' AND col.name = 'NewSalary')
        ALTER TABLE HT0362 ADD NewSalary DECIMAL(28,8) NULL

    END