IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP14801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form CIF1480 Danh mục thiết lập mã phân tích mua và bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 15/12/2022
-- <Example>
----    EXEC CIP14801 '1B','','','',1,20

CREATE PROCEDURE CIP14801 (
        @DivisionID VARCHAR(50),
		@AnaTypeID VARCHAR(50),
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

	SET @sWhere = 'AND (OT1005.AnaTypeID LIKE ''P%'' OR OT1005.AnaTypeID LIKE ''S%'')'
	SET @OrderBy = 'OT1005.DivisionID, OT1005.AnaTypeID'
	
	-- Kiểm tra điều kiện search
	IF ISNULL(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'AND OT1005.DivisionID IN ('''+@DivisionID+''', ''@@@'')'
	IF ISNULL(@AnaTypeID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(OT1005.AnaTypeID, '''') LIKE N''%'+@AnaTypeID+'%'' '
	IF ISNULL(@UserName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(OT1005.UserName, '''') LIKE N''%'+@UserName+'%'' '
	IF ISNULL(@UserNameE, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1005.UserNameE, '''') LIKE N''%'+@UserNameE+'%'' '
	IF ISNULL(@SystemName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1005.SystemName, '''') LIKE N''%'+@SystemName+'%'' '
	IF ISNULL(@IsUsed, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1005.IsUsed, '''') LIKE N''%'+ISNULL(@IsUsed, 0)+'%'' '
	
	--Kiểm tra load mặc định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				DECLARE @OT1005 TABLE
				(
					DivisionID NVARCHAR(50),
					AnaTypeID NVARCHAR(50),
					SystemName NVARCHAR(250),
					UserName NVARCHAR(250),
					IsUsed TINYINT,
					UserNameE NVARCHAR(250),
					APK uniqueidentifier
				)
				INSERT INTO @OT1005
				(
					DivisionID, AnaTypeID, SystemName, UserName, IsUsed, UserNameE, APK
				)
				SELECT OT05.DivisionID, OT05.AnaTypeID, OT05.SystemName, OT05.UserName, OT05.IsUsed, OT05.UserNameE, OT05.APK
				FROM OT1005 OT05 WITH (NOLOCK)
				'
    set @sSQL01='
						DECLARE @CountTotal NVARCHAR(MAX)
						DECLARE @CountEXEC TABLE (CountRow NVARCHAR(MAX))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						BEGIN
							INSERT INTO @CountEXEC (CountRow)
							SELECT COUNT(OT1005.AnaTypeID) FROM @OT1005 OT1005 WHERE 1=1 '+ @sWhere +'
						END
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow FROM @CountEXEC) AS TotalRow	,
				 OT1005.DivisionID, OT1005.AnaTypeID, OT1005.SystemName, OT1005.UserName, OT1005.IsUsed,
				 OT1005.UserNameE, OT1005.APK
				 FROM @OT1005 AS OT1005
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
