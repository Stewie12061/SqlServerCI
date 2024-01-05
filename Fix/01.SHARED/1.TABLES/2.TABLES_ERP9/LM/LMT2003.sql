-- <Summary>
---- Danh mục hợp đồng tín dụng, chi tiết TSDB (Asoft-LM)
-- <History>
---- Create on 27/06/2017 by Bảo Anh
---- Modified on ... by 
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2003]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2003]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [TransactionID] VARCHAR(50) NOT NULL,
	  [Orders] INT NULL,
	  [SourceID] TINYINT NULL,
	  [AssetID] NVARCHAR(500) NOT NULL,
	  [ConvertedAmount] DECIMAL(28,8) NULL,
      [Notes] NVARCHAR(250) NULL      
    CONSTRAINT [PK_LMT2003] PRIMARY KEY CLUSTERED
      (
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modififed by Tiểu Mai on 28/09/2017: Bổ sung trường 10 MPT nghiệp vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2003' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2003' AND col.name = 'Ana01ID') 
   ALTER TABLE LMT2003 ADD	Ana01ID NVARCHAR(50) NULL,
							Ana02ID NVARCHAR(50) NULL,
							Ana03ID NVARCHAR(50) NULL,
							Ana04ID NVARCHAR(50) NULL,
							Ana05ID NVARCHAR(50) NULL,
							Ana06ID NVARCHAR(50) NULL,
							Ana07ID NVARCHAR(50) NULL,
							Ana08ID NVARCHAR(50) NULL,
							Ana09ID NVARCHAR(50) NULL,
							Ana10ID NVARCHAR(50) NULL
END


--- Modified by Hải Long on 20/10/2017: modified dữ liệu trường SourceID thành nvarchar
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2003' AND xtype = 'U')
    BEGIN  
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'LMT2003' AND col.name = 'SourceID')
        ALTER TABLE LMT2003 ALTER COLUMN SourceID NVARCHAR(50) NULL    
    END	                  