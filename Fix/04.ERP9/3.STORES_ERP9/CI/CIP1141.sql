IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid tab thông tin chung (danh mục kho hàng)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Khả Vi, Date: 05/01/2017
-- <Example>
---- 
/*-- <Example>
	CIP1141 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @WareHouseID = 'KC-CT'
	
	CIP1141 @DivisionID, @UserID, @PageNumber, @PageSize, @WareHouseID
----*/

CREATE PROCEDURE CIP1141
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @WareHouseID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50), 
		@TotalRow NVARCHAR(50) = N'', 
		@OrderBy NVARCHAR (MAX) = N''
		
SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
SET @OrderBy = @OrderBy + N' CIT1140.LevelID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
WMT0001.LevelID, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'WMT0099.Description' ELSE 'WMT0099.DescriptionE' END+' AS LevelName, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'WMT0001.UserName' ELSE 'WMT0001.UserNameE' END+' AS UserName, 
CASE WHEN CIT1140.LevelID = '''' THEN 0 
WHEN CIT1140.LevelID <> '''' THEN 1 END AS IsUsed
FROM CIT1140 WITH (NOLOCK) 
LEFT JOIN WMT0001 WITH (NOLOCK) ON CIT1140.DivisionID = WMT0001.DivisionID AND CIT1140.LevelID = WMT0001.LevelID
LEFT JOIN WMT0099 WITH (NOLOCK) ON CIT1140.LevelID = WMT0099.ID AND WMT0099.CodeMaster = ''Level'' AND WMT0099.[Disabled] = 0 
WHERE CIT1140.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND CIT1140.WareHouseID = '''+@WareHouseID+'''
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)


   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
