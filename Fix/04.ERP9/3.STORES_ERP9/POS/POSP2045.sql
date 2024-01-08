IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2045]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2045]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load danh sách chốt ca bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 16/10/2018
-- <Example>
---- 
/*-- <Example>
	POSP2045 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ShiftID = '', 
	@EmployeeID1 = '',@SysAmount='', @ShopID=''
	
----*/

CREATE PROCEDURE POSP2045
(    
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsPeriod TINYINT, -- 1:Datetime; 0:Period
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodIDList NVARCHAR(MAX),
	 @ShiftID VARCHAR(50),
	 @EmployeeID1 NVARCHAR(250),
	 @ShopID NVARCHAR(50),
	 @SysAmount decimal 
	)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        SET @OrderBy = 'P33.ShiftID'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' P33.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + ' P33.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@ShiftID,'') <> '' SET @sWhere = @sWhere + '	AND P33.ShiftID LIKE N''%'+@ShiftID+'%'' '	
IF ISNULL(@EmployeeID1,'') <> '' SET @sWhere = @sWhere + 'AND P33.EmployeeID1 LIKE N''%'+@EmployeeID1+'%'' '
IF @SysAmount is not null SET @sWhere = @sWhere + '	AND P33.SystemAmount = '+ str(@SysAmount) +''	

IF @IsPeriod = 0
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),P33.ShiftDate,112) BETWEEN ' + CONVERT(VARCHAR(10), @FromDate, 112) + ' AND ' + CONVERT(VARCHAR(10), @ToDate, 112) + ' '
ELSE IF @IsPeriod = 1
	SET @sWhere = @sWhere + ' AND (CASE WHEN MONTH(P33.ShiftDate) < 10 THEN ''0'' + RTRIM(LTRIM(STR(MONTH(P33.ShiftDate)))) + ''/'' + LTRIM(RTRIM(STR(YEAR(P33.ShiftDate)))) 
		ELSE RTRIM(LTRIM(STR(MONTH(P33.ShiftDate))))+''/'' + LTRIM(RTRIM(STR(YEAR(P33.ShiftDate)))) END) IN (''' + @PeriodIDList + ''')'
	
SET @sSQL = @sSQL + N'
SELECT distinct  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
P33.DivisionID, P33.APK, N'' Ca ''+ P33.ShiftID +N'' ngày  ''+CONVERT(VARCHAR,P33.ShiftDate,103) as  ShipID,
P33.EmployeeID1, P33.ShopID, P33.ShiftID, P33.InvoiceNumber, P33.ShiftDate ,P33.SystemAmount as SysAmount
 from POST2033 P33 WITH (NOLOCK) inner join POST2034 P34 WITH (NOLOCK) ON P33.DivisionID=P34.DivisionID and P33.ShopID=P34.ShopID and P33.ShiftID=P34.ShiftID
    
WHERE '+@sWhere +' and P33.IsLockShift=1
group by P33.ShiftID,P33.DivisionID, P33.APK,P33.EmployeeID1, P33.ShopID, P33.ShiftID, P33.InvoiceNumber, P33.ShiftDate ,P33.SystemAmount
ORDER BY '+@OrderBy+' 
	
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
PRINT(@sSQL)



 








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
