IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2164]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2164]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load động khoản thu theo biểu phí 
----
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 6/5/2019
----Update by: Lương Mỹ, Date: 12/2/2020

-- <Example>
/*


*/
CREATE PROCEDURE EDMP2164
( 
        @DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@APK VARCHAR(50),
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR(50),
		@Mode INT	---0: Phí dự thu
					---1: Phí quyết toán

) 
AS 

DECLARE @sSQL NVARCHAR(MAX) = N''


IF @Mode = 0
BEGIN 

SET @sSQL = '

SELECT T1.ReceiptTypeID,T1.ReceiptTypeName,T1.TypeOfFee
FROM EDMT1050 T1 WITH (NOLOCK) 
LEFT JOIN EDMT1051 T2 WITH(NOLOCK) ON T1.APK = T2.APKMaster
LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.TypeOfFee AND T3.CodeMaster = ''TypeOfFee''
WHERE T1.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T2.Business = 4 
ORDER BY  T3.OrderNo ASC


'
END 

ELSE IF @Mode = 1
BEGIN 
SET @sSQL = '

SELECT DISTINCT T1.ReceiptTypeID,T1.ReceiptTypeName, T1.TypeOfFee, T3.OrderNo
FROM EDMT1050 T1 WITH (NOLOCK) 
LEFT JOIN EDMT1051 T2 WITH(NOLOCK) ON T1.APK = T2.APKMaster
LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.TypeOfFee AND T3.CodeMaster = ''TypeOfFee''
WHERE T1.DivisionID IN ('''+@DivisionID+''',''@@@'')
AND T1.TypeOfFee IN (10,11,12,13)
ORDER BY  T3.OrderNo

'
END 





PRINT @sSQL
 EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
