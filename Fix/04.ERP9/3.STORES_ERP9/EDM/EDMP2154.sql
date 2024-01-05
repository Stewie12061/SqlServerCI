IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2154]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2154]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load thông tin Chuyển nhượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Lương Mỹ on 12/3/2020
-- <Example>
---- 
/*-- <Example>

	
	 
----*/
CREATE PROCEDURE EDMP2154
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode VARCHAR(50)	---0: Load master
						---1: Load detail không phân trang
						---2: Load detail phân trang
)

AS 

DECLARE @sSQL NVARCHAR(MAX),@sOrderBy NVARCHAR(MAX)

SET @sOrderBy = N' ReceiptTypeID'
IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT  T1.*,
T2.SchoolYearID, T2.FromDate, T3.StudentName as StudentName, T4.StudentName as StudentNameReceiver
FROM EDMT2152 T1 WITH(NOLOCK)
LEFT JOIN EDMT2150 T2 WITH(NOLOCK) ON T2.APK= T1.APKMaster
LEFT JOIN EDMT2010 T3 WITH(NOLOCK) ON T3.StudentID = T1.StudentID
LEFT JOIN EDMT2010 T4 WITH(NOLOCK) ON T4.StudentID = T1.StudentIDReceiver
WHERE CONVERT(VARCHAR(50), T1.APK) ='''+ @APK+'''
'

END 



ELSE IF @Mode = 1 ----load danh sách 
BEGIN 

SET @sSQL = N'
SELECT  T1.*,
T2.ReceiptTypeName, T3.Description as PaymentMethodName
FROM EDMT2153 T1 WITH(NOLOCK)
JOIN EDMT1050 T2 WITH(NOLOCK) ON T2.ReceiptTypeID = T1.ReceiptTypeID
LEFT JOIN EDMT0099 T3 WITH(NOLOCK) ON T3.ID = T1.PaymentMethod AND T3.CodeMaster = ''PaymentMethod''
WHERE CONVERT(VARCHAR(50), T1.APKMaster) ='''+ @APK+'''


'



END 

ELSE IF @Mode = 2 ----load danh sách 
BEGIN 

SET @sSQL = N'
SELECT  T1.*,
T2.ReceiptTypeName, T3.Description as PaymentMethodName
INTO #Table 
FROM EDMT2153 T1 WITH(NOLOCK)
JOIN EDMT1050 T2 WITH(NOLOCK) ON T2.ReceiptTypeID = T1.ReceiptTypeID
LEFT JOIN EDMT0099 T3 WITH(NOLOCK) ON T3.ID = T1.PaymentMethod AND T3.CodeMaster = ''PaymentMethod''
WHERE CONVERT(VARCHAR(50), T1.APKMaster) ='''+ @APK+'''

SELECT ROW_NUMBER() OVER (ORDER BY '+@sOrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow, * 
FROM #Table AS Temp
ORDER BY '+@sOrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'




END 





 PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
