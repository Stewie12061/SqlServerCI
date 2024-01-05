IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP1004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab thông tin detail định mức chi phí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 01/11/2018
-- <Example>
---- 
/*-- <Example>
	 FNP1004 @DivisionID = 'BS', @UserID = '', @APK = '5D46A216-DB45-4550-9EEB-6C561688A105',@LanguageID= 'vi-VN', @PageNumber = '1',@PageSize = '25',@Mode = 0
	
	 FNP1004 @DivisionID, @UserID, @APK,@LanguageID,@PageNumber,@PageSize,@Mode
----*/
CREATE PROCEDURE FNP1004
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT 
)

AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N''


SET @OrderBy = 'T1.FeeID'

IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.APKMaster,T1.FeeID,T2.AnaName AS FeeName,T1.UnitID,T3.UnitName,T1.LevelID,T4.AnaName AS LevelName, 
T1.Quantity,T1.FromAmount,T1.ToAmount,T1.CreateUserID,T5.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,
T6.FullName AS LastModifyUserName,T1.LastModifyDate
FROM FNT1001 T1 WITH (NOLOCK) 
LEFT JOIN AT1011 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID, ''@@@'') AND T2.AnaID = T1.FeeID AND T2.AnaTypeID = ''A03''
LEFT JOIN AT1304 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, ''@@@'') AND T3.UnitID = T1.UnitID 
LEFT JOIN AT1015 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.AnaID = T1.LevelID AND T4.AnaTypeID = ''O04''
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.EmployeeID = T1.LastModifyUserID
WHERE T1.APKMaster = '''+@APK+''''
END 

ELSE IF @Mode = 1 
BEGIN 

DECLARE @TotalRow NVARCHAR(50) = N''

SET @TotalRow = 'COUNT(*) OVER ()'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK,T1.DivisionID,T1.APKMaster,T1.FeeID,T2.AnaName AS FeeName,T1.UnitID,T3.UnitName,T1.LevelID,T4.AnaName AS LevelName, 
T1.Quantity,T1.FromAmount,T1.ToAmount,T1.CreateUserID,T5.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,
T6.FullName AS LastModifyUserName,T1.LastModifyDate
FROM FNT1001 T1 WITH (NOLOCK) 
LEFT JOIN AT1011 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID, ''@@@'') AND T2.AnaID = T1.FeeID AND T2.AnaTypeID = ''A03''
LEFT JOIN AT1304 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, ''@@@'') AND T3.UnitID = T1.UnitID 
LEFT JOIN AT1015 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.AnaID = T1.LevelID AND T4.AnaTypeID = ''O04''
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.EmployeeID = T1.LastModifyUserID
WHERE T1.APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+' 

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END 




 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO





