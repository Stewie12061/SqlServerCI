-- <Summary>
---- Nghiệp vụ phong tỏa/giải tỏa TK ký quỹ master (Asoft-LM)
-- <History>
---- Create on 05/07/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2011]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [TranMonth] INT NOT NULL,
	  [TranYear] INT NOT NULL,
	  [CreditVoucherID] VARCHAR(50) NOT NULL,
	  [AdvanceDate] DATETIME NOT NULL,
	  [AdvanceTypeID] TINYINT NOT NULL,	---0: phong tỏa, 1: giải tỏa
	  [AdvancePercent] DECIMAL(28,8) NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
	  [CostTypeID] VARCHAR(50) NULL,
	  [SalesTypeID] VARCHAR(50) NULL,
      [Description] NVARCHAR(250) NULL,
	  [RelatedToTypeID] INT NOT NULL DEFAULT(4),
	  [InheritTableName] VARCHAR(50) NULL,
	  [InheritVoucherID] VARCHAR(50) NULL,
	  [InheritTransactionID] VARCHAR(50) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_LMT2011] PRIMARY KEY CLUSTERED
      (
		[DivisionID],
		[VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified by Tiểu Mai on 31/10/2017: Bổ sung trường Giá trị bảo lãnh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2011' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'GuaranteeValue')
		ALTER TABLE LMT2011 ADD GuaranteeValue DECIMAL(28,8) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'FromDateGuarantee')
		ALTER TABLE LMT2011 ADD FromDateGuarantee DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'ToDateGuarantee')
		ALTER TABLE LMT2011 ADD ToDateGuarantee DATETIME NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'AssignObjectID')
		ALTER TABLE LMT2011 ADD AssignObjectID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'Parameter01')
		ALTER TABLE LMT2011 ADD Parameter01 NVARCHAR(250) NULL,
								Parameter02 NVARCHAR(250) NULL,
								Parameter03 NVARCHAR(250) NULL,
								Parameter04 NVARCHAR(250) NULL,
								Parameter05 NVARCHAR(250) NULL,
								Parameter06 NVARCHAR(250) NULL,
								Parameter07 NVARCHAR(250) NULL,
								Parameter08 NVARCHAR(250) NULL,
								Parameter09 NVARCHAR(250) NULL,
								Parameter10 NVARCHAR(250) NULL,
								Parameter11 NVARCHAR(250) NULL,
								Parameter12 NVARCHAR(250) NULL,
								Parameter13 NVARCHAR(250) NULL,
								Parameter14 NVARCHAR(250) NULL,
								Parameter15 NVARCHAR(250) NULL,
								Parameter16 NVARCHAR(250) NULL,
								Parameter17 NVARCHAR(250) NULL,
								Parameter18 NVARCHAR(250) NULL,
								Parameter19 NVARCHAR(250) NULL,
								Parameter20 NVARCHAR(250) NULL
									
	END
	
------- Modify by Như Hàn on 31/01/2019: Thêm thông tin dự án
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2011' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'LMT2011' AND col.name = 'ProjectID')
		ALTER TABLE LMT2011 ADD ProjectID VARCHAR(50) NULL
	END