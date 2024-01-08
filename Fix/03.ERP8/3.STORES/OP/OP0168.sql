IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0168]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0168]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra trước khi lưu bảng giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 12/06/2017
/*-- <Example>
	OP0168 @DivisionID='TT',@UserID='ASOFTADMIN',@ID='B01',@InventoryList=NULL
----*/


CREATE PROCEDURE OP0168
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @ID VARCHAR(50),
  @InventoryList XML
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@TypeID TINYINT,
		@OID VARCHAR(50),
		@InventoryTypeID VARCHAR(50),
		@CurrencyID VARCHAR(50)

SELECT @FromDate = FromDate, @ToDate = ToDate, @TypeID = TypeID, @OID = OID, @InventoryTypeID = InventoryTypeID, @CurrencyID = CurrencyID
FROM OT1301 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND ID = @ID

SELECT X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID
INTO #Inventory_Temp
FROM @InventoryList.nodes('//Data') AS X (Data)

SET @sSQL = '
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX) = '''',
		@InventoryID VARCHAR(50),
		@FromDate_Cur DATETIME,
		@ToDate_Cur DATETIME
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT InventoryID, FromDate, ToDate FROM
(
	SELECT T1.InventoryID, T2.FromDate, T2.ToDate, MAX(T2.CreateDate) AS CreateDate FROM OT1302 T1 WITH (NOLOCK)
	INNER JOIN  OT1301 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.ID = T2.ID
	INNER JOIN #Inventory_Temp T3 WITH (NOLOCK) ON T1.InventoryID = T3.InventoryID
	WHERE T2.ID <> '''+@ID+''' AND T2.TypeID = '+STR(@TypeID)+'
	AND T2.OID IN ('''+@OID+''',''%'') AND T2.OID IN ('''+@InventoryTypeID+''',''%'') AND T2.CurrencyID = '''+@CurrencyID+'''
	GROUP BY T1.InventoryID, T2.FromDate, T2.ToDate
)Temp

OPEN @Cur
FETCH NEXT FROM @Cur INTO @InventoryID, @FromDate_Cur, @ToDate_Cur
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF EXISTS (SELECT TOP 1 1 WHERE '''+CONVERT(VARCHAR(50),@FromDate,120)+''' BETWEEN @FromDate_Cur AND @ToDate_Cur
								OR  '''+CONVERT(VARCHAR(50),@ToDate,120)+''' BETWEEN @FromDate_Cur AND @ToDate_Cur
								OR ('''+CONVERT(VARCHAR(50),@FromDate,120)+''' < @FromDate_Cur AND '''+CONVERT(VARCHAR(50),@ToDate,120)+''' > @ToDate_Cur)
			  )
	
		SET @Params1 = @Params1 + @InventoryID + '', ''
	FETCH NEXT FROM @Cur INTO @InventoryID, @FromDate_Cur, @ToDate_Cur
END 
Close @Cur

IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
SELECT * FROM
(
SELECT 2 AS Status,''OFML000270'' AS MessageID, @Params1 AS Params
)A WHERE A.Params <> '''' '

--PRINT @sSQL
EXEC (@sSQL)

DROP TABLE #Inventory_Temp

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
