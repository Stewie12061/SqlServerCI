IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2104]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master cho màn hình POF2103 - kế thừa tiến độ nhận hàng
-- <History>
---- Create on 21/09/2023 by Lê Thanh Lượng 
-- <Example>
/*
POP2104 @DivisionID = 'PANGLOBE', @FromMonth = 11, @FromYear = 2023, @ToMonth = 11, @ToYear = 2023, 
       @FromDate = '2023-11-02 14:39:51.283', @ToDate = '2023-12-02 14:39:51.283', @IsDate = 0, 
       @ObjectID = '%', @SOVoucherID = 'TV20140000000002'  
 */
 
CREATE PROCEDURE [dbo].[POP2104]	
	@DivisionID NVARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsDate TINYINT, -- = 1: search theo ngày
	@ObjectID NVARCHAR(50),
	@POrderID NVARCHAR(50) = '',
	@Mode INT = 0,
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@UserID varchar(50)='',
	@ScreenID nvarchar(50)='',
	@VoucherNo nvarchar(50)=''
AS
DECLARE @sSQL1 NVARCHAR(MAX),
        @sWHERE NVARCHAR(MAX),
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
		
SET @POrderID = ISNULL(@POrderID,'')
SET @sWHERE = ''
	IF @ObjectID IS NOT NULL AND @ObjectID != ''
	SET @sWHERE = @sWHERE + 'AND ISNULL(O1.ObjectID,'''') LIKE '''+@ObjectID+''' '

		IF ISNULL(@POrderID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(O2.VoucherNo, '''') = N''%'+@POrderID+'%'' '
	IF LTRIM(STR(@IsDate)) = 1	SET @sWHERE = @sWHERE + '
	  AND CONVERT(VARCHAR(10),O1.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	IF LTRIM(STR(@IsDate)) = 0	SET @sWHERE = @sWHERE + '
	  AND (YEAR(O1.VoucherDate)*12 + Month(O1.VoucherDate)) BETWEEN '+LTRIM(STR(@FromYear*12 + @FromMonth))+' AND '+LTRIM(STR(@ToYear*12 + @ToMonth))+' '

		SET @sSQL1 = '
			SELECT ROW_NUMBER() OVER (ORDER BY P.VoucherNo ) AS RowNum, '+@TotalRow+' AS TotalRow,* 
	FROM(
	SELECT  
				   O1.APK
				  , O1.DivisionID
				  , O1.VoucherNo
				  , O1.VoucherDate
				  , O1.ObjectID
				  , A2.ObjectName
				  , O2.VoucherNo AS POrderID
				  , O1.CreateDate
			FROM OT3003 O1 WITH (NOLOCK)
				LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.ObjectID = O1.ObjectID
				LEFT JOIN OT3001 O2 WITH (NOLOCK) ON O2.POrderID = O1.POrderID
				WHERE O1.DivisionID = '''+@DivisionID+''' 
				'+ @sWhere +') as P'
IF @Mode = 1
BEGIN
	SET @sSQL1 = @sSQL1+'
	ORDER BY P.CreateDate
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
EXEC (@sSQL1)
PRINT (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
