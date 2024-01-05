IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1120]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CIF1120: Danh mục đơn vị
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Lê Hoàng, Date: 22/12/2020
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE CIP1120
( 
	 @DivisionID VARCHAR(50),
	 @DivisionName VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @Address VARCHAR(50),
	 @Tel NVARCHAR(50),
	 @Email NVARCHAR(250), 
	 @Fax NVARCHAR(50), 
	 @ContactPerson NVARCHAR(250),
	 @Disabled VARCHAR(1)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'DivisionID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + ' 1 = 1 '

IF ISNULL(@DivisionID,'') <> '' SET @sWhere = @sWhere + '
AND DivisionID LIKE ''%'+@DivisionID+'%'' '	
IF ISNULL(@DivisionName,'') <> '' SET @sWhere = @sWhere + '
AND DivisionName LIKE ''%'+@DivisionName+'%'' '
IF ISNULL(@Address,'') <> '' SET @sWhere = @sWhere + '
AND Address LIKE ''%'+@Address+'%'' '
IF ISNULL(@Tel,'') <> '' SET @sWhere = @sWhere + '
AND Tel LIKE ''%'+@Tel+'%'' '
IF ISNULL(@Email,'') <> '' SET @sWhere = @sWhere + '
AND Email LIKE ''%'+@Email+'%'' '
IF ISNULL(@Fax,'') <> '' SET @sWhere = @sWhere + '
AND Fax LIKE ''%'+@Fax+'%'' '
IF ISNULL(@ContactPerson,'') <> '' SET @sWhere = @sWhere + '
AND ContactPerson LIKE ''%'+@ContactPerson+'%'' '
IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
AND Disabled = '+@Disabled+' '

	

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
APK, DivisionID, DivisionName, Address, Tel, Email, Fax, ContactPerson, [Disabled]
FROM AT1101 WITH (NOLOCK)
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+' 
	
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
