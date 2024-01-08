-- <Summary>
---- 
-- <History>
---- Create on 23/05/2013 by Bảo Quỳnh
---- Modified on 24/01/2021 by Nhựt Trường: Bổ sung kiểm tra tồn tại zTypeOfAV4202.
---- Modified on 27/01/2022 by Văn Tài	  : Bổ sung xử lý drop store để không ảnh hưởng quá trình tái tạo Type mới.
---- <Example>
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4202' AND ss.name = N'dbo')
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
	[TransactionTypeID] [nvarchar](50) NULL,
	[AnaID] [nvarchar](50) NULL
)


---->>> Modified by Tiểu Mai on 15/09/2017: Bổ sung trường AnaID
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'zTypeOfAV4202' AND ss.name = N'dbo')
BEGIN

	EXEC sys.sp_rename 'dbo.TypeOfAV4202', 'zTypeOfAV4202';
END
GO

DECLARE @DeleteName NVARCHAR(776);

DECLARE DEL_CURSOR CURSOR FOR
SELECT referencing_schema_name + '.' + referencing_entity_name
FROM sys.dm_sql_referencing_entities('dbo.TypeOfAV4202', 'TYPE');

OPEN DEL_CURSOR;


FETCH NEXT FROM DEL_CURSOR INTO @DeleteName;
WHILE (@@FETCH_STATUS = 0)
BEGIN
	print (@DeleteName)
	IF EXISTS (Select * from sysobjects where type = 'P' and category = 0 and CONCAT('dbo.', [Name]) = @DeleteName)
	BEGIN
		SET @DeleteName =  CONCAT('DROP PROCEDURE ', @DeleteName)
		PRINT (@DeleteName)
		EXEC (@DeleteName);  
	END
    FETCH NEXT FROM DEL_CURSOR INTO @DeleteName;
END;

CLOSE DEL_CURSOR;
DEALLOCATE DEL_CURSOR;

GO



IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4202' AND ss.name = N'dbo')
BEGIN
	print ('CREATED')
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
		[TransactionTypeID] [nvarchar](50) NULL,
		[AnaID] [nvarchar](50) NULL
	)
END
ELSE
BEGIN
	DROP TYPE dbo.TypeOfAV4202;

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
		[TransactionTypeID] [nvarchar](50) NULL,
		[AnaID] [nvarchar](50) NULL
	)
END

GO

DECLARE @Name NVARCHAR(776);

DECLARE REF_CURSOR CURSOR FOR
SELECT referencing_schema_name + '.' + referencing_entity_name
FROM sys.dm_sql_referencing_entities('dbo.TypeOfAV4202', 'TYPE');

OPEN REF_CURSOR;

FETCH NEXT FROM REF_CURSOR INTO @Name;
WHILE (@@FETCH_STATUS = 0)
BEGIN
	print (@Name)
	EXEC sys.sp_refreshsqlmodule @name = @Name;	

    FETCH NEXT FROM REF_CURSOR INTO @Name;
END;

CLOSE REF_CURSOR;
DEALLOCATE REF_CURSOR;
GO

IF EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'zTypeOfAV4202' AND ss.name = N'dbo')
	DROP TYPE dbo.zTypeOfAV4202;
GO
------<<< Modified by Tiểu Mai on 15/09/2017: Bổ sung trường AnaID
