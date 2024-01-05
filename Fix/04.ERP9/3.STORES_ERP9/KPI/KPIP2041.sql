IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load đổ nguồn màn hình xem thông tin kết quả đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
---- <Example>
---- EXEC KPIP2041 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingResultID='TR0001',@PageNumber=1,@PageSize=25
---- 

CREATE PROCEDURE [dbo].[KPIP2041]
(
	@APKMaster NVARCHAR(50),
	@DepartmentID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY TargetsGroupID)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT APK, APKMaster, DivisionID, STT, TargetsGroupID, TargetsGroupName AS Description, TargetsGroupValue AS Reality, TargetsGroupValue AS RealValue, PercentTargets, TypeTargets
	FROM KPIT2041 WITH (NOLOCK)
	WHERE KPIT2041.APKMaster = ''' + @APKMaster + '''
) A 	
ORDER BY TypeTargets
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'	

PRINT @sSQL			
EXEC (@sSQL)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
