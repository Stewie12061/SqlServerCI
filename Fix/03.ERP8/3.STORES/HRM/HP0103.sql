IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load/ In/ Xuất Excel tai nạn lao động
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 23/11/2017
-- <Example>
---- 
/*-- <Example>
	HP0103 @DivisionID = 'KT', @UserID = 'ASOFTADMIN', @IsSearch = 0, @IsMode = 1, @FromDepartmentID = '', @ToDepartmentID = '', @TeamID = '', 
	@DepartmentID = '', @EmployeeID = ''
	
	HP0103 @DivisionID, @UserID, @IsSearch, @IsMode, @FromDepartmentID, @ToDepartmentID, @TeamID, @DepartmentID, @EmployeeID
----*/

CREATE PROCEDURE HP0103
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @IsMode TINYINT, -- 1 Load 
						-- 2 Load theo nhân viên 
						-- 0 Load theo phòng ban 
	 @FromDepartmentID VARCHAR(50),
	 @ToDepartmentID VARCHAR(50), 
	 @TeamID VARCHAR(50), 
	 @DepartmentID VARCHAR(50), 
	 @EmployeeID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N''
       
        
SET @OrderBy = 'HT1370.EmployeeID, HT1370.AccidentDate, HT1370.AccidentTime'
SET @sWhere = @sWhere + ' HT1370.DivisionID = '''+@DivisionID+''' ' 

IF @IsSearch = 1 -- Load 
BEGIN
	IF (@FromDepartmentID IS NOT NULL AND @ToDepartmentID IS NULL) SET @sWhere = @sWhere + '
	AND HV1400.DepartmentID >= '''+@FromDepartmentID+'''' 
	IF (@FromDepartmentID IS NULL AND @ToDepartmentID IS NOT NULL) SET @sWhere = @sWhere + '
	AND HV1400.DepartmentID <= '''+@ToDepartmentID+''''
	IF (@FromDepartmentID IS NOT NULL AND @ToDepartmentID IS NOT NULL) SET @sWhere = @sWhere + '
	AND HV1400.DepartmentID BETWEEN '''+@FromDepartmentID+''' AND '''+@ToDepartmentID+''''
	IF ISNULL(@TeamID, '') <> '' SET @sWhere = @sWhere + '
	AND HV1400.TeamID LIKE ''%'+@TeamID+'%'''
	
	SET @sSQL = @sSQL + N'
	SELECT HT1370.DivisionID, HT1370.AccidentID, HT1370.EmployeeID, HV1400.FullName, HT1370.AccidentTime, HT1370.AccidentDate, HT1370.AccidentPlace, HT1370.Wounds, 
	HT1370.Status01, HT1370.Status02, HT1370.Status03, HT1370.Status04, HT1370.Status05, HT1370.Cause01, HT1370.Cause02, HT1370.Cause03, HT1370.Cause04, 
	HT1370.Cause05, HT1370.Cause06, HT1370.Cause07, HT1370.Cause08, HT1370.Cause09, HT1370.OtherCause, HT1370.Leaves, HT1370.ActualLeaves, 
	HT1370.ReturnDate, HT1370.HospitalFees, HT1370.AccSalary , HV1400.DepartmentID, HV1400.DepartmentName
	FROM HT1370 WITH (NOLOCK) 
	INNER JOIN HV1400 ON HT1370.DivisionID = HV1400.DivisionID AND HT1370.EmployeeID = HV1400.EmployeeID
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
END
IF @IsSearch = 0 -- Xuất excel
BEGIN
	IF @IsMode = 1 -- Xuất theo phòng ban 
	BEGIN
		SET @sWhere = @sWhere + '
		AND HV1400.DepartmentID = '''+@DepartmentID+''''
		IF ISNULL(@TeamID, '') <> '' SET @sWhere = @sWhere + '
		AND HV1400.TeamID LIKE ''%'+@TeamID+'%'''
		
		SET @sSQL = @sSQL + N'
		SELECT HT1370.DivisionID, HT1370.AccidentID, HT1370.EmployeeID, HV1400.FullName, HT1370.AccidentTime, HT1370.AccidentDate, HT1370.AccidentPlace, HT1370.Wounds,
		HV1400.DepartmentID, HV1400.DepartmentName,
		CASE WHEN HT1370.Cause01 = 1 THEN N''Do máy gia công cơ khí (các may phay, cắt, dập, mài, khoan, cưa...)''
			WHEN HT1370.Cause02 = 1 THEN N''Do chi tiết máy nguy hiểm (chi tiết quay, truyền động, dẫn động...)''
			WHEN HT1370.Cause03 = 1 THEN N''Do công nhân (thao tác sai, sơ suất, dùng sai phương tiện bảo vệ cá nhân...)''
			WHEN HT1370.Cause04 = 1 THEN N''Do trang thiết bị, phương tiện và bảo vệ cá nhân (thiếu hoặc chưa phù hợp)''
			WHEN HT1370.Cause05 = 1 THEN N''Do điện giật, do hơi, khí, hóa chất, chất độc''
			WHEN HT1370.Cause06 = 1 THEN N''Do thiết bị chịu áp lực, do sự cố nổ - cháy''
			WHEN HT1370.Cause07 = 1 THEN N''Do thiết bị nâng chuyển (cầu lăn, pa lăng, xe nâng hàng...)''
			WHEN HT1370.Cause08 = 1 THEN HT1370.OtherCause END AS Cause, 
		CASE WHEN HT1370.Status01 = 1 THEN N''Nhẹ''
			WHEN HT1370.Status02 = 1 THEN N''Nặng''
			WHEN HT1370.Status03 = 1 THEN N''Chết người''
			WHEN HT1370.Status04 = 1 THEN N''Tai nạn trên đường về'' END AS Status, 
		HT1370.Leaves, HT1370.ActualLeaves, 
		HT1370.ReturnDate, HT1370.HospitalFees, HT1370.AccSalary , HV1400.DepartmentID, HV1400.DepartmentName
		FROM HT1370 WITH (NOLOCK) 
		INNER JOIN HV1400 ON HT1370.DivisionID = HV1400.DivisionID AND HT1370.EmployeeID = HV1400.EmployeeID
		WHERE '+@sWhere+'
		ORDER BY '+@OrderBy+'
		'
	END
	IF @IsMode = 0 -- Xuất theo nhân viên 
	BEGIN
		SET @sWhere = @sWhere + '
		AND HT1370.EmployeeID = '''+@EmployeeID+''''
		
		SET @sSQL = @sSQL + N'
		SELECT HT1370.DivisionID, HT1370.AccidentID, HT1370.EmployeeID, HV1400.FullName, HT1370.AccidentTime, HT1370.AccidentDate, HT1370.AccidentPlace, HT1370.Wounds, 
		HV1400.DepartmentID, HV1400.DepartmentName,
		CASE WHEN HT1370.Cause01 = 1 THEN N''Do máy gia công cơ khí (các may phay, cắt, dập, mài, khoan, cưa...)''
			WHEN HT1370.Cause02 = 1 THEN N''Do chi tiết máy nguy hiểm (chi tiết quay, truyền động, dẫn động...)''
			WHEN HT1370.Cause03 = 1 THEN N''Do công nhân (thao tác sai, sơ suất, dùng sai phương tiện bảo vệ cá nhân...)''
			WHEN HT1370.Cause04 = 1 THEN N''Do trang thiết bị, phương tiện và bảo vệ cá nhân (thiếu hoặc chưa phù hợp)''
			WHEN HT1370.Cause05 = 1 THEN N''Do điện giật, do hơi, khí, hóa chất, chất độc''
			WHEN HT1370.Cause06 = 1 THEN N''Do thiết bị chịu áp lực, do sự cố nổ - cháy''
			WHEN HT1370.Cause07 = 1 THEN N''Do thiết bị nâng chuyển (cầu lăn, pa lăng, xe nâng hàng...)''
			WHEN HT1370.Cause08 = 1 THEN HT1370.OtherCause END AS Cause, 
		CASE WHEN HT1370.Status01 = 1 THEN N''Nhẹ''
			WHEN HT1370.Status02 = 1 THEN N''Nặng''
			WHEN HT1370.Status03 = 1 THEN N''Chết người''
			WHEN HT1370.Status04 = 1 THEN N''Tai nạn trên đường về'' END AS Status, 
		HT1370.Leaves, HT1370.ActualLeaves, 
		HT1370.ReturnDate, HT1370.HospitalFees, HT1370.AccSalary, HV1400.DepartmentID, HV1400.DepartmentName
		FROM HT1370 WITH (NOLOCK) 
		INNER JOIN HV1400 ON HT1370.DivisionID = HV1400.DivisionID AND HT1370.EmployeeID = HV1400.EmployeeID
		WHERE '+@sWhere+'
		ORDER BY '+@OrderBy+'
		'
	END
	
END
	
--PRINT(@sSQL)
EXEC (@sSQL)


   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
