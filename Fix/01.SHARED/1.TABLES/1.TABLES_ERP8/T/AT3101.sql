---- Created by Kim Thư on 15/01/2019: Lưu phiếu chiết khấu
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT3101]') AND type in (N'U'))
CREATE TABLE [dbo].[AT3101](
	[DivisionID] varchar(50) NOT NULL,
	[VoucherID] VARCHAR(50) DEFAULT NEWID() NOT NULL,
	[TransactionID] VARCHAR(50) DEFAULT NEWID() NOT NULL,
	[TranMonth] INT NOT NULL,
	[TranYear] INT NOT NULL,
	[VoucherTypeID] varchar(50) NOT NULL,
	[VoucherNo] varchar(50) NOT NULL,
	[VoucherDate] datetime NOT NULL,
	[EmployeeID] varchar(50) NOT NULL,
	[Description] NVARCHAR(MAX) NOT NULL,
    [Note] nvarchar(MAX) NOT NULL,
	[DiscountType] TINYINT NOT NULL,
	[InvoiceNo] varchar(50) NULL,
	[InvoiceDate] datetime NULL,
	[ReceivedDate] datetime NULL,
	[InventoryID] varchar(50) NULL,
	[InventoryName] nvarchar(MAX) NULL,
	[Amount] DECIMAL(28,8) DEFAULT(0) NULL,
	[AfterVATAmount] DECIMAL(28,8) DEFAULT(0) NULL,
	[DiscountRate] DECIMAL(28,8) DEFAULT(0) NULL,
	[DiscountAmount] DECIMAL(28,8) DEFAULT(0) NULL,
	[ObjectID] varchar(50) NULL,
	[ObjectName] NVARCHAR (MAX) NULL,
	[TDescription] NVARCHAR(MAX) NULL,
	[InheritTableID] VARCHAR(50) NULL,
	[InheritVoucherID] VARCHAR(50) NULL,
	[InheritTransactionID] VARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[CreateUserID] NVARCHAR (50) NULL,
	[LastModifyDate] datetime NULL,
	[LastModifyUserID] NVARCHAR (50) NULL
	
 CONSTRAINT [PK_AT3101] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

/*ALTER INDEX PK_AT3101 ON AT3101 DISABLE;
ALTER TABLE AT3101 DROP CONSTRAINT PK_AT3101
ALTER TABLE AT3101 ADD CONSTRAINT PK_AT3101 PRIMARY KEY ([DivisionID], [TransactionID]);*/

--- Modified by Huỳnh Thử on 03/12/2019: Bổ sung trường các trường Số tiền thực thu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT3101' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT3101' AND col.name = 'EndOriginalAmount')
        ALTER TABLE AT3101 ADD EndOriginalAmount DECIMAL(28,8) DEFAULT(0) NULL
        
             
    END	    	
    