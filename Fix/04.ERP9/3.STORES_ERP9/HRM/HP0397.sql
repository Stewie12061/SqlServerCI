IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0397]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0397]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load chi tiết phương pháp tính phép - HF0397
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
-- <Example>
---- 
/*-- <Example>
	EXEC HP0397 @DivisionID='ANG',@MethodVacationID='xyz'
----*/

CREATE PROCEDURE HP0397
( 
	 @DivisionID VARCHAR(50),
	 @APK NVARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)
        
SET @sSQL = ''

SET @sSQL = N'
SELECT H29.*,
CASE WHEN H29.IsWorkDate = 0 THEN N''Ngày vào làm thử việc'' ELSE N''Ngày vào làm chính thức'' END AS IsWorkDateName,
CASE WHEN H29.IsManagaVacation = 0 THEN N''Theo năm'' ELSE N''Theo kỳ'' END AS IsManagaVacationName,
H27.DescriptionID AS SeniorityName, 
CASE WHEN H29.IsPrevVacationDay = 0 THEN N''Chuyển tối đa'' ELSE N''Không vượt quá số phép tồn được chuyển theo thâm niên'' END AS IsPrevVacationDayName
FROM HT1029 H29 WITH (NOLOCK)
LEFT JOIN HT1027 H27 WITH (NOLOCK) ON H27.DivisionID = H29.DivisionID AND H27.SeniorityID = H29.SeniorityID
WHERE H29.DivisionID = ''' +@DivisionID +'''
	AND CONVERT(NVARCHAR(50),H29.APK) = '''+@APK+'''	'


EXEC (@sSQL)
PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
