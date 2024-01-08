IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1540]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1540]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CIF1540 Danh mục công thức chi phí
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Long, Date: 16/06/2023
----Modify by: Lê Thanh Lượng, Date: 28/08/2023:[2023/08/TA/0159] - Bổ sung script khởi tạo dữ liệu CIT1540 ban đầu.
-- <Example>
----   exec CIP1540 @DivisionID=N'GREE-SI',@TypeID=N'',@UserName=N'',@Recipe=N'',@IsUsed=N'',@PageNumber=1,@PageSize=25


CREATE PROCEDURE CIP1540 (
        @DivisionID VARCHAR(50),
		@TypeID VARCHAR(50),
        @UserName NVARCHAR(100),
        @Recipe NVARCHAR(100),
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

	SET @sWhere = 'AND (CIT1540.TypeID LIKE ''M%'' OR CIT1540.TypeID LIKE ''C%'')'
	SET @OrderBy = 'CIT1540.DivisionID, CIT1540.TypeID'
	
	-- Kiểm tra điều kiện search
	IF ISNULL(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'AND CIT1540.DivisionID IN ('''+@DivisionID+''', ''@@@'')'
	IF ISNULL(@TypeID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(CIT1540.TypeID, '''') LIKE N''%'+@TypeID+'%'' '
	IF ISNULL(@UserName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(CIT1540.UserName, '''') LIKE N''%'+@UserName+'%'' '
	IF ISNULL(@Recipe, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CIT1540.Recipe, '''') LIKE N''%'+@Recipe+'%'' '
	IF ISNULL(@IsUsed, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CIT1540.IsUsed, '''') LIKE N''%'+ISNULL(@IsUsed, 0)+'%'' '
	
	--Kiểm tra load mặc định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				DECLARE @CIT15401 TABLE
				(
					DivisionID NVARCHAR(50),
					TypeID NVARCHAR(50),
					UserName NVARCHAR(250),
					IsUsed TINYINT,
					Recipe NVARCHAR(250),
					APK uniqueidentifier
				)
				INSERT INTO @CIT15401
				(
					DivisionID, TypeID, UserName, IsUsed, Recipe, APK
				)
				SELECT OT05.DivisionID, OT05.TypeID, OT05.UserName, OT05.IsUsed, OT05.Recipe, OT05.APK
				FROM CIT1540 OT05 WITH (NOLOCK)
				'
    set @sSQL01='
						DECLARE @CountTotal NVARCHAR(MAX)
						DECLARE @CountEXEC TABLE (CountRow NVARCHAR(MAX))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						BEGIN
							INSERT INTO @CountEXEC (CountRow)
							SELECT COUNT(CIT1540.TypeID) FROM @CIT15401 CIT1540 WHERE 1=1 '+ @sWhere +'
						END
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow FROM @CountEXEC) AS TotalRow	,
				 CIT1540.DivisionID, CIT1540.TypeID, CIT1540.UserName, CIT1540.IsUsed,
				 CIT1540.Recipe, CIT1540.APK
				 FROM @CIT15401 AS CIT1540
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	PRINT (@sSQL+ @sSQL01+@sSQL02)
	EXEC (@sSQL+ @sSQL01+@sSQL02)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
