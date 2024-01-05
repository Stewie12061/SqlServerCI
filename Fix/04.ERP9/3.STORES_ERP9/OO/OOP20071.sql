IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP20071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP20071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn người duyệt
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Học Huy
----Modified on 30/08/2023 by Thu Hà: Cập nhật điều kiện lọc
-- <Example>
/*
    EXEC OOP20071 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE OOP20071 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'HV.EmployeeID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL 
		SET @sWhere = @sWhere +'
			AND (HV.EmployeeID LIKE N''%' + @TxtSearch + '%'' 
			OR FullName LIKE N''%' + @TxtSearch + '%''
			OR HV.DepartmentName LIKE N''%' + @TxtSearch + '%'')'
	
	SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow + ' AS TotalRow
			, HV.EmployeeID, HV.FullName EmployeeName
			, HV.DepartmentName
		FROM HV1400 HV WITH (NOLOCK)
			INNER JOIN AT1102 WITH (NOLOCK) ON HV.EmployeeID = AT1102.ContactPerson
		WHERE HV.DivisionID = ''' + @DivisionID + '''' + @sWhere + '
		--AND HV.StatusID NOT IN (3,9)'+ @sWhere + '
		GROUP BY HV.EmployeeID, HV.FullName, HV.DepartmentName
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
