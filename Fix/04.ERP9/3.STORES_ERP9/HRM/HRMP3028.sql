IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load dữ liệu báo cáo tổng hợp hồ sơ nhân viên.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Thu Hà
----Modified by Thanh Hải, Date: 02/01/2024: --Điều chỉnh hiển thị cho cột IsMale
											 --Bổ sung lọc từ ngày đến ngày và theo kỳ 	
											 --Điều chỉnh load dữ liệu cho cột Chức vụ	
-- <Example>
/*
    EXEC HRMP3026 'AS', '','PHUONG',1,25
*/
CREATE PROCEDURE HRMP3028 (
    @DivisionID      NVARCHAR(50),   -- Biến môi trường
    @DivisionIDList  NVARCHAR(MAX),
    @IsDate          TINYINT,        -- 1: Theo ngày; 0: Theo kỳ
    @FromDate        DATETIME, 
    @ToDate          DATETIME,
    @DepartmentList  VARCHAR(MAX),
    @TeamList        VARCHAR(MAX),
    @StatusList      VARCHAR(MAX),
    @PeriodIDList    NVARCHAR(MAX)
)
AS 
BEGIN
    DECLARE @sSQL NVARCHAR(MAX)='',        
            @sWhere NVARCHAR(MAX)='',
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@OrderBy NVARCHAR(500)=N''

	SET @OrderBy = 'H.DepartmentID DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'	
	
	--Kiểm tra DivisionIDList null sau đó lấy DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' (H.DivisionID IN ('''+@DivisionIDList+''', ''@@@'')) '
	Else 
		SET @sWhere = @sWhere + ' (H.DivisionID in ('''+@DivisionID+''', ''@@@'')) '

	IF @IsDate = 1
	--Theo ngày
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (H.CreateDate >= ''' + @FromDateText + '''
												OR H.CreateDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (H.CreateDate <= ''' + @ToDateText + ''' 
												OR H.CreateDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (H.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE
	--Theo kỳ
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(H.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodIDList + ''') '
	END

	IF ISNULL(@DepartmentList,'') <> ''
		SET @sWhere = @sWhere + ' AND H.DepartmentID  IN (''' + @DepartmentList + ''') '

	IF ISNULL(@TeamList, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(H.TeamID,'''') IN (''' + @TeamList + ''') '

	IF ISNULL(@StatusList, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(HT0099.ID,'''') IN (''' + @StatusList + ''') '

    SET @sSQL ='
	SELECT H.DivisionID, H.EmployeeID,
	LTRIM(RTRIM(ISNULL(H.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(H.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(H.FirstName,''''))) AS EmployeeName,
	H.DepartmentID, AT1102.DepartmentName, HT0099.Description AS EmployeeStatus,
	HT1102.DutyName,
	H.TeamID, HT1101.TeamName,
	FORMAT(H.Birthday, ''dd/MM/yyyy'') AS Birthday,
	--CASE WHEN H.IsMale = 0 THEN ''Nữ'' ELSE ''Nam'' END AS IsMale,
	H2.Description AS IsMale,
	H.BornPlace,
	H.IdentifyCardNo,
	FORMAT(H.IdentifyDate, ''dd/MM/yyyy'') AS IdentifyDate,
	H.EthnicID,
	HT1001.EthnicName,
	H.PermanentAddress,
	H.TemporaryAddress,
	H.Notes
	FROM HT1400 H WITH (NOLOCK)
	LEFT JOIN HT1403 HT43 WITH (NOLOCK) ON HT43.DivisionID IN (''@@@'', H.DivisionID ) AND HT43.EmployeeID = H.EmployeeID
	LEFT JOIN AT1102 WITH (NOLOCK) ON H.DivisionID = AT1102.DivisionID AND AT1102.DepartmentID = H.DepartmentID
	LEFT JOIN HT1101 WITH (NOLOCK) ON H.DivisionID = HT1101.DivisionID AND HT1101.TeamID = H.TeamID
	LEFT JOIN HT1102 WITH (NOLOCK) ON H.DivisionID = HT1102.DivisionID AND HT1102.DutyID = HT43.DutyID
	LEFT JOIN HT1001 WITH (NOLOCK) ON H.DivisionID = HT1001.DivisionID AND HT1001.EthnicID = H.EthnicID
	LEFT JOIN HT0099 WITH (NOLOCK) ON H.EmployeeStatus = HT0099.ID AND HT0099.CodeMaster = ''EmployeeStatus''
	LEFT JOIN HT0099 AS H2 WITH (NOLOCK) ON H.IsMale = H2.ID AND H2.CodeMaster = ''IsMale''

	WHERE '+ @sWhere +'
	ORDER BY '+ @OrderBy +''

    PRINT @sSQL
    EXEC sp_executesql @sSQL
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

