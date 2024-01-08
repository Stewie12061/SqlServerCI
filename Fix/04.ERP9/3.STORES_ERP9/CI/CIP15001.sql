IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP15001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP15001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form CIF1500 Danh mục mã phân tích đơn hàng mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 19/12/2022
----Modified by: Tấn Lộc,  Date: 06/01/2023 - Bổ sung điều kiện join
-- <Example>
----    EXEC CIP15001 '1B','','','',1,20

CREATE PROCEDURE CIP15001 (
    @DivisionID VARCHAR(50),
	@AnaID VARCHAR(50),
	@AnaTypeID NVARCHAR(MAX),
    @AnaName NVARCHAR(250),
    @AnaNameE NVARCHAR(250),
	@Disabled VARCHAR(50),
	@PageNumber INT,
	@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

	SET @sWhere = 'AND (OT1002.AnaTypeID LIKE ''P%'')'
	SET @OrderBy = 'OT1002.DivisionID, OT1002.AnaTypeID'
	
	-- Kiểm tra điều kiện search
	IF ISNULL(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'AND OT1002.DivisionID IN ('''+@DivisionID+''', ''@@@'')'
	IF ISNULL(@AnaID,'') != ''
		SET @sWhere = @sWhere + 'AND ISNULL(OT1002.AnaID, '''') LIKE N''%'+@AnaID+'%'' '
	IF ISNULL(@AnaTypeID,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(OT1002.AnaTypeID, '''') IN (SELECT Value FROM dbo.StringSplit('''+@AnaTypeID+''', '',''))'
	IF ISNULL(@AnaName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(OT1002.AnaName, '''') LIKE N''%'+@AnaName+'%'' '
	IF ISNULL(@AnaNameE, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1002.AnaNameE, '''') LIKE N''%'+@AnaNameE+'%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1002.Disabled, '''') LIKE N''%'+ISNULL(@Disabled, 0)+'%'' '
	
	--Kiểm tra load mặc định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'
				DECLARE @OT1002 TABLE
				(
					DivisionID NVARCHAR(50),
					AnaID NVARCHAR(50),
					AnaTypeID NVARCHAR(50),
					AnaName NVARCHAR(250),
					AnaNameE NVARCHAR(250),
					Disabled TINYINT,
					OrdersArea INT,
					APK uniqueidentifier
				)
				INSERT INTO @OT1002
				(
					DivisionID, AnaID, AnaTypeID, AnaName, AnaNameE, Disabled, OrdersArea, APK
				)
				SELECT OT02.DivisionID, OT02.AnaID, AnaTypeID, OT02.AnaName, OT02.AnaNameE, OT02.Disabled, OT02.OrdersArea, OT02.APK
				FROM OT1002 OT02 WITH (NOLOCK)
				'
    set @sSQL01='
						DECLARE @CountTotal NVARCHAR(MAX)
						DECLARE @CountEXEC TABLE (CountRow NVARCHAR(MAX))
						IF '+CAST(@PageNumber AS VARCHAR(2)) + ' = 1
						BEGIN
							INSERT INTO @CountEXEC (CountRow)
							SELECT COUNT(OT1002.AnaID) FROM @OT1002 OT1002 WHERE 1=1 '+ @sWhere +'
						END
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow FROM @CountEXEC) AS TotalRow	,
				 OT1002.DivisionID, OT1002.AnaID, OT05.UserName AS AnaTypeName, OT1002.AnaName, OT1002.AnaNameE, OT1002.Disabled,
				 OT1002.OrdersArea, OT1002.APK, OT05.AnaTypeID
				 FROM @OT1002 AS OT1002
					LEFT JOIN OT1005 OT05 WITH (NOLOCK) ON OT05.AnaTypeID = OT1002.AnaTypeID AND OT05.DivisionID in ('''+@DivisionID+''', ''@@@'')
				 WHERE ISNULL(OT05.IsUsed, 0) = 1 '+@sWhere+'
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
