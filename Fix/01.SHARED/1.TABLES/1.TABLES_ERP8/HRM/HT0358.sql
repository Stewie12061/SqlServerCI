﻿-- <Summary>
---- 
-- <History>
---- Create on 15/07/2015 by Thanh Thinh
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0358]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0358]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NULL, 
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,    
	  [EmployeeID] NVARCHAR(50) NOT NULL,   
	  [Type] TINYINT NOT NULL,
	  [EmailReceiver] nvarchar(50) NOT NULL,
      [SendDate] DATETIME NOT NULL,
	  [Subject] nvarchar(200) NOT NULL,
	  [Content] nvarchar(MAX) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NOT NULL,
	  [CreateUserID] VARCHAR (50) NULL,
	  [CreateDate] DATETIME NULL,
	  [LastModifyUserID] VARCHAR (50) NULL,
	  [LastModifyDate] DATETIME NULL

    CONSTRAINT [PK_HT0358] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

--Modefied by Huỳnh Thử 23/07/2020: Status Add Column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0358' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0358' AND col.name = 'Status')
        ALTER TABLE HT0358 ADD Status TINYINT NULL
    END



