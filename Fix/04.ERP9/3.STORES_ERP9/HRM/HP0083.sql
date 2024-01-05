IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Trả dữ liệu cho màn hình hồ sơ phép
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created on 07/05/2004 by: Hải Long
--- Modified on 30/03/2017 by Bảo Thy : Fix lỗi lọc khi chọn nhiều tổ nhóm
--- Modified on 16/05/2017 by Phương Thảo : Sửa danh mục dùng chung
--- Modified on 12/07/2018 by Bảo Anh: Sắp xếp theo mã nhân viên
--- Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
--- Modified on 26/10/2020 by Văn Tài : Bổ sung đổ phân quyền theo bảng tạm. Điều chỉnh param Condition thành dạng XML để không bị tràn chuỗi.
--- Modified on 19/08/2021 by Văn Tài : [Minh Trị] Không sử dụng phân quyền dữ liệu theo User.
--- Modified on 21/07/2022 by Văn Tài : [Liễn Quán] Không sử dụng phân quyền dữ liệu theo User.
--- Modified on 17/11/2022 by Văn Tài : [NQH] Không sử dụng phân quyền dữ liệu theo User.
-- <Example>
/*   
   EXEC HP0083 @DivisionID = 'ANG', @TranMonth = 2, @TranYear = 2016, @PageNumber=1, @PageSize=10, @IsSearch = 1, @LstDepartmentID = 'PRD, PSX', @LstTeamID = 'TRD, PSX', @EmployeeID = '', @FullName = ''
*/

CREATE PROCEDURE [dbo].[HP0083]
(
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT,
	@PageSize INT,
	@IsSearch BIT,	
	@LstDepartmentID NVARCHAR(4000),
	@LstTeamID NVARCHAR(4000),
	@EmployeeID NVARCHAR(100),
	@FullName NVARCHAR(100),
	@ConditionSabbaticalProfileID XML = NULL
)
AS
DECLARE @sSQL NVARCHAR(4000),
		@sWhere NVARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@CustomerIndex INT

SET @CustomerIndex = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

-- Đổ dữ liệu phân quyền vào bảng tạm. Vì dữ liệu vượt ngưỡng 8000 cho VARCHAR.
CREATE TABLE #HP0083(EmployeeID VARCHAR(100))
IF @ConditionSabbaticalProfileID IS NOT NULL
BEGIN
	INSERT INTO #HP0083(EmployeeID)
	SELECT X.Data.query('EmployeeID').value('.', 'VARCHAR(100)') AS APK
	FROM @ConditionSabbaticalProfileID.nodes('//Data') AS X (Data)
END
		
SET @OrderBy = 'A.EmployeeID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'		
		
SET @LstDepartmentID = REPLACE(@LstDepartmentID, ',', ''',''')
SET @LstTeamID = REPLACE(@LstTeamID, ', ', ''',''')
	
IF @IsSearch = 1
BEGIN		
	IF @LstDepartmentID <> '' 
	BEGIN 
		SET @sWhere = @sWhere + 'AND HT1400.DepartmentID IN (''' + @LstDepartmentID + ''')' + char(13)
	END

	IF @LstTeamID <> '' 
	BEGIN

		SET @sWhere = @sWhere + 'AND HT1400.TeamID IN (''' + @LstTeamID + ''')'	+ char(13)
	END

	IF @EmployeeID <> '' 
	BEGIN
	 
		SET @sWhere = @sWhere + 'AND HT1400.EmployeeID LIKE ''%' + @EmployeeID + '%''' + char(13)	
	END

	IF @FullName <> '' 
	BEGIN
	
		SET @sWhere = @sWhere + 'AND Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) LIKE ''%' + @FullName + '%''' + char(13)
	END
END 

