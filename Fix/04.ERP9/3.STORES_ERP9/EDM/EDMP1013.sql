IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Tab thông tin chi tiết EDMF1012: Danh mục định mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 28/08/2018
-- <Example>
---- 
--	EDMP1013 @DivisionID='MK', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'81341292-C926-487C-B208-92E3D0B584E2', @Mode = '0'

CREATE PROCEDURE [dbo].[EDMP1013]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode VARCHAR(1) = '0',
	 @PageNumber INT = 1,
	 @PageSize INT = 25
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @TotalRow NVARCHAR(50)
                
SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(1) OVER ()' ELSE SET @TotalRow = 'NULL'

--SELECT TOP 1 @LanguageID = LanguageID FROM AT14051 WHERE UserID = @UserID
SELECT @LanguageID = ISNULL(@LanguageID, 'vi-VN')

IF @LanguageID = 'vi-VN'
	SET @cLan = ''
ELSE 
	SET @cLan = 'E'

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY a.LevelID) AS RowNum, ' + @TotalRow + ' AS TotalRow,
		a.DivisionID, a.APK, a.APKMaster, a.LevelID, b.LevelName, a.Quantity
	FROM EDMT1011 a WITH(NOLOCK)
	LEFT JOIN (
			SELECT ID AS LevelID, Description' + @cLan + ' AS LevelName FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''Level'' AND [Disabled] = 0
		) b ON a.LevelID = b.LevelID
	WHERE a.APKMaster = ''' + @APK + '''
	ORDER BY a.LevelID
'

IF @Mode = '0' -- VIEW
BEGIN
	SET @sSQL = @sSQL + 'OFFSET ' + LTRIM(STR((@PageNumber-1)) * @PageSize) + ' ROWS
	FETCH NEXT ' + LTRIM(STR(@PageSize)) + ' ROWS ONLY'
END

--PRINT @sSQL
EXEC (@sSQL)


GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

