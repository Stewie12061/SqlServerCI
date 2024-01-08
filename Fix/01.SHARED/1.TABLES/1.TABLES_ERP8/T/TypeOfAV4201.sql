-- <Summary>
---- 
-- <History>
---- Create on 23/05/2013 by Bảo Quỳnh
---- Modified on 24/01/2021 by Nhựt Trường: Bổ sung kiểm tra tồn tại zTypeOfAV4201.
---- Modified on 27/01/2022 by Văn Tài	  : Bổ sung xử lý drop store để không ảnh hưởng quá trình tái tạo Type mới.
---- <Example>
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4201' AND ss.name = N'dbo')
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

---->>> Modified by Tiểu Mai on 15/09/2017: Bổ sung trường AnaID
IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'zTypeOfAV4201' AND ss.name = N'dbo')
	EXEC sys.sp_rename 'dbo.TypeOfAV4201', 'zTypeOfAV4201';
GO

DECLARE @DeleteName NVARCHAR(776);

DECLARE DEL_CURSOR CURSOR FOR
SELECT referencing_schema_name + '.' + referencing_entity_name
FROM sys.dm_sql_referencing_entities('dbo.TypeOfAV4201', 'TYPE');

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


IF  NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TypeOfAV4201' AND ss.name = N'dbo')
BEGIN
	CREATE TYPE [dbo].[TypeOfAV4201] AS TABLE(
		[DivisionID] [nvarchar](50) NULL,
		[AccountID] [nvarchar](50) NULL,
		[ConvertedAmount] [decimal](28, 8) NULL,
		[TranMonth] [int] NULL,
		[TranYear] [int] NULL,
		[CorAccountID] [nvarchar](50) NULL,
		[D_C] [nvarchar](10) NULL,
		[TransactionTypeID] [nvarchar](10) NULL,
		[AnaID] [nvarchar](50) NULL
	)
END
ELSE
BEGIN
	DROP TYPE dbo.TypeOfAV4201;
	CREATE TYPE [dbo].[TypeOfAV4201] AS TABLE(
		[DivisionID] [nvarchar](50) NULL,
		[AccountID] [nvarchar](50) NULL,
		[ConvertedAmount] [decimal](28, 8) NULL,
		[TranMonth] [int] NULL,
		[TranYear] [int] NULL,
		[CorAccountID] [nvarchar](50) NULL,
		[D_C] [nvarchar](10) NULL,
		[TransactionTypeID] [nvarchar](10) NULL,
		[AnaID] [nvarchar](50) NULL
	)
END

DECLARE @Name NVARCHAR(776);

DECLARE REF_CURSOR CURSOR FOR
SELECT referencing_schema_name + '.' + referencing_entity_name
FROM sys.dm_sql_referencing_entities('dbo.TypeOfAV4201', 'TYPE');

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
DROP TYPE dbo.zTypeOfAV4201;
GO

------<<< Modified by Tiểu Mai on 15/09/2017: Bổ sung trường AnaID



