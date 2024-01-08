IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load danh sách đơn hàng 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Hoà Date 26/08/2020
-- Modify by Kiều Nga Date 26/01/2021 : Chuyển đk lọc từ kỳ đến kỳ sang chọn kỳ
-- <Example>

 CREATE PROCEDURE [dbo].[SOP30161] (
	 @DivisionID NVARCHAR(2000),
	 @DivisionIDList	NVARCHAR(MAX),
	 @TxtSearch NVARCHAR(250),
	 @IsDate INT, ---- 1: là ngày, 0: là kỳ
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList NVARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @TotalRow NVARCHAR(50)

	 SET @sWhere = ''
	 SET @TotalRow = ''

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = '  DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = '  DivisionID = N'''+@DivisionID+''''	

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + 'AND (VoucherNo LIKE N''%' + @TxtSearch + '%'')
							 OR ObjectName LIKE N''%'+@TxtSearch+'%''
							 OR ObjectID LIKE N''%'+@TxtSearch+'%'''

IF @IsDate = 1
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhere = @sWhere + ' AND ((CASE WHEN TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(TranMonth)))+''/''+ltrim(Rtrim(str(TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhere = @sWhere + ' AND (Convert(varchar(20),OrderDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END

SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,OrderID as SOrderID, *
		FROM OV1003 
        WHERE '+ @sWhere +'
        AND Type = ''PO'' AND OrderStatus IN (1, 2, 3)
        ORDER BY VoucherNo
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
