IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2082]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load  xem thông tin quyết định nghỉ học LOAD (DETAIL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 28/11/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2082 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '1111111111111111111111111111111', @LanguageID= 'vi-VN',@Mode = '1',@PageNumber = '1',@PageSize = '25'

	EDMP2082 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2082
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @Mode VARCHAR(50),
	 @PageNumber INT = 1,
	 @PageSize INT = 25

)

AS 

DECLARE @sSQL NVARCHAR(MAX),
		@TotalRow NVARCHAR(50)


SET @sSQL = N'

	T1.APKVoucher,T1.DivisionID,T1.StudentID,	T1.Reason
	,T2.StudentName
	,T2.DateOfBirth
	FROM EDMT2080 T1 WITH (NOLOCK) 
	LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID
	WHERE ISNULL(T1.APKVoucher, T1.APK) = '''+@APK+''' AND T1.DeleteFlg = 0

	'
		
IF @Mode = 0 
BEGIN 

SET @sSQL = N'
	SELECT 
	' + @sSQL
END 


ELSE IF @Mode = 1
BEGIN 

 
		SET @TotalRow = 'COUNT(1) OVER ()'

		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY  T1.StudentID) AS RowNum, ' + @TotalRow + ' AS TotalRow,
		' + @sSQL


END 


PRINT @sSQL
 EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

