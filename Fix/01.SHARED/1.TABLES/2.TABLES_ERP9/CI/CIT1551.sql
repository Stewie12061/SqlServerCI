-- <Summary> Danh mục giá vốn dự kiến (Detail)
-- <History>
---- Create on 15/06/2023 by Nhật Thanh
---- Modified on ... by ...
----Modify by: Lê Thanh Lượng, Date: 28/08/2023:[2023/08/TA/0159] - Bổ sung thêm 1 loại mã chi phí cố định.
---- <Example>
-- DROP TABLE CIT1551
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1551]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1551]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] [uniqueidentifier] NULL,
  [DivisionID] [varchar](50) NOT NULL,
  [InventoryID] NVARCHAR(50) NULL, 
  [InventoryName] NVARCHAR(50) NULL, 
  [InventoryTypeID] VARCHAR(50) NULL
CONSTRAINT [PK_CIT1551] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'CIT1551' and xtype ='U') 
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
		On col.id = tab.id where tab.name =   ''CIT1551''  and col.name = '''+@Column+''')
			Alter Table CIT1551 ADD ' + @Column +' DECIMAL(28,8) NULL'
			EXECUTE sp_executesql @sSQL
		SET @Counter  = @Counter  + 1
	END
	-- 30 loại mã chi phí phát sinh
	SET @Counter=1
	WHILE ( @Counter <= 30)
	BEGIN	
		SET @Column = CONCAT('COS',format(@Counter,'00'))
			set @sSQL = 'If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   ''CIT1551''  and col.name = '''+@Column+''')
			Alter Table CIT1551 ADD ' + @Column +' DECIMAL(28,8) NULL'
			EXECUTE sp_executesql @sSQL
		SET @Counter  = @Counter  + 1
	END
END
