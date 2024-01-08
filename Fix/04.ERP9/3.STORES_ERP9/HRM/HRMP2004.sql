IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In danh sách kế hoạch tuyển dụng tại HRF2000
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 20/07/2017
----Modified on 27/06/2023 by Võ Dương: Cập nhật màn hình lọc in theo ngày và kì
----Modified on 15/09/2023 by Thu Hà: Cập nhật in (chi phí hiện có "ActualCost") và bổ sung điều kiện in
-- <Example>
---- 
/*-- <Example>
	HRMP2004 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@RecruitPlanID=NULL,@DepartmentID=NULL,@DutyID='LD',@FromDate=NULL,@ToDate='2017-08-30',@IsCheckAll=1,@Status=0,@RecruitPlanList=NULL

	EXEC HRMP2004 @DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @RecruitPlanID, @DepartmentID, @DutyID,@FromDate,@ToDate,@Disabled,@IsCheckAll,@RecruitPlanList

----*/

CREATE PROCEDURE HRMP2004
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @CheckListPeriodControl VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @RecruitPlanID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Status TINYINT,
	 @IsCheckAll TINYINT,
	 @IsPeriod TINYINT,
	 @RecruitPlanList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@RecruitPlanListConvert NVARCHAR(MAX)=N''

SET @OrderBy = 'A.RecruitPlanID'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' A.DivisionID IN ('''+@DivisionList+''')'
ELSE 
BEGIN
	SET @sWhere = @sWhere + ' A.DivisionID = '''+@DivisionID+''' '
END
IF (@RecruitPlanList IS NOT NULL) 
BEGIN
	SELECT @RecruitPlanListConvert =  @RecruitPlanListConvert + ',''' + T.c.value('.', 'nvarchar(max)') + ''''
	FROM @RecruitPlanList.nodes('//RecruitPlanID') AS T(c)
	SET @RecruitPlanListConvert = STUFF(@RecruitPlanListConvert, 1, 1, '')
	SET @sWhere = @sWhere + '
	AND A.RecruitPlanID IN ('+@RecruitPlanListConvert+') '
END

IF  @IsSearch = 1
BEGIN

	IF (@DepartmentID IS NOT NULL) SET @sWhere = @sWhere + '
	AND A.DepartmentID LIKE N''%'+@DepartmentID+'%'' '
	IF (@DutyID IS NOT NULL) SET @sWhere = @sWhere + '
	AND B.DutyID LIKE ''%'+@DutyID+'%'' '
	--lọc theo ngày
	IF (@IsPeriod = 0)
	BEGIN
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
		BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE,A.FromDate,120), 120) >= '''+CONVERT(VARCHAR(10),@FromDate,120)+''' '
		END
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
		BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), CONVERT(DATE,A.ToDate,120), 120) <= '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
		END
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
		BEGIN
		SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE,A.FromDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' 
		AND CONVERT(VARCHAR(10), CONVERT(DATE,A.ToDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
		END
	END
	-- lọc theo kỳ
	IF (@IsPeriod = 1)
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(A.FromDate,A.ToDate), ''MM/yyyy'')) IN (''' + @CheckListPeriodControl + ''') '
	END 
END

SET @sSQL = @sSQL + N'
	SELECT 
		ROW_NUMBER() OVER (ORDER BY A.RecruitPlanID) AS RowNum,
		A.DivisionID,
		E.CostBoundary,
		SUM(A.TotalCost) AS ActualCost,
		--(SELECT SUM(TotalCost)  AS ActualCost FROM HRMT2000) AS ActualCost,
		H.DivisionName,
		A.RecruitPlanID, 
		F.DepartmentID, 
		F.DepartmentName, 
		A.FromDate, 
		A.ToDate, 
		A.TotalCost, 
		A.Description, 
		B.DutyID, 
		C.DutyName, 
		B.Quantity, 
		SUM(B.Quantity) AS ActualQuantity, 
		D.QuantityBoundary, 
		G.Description AS WorkTypeName, 
		B.WorkPlace, 
		B.RecruitCost, 
		B.RequireDate, 
		B.Note

	FROM HRMT2000 A
	LEFT JOIN HRMT2001 B ON A.RecruitPlanID = B.RecruitPlanID
	LEFT JOIN HT1102 C ON B.DutyID = C.DutyID
	LEFT JOIN HRMT1021 D ON C.DutyID = D.DutyID AND D.DepartmentID =A.DepartmentID
	LEFT JOIN HRMT1020 E ON D.BoundaryID = E.BoundaryID AND  D.DepartmentID = E.DepartmentID
	LEFT JOIN AT1102 F ON A.DepartmentID = F.DepartmentID
	LEFT JOIN HT0099 G ON B.WorkType = G.ID AND G.CodeMaster = ''WorkType''
	LEFT JOIN AT1101 H ON A.DivisionID = H.DivisionID
	WHERE '+@sWhere+'
	GROUP BY 
		A.DivisionID,
		E.CostBoundary,
		H.DivisionName,
		A.RecruitPlanID,
		F.DepartmentName,
		A.FromDate,
		A.ToDate,
		A.TotalCost,
		A.Description,
		B.DutyID,
		B.WorkPlace,
		B.Quantity,
		B.RecruitCost,
		B.RequireDate,
		B.Note,
		C.DutyName,
		F.DepartmentID,
		D.QuantityBoundary,
		G.Description
		ORDER BY '+@OrderBy
PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
