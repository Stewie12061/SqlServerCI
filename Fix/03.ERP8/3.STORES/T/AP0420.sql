IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0420]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0420]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xử lý Import khoản thu lô đất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 05/04/2022 By Kiều Nga 
---- Update on 17/01/2023 By Kiều Nga  Bổ sinh tự động voucherno 
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP0420]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@sSQL1 AS VARCHAR(1000),
		@sSQL2 AS VARCHAR(MAX)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)

		
--IF OBJECT_ID('tempdb..XMLData') IS NOT NULL 
--DROP TABLE XMLData
--- SELECT * FROM XMLData

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLData]') AND type in (N'U'))
	CREATE TABLE XMLData (XMLCol XML)

INSERT INTO XMLData VALUES (@XML)	


CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,	
	ImportMessage NVARCHAR(500) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @sSQL2 = '
DECLARE @XML XML
SELECT @XML = XMLCol FROM XMLData

SELECT X.Data.query(''Row'').value(''.'', ''INT'') AS Row,
		X.Data.query(''ImportMessage'').value(''.'', ''NVARCHAR(50)'') AS ImportMessage,
         '

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A01066 TLD
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm 
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)

	SET @sSQL2 = @sSQL2 + '
	X.Data.query('''  + @ColID + ''').value(''.'', ''' + @ColSQLDataType + ''') AS ' + @ColID + ','            
				 
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END



IF OBJECT_ID('tempdb..##AP0420') IS NOT NULL 
DROP TABLE ##AP0420
	

SET @sSQL2 = LEFT(@sSQL2,LEN(@sSQL2) - 1)
SET @sSQL2 = @sSQL2 + '
INTO    ##AP0420	
FROM	@XML.nodes(''//Data'') AS X (Data)

--SELECT * FROM ##AP0420

'
PRINT @sSQL2
EXEC(@sSQL2)


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLData]') AND type in (N'U'))
DROP TABLE XMLData

INSERT INTO #Data 
SELECT NEWID() AS APK, * FROM ##AP0420

------ Kiểm tra check code mặc định 
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---------- N?u có l?i thì không d?y d? li?u vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

--------------INSERT THÀNH DÒNG  
DECLARE 
		@Cur CURSOR, 
		@CostTypeID VARCHAR(50),
        @CostTypeName NVARCHAR(max),
		@query nvarchar(max) = '',
		@CurTemp CURSOR,
		@ContractNo VARCHAR(50),
		@ObjectID VARCHAR(50),
		@Period VARCHAR(50),
		@ContractID NVARCHAR(50),
		@Description NVARCHAR(250),
		@DatePeriod  AS DATE,
		@APK AS UNIQUEIDENTIFIER

SET @CurTemp  = CURSOR SCROLL KEYSET FOR
SELECT DISTINCT #Data.ContractNo,#Data.ObjectID ,#Data.Period FROM #Data 
OPEN @curTemp

FETCH NEXT FROM @CurTemp INTO  @ContractNo, @ObjectID,@Period
WHILE @@Fetch_Status = 0
BEGIN

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT ID as CostTypeID,Description as CostTypeName 
	FROM AT0099 WITH (NOLOCK)
	WHERE CodeMaster = 'CostTypeID' AND Disabled =0

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO  @CostTypeID,@CostTypeName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF(@CostTypeID <>'PQL')
		BEGIN
			--- Sinh số chứng từ tự động
			DECLARE @StringKey1 NVARCHAR(50) = LEFT(@Period, 2)
			DECLARE @StringKey2 NVARCHAR(50) =  RIGHT(@Period, 4)
			DECLARE @TableName VARCHAR(50) = (CASE WHEN @CostTypeID = 'DIEN' THEN 'AF0423PI03Report'  
												  WHEN @CostTypeID = 'NUOC' THEN 'AF0423PI04Report'  
												  WHEN @CostTypeID = 'XLNTHAI' THEN 'AF0423PI02Report' END)

			DECLARE @Text VARCHAR(50) =(CASE WHEN @CostTypeID = 'DIEN' THEN 'TD'  
										WHEN @CostTypeID = 'NUOC' THEN 'TN'  
										WHEN @CostTypeID = 'XLNTHAI' THEN 'NXT' END) +'-'

			SET @Description = @CostTypeName + ' ' + @Period
			SET @Query =
			' 
			IF NOT EXISTS (SELECT TOP 1 1 FROM AT0420 T1
						INNER JOIN #Data T2 ON T1.DivisionID = T2.DivisionID AND T1.ContractNo = T2.ContractNo AND T1.CostTypeID = '''+@CostTypeID+'''
						AND T1.TranMonth =LEFT(T2.Period, 2) AND T1.TranYear = RIGHT(Period, 4))
			BEGIN
				--- Sinh số chứng từ tự động
				DECLARE @VoucherNo VARCHAR(50) =''''
				EXEC AP0000 '''+@DivisionID+''',@VoucherNo Output, '''+@TableName+''', '''+@StringKey1+''', '''+@StringKey2+''', '''', 12,0,1,''/''
				SET @VoucherNo ='''+@Text+''' +@VoucherNo

				INSERT INTO AT0420 (DivisionID,VoucherNo,ObjectID,ContractNo,CostTypeID,FromValue,ToValue,Quantity,TranMonth,TranYear,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,Description)
				SELECT #Data.DivisionID,@VoucherNo,#Data.ObjectID,#Data.ContractNo,'''+@CostTypeID+''' as CostTypeID,#Data.'+@CostTypeID+'01,#Data.'+@CostTypeID+'02,
				#Data.'+@CostTypeID+'02 - #Data.'+@CostTypeID+'01,LEFT(Period, 2),RIGHT(Period, 4),'''+@UserID+''',GETDATE(),'''+@UserID+''',GETDATE(),N'''+@Description+'''
				FROM #Data 
				WHERE ContractNo = '''+@ContractNo+''' AND ObjectID = '''+@ObjectID+''' 
			END
			'		
			 --PRINT (@query)
			 exec(@query)
		END
	FETCH NEXT FROM @Cur INTO @CostTypeID,@CostTypeName 
	END
	Close @Cur
	DEALLOCATE @Cur

FETCH NEXT FROM @curTemp INTO @ContractNo, @ObjectID,@Period
END            
CLOSE @curTemp
DEALLOCATE @curTemp

LB_RESULT:
SELECT * FROM  #Data 


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
