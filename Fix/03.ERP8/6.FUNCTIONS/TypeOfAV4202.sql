/****** Object:  UserDefinedTableType [dbo].[TypeOfAV4202]    Script Date: 04/16/2013 15:41:35 ******/
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4202' AND ss.name = N'dbo')
/****** Object:  UserDefinedTableType [dbo].[TypeOfAV4202]    Script Date: 04/16/2013 15:41:35 ******/
CREATE TYPE [dbo].[TypeOfAV4202] AS TABLE(
	[ObjectID] [nvarchar](50) NULL,
	[CurrencyIDCN] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[InvoiceDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[DivisionID] [nvarchar](50) NULL,
	[AccountID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CorAccountID] [nvarchar](50) NULL,
	[D_C] [nvarchar](50) NULL,
	[TransactionTypeID] [nvarchar](50) NULL
)



