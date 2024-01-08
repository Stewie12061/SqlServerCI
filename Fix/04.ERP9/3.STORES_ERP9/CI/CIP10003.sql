IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP10003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP10003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In danh muc phong ban -Store CIP10003
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng on 22/06/2016
---- 
--EXEC CIP10003 'AS','', '','','',''
----
CREATE PROCEDURE CIP10003
( 
    @DivisionID nvarchar(50),
	@DivisionIDList NVARCHAR(2000),       
	@DepartmentID nvarchar(50),
	@DepartmentName nvarchar(50),
	@Disabled TINYINT,		
	@IsCommon TINYINT)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
        
SET @sWhere = ''

SET @OrderBy = 'DivisionID, DepartmentID'

IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere =@sWhere+ ' AND DivisionID = '''+ @DivisionID+''' Or IsCommon =1'
	Else 
		SET @sWhere = @sWhere+ ' AND DivisionID IN ('''+@DivisionIDList+''')Or IsCommon =1'
IF Isnull(@DepartmentID,'') !='' SET @sWhere = @sWhere + '
AND DepartmentID LIKE ''%'+@DepartmentID+'%'' '
IF Isnull(@DepartmentName,'') !='' SET @sWhere = @sWhere + '
AND DepartmentName LIKE N''%'+@DepartmentName+'%'' '
IF Isnull(@Disabled,'') !='' SET @sWhere = @sWhere + '
AND Disabled = '+STR(@Disabled)+' '
IF Isnull(@IsCommon,'') !='' SET @sWhere = @sWhere + '
AND IsCommon = '+STR(@IsCommon)+' '	

SET @sSQL = '
SELECT 
	DivisionID, DepartmentID, DepartmentName, [Disabled], IsCommon,
	CreateUserID, LastModifyUserID, CreateDate, LastModifyDate 
FROM AT1102 With (NOLOCK)
WHERE 1 = 1 '+@sWhere+'
ORDER BY '+@OrderBy

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
