-- <Summary>
----Chi tiết định mức khoản thu theo hợp đồng SIKICO
-- <History>
---- Create on 29/03/2022 by Kiều Nga 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0158]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0158]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
    [DivisionID] VARCHAR(50) NOT NULL,
	[Orders] INT NULL,
	[TypeID] INT NULL,
	[FromValue] DECIMAL(28,8) NULL,
	[ToValue] DECIMAL(28,8) NULL,	
	[UnitPrice] DECIMAL(28,8) NULL,
	[Notes] NVARCHAR(MAX) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_CT0158] PRIMARY KEY NONCLUSTERED 
	(
		[DivisionID] ASC,
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END

---- Modified on 03/06/2022 by Kiều Nga: Bổ sung cột tỷ lệ tăng giá
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CT0158' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'CT0158' AND col.name = 'Rate')
        ALTER TABLE CT0158 ADD Rate DECIMAL(28,8) NULL
    END	 


