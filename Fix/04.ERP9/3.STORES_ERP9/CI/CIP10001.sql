IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP10001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP10001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Man hinh truy van load du lieu danh muc phong ban -Store CIP10001
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Ho hoang tu, Date: 09/10/2014
----Modify by: Phan thanh hoang vu, 16/10/2014 
---- Modified by Bảo Thy on 15/06/2016: Bổ sung @IsSearch
---- Modified BY thị Phượng on 18/07/2017 bổ sung load dùng chung
---- Modified BY Le Hoang on 04/12/2020 bổ sung load trường DepartmentNameE
--EXEC CIP10001 'KC','KC'',''', '','','','',1,20
----
CREATE PROCEDURE CIP10001
( 
    @DivisionID nvarchar(50),
	@DivisionIDList NVARCHAR(2000),       
	@DepartmentID nvarchar(50),
	@DepartmentName nvarchar(50),
	@Disabled TINYINT,		
	@IsCommon TINYINT,
	@PageNumber INT,
    @PageSize INT,
    @IsSearch INT --1: search
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50)
        
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'DivisionID, DepartmentID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsSearch = 1
BEGIN
	IF @DivisionIDList IS NULL SET @sWhere = @sWhere + '
	AND (DivisionID = ('''+@DivisionID+''') or IsCommon =1) '
	ELSE SET @sWhere = @sWhere + '
	AND (DivisionID IN ('''+@DivisionIDList+''') Or IsCommon =1)'
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF @DepartmentName IS NOT NULL SET @sWhere = @sWhere + '
	AND DepartmentName LIKE N''%'+@DepartmentName+'%'' '
	IF @Disabled IS NOT NULL SET @sWhere = @sWhere + '
	AND Disabled = '+STR(@Disabled)+' '
	IF @Iscommon IS NOT NULL SET @sWhere = @sWhere + '
	AND IsCommon = '+STR(@IsCommon)+' '	
END 

SET @sSQL = '
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	DivisionID, DepartmentID, DepartmentName, DepartmentNameE, [Disabled], IsCommon,
	CreateUserID, LastModifyUserID, CreateDate, LastModifyDate 
FROM AT1102
WHERE 1 = 1 '+@sWhere+'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
