-- <Summary>
---- Bảng mặt hàng không sinh phiếu nhập/xuất kho. (DUCPHAT)
-- <History>
---- Create on 28/01/2021 by Văn Tài

---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2007]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2007](
	[DivisionID] [varchar](50) NULL,
	[ProductID] [varchar](20) NOT NULL
)
ON [PRIMARY]


--- Modified by Văn Tài on 05/02/2020: Bổ sung cột DivisionID.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT2007' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2007' AND col.name = 'DivisionID') 
   ALTER TABLE WT2007 ADD DivisionID VARCHAR(50) NULL 
END
