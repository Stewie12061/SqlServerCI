IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP14501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form CIP14501 Danh mục thiết lập mã phân tích
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 23/08/2022
----Modified by: Hoài Bảo, Date: 24/02/2023 - Cập nhật order theo TypeID
-- <Example>
----    EXEC CIP14501 'AS','','','',1,10

CREATE PROCEDURE CIP14501 (
        @DivisionID VARCHAR(50),
		@TypeID VARCHAR(50),
        @UserName NVARCHAR(100),
        @UserNameE NVARCHAR(100),
        @SystemName NVARCHAR(100),
		@IsCommon VARCHAR(50),
		@IsUsed VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@AnaTypeList NVARCHAR(MAX) = '',
		@Count INT

	SET @Count = 1
	WHILE @Count <= 5
	BEGIN
		SET @AnaTypeList = CONCAT(@AnaTypeList, ',', 'O0' + CONVERT(varchar(50), @Count))
		SET @Count = @Count + 1
	END

	SET @sWhere = 'AND (TypeID LIKE ''A%'' OR TypeID LIKE ''I%'' OR TypeID LIKE ''D%'' OR TypeID LIKE ''N%'' OR TypeID IN (SELECT * FROM dbo.StringSplit(TRIM('','' FROM '''+ @AnaTypeList+''' ), '','') ))'
	SET @OrderBy = 'AT0005.TypeID'
	
	-- Kiểm tra điều kiện search
	IF ISNULL(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'AND (AT0005.DivisionID = '''+@DivisionID+''' OR AT0005.DivisionID = ''@@@'')'
	IF ISNULL(@TypeID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT0005.TypeID,'''') LIKE N''%'+@TypeID+'%'' '
	IF ISNULL(@UserName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT0005.UserName,'''') LIKE N''%'+@UserName+'%'' '
	IF ISNULL(@UserNameE, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT0005.UserNameE, '''') LIKE N''%'+@UserNameE+'%'' '
	IF ISNULL(@SystemName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT0005.SystemName,'''') LIKE N''%'+@SystemName+'%'' '
	IF ISNULL(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT0005.IsCommon,'''') LIKE N''%'+ISNULL(@IsCommon, 0)+'%'' '
	IF ISNULL(@IsUsed, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT0005.IsUsed,'''') LIKE N''%'+ISNULL(@IsUsed, 0)+'%'' '
	
	--Kiểm tra load mặc định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				DECLARE @AT0005 TABLE 
				(
  					DivisionID NVARCHAR(50),
  					TypeID NVARCHAR(50),
  					SystemName NVARCHAR(250),
  					UserName NVARCHAR(250),
  					IsUsed TINYINT,
  					UserNameE NVARCHAR(250),
  					Status TINYINT,
  					IsCommon TINYINT,
  					IsExtraFee TINYINT,
					ReTypeID NVARCHAR(50),
					AllocationLevelID TINYINT,
					APK UNIQUEIDENTIFIER
				)
			 INSERT INTO @AT0005
			 (
 				DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE, Status,
				IsCommon, IsExtraFee, ReTypeID, AllocationLevelID, APK
			 )
			 SELECT AT05.DivisionID, AT05.TypeID, AT05.SystemName, AT05.UserName ,
					AT05.IsUsed, AT05.UserNameE, AT05.Status, AT05.IsCommon, AT05.IsExtraFee,
					AT05.ReTypeID, AT05.AllocationLevelID, AT05.APK
			 FROM AT0005 AT05 WITH (NOLOCK)
			 '
    SET @sSQL01='
						DECLARE @CountTotal NVARCHAR(MAX)
						DECLARE @CountEXEC TABLE (CountRow NVARCHAR(MAX))
						IF '+CAST(@PageNumber AS VARCHAR(2)) + ' = 1
						BEGIN
							INSERT INTO @CountEXEC (CountRow)
							SELECT COUNT(AT0005.TypeID) FROM @AT0005 AT0005 WHERE 1=1 '+ @sWhere +'
						END
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (SELECT CountRow FROM @CountEXEC) AS TotalRow,
					   AT0005.DivisionID,
					   AT0005.TypeID, AT0005.SystemName, AT0005.UserName, AT0005.IsUsed,
					   AT0005.UserNameE, AT0005.Status, AT0005.IsCommon, AT0005.IsExtraFee,
					   AT0005.ReTypeID, AT0005.AllocationLevelID, AT0005.APK
				FROM @AT0005 AS AT0005
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
