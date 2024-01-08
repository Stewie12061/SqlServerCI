IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0392]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0392]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HF0392: Danh mục phép thâm niên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
-- <Example>
---- 
/*-- <Example>
	EXEC HP0392 @DivisionID='ANG',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@SeniorityID=NULL,@DescriptionID=NULL
----*/

CREATE PROCEDURE HP0392
( 
	 @DivisionID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch BIT,
	 @SeniorityID VARCHAR(50),
	 @DescriptionID NVARCHAR(250),
	 @Disabled TINYINT
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)


                
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'H27.SeniorityID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF  @IsSearch = 1
BEGIN
	IF @SeniorityID IS NOT NULL 
		SET @sWhere = @sWhere + '
		AND H27.SeniorityID LIKE ''%'+@SeniorityID+'%'' '
	IF @DescriptionID IS NOT NULL 
		SET @sWhere = @sWhere + '
		AND H27.DescriptionID LIKE N''%'+@DescriptionID+'%'' '
	IF @Disabled IS NOT NULL
		SET @sWhere = @sWhere + '
		AND H27.Disabled = ' + CONVERT(NVARCHAR(5),@Disabled)
END

SET @sSQL = '
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, H27.*
FROM HT1027 H27 WITH (NOLOCK)
WHERE DivisionID = ''' +@DivisionID +'''
'
+@sWhere +'
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
