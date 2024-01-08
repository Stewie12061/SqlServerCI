/****** Object:  UserDefinedTableType [dbo].[TypeOfAV4201]    Script Date: 04/16/2013 15:41:27 ******/
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4201' AND ss.name = N'dbo')
/****** Object:  UserDefinedTableType [dbo].[TypeOfAV4201]    Script Date: 04/16/2013 15:41:27 ******/
CREATE TYPE [dbo].[TypeOfAV4201] AS TABLE(
	[DivisionID] [nvarchar](50) NULL,
	[AccountID] [nvarchar](50) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CorAccountID] [nvarchar](50) NULL,
	[D_C] [nvarchar](10) NULL,
	[TransactionTypeID] [nvarchar](10) NULL
)