--IF Isnull(@ConditionSabbaticalProfileID, '') != ''
--		SET @sWhere = @sWhere + ' AND ISNULL(HT1400.CreateUserID,'''') in (N'''+@ConditionSabbaticalProfileID+''' )'

IF (@CustomerIndex = 92 OR @CustomerIndex = 105 OR @CustomerIndex = 131) -- Minh Trị, Liễn Quán, NQH
BEGIN

	-- Không sử dụng phân quyền dữ liệu.

	SET @sSQL = '
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT HT2803.APK, HT2803.DivisionID, HT2803.TranMonth, HT2803.TranYear, HT2803.EmployeeID, Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS FullName,
		AT1102.DepartmentName, HT1101.TeamName, HT2803.MethodVacationID, HT1029.MethodVacationName, HT2803.DaysPrevMonth, HT2803.DaysInYear, HT2803.VacSeniorDays, HT2803.AddDays, HT2803.DaysSpentToMonth, HT2803.DaysSpent, HT2803.DaysRemained,
		HT2803.CreateUserID, HT2803.CreateDate, HT2803.LastModifyUserID, HT2803.LastModifyDate
		FROM HT2803 WITH (NOLOCK) 
		INNER JOIN HT1400 WITH (NOLOCK) ON HT2803.DivisionID = HT1400.DivisionID AND HT2803.EmployeeID = HT1400.EmployeeID
		LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID
		LEFT JOIN HT1101 WITH (NOLOCK) ON HT1400.DivisionID = HT1101.DivisionID AND HT1400.TeamID = HT1101.TeamID AND HT1400.DepartmentID = HT1101.DepartmentID
		LEFT JOIN HT1029 WITH (NOLOCK) ON HT2803.DivisionID = HT1029.DivisionID AND HT2803.MethodVacationID = HT1029.MethodVacationID
		WHERE HT2803.DivisionID = ''' + @DivisionID + ''' 
		AND HT2803.TranMonth = ' + Convert(NVARCHAR(10), @TranMonth) + '
		AND HT2803.TranYear = ' + Convert(NVARCHAR(10), @TranYear) + '
		' + @sWhere + 
		'
	) A 	
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

END
ELSE
BEGIN

	SET @sSQL = '
	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
		SELECT HT2803.APK, HT2803.DivisionID, HT2803.TranMonth, HT2803.TranYear, HT2803.EmployeeID, Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS FullName,
		AT1102.DepartmentName, HT1101.TeamName, HT2803.MethodVacationID, HT1029.MethodVacationName, HT2803.DaysPrevMonth, HT2803.DaysInYear, HT2803.VacSeniorDays, HT2803.AddDays, HT2803.DaysSpentToMonth, HT2803.DaysSpent, HT2803.DaysRemained,
		HT2803.CreateUserID, HT2803.CreateDate, HT2803.LastModifyUserID, HT2803.LastModifyDate
		FROM HT2803 WITH (NOLOCK) 
		INNER JOIN HT1400 WITH (NOLOCK) ON HT2803.DivisionID = HT1400.DivisionID AND HT2803.EmployeeID = HT1400.EmployeeID
		INNER JOIN #HP0083 Condition WITH (NOLOCK) ON HT2803.EmployeeID = Condition.EmployeeID
		LEFT JOIN AT1102 WITH (NOLOCK) ON HT1400.DepartmentID = AT1102.DepartmentID
		LEFT JOIN HT1101 WITH (NOLOCK) ON HT1400.DivisionID = HT1101.DivisionID AND HT1400.TeamID = HT1101.TeamID AND HT1400.DepartmentID = HT1101.DepartmentID
		LEFT JOIN HT1029 WITH (NOLOCK) ON HT2803.DivisionID = HT1029.DivisionID AND HT2803.MethodVacationID = HT1029.MethodVacationID
		WHERE HT2803.DivisionID = ''' + @DivisionID + ''' 
		AND HT2803.TranMonth = ' + Convert(NVARCHAR(10), @TranMonth) + '
		AND HT2803.TranYear = ' + Convert(NVARCHAR(10), @TranYear) + '
		' + @sWhere + 
		'
	) A 	
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

END


EXEC (@sSQL)
PRINT @sSQL

-- SELECT * FROM  #HP0083


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
