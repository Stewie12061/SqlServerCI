IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0363]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0363]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In Bao cao ky luat
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: HRM\Bao cao \Bao cao nhan vien vi pham
-- <History>
---- Create on 06/01/2016 by Phuong Thao 
--- Modified by Phương Thảo on 17/05/2017: Sửa danh mục dùng chung
--- Modified on 08/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị
-- <Example>
---- Exec HP0363 'GS', 1, 12, 2015

CREATE PROCEDURE [dbo].[HP0363] 
				@DivisionID AS nvarchar(50),
				@IsPeriod AS Tinyint, -- 1: Nam, 2:Ky
				@TranMonth AS int,
				@TranYear AS int,
				@StrDivisionID AS NVARCHAR(4000) = ''
	
 AS
 DECLARE	@sSQL01 NVarchar(4000),
			@StrDivisionID_New AS NVARCHAR(4000)

SET @StrDivisionID_New = ''		

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''

IF(@IsPeriod = 1) -- Nam
BEGIN
	SELECT 	@sSQL01 = '
	SELECT	--IDENTITY(int, 1, 1) AS Identity,
			--- Thong tin nhan vien
			T1.DivisionID, T1.EmployeeID, Max(Ltrim(RTrim(isnull(T2.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(T2.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(T2.FirstName,'''')))) As FullName,
			Max(T3.TitleID) AS TitleID, Max(T2.DepartmentID) AS DepartmentID, Max(T2.TeamID) AS TeamID, 
			Max(T2.Ana04ID) AS SectionID, Max(T2.Ana05ID) AS ProcessID,
			Convert(Nvarchar(250),'''') AS TitleName,
			Convert(Nvarchar(250),'''') AS DepartmentName, Convert(Nvarchar(250),'''') AS TeamName,
			Convert(Nvarchar(250),'''') AS SectionName, Convert(Nvarchar(250),'''') AS ProcessName,
			MAX(T1.RetributeDate) AS MaxViolateDate, 
			--T1.RetributeDate,
			--Convert(Date,'''') AS MaxViolateDate,
			Convert(NVarchar(50),'''') AS MaxFormID,
			Convert(NVarchar(50),'''') AS MaxFormDesc,
			-- T4.Description As WarningForm
			T1.FormID, T4.FormName,
			Count(T1.FormID) AS Totals,
			T4.Level
	INTO	#HP0363
	FROM	HT1406 T1 WITH (NOLOCK)
	INNER JOIN HT1400 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
	INNER JOIN HT1403 T3 WITH (NOLOCK) ON T2.EmployeeID = T3.EmployeeID and T2.DivisionID = T3.DivisionID
	LEFT JOIN HT1108 T4 WITH (NOLOCK) ON T1.FormID = T4.FormID and T1.DivisionID = T4.DivisionID
	WHERE	T1.DivisionID '+@StrDivisionID_New+' AND T1.IsReward = 0 AND Year(RetributeDate) = '+STR(@TranYear)+'
	GROUP BY T1.DivisionID, T1.EmployeeID, T1.FormID, T4.Level, T4.FormName

	-- Update ten chuc danh: TitleName
	Update	T1
	set		T1.TitleName = T2.TitleName
	from	#HP0363 T1
	inner join HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID

	-- Update ten Khoi: DepartmentName
	Update	T1
	set		T1.DepartmentName = T2.DepartmentName
	from	#HP0363 T1
	inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID 

	-- Update ten Phong: TeamName
	Update	T1
	set		T1.TeamName = T2.TeamName
	from	#HP0363 T1
	inner join HT1101 T2 WITH (NOLOCK) on T1.TeamID = T2.TeamID and T1.DivisionID = T2.DivisionID

	-- Update ten Ban: SectionName
	Update	T1
	set		T1.SectionName = T2.AnaName
	from	#HP0363 T1
	inner join AT1011 T2 WITH (NOLOCK) on T1.SectionID = T2.AnaID and T2.AnaTypeID = ''A04''

	-- Update ten Cong doan: ProcessName
	Update	T1
	set		T1.ProcessName = T2.AnaName
	from	#HP0363 T1
	inner join AT1011 T2 WITH (NOLOCK) on T1.ProcessID = T2.AnaID and T2.AnaTypeID = ''A05''

	
	-- Update hinh thuc ky luat cao nhat va ngay hieu luc moi nhat
	UPDATE T1
	SET		T1.MaxFormID = CASE WHEN T2.Level <> 10 THEN RIGHT (T2.MaxFormID,LEN(LTRIM(RTRIM(Convert(Varchar(100),T2.MaxFormID)))) - 1) ELSE RIGHT (T2.MaxFormID, LEN(LTRIM(RTRIM(Convert(Varchar(100),T2.MaxFormID))) - 2)) END			
	FROM #HP0363 T1
	INNER JOIN 
	(	SELECT	DivisionID, EmployeeID, 
				MAX(STR(Level)+FormID) AS MaxFormID, 				
				MAX(Level) AS Level
		FROM	#HP0363
		GROUP BY DivisionID, EmployeeID
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID


	UPDATE T1
	SET	T1.MaxFormDesc = T2.FormName
	FROM #HP0363 T1
	INNER JOIN HT1108 T2  WITH (NOLOCK) ON T1.MaxFormID = T2.FormID AND T1.DivisionID = T2.DivisionID 
		 
	UPDATE T1
	SET	T1.MaxViolateDate = T2.MaxViolateDate
	FROM #HP0363 T1
	INNER JOIN (SELECT EmployeeID, DivisionID,  MaxViolateDate FROM #HP0363 WHERE FormID = MaxFormID) T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	

	Select * from #HP0363

	drop table #HP0363
	'
	
END
ELSE  -- Ky
BEGIN
SELECT 	@sSQL01 = '
	SELECT	T1.EmployeeID, 	T1.DivisionID,  Ltrim(RTrim(isnull(T2.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(T2.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(T2.FirstName,''''))) As FullName,
			T3.TitleID, T2.DepartmentID, T2.TeamID, T2.Ana04ID AS SectionID, T2.Ana05ID AS ProcessID,
			Convert(Nvarchar(250),'''') AS TitleName,
			Convert(Nvarchar(250),'''') AS DepartmentName, Convert(Nvarchar(250),'''') AS TeamName,
			Convert(Nvarchar(250),'''') AS SectionName, Convert(Nvarchar(250),'''') AS ProcessName,
			T1.Reason, T1.RetributeDate, T1.Times, T1.Form
	INTO	#HP0363
	FROM	HT1406 T1 WITH (NOLOCK)
	INNER JOIN HT1400 T2 WITH (NOLOCK) ON T1.EmployeeID = T2.EmployeeID and T1.DivisionID = T2.DivisionID
	INNER JOIN HT1403 T3 WITH (NOLOCK) ON T2.EmployeeID = T3.EmployeeID and T2.DivisionID = T3.DivisionID
	WHERE	T1.DivisionID '+@StrDivisionID_New+' AND  T1.IsReward = 0 AND Month(RetributeDate) = '+STR(@TranMonth)+' AND Year(RetributeDate) = '+STR(@TranYear)+'
	
	-- Update ten chuc danh: TitleName
	Update	T1
	set		T1.TitleName = T2.TitleName
	from	#HP0363 T1
	inner join HT1106 T2 WITH (NOLOCK) on T1.TitleID = T2.TitleID and T1.DivisionID = T2.DivisionID

	-- Update ten Khoi: DepartmentName
	Update	T1
	set		T1.DepartmentName = T2.DepartmentName
	from	#HP0363 T1
	inner join AT1102 T2 WITH (NOLOCK) on T1.DepartmentID = T2.DepartmentID and T1.DivisionID = T2.DivisionID

	-- Update ten Phong: TeamName
	Update	T1
	set		T1.TeamName = T2.TeamName
	from	#HP0363 T1
	inner join HT1101 T2 WITH (NOLOCK) on T1.TeamID = T2.TeamID and T1.DivisionID = T2.DivisionID

	-- Update ten Ban: SectionName
	Update	T1
	set		T1.SectionName = T2.AnaName
	from	#HP0363 T1
	inner join AT1011 T2 WITH (NOLOCK) on T1.SectionID = T2.AnaID and T2.AnaTypeID = ''A04''

	-- Update ten Cong doan: ProcessName
	Update	T1
	set		T1.ProcessName = T2.AnaName
	from	#HP0363 T1
	inner join AT1011 T2 WITH (NOLOCK) on T1.ProcessID = T2.AnaID and T2.AnaTypeID = ''A05''

	Select * from #HP0363

	drop table #HP0363
	'
	

END
--PRINT @sSQL01
EXEC (@sSQL01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

