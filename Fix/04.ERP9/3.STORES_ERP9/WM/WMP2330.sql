IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2330]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2330]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form WMF2330 Định nghĩa tham số 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thắm, Date: 29/11/2023
-- <Example>
----    exec WMP2330 @DivisionID=N'GREE-SI',@TypeID=N'wm',@UserName=N'',@UserNameE=N'',@SystemName =N'',@IsUsed=N'0',@PageNumber=1,@PageSize=25

CREATE PROCEDURE WMP2330 (
        @DivisionID VARCHAR(50),
		@TypeID VARCHAR(50),
        @UserName NVARCHAR(100),
        @UserNameE NVARCHAR(100),
        @SystemName NVARCHAR(100),
		@IsUsed VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

SET @sWhere = 'AND (WT0005.TypeID LIKE ''WM%'' OR WT0005.TypeID LIKE ''W%'')'
SET @OrderBy = 'WT0005.DivisionID, WT0005.TypeID'

-- Kiểm tra điều kiện search
IF ISNULL(@DivisionID,'') != ''
	SET @sWhere = @sWhere + 'AND WT0005.DivisionID IN ('''+@DivisionID+''', ''@@@'')'
IF ISNULL(@TypeID,'') != ''
	SET @sWhere = @sWhere +  'AND ISNULL(WT0005.TypeID, '''') LIKE N''%'+@TypeID+'%'' '
IF ISNULL(@UserName,'') != ''
	SET @sWhere = @sWhere +  'AND ISNULL(WT0005.UserName, '''') LIKE N''%'+@UserName+'%'' '
IF ISNULL(@UserNameE, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(WT0005.UserNameE, '''') LIKE N''%'+@UserNameE+'%'' '
IF ISNULL(@SystemName, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(WT0005.SystemName, '''') LIKE N''%'+@SystemName+'%'' '
IF ISNULL(@IsUsed, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(WT0005.IsUsed, '''') LIKE N''%'+ISNULL(@IsUsed, 0)+'%'' '
BEGIN	
SET @sSQL = N'
				 SELECT COUNT(*) OVER() AS TotalRow, ROW_NUMBER() OVER (ORDER BY WT0005.TypeID) AS RowNum,
				 WT0005.APK, WT0005.DivisionID, WT0005.TypeID, WT0005.SystemName, WT0005.UserName,
				 WT0005.UserNameE, WT0005.IsUsed
				 FROM WT0005 WITH (NOLOCK)
				 WHERE 1=1 '+@sWhere+'
				 ORDER BY '+@OrderBy+'
				 OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				 FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
END
PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

