IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load thông tin detail hình thức phỏng vấn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 09/08/2017
---- Modified by on
-- <Example>
---- 
/*
exec HRMP1012 @DivisionID=N'MK',@UserID=N'000054',@InterviewTypeID = '',@PageNumber=1,@PageSize=10
*/
CREATE PROCEDURE HRMP1012
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@InterviewTypeID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = ''

SET @OrderBy = 'HRMP1012_Temp.DetailTypeID'
IF @PageNumber IS NULL 
BEGIN
	SET  @sSQL1=''
	SET @TotalRow = 'NULL'	
END
ELSE if @PageNumber = 1 
BEGIN
SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE 
BEGIN
	SET @TotalRow = 'NULL'
	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
 	

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+N' AS TotalRow, HRMP1012_Temp.*
FROM
(
	SELECT T1.APK, T1.DivisionID, T1.InterviewTypeID, T1.DutyID, T1.DetailTypeID, T1.Description, T1.FromValue, T1.ToValue, T1.Notes,
	CASE WHEN T1.ResultFormat = 0 THEN N''Số''
		WHEN T1.ResultFormat = 1 THEN N''Chuỗi''
		WHEN T1.ResultFormat = 2 THEN N''Xếp loại'' END AS ResultFormat
	FROM HRMT1011 T1 WITH (NOLOCK)
	LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON HT99.ID = T1.ResultFormat AND HT99.Description = ''ResultFormat''
	WHERE T1.InterviewTypeID = '''+@InterviewTypeID+'''
)HRMP1012_Temp		
ORDER BY '+@OrderBy+' '+@sSQL1

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
