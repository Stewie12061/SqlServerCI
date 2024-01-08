IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2070]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRF2070: Danh mục kế hoạch đào tạo định kỳ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 15/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 29/08/2023 by Thu Hà: Bổ sung trường lọc AssignedToUserName(người phụ trách)
----Modified on 06/09/2023 by Thu Hà:   Cập nhật sắp xếp giảm dần theo mã kế hoạch đào tạo định kỳ
----Update  by: Minh Trí, Date: 17/10/2023 -[2023/10/IS/0013] Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
---- 
/*-- <Example>
	HRMP2070 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@TrainingPlanID=NULL,@FromDate='01-01-2016',@ToDate='01-01-2017'
----*/

CREATE PROCEDURE [dbo].[HRMP2070]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @TrainingPlanID NVARCHAR(500),
	 @AssignedToUserName NVARCHAR(500),
	--@IsConfirmName NVARCHAR(500),
	 @PeriodList VARCHAR(MAX),
	 @IsPeriod TINYINT,
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ConditionTrainingPlanID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'TrainingPlanID DESC,CreateDate',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	
       
    
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	HRMT2070.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
ELSE 
	SET @sWhere = '
	HRMT2070.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@TrainingPlanID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2070.TrainingPlanID LIKE N''%' + @TrainingPlanID + '%'''		
	END

		IF ISNULL(@AssignedToUserName,'') <> ''
		BEGIN
			SET @sWhere = @sWhere + '
			AND AT1103.FullName LIKE N''%'+@AssignedToUserName+'%'''
		END

	--IF ISNULL(@IsConfirmName,'') <> ''
	--BEGIN
	--	SET @sWhere = @sWhere + '
	--	AND HRMT2070.IsConfirmName LIKE N''%' + @IsConfirmName + '%'''		
	--END
	
	--Lọc theo ngày
	IF (@IsPeriod = '0')
	BEGIN
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2070.CreateDate >= N''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''''
		END
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
		BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2070.CreateDate < N''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''''
		END
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL)
		BEGIN
		SET @sWhere = @sWhere + '
				AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2070.CreateDate,120), 120) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,120)+''''
		END
	END
	-- Lọc theo kỳ
	ELSE
	BEGIN
SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT2070.CreateDate,HRMT2070.CreateDate), ''MM/yyyy'')) IN (''' + @PeriodList + ''') '
	END
END
IF Isnull(@ConditionTrainingPlanID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2070.CreateUserID,'''') in (N'''+@ConditionTrainingPlanID+''' )'
--Bổ sung điều kiện cờ xóa = 0
SET @sWhere = @sWhere + ' AND ISNULL(HRMT2070.DeleteFlg,0) = 0 '
SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
FROM
(
	SELECT HRMT2070.APK, HRMT2070.DivisionID, 
	HRMT2070.TrainingPlanID, HRMT2070.AssignedToUserID, AT1103.FullName AS AssignedToUserName, N''Đã duyệt'' AS IsConfirmName,
	HRMT2070.CreateUserID, HRMT2070.CreateDate, HRMT2070.LastModifyUserID, HRMT2070.LastModifyDate
	FROM HRMT2070 WITH (NOLOCK)
	LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2070.AssignedToUserID = AT1103.EmployeeID AND AT1103.DivisionID IN ('''+@DivisionID+''', ''@@@'')


	WHERE '+@sWhere +'
) A 	
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
