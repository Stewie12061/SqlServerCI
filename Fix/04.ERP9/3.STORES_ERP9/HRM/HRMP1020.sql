IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRF1020: Định biên tuyển dụng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Bảo Thy, Date: 20/07/2017
----Update  by: Thu  Hà, Date: 23/06/2023 - Bổ sung lọc theo kỳ
----Update  by: Thu Hà,  Date: 06/09/2023 - Cập nhật sắp xếp giảm dần theo mã định biên tuyển dụng
----Update  by: Thanh Hải,  Date: 13/10/2023 - Cập nhật load dữ liệu những dòng có cột DeleteFlg = 0
-- <Example>
/*-- <Example>
	HRMP1020 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@BoundaryID=NULL,@DepartmentID=NULL,@DutyID='LD',@FromDate=NULL,@ToDate='2017-08-30',@Disabled=0
----*/

CREATE PROCEDURE [dbo].[HRMP1020]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @FromDate DATETIME ,
	 @ToDate DATETIME ,
	 @IsSearch INT = 0,
	 @PeriodList VARCHAR(MAX) ='',
	 @BoundaryID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Disabled VARCHAR(1)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
        @TotalRow NVARCHAR(50)=N''

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)

SET @OrderBy = 'HRMT1020.BoundaryID DESC'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') != ''
	SET @sWhere = @sWhere + ' AND HRMT1020.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND HRMT1020.DivisionID = '''+@DivisionID+''' '

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1020.FromDate >= ''' + @FromDateText + '''
											OR HRMT1020.FromDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1020.ToDate <= ''' + @ToDateText + ''' 
											OR HRMT1020.ToDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1020.FromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END

IF  @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT1020.FromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
END

	IF ISNULL(@BoundaryID,'') != '' 
	SET @sWhere = @sWhere + 'AND HRMT1020.BoundaryID LIKE ''%'+@BoundaryID+'%'' '

	IF ISNULL(@DepartmentID,'')!= ''
	SET @sWhere = @sWhere + 'AND HRMT1020.DepartmentID LIKE N''%'+@DepartmentID+'%'' '
	
	IF ISNULL(@DutyID,'') != '' 
	BEGIN
		SET @sWhere = @sWhere + 'AND HRMT1021.DutyID LIKE ''%'+@DutyID+'%'' '
		SET @sJoin = '
	LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND HRMT1020.BoundaryID = HRMT1021.BoundaryID AND HRMT1020.DepartmentID = HRMT1021.DepartmentID'
	END

	IF ISNULL(@Disabled,'')!= ''
	SET @sWhere = @sWhere + 'AND HRMT1020.Disabled LIKE N''%'+@Disabled+'%'' '
SET @sSQL =@sSQL +  N'
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HRMT1020.APK, HRMT1020.DivisionID, HRMT1020.BoundaryID, HRMT1020.Description, HRMT1020.DepartmentID, AT1102.DepartmentName,
		HRMT1020.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1020.CreateUserID) CreateUserID, HRMT1020.CreateDate, 
		HRMT1020.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1020.LastModifyUserID) LastModifyUserID, HRMT1020.LastModifyDate,
		HRMT1020.Disabled ,HRMT1020.FromDate, HRMT1020.ToDate
	FROM HRMT1020 WITH (NOLOCK)
	LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT1020.DepartmentID = AT1102.DepartmentID '+@sJoin+'
	WHERE ISNULL(HRMT1020.DeleteFlg,0) = 0  '+@sWhere +' 
	ORDER BY '+@OrderBy+'

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
