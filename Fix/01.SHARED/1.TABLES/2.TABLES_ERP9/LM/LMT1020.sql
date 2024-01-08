---- Create by Trương Ngọc Phương Thảo on 10/2/2017 2:16:41 PM
---- Danh mục tài sản thế chấp

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT1020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[LMT1020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [AssetID] NVARCHAR(50) NOT NULL,
  [SourceID] NVARCHAR(50) NOT NULL,
  [AssetName] NVARCHAR(250) NULL,
  [ValidDate] DATETIME NULL,
  [Status] INT NULL,
  [AccountingValue] DECIMAL(28,8) NULL,
  [LoanLimitRate] DECIMAL(28,8) NULL,
  [LoanLimitAmount] DECIMAL(28,8) NULL,
  [Note] NVARCHAR(2000) NULL,
  [Disabled] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL
CONSTRAINT [PK_LMT1020] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [AssetID],
  [SourceID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- Modified by Hải Long on 17/10/2017: Bổ sung trường EvaluationValue (Giá trị thẩm định), InheritID (lưu vết)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT1020' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT1020' AND col.name = 'EvaluationValue')
        ALTER TABLE LMT1020 ADD EvaluationValue Decimal(28,8) NULL          
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT1020' AND col.name = 'InheritID')
        ALTER TABLE LMT1020 ADD InheritID NVARCHAR(50) NULL               
    END	