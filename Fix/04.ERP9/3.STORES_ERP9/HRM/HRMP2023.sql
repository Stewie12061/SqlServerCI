IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRMF2023: Chọn Kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 20/07/2017
----Created by: Huỳnh Thử, Date: 30/11/2020 -- Load kế hoạch tuyển dụng đã được duyệt
----Created by: Phương Thảo, Date: 21/09/2023 --Bổ sung điều kiện load KHTD chưa bị xóa (ISNULL(HRMT2000.DeleteFlg,0) = 0)
----                                          -- Điều chỉnh lấy thêm DepartmentID và DutyID
-- <Example>
---- 
/*-- <Example>
	HRMP2023 @DivisionID='%',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25, @DepartmentID=NULL,@DutyID=NULL

	@DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate, @Status
----*/

CREATE PROCEDURE HRMP2023
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50), 
	 @TxtSearch VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL1 NVARCHAR (MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'', 
		@sWhere NVARCHAR(MAX) = N''

SET @OrderBy = '#HRMF2023.DepartmentID, #HRMF2023.RecruitPlanID, #HRMF2023.DutyID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = @sWhere + N' HRMT2000.DivisionID = '''+@DivisionID+''' AND HRMT2000.Status = 1 AND ISNULL(HRMT2000.DeleteFlg,0) = 0 -- Do chưa có duyệt
'

IF ISNULL(@DepartmentID, '') <> '' SET @sWhere = @sWhere + N'
AND HRMT2000.DepartmentID = '''+@DepartmentID+''''
IF ISNULL(@DutyID, '') <> '' SET @sWhere = @sWhere + N'
AND HRMT2001.DutyID = '''+@DutyID+''''
IF ISNULL(@TxtSearch, '') <> '' SET @sWhere = @sWhere + N'
AND ISNULL(HRMT2000.RecruitPlanID, ''%'') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HRMT2001.Description, ''%'') LIKE ''%'+@TxtSearch+'%''
OR ISNULL(HRMT2000.DepartmentID, ''%'') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HRMT2001.DutyID, ''%'') LIKE ''%'+@TxtSearch+'%''
OR ISNULL(HRMT2000.FromDate, ''%'') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(HRMT2001.ToDate, ''%'') LIKE ''%'+@TxtSearch+'%'''

SET @sSQL = N'
SELECT HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID, HRMT2000.Description, HRMT2000.DepartmentID, AT1102.DepartmentName, HRMT2001.DutyID,
HRMT2000.FromDate, HRMT2000.ToDate
INTO #HRMF2023
FROM HRMT2000 WITH (NOLOCK)
LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND Convert(Varchar(50),HRMT2000.APK) = HRMT2001.RecruitPlanID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2000.DepartmentID = AT1102.DepartmentID
WHERE '+@sWhere+'

----Lấy thông tin chi phí và số lượng của KHTD trong danh sách
SELECT T3.DivisionID, T3.RecruitPlanID, T1.DepartmentID, T2.DutyID, SUM(T2.RecruitCost) AS Cost_KHTD, SUM(T2.Quantity) AS Quantity_KHTD
INTO #Temp_KHTD_HRMF2023
FROM HRMT2000 T1 WITH (NOLOCK)
LEFT JOIN HRMT2001 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND Convert(Varchar(50),T1.APK) = T2.RecruitPlanID
INNER JOIN #HRMF2023 T3 ON T1.DivisionID = T3.DivisionID AND T1.RecruitPlanID = T3.RecruitPlanID AND T1.DepartmentID = T3.DepartmentID AND T2.DutyID = T3.DutyID
AND (T3.FromDate Between T1.FromDate and T1.ToDate
	OR T3.ToDate Between T1.FromDate and T1.ToDate
	OR (T3.FromDate <= T1.FromDate AND T3.ToDate >= T1.ToDate))
GROUP BY T3.DivisionID, T3.RecruitPlanID, T1.DepartmentID, T2.DutyID

----Lấy thông tin chi phí và số lượng của DTD kế thừa KHTD trong danh sách
SELECT T2.DivisionID, T2.RecruitPlanID, T1.DepartmentID, T1.DutyID, SUM(T1.Cost) AS Cost_DTD, SUM(T1.RecruitQuantity) AS Quantity_DTD
INTO #Temp_DTD_HRMF2023
FROM HRMT2020 T1 WITH (NOLOCK)
INNER JOIN #HRMF2023 T2 ON T1.DivisionID = T2.DivisionID AND T1.DepartmentID = T2.DepartmentID AND T1.DutyID = T2.DutyID
AND (T2.FromDate Between T1.PeriodFromDate and T1.PeriodToDate
	OR T2.ToDate Between T1.PeriodFromDate and T1.PeriodToDate
	OR (T2.FromDate <= T1.PeriodFromDate AND T2.ToDate >= T1.PeriodToDate))
GROUP BY T2.DivisionID, T2.RecruitPlanID, T1.DepartmentID, T1.DutyID
'

SET @sSQL1 = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, #HRMF2023.DivisionID, #HRMF2023.RecruitPlanID, #HRMF2023.Description,
#HRMF2023.DepartmentName AS DepartmentName,#HRMF2023.DepartmentID AS DepartmentID, HT1102.DutyName AS DutyName, #HRMF2023.DutyID AS DutyID, #HRMF2023.FromDate, #HRMF2023.ToDate
FROM #HRMF2023
INNER JOIN #Temp_KHTD_HRMF2023 T1 ON T1.DivisionID = #HRMF2023.DivisionID AND T1.RecruitPlanID = #HRMF2023.RecruitPlanID 
			AND T1.DepartmentID = #HRMF2023.DepartmentID AND T1.DutyID = #HRMF2023.DutyID
LEFT JOIN #Temp_DTD_HRMF2023 T2 ON T2.DivisionID = #HRMF2023.DivisionID AND T2.RecruitPlanID = #HRMF2023.RecruitPlanID 
			AND T2.DepartmentID = #HRMF2023.DepartmentID AND T2.DutyID = #HRMF2023.DutyID
LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = #HRMF2023.DivisionID AND HT1102.DutyID = #HRMF2023.DutyID 
WHERE ISNULL(T1.Cost_KHTD,0) - ISNULL(T2.Cost_DTD, 0) > 0
AND ISNULL(T1.Quantity_KHTD, 0) - ISNULL(T2.Quantity_DTD, 0) > 0
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

DROP TABLE #HRMF2023
DROP TABLE #Temp_KHTD_HRMF2023
DROP TABLE #Temp_DTD_HRMF2023
'
PRINT(@sSQL)
PRINT(@sSQL1)

EXEC (@sSQL + @sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
