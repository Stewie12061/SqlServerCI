IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP90161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP90161]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn nhân viên (ADMIN)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nhựt Trường
-- <Example>
/*
    EXEC CMNP90161 'AS', '','PHUONG',1,25
*/

 CREATE PROCEDURE CMNP90161 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionTaskID VARCHAR(MAX) = NULL,
	 @UserID2 VARCHAR(50) =''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@All NVARCHAR(50) = N'Tất cả'

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'EmployeeID, EmployeeName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere + '
									AND (AnaID LIKE N''%' + @TxtSearch + '%'' 
									OR AnaName LIKE N''%' + @TxtSearch + '%'')'
	
	
	SET @sSQL = '
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM (
				SELECT '''+@DivisionID+''' AS DivisionID, ''%'' AS EmployeeID, N'''+@All+''' AS EmployeeName
				UNION ALL
				
				SELECT DivisionID, AnaID AS EmployeeID, AnaName AS EmployeeName
				FROM OT1002 WITH (NOLOCK)
				WHERE DivisionID = '''+@DivisionID+''' AND AnaTypeID = ''S04'' And Disabled=0
				'+@sWhere+' ) OT1002
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
				'
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO