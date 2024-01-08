IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2310]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2310]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục WMF2310 Phiếu tháo dỡ 
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hồng Thắm, Date: 13/11/2023
-- <Example>
/*
EXEC [WMP2310]
	@DivisionID = N'GREE-SI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/
create    PROCEDURE [dbo].[WMP2310]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX) = '',
	 @VoucherNo varchar(max),
	 @ObjectID varchar(max),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsPeriod TINYINT = 0,
	 @PeriodList VARCHAR (100) = '',
	 @VoucherTypeID VARCHAR(MAX),
	 @ImWareHouseID VARCHAR(MAX),
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @sWhere NVARCHAR(4000)='',
	 @Mode int
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = '',
	    @sSQL1 NVARCHAR(MAX) = '',
	    @sSQL2 NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500) = N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)


        
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'
SET @OrderBy = 'A1.VoucherID'


SET @sWhere = @sWhere + ' 1 = 1 AND A1.Type = 1 '

IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') <> '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
IF ISNULL(@DivisionList,'') <> '' SET @sWhere = @sWhere + '
	AND A1.DivisionID IN ('''+ @DivisionList +''')'	
ELSE 
	SET @sWhere = @sWhere + 'AND A1.DivisionID = '''+@DivisionID +''''	
IF ISNULL(@VoucherNo,'') <> '' SET @sWhere = @sWhere + '
	AND A1.VoucherNo LIKE ''%'+@VoucherNo+'%'' '	
IF ISNULL(@ObjectID,'') <> '' SET @sWhere = @sWhere + '
	AND A1.ObjectID LIKE ''%'+@ObjectID+'%'' '
IF ISNULL(@VoucherTypeID,'') <> '' SET @sWhere = @sWhere + '
	AND A1.VoucherTypeID LIKE ''%'+@VoucherTypeID+'%'' '
IF ISNULL(@ImWareHouseID,'') <> '' SET @sWhere = @sWhere + '
	AND A4.ImWareHouseID LIKE ''%'+@ImWareHouseID+'%'' '

BEGIN
SET @sSQL = @sSQL + N'
			SELECT COUNT(*) OVER() AS TotalRow, ROW_NUMBER() OVER (ORDER BY A1.VoucherID) AS RowNum, MAX(A1.APK) APK, A1.DivisionID, A1.VoucherTypeID, A1.VoucherNo, A1.VoucherDate, A1.Description, A1.ObjectID, A2.ObjectName,
			A1.EmployeeID, A3.FullName as EmployeeName , (Select top 1 ImWareHouseID from AT0113 where A1.VoucherID = AT0113.VoucherID) as ImWareHouseName
			FROM AT0112 A1 WITH (NOLOCK)
			LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A1.ObjectID = A2.ObjectID AND A2.DivisionID IN (A1.DivisionID,''@@@'')
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A1.EmployeeID = A3.EmployeeID AND A3.DivisionID IN (A1.DivisionID,''@@@'')
			LEFT JOIN AT0113 A4 WITH (NOLOCK) ON A1.VoucherID = A4.VoucherID AND A4.DivisionID IN (A1.DivisionID,''@@@'')
			WHERE '+@sWhere +'
			GROUP BY   A1.VoucherID, A1.DivisionID, A1.VoucherTypeID, A1.VoucherNo, A1.VoucherDate, A1.Description, A1.ObjectID, A2.ObjectName,A3.FullName,A1.EmployeeID
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

