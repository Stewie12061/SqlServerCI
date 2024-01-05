IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2294]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2294]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load lưới 1: kế thừa phiếu xuất kho mã vạch (WMP2294)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Hồng Thắm, Date: 15/12/2023

-- <Example>
---- 
/*-- <Example>
	exec WMP2294 @DivisionID=N'HVH',@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@IsDate=0
	,@FromMonth=NULL,@FromYear=NULL,@ToMonth=NULL,@ToYear=NULL,@ObjectID=N'HOANMYCT',@APK=N'',@FromDate=NULL,@ToDate=NULL
----*/

CREATE PROCEDURE [dbo].[WMP2294]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsDate TINYINT, ---- 0: Radiobutton từ ngày có check
					  ---- 1: Radiobutton từ kỳ có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @ObjectID VARCHAR(50), 
	 @APK VARCHAR(50)  ----- Addnew truyền ''
)
AS 
	DECLARE @sSQL NVARCHAR(MAX) = N'', 
			@SWhere NVARCHAR(MAX) = N'',
			@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N'
BT1002.DivisionID = '''+@DivisionID+''''

IF ISNULL(@ObjectID,N'')<>N''
	SET @SWhere=@SWhere+' AND ISNULL(BT1002.ObjectID, '''') = '''+@ObjectID+''' '
 

IF @IsDate = 1 
	BEGIN
		SET @sWhere = @sWhere + N'
		AND BT1002.TranMonth + BT1002.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
	END
ELSE
	BEGIN
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, BT1002.VoucherDate, 120),'''') >= '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, BT1002.VoucherDate, 120),'''') <= '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+''''
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') SET @sWhere = @sWhere + N'
		AND ISNULL(CONVERT(VARCHAR, BT1002.VoucherDate, 120),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromDate, 120),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToDate, 120),'')+'''	'
	END 

IF @APK=''
BEGIN
	SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT DISTINCT BT1002.DivisionID, BT1002.VoucherNo, BT1002.ObjectID, AT1202.ObjectName,BT1002.RDAddress, BT1002.Description
						, BT1002.WareHouseID AS ExWareHouseID, AT1303.WareHouseName AS ExWareHouseName
		FROM BT1002 WITH (NOLOCK) 
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (BT1002.DivisionID, ''@@@'') AND BT1002.ObjectID = AT1202.ObjectID
		LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN (BT1002.DivisionID, ''@@@'') AND BT1002.WareHouseID = AT1303.WareHouseID
		WHERE '+@sWhere+'
		GROUP BY BT1002.DivisionID, BT1002.VoucherNo, BT1002.ObjectID, AT1202.ObjectName,BT1002.RDAddress, BT1002.Description,BT1002.WareHouseID,AT1303.WareHouseName
		
	)Temp 
	ORDER BY VoucherNo
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
	'
END

PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
