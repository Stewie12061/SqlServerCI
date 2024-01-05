IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2165]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2165]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load khoản thu tiền ăn và hoàn trả tiền ăn 
----
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 22/7/2019
-- <Example>
/*
			EDMP2165 @DivisionID = 'BE', @UserID = '',@Mode = 0,@FeeID = 'BP0001',@APK = NULL 
			EDMP2165 @DivisionID = 'BE', @UserID = '',@Mode = 1,@FeeID = NULL,@APK = '86D1FF91-0B60-4D08-B00D-DBE4210DCE38'
		EDMP2165 @DivisionID, @UserID,@Mode,@FeeID,@APK 
		
		EDMP2165 @DivisionID = 'BE', @UserID = '', @Mode = '', @FeeID = '', @APK = '', @LeaveDate = '', @StudentID = '', @Month = '',@Year = '', @SchoolYearID = ''

*/
CREATE PROCEDURE EDMP2165
( 
        @DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@Mode VARCHAR(50), ---0: load màn hình dự thu, 1: load quyết toán
		@APK VARCHAR(50),---APK nghỉ học 
		@LeaveDate DATETIME,
		@StudentID VARCHAR(MAX),
		@Month VARCHAR(50), 
		@Year VARCHAR(50),
		@SchoolYearID VARCHAR(50) 

) 
AS 

IF @Mode = 0 

BEGIN 

DECLARE @sSql NVARCHAR(MAX) = ''
		

SET @sSql = N'
SELECT * FROM 
(
----Lấy khoản thu được check vào dự thu 
SELECT T1.DivisionID,T1.SchoolYearID, T1.StudentID, T2.ReceiptTypeID,T3.ReceiptTypeName,T2.AmountEstimate AS Amount, T2.InheritVoucherID, T2.InheritTransactionID,
T3.TypeOfFee
FROM EDMT2013 T1 WITH (NOLOCK)
OUTER APPLY (SELECT TOP 1 * FROM EDMT2013 A1 WITH (NOLOCK) WHERE T1.SchoolYearID = A1.SchoolYearID AND T1.StudentID = A1.StudentID  AND A1.DeleteFlg = 0 
			 ORDER BY A1.CreateDate DESC) A
LEFT JOIN EDMT2014 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T3.ReceiptTypeID = T2.ReceiptTypeID 
LEFT JOIN EDMT1051 T4 WITH (NOLOCK) ON T3.APK = T4.APKMaster
WHERE T1.DeleteFlg = 0 AND T1.SchoolYearID = '''+@SchoolYearID+''' AND  '''+@Month+''' BETWEEN MONTH(T2.FromDate) AND MONTH(T2.ToDate)
AND '''+@Year+''' BETWEEN YEAR(T2.FromDate) AND YEAR(T2.ToDate)
AND  T1.StudentID  IN ('''+@StudentID+''') AND T4.Business = 4
AND T1.APK = A.APK

UNION ALL 

----Lấy khoản thu tiền ăn hoàn trả 
SELECT DISTINCT T5.DivisionID,T5.SchoolYearID,T5.StudentID,T2.ReceiptTypeID, T3.ReceiptTypeName,T2.AmountOfDay AS Amount, NULL InheritVoucherID , NULL AS InheritTransactionID,
T3.TypeOfFee
FROM EDMT1090 T1 WITH(NOLOCK)
LEFT JOIN EDMT1091 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster 
LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T2.ReceiptTypeID = T3.ReceiptTypeID 
LEFT JOIN EDMT1051 T4 WITH (NOLOCK) ON T3.APK = T4.APKMaster 
LEFT JOIN EDMT2013 T5 WITH (NOLOCK) ON T5.FeeID = T1.FeeID AND T5.SchoolYearID = '''+@SchoolYearID+'''
OUTER APPLY (SELECT TOP 1 * FROM EDMT2013 A1 WITH (NOLOCK) WHERE T5.SchoolYearID = A1.SchoolYearID AND T5.StudentID = A1.StudentID  AND A1.DeleteFlg = 0 
			 ORDER BY A1.CreateDate DESC) A
WHERE T3.TypeOfFee IN (10,11) AND T4.Business = 4 AND T5.StudentID IN ('''+@StudentID+''') 
AND T5.APK = A.APK
) AS A
ORDER BY A.StudentID, A.ReceiptTypeID
'



END 




PRINT @sSql 
EXEC (@sSql)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
