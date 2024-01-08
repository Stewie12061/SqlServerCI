IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2153]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2153]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load số tiền ăn hoàn trả chưa đc thanh toán 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 27/2/2020
-- <Example>
---- 
/*-- <Example>
	EDMP2153 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @StudentID = 'PH-M025', @FromDate = '2019-09-01 00:00:00',  @ToDate = '2020-01-30 00:00:00'
	
	 
----*/
CREATE PROCEDURE EDMP2153
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @FromDate DATETIME, --- từ ngày bắt đầu năm học  
	 @ToDate DATETIME, ----Từ ngày bảo lưu,
	 @Mode VARCHAR(50) ----0: Load số tiền hoàn trả tiền ăn, 1: Load dánh sách tiền ăn để update dự thu 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 0 
BEGIN 
SET @sSQL = N'
 
SELECT T2.StudentID,T3.ReceiptTypeID,T4.ReceiptTypeName,SUM(T3.Amount) AS Amount
FROM EDMT2160 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2161 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T2.APKMaster AND T2.DeleteFlg = 0 
LEFT JOIN EDMT2162 T3 WITH(NOLOCK) ON CONVERT(VARCHAR(50),T2.APK) = T3.APKMaster AND T3.DeleteFlg = 0
LEFT JOIN EDMT1050 T4 WITH (NOLOCK) ON T4.ReceiptTypeID = T3.ReceiptTypeID
WHERE T2.DeleteFlg = 0  AND T4.TypeOfFee IN (''10'',''11'') AND T3.IsInherit = 0 
AND T3.Amount > 0 AND T2.StudentID = '''+@StudentID+'''
AND (T1.TranMonth + T1.TranYear * 100) BETWEEN ( MONTH('''+CONVERT(VARCHAR(10),@FromDate,126)+''') + YEAR('''+CONVERT(VARCHAR(10),@FromDate,126)+''') * 100) AND (MONTH('''+CONVERT(VARCHAR(10),@ToDate,126)+''') + YEAR('''+CONVERT(VARCHAR(10),@ToDate,126)+''') * 100)
AND NOT EXISTS (SELECT A.InheritVoucherID,A.InheritTransactionID FROM AT9000 A WITH (NOLOCK) WHERE A.InheritVoucherID = T1.APK AND A.InheritTransactionID = T3.APK AND A.InheritTableID = ''EDMT2160'' AND A.ObjectID = '''+@StudentID+''' )
GROUP BY T2.StudentID,T3.ReceiptTypeID,T4.ReceiptTypeName
ORDER BY T3.ReceiptTypeID


'

END 



ELSE IF @Mode = 1 ----load danh sách 
BEGIN 

SET @sSQL = N'
 
SELECT T1.APK AS InheritVoucherID, T3.APK AS InheritTransactionID,T2.StudentID,T3.ReceiptTypeID,T4.ReceiptTypeName,T3.Amount 
FROM EDMT2160 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2161 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T2.APKMaster AND T2.DeleteFlg = 0 
LEFT JOIN EDMT2162 T3 WITH(NOLOCK) ON CONVERT(VARCHAR(50),T2.APK) = T3.APKMaster AND T3.DeleteFlg = 0
LEFT JOIN EDMT1050 T4 WITH (NOLOCK) ON T4.ReceiptTypeID = T3.ReceiptTypeID
WHERE T2.DeleteFlg = 0  AND T4.TypeOfFee IN (''10'',''11'') AND T3.IsInherit = 0 
AND T3.Amount > 0 AND T2.StudentID = '''+@StudentID+'''
AND (T1.TranMonth + T1.TranYear * 100) BETWEEN ( MONTH('''+CONVERT(VARCHAR(10),@FromDate,126)+''') + YEAR('''+CONVERT(VARCHAR(10),@FromDate,126)+''') * 100) AND (MONTH('''+CONVERT(VARCHAR(10),@ToDate,126)+''') + YEAR('''+CONVERT(VARCHAR(10),@ToDate,126)+''') * 100)
AND NOT EXISTS (SELECT A.InheritVoucherID,A.InheritTransactionID FROM AT9000 A WITH (NOLOCK) WHERE A.InheritVoucherID = T1.APK AND A.InheritTransactionID = T3.APK AND A.InheritTableID = ''EDMT2160'' AND A.ObjectID = '''+@StudentID+''' )

ORDER BY T3.ReceiptTypeID


'



END 







 ---PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
