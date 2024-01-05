IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1142]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1142]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin chi tiết cấp quản lý kho theo vị trí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 05/01/2017
-- <Example>
---- 
/*-- <Example>
	CIP1142 @DivisionID = 'VF',  @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @LevelID = 'Level1', @WareHouseID = 'KC-CT'
	
	CIP1142 @DivisionID, @UserID, @PageNumber, @PageSize, @LevelID, @WareHouseID
----*/

CREATE PROCEDURE CIP1142
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LevelID VARCHAR(50), 
	 @WareHouseID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N'',
		@OrderBy NVARCHAR (MAX) = N'', 
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @OrderBy = @OrderBy + N' CIT1141.LevelDetailID'
     
SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, 
CIT1141.APK, CIT1141.APKMaster, CIT1141.LevelDetailID, CIT1141.LevelDetailName, CIT1141.Notes, CIT1141.IsUsed
FROM CIT1141 WITH (NOLOCK)
INNER JOIN CIT1140 WITH (NOLOCK) ON CIT1141.APKMaster = CIT1140.APK
WHERE CIT1140.DivisionID IN ('''+@DivisionID+''') AND CIT1140.WareHouseID = '''+@WareHouseID+'''
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
