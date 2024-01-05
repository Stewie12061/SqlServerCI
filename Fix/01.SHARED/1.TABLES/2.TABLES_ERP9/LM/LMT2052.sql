-- <Summary>
---- Danh mục hợp đồng bảo lãnh, chi tiết phí ngân hàng (Asoft-LM)
-- <History>
---- Create by Tiểu Mai on 12/10/2017
---- Modified on 30/01/2019 by Như Hàn: Bổ sung 10 trường mã phân tích
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2052]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2052]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
	  [VoucherID] NVARCHAR(50) NOT NULL,
	  [TransactionID] NVARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [CostID] NVARCHAR(250) NULL,
	  [CostDate] DATETIME NULL,
	  [CostRate] DECIMAL(28,8) NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
	  [CostTypeID] NVARCHAR(50) NULL,
      [Notes] NVARCHAR(250) NULL     
    CONSTRAINT [PK_LMT2052] PRIMARY KEY CLUSTERED
      (
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'LMT2052' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'LMT2052'  and col.name = 'Ana01ID')
Alter Table LMT2052 Add Ana01ID nvarchar(50) Null,
					 Ana02ID nvarchar(50) Null,
					 Ana03ID nvarchar(50) Null,
					 Ana04ID nvarchar(50) Null,
					 Ana05ID nvarchar(50) Null,
					 Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
END