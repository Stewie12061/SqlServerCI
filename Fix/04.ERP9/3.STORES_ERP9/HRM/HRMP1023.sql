IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In danh sách Định biên tuyển dụng tại HRF1020
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy		Date: 20/07/2017
----Updated by : Thu Hà		Date: 13/07/2023 - Bổ sung DutyID,DutyName,Notes,QuantityBoundary để in phần detail 
----Updated by : Võ Dương	Date: 09/08/2023 - Cập nhật điều kiện lọc
-- <Example>
---- 
/*-- <Example>
	HRMP1023 @DivisionID='MK',@DivisionList=NULL,@UserID='ASOFTADMIN',@IsSearch=1,
	@BoundaryID=NULL,@DepartmentID=NULL,@DutyID='LD',@FromDate=NULL,@ToDate='2017-08-30',@Disabled=0,@IsCheckAll=1,@BoundaryList=NULL

	EXEC HRMP1023 @DivisionID,@UserID,@PageNumber,@PageSize,@IsSearch, @BoundaryID, @DepartmentID, @DutyID,@FromDate,@ToDate,@Disabled,@IsCheckAll,@BoundaryList

----*/

CREATE PROCEDURE HRMP1023
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @IsPeriod VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @BoundaryID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Disabled VARCHAR(1),
	 @IsCheckAll TINYINT,
	 @BoundaryList NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = ' HRMT1020.BoundaryID,HRMT1020.DepartmentID'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT1020.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT1020.DivisionID = '''+@DivisionID+''' '
IF @BoundaryList IS NOT NULL
SET @sWhere = @sWhere + ' AND HRMT1020.BoundaryID IN (''' + @BoundaryList +''') '

IF @IsSearch = 1
BEGIN
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT1020.DepartmentID LIKE N''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT1021.DutyID LIKE ''%'+@DutyID+'%'' '
	IF @Disabled IS NOT NULL SET @sWhere = @sWhere + N'
	AND HRMT1020.Disabled = '+@Disabled+''
--Lọc theo ngày
	IF (@IsPeriod = '0')
	BEGIN
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1020.CreateDate >= N''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''''
		END
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1020.CreateDate < N''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''''
		END
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
		BEGIN
		SET @sWhere = @sWhere + '
				AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT1020.CreateDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		END
	END	
	-- Lọc theo kỳ
	ELSE
	BEGIN
		IF(@PeriodList IS NOT NULL)
			BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT1020.CreateDate,HRMT1020.CreateDate), ''MM/yyyy'')) IN (''' + @PeriodList + ''') '
			END
	END

END

SET @sSQL = N'
SELECT HRMT1020.APK,
		HRMT1020.DivisionID,
		AT1101.DivisionName,
		HRMT1020.BoundaryID,
		HRMT1020.Description,
		HRMT1020.DepartmentID,
		HRMT1020.CostBoundary,
		AT1102.DepartmentName,
		B.DutyID,
		C.DutyName,
		B.Notes,
		FORMAT(B.QuantityBoundary, ''N0'') AS QuantityBoundary,
		HRMT1020.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1020.CreateUserID) CreateUserID,
		HRMT1020.CreateDate,
		HRMT1020.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1020.LastModifyUserID) LastModifyUserID,
		HRMT1020.LastModifyDate,
		HT0099.Description AS Disabled,
		HRMT1020.CostBoundary,
		HRMT1020.FromDate,
		HRMT1020.ToDate
FROM HRMT1020 WITH (NOLOCK)
LEFT JOIN HRMT1021 B ON HRMT1020.BoundaryID = B.BoundaryID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1020.DepartmentID = AT1102.DepartmentID
LEFT JOIN AT1101 WITH (NOLOCK) ON HRMT1020.DivisionID = AT1101.DivisionID
LEFT JOIN HT1102 C WITH (NOLOCK) ON B.DutyID = C.DutyID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT1020.Disabled = HT0099.ID AND HT0099.CodeMaster = ''Disabled'' '+@sJoin+'
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+''

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
