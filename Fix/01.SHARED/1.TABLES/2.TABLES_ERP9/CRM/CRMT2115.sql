-- <Summary> Danh mục giá vốn dự kiến (Detail)
-- <History>
---- Create on 06/11/20203 by Min Dũng
---- UPdate on 20/11/20203 by Min Dũng
---- <Example>
-- DROP TABLE CRMT2115
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2115]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2115]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] [uniqueidentifier] NULL,
  [DivisionID] [varchar](50) NOT NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [InventoryID] NVARCHAR(50) NULL, 
  [InventoryName] NVARCHAR(50) NULL, 
  [InventoryTypeID] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CRMT2115] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'CRMT2115' and xtype ='U') 
Begin
	DECLARE @Counter INT ,
			@sSQL nvarchar(500) ,
			@Column nvarchar(20) 
    -- 7 loại mã chi phí cố định
	SET @Counter=1
	WHILE ( @Counter <= 7)
	BEGIN	
		SET @Column = CONCAT('MCP',format(@Counter,'00'))
			set @sSQL = 'If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   ''CRMT2115''  and col.name = '''+@Column+''')
			Alter Table CRMT2115 ADD ' + @Column +' DECIMAL(28,8) NULL'
			EXECUTE sp_executesql @sSQL
		SET @Counter  = @Counter  + 1
	END
	-- 30 loại mã chi phí phát sinh
	SET @Counter=1
	WHILE ( @Counter <= 30)
	BEGIN	
		SET @Column = CONCAT('COS',format(@Counter,'00'))
			set @sSQL = 'If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   ''CRMT2115''  and col.name = '''+@Column+''')
			Alter Table CRMT2115 ADD ' + @Column +' DECIMAL(28,8) NULL'
			EXECUTE sp_executesql @sSQL
		SET @Counter  = @Counter  + 1
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'CRMT2110' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'CRMT2110' AND col.name = 'TotalAmount') 
	ALTER TABLE CRMT2110 ADD   [TotalAmount] DECIMAL (28,8)
END