IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2280]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2280]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục WMF2280 Nhập kho seri
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hồng Thắm, Date: 30/10/2023
-- <Example>
/*
EXEC [WMP2280]
	@DivisionID = N'GREE-SI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/


create   PROCEDURE [dbo].[WMP2280]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX) = '',
	 @VoucherNo varchar(max),
	 @ObjectID varchar(max),
	 @PageNumber INT,
	 @PageSize INT,
	 @SearchWhere TINYINT,
	 @IsPeriod TINYINT = 0,
	 @PeriodList VARCHAR (100) = '',
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'
SET @OrderBy = 'VoucherNo'


SET @sWhere = @sWhere + ' 1 = 1 AND BT1002.KindVoucherID = 1 '

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
	AND DivisionID IN ('''+ @DivisionList +''')'	
ELSE 
	SET @sWhere = @sWhere + 'AND DivisionID = '''+@DivisionID +''''	
IF ISNULL(@VoucherNo,'') <> '' SET @sWhere = @sWhere + '
	AND VoucherNo LIKE ''%'+@VoucherNo+'%'' '	
IF ISNULL(@ObjectID,'') <> '' SET @sWhere = @sWhere + '
	AND ObjectID LIKE ''%'+@ObjectID+'%'' '

BEGIN
SET @sSQL = @sSQL + N'
			SELECT COUNT(*) OVER() AS TotalRow, ROW_NUMBER() OVER (ORDER BY BT1002.VoucherNo) AS RowNum, MAX(BT1002.APK) APK, DivisionID, VoucherNo , VoucherTypeID,VoucherID, ObjectID,VoucherDate,WareHouseID,Description     
			FROM BT1002 WITH (NOLOCK)  
			WHERE '+@sWhere +'
			GROUP BY DivisionID, VoucherNo , VoucherTypeID,VoucherID,ObjectID,VoucherDate,WareHouseID,Description
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

