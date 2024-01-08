IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'KPIP10481') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE KPIP10481
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form KPIP10481 Chọn chỉ tiêu đánh giá KPI
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 15/07/2019 by Như Hàn
-- <Example> EXEC KPIP10481 'NTY', 'Test',1, 20

CREATE PROCEDURE KPIP10481 ( 
          @DivisionID VARCHAR(50),
		  @TxtSearch NVARCHAR(MAX),
		  @PageNumber INT,
		  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWHERE NVARCHAR (MAX) = '',
		@OrderBy NVARCHAR(500)
		


SET @OrderBy = 'ParameterID '
IF ISNULL(@TxtSearch,'') <> ''
SET @sWHERE = @sWHERE +' AND ParameterID like ''%'+@TxtSearch+'%'' OR ParameterName like ''%'+@TxtSearch+'%'' '
	
SET @sSQL = ' 
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow,A.*
			FROM
			(
			SELECT ParameterID, ParameterName
			FROM KPIT10441 WITH (NOLOCK)
			WHERE DivisionID IN (''@@@'', '''+@DivisionID+''')
			AND Disabled = 0
			'+@sWHERE+'
			) A
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
--PRINT @sSQL

