IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình danh mục ca bán hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tiểu Mai on 06/06/2018
----Edit by: Tra Giang on 19/10/2018: Chỉnh sửa : lọc theo người lập ca 
-- <Example>
/*
    EXEC POSP0071 'PL', '','', '', '',1,50
*/


 CREATE PROCEDURE POSP0071
(
     @DivisionID NVARCHAR(2000),
     @ShiftID VARCHAR(50),
     @Description NVARCHAR(250),
     @CreateUserID VARCHAR(50),
     @Disabled VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
 

SET @sWhere = ' 1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'P69.ShiftID, P69.FromTime'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


SET @sSQL = '	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,  
P69.*, A45.UserID AS EmployeeName
FROM POST0069 P69 WITH (NOLOCK) 
LEFT JOIN AT1405 A45 WITH (NOLOCK) ON P69.DivisionID = A45.DivisionID AND P69.EmployeeID = A45.UserID 
Where P69.DivisionID = '''+@DivisionID+''' 
'+ CASE WHEN ISNULL(@ShiftID,'') != '' THEN ' AND P69.ShiftID LIKE ''%'+@ShiftID+ '%''' ELSE '' END + '
'+ CASE WHEN ISNULL(@Description,'') != '' THEN ' AND P69.Description LIKE N''%'+@Description+ '%''' ELSE '' END + '
'+ CASE WHEN ISNULL(@CreateUserID,'') != '' THEN ' AND P69.EmployeeID LIKE ''%'+@CreateUserID+'%'' ' ELSE '' END +'
'+ CASE WHEN ISNULL(@Disabled,'') != '' THEN ' AND CONVERT(NVARCHAR(5),P69.Disabled) = '+CONVERT(NVARCHAR(5),@Disabled) ELSE '' END +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
