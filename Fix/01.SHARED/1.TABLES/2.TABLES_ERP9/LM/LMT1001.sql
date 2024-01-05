-- <Summary>
---- Danh mục hình thức tín dụng (Asoft-LM)
-- <History>
---- Create on 21/06/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT1001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT1001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [CreditFormID] VARCHAR(50) NOT NULL,
      [CreditFormName] NVARCHAR(250) NULL,
      [Notes] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [IsCommon] TINYINT DEFAULT (0) NOT NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(1),
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT1001] PRIMARY KEY CLUSTERED
      (
      [CreditFormID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modififed by Tiểu Mai on 27/09/2017: Bổ sung trường CreditTypeID (Loại tín dụng)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT1001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT1001' AND col.name = 'CreditTypeID') 
   ALTER TABLE LMT1001 ADD CreditTypeID TINYINT NULL 
END