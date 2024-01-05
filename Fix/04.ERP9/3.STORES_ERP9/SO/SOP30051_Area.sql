IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30051_AREA]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30051_AREA]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh sách khu vực theo chuẩn hoặc theo CustomerIndex
---- Created by Anh Đô on 23/11/2022
---- Updated on 07/02/2023 by Anh Đô: Fix lỗi trùng lặp danh sách khu vực
-- <Example> 

CREATE PROC [DBO].[SOP30051_Area]
			@DivisionID	NVARCHAR(50)
AS

DECLARE @CustomerIndex INT,
		@sSQL NVARCHAR(MAX),
		@TypeID NVARCHAR(MAX)

SELECT @CustomerIndex = CONVERT(INT, c.CustomerName) FROM CustomerIndex c
SELECT @TypeID = TypeID FROM AT0005 WITH (NOLOCK)
      		WHERE DivisionID in (@DivisionID,'@@@') and TypeID like 'O%' and status = 1
			ORDER BY DivisionID
      		, TypeID
print @TypeID
SET @sSQL = N''

IF @CustomerIndex IN (-1, 92)
BEGIN
	SET @sSQL = N'
	SELECT DISTINCT x.AreaID, x.AreaName 
	FROM (SELECT AreaID, AreaName FROM AT1003 With (NOLOCK) 
	WHERE DivisionID IN ('''+ @DivisionID +''',''@@@'') AND Disabled = 0 
	UNION ALL
	SELECT AreaID, AreaName 
	FROM AT1003 With (NOLOCK) 
	WHERE IsCommon = 1 AND Disabled = 0
	) x
	ORDER BY x.AreaID'

END
ELSE --IF @CustomerIndex = 91
BEGIN
	SET @sSQL = N'SELECT A1.AnaID AS AreaID, A1.AnaName AS AreaName
	FROM AT1015 A1 WITH (NOLOCK)
	WHERE A1.AnaTypeID = N'''+@TypeID+''' AND A1.Disabled = 0 AND A1.DivisionID IN ('''+ @DivisionID +''',''@@@'')'
END

PRINT(@sSQL)
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
