IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo hoàn trả tiền ăn chi tiết  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 13/9/2019
-- <Example>
---- 
/*-- <Example>
  
  EXEC EDMP30009 'VS', 'BGD',12,2018
  EDMP30009 @DivisionID= 'BE',@FromDate = '',@ToDate = '',@GradeID

----*/

CREATE PROCEDURE EDMP30009
(
	@DivisionID			VARCHAR(MAX),
	@FromDate 			DATETIME,
	@ToDate				DATETIME,
	@GradeID			VARCHAR(MAX)		
)
AS
DECLARE @sSQL   NVARCHAR(MAX),
		@sSQL1   NVARCHAR(MAX),
		@sSQL2   NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
	

 

IF @GradeID <> '' 
		SET @sWhere = @sWhere + ' AND T1.GradeID IN ('''+@GradeID+''') '

--IF @Mode = 0 
BEGIN 


 SET @sSQL1 = '
 ----Lấy danh sách các nghỉ có phép và không phép so với đơn xin phép 

 SELECT T1.DivisionID,T5.DivisionName, T2.StudentID,T4.StudentName, T1.GradeID,T7.GradeName,T1.ClassID,T6.ClassName,
 T1.AttendanceDate, T3.CreateDate, T3.FromDate, T3.ToDate, T2.Reason AS ReasonTeacher, T3.ReasonNotes AS ReasonParent 
 FROM EDMT2040 T1 WITH (NOLOCK) 
 OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.DivisionID = T3.DivisionID AND T1.ClassID = T3.ClassID 
			AND T1.GradeID = T3.GradeID AND T1.SchoolYearID = T3.SchoolYearID AND T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
 LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
 LEFT JOIN APT0008 T3 WITH (NOLOCK) ON T3.DivisionID  = T1.DivisionID AND T3.StudentID = T2.StudentID 
 AND T1.DeleteFlg = T3.DeleteFlg AND T3.SchoolYearID = T1.SchoolYearID AND T1.GradeID = T3.GradeID AND T1.ClassID = T3.ClassID AND T1.AttendanceDate BETWEEN T3.FromDate AND T3.ToDate
 LEFT JOIN EDMT2010 T4 WITH  (NOLOCK) ON T4.DivisionID = T1.DivisionID AND T4.StudentID = T2.StudentID AND T4.DeleteFlg = T1.DeleteFlg
 LEFT JOIN AT1101 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID 
 LEFT JOIN EDMT1020 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ClassID = T1.ClassID
 LEFT JOIN EDMT1000 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID,''@@@'') AND T7.GradeID = T1.GradeID
 WHERE T1.DivisionID  IN ('''+@DivisionID+''') AND T1.DeleteFlg = 0 AND T2.AvailableStatusID != ''HD''
 AND  CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''
 AND T1.CreateDate = A.CreateDate 
 '+@sWhere+'


 '

END 

--ELSE IF @Mode = 1
BEGIN 

 SET @sSQL2 = '
 ----Lấy số tiền ăn hoàn trả lại 
 SELECT * FROM (
SELECT T1.DivisionID, T1.GradeID, T1.ClassID, T1.SchoolYearID, T1.TranMonth, T1.TranYear, T2.StudentID, T1.FeeID, T5.Amount, T6.IsMoney
FROM EDMT2160 T1 WITH (NOLOCK)
LEFT JOIN EDMT2161 T2 WITH (NOLOCK) ON  T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
LEFT JOIN EDMT2162 T3 WITH (NOLOCK) ON CONVERT(VARCHAR(50), T2.APK) = T3.APKMaster
LEFT JOIN EDMT1090 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T1.FeeID = T4.FeeID 
LEFT JOIN EDMT1091 T5 WITH (NOLOCK) ON CONVERT(VARCHAR(50), T4.APK) = T5.APKMaster AND T3.ReceiptTypeID = T5.ReceiptTypeID
LEFT JOIN EDMT1050 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T5.ReceiptTypeID= T6.ReceiptTypeID  
WHERE  T1.DivisionID  IN ('''+@DivisionID+''') AND T1.TranMonth BETWEEN  MONTH('''+CONVERT(VARCHAR(10),@FromDate,126)+''') AND MONTH('''+CONVERT(VARCHAR(10),@ToDate,126)+''') 
AND T1.DeleteFlg = 0 AND ISNULL(T6.IsMoney,0) IN (2,3)
'+@sWhere+'

 UNION ALL
 SELECT 
EDM.DivisionID, T1.GradeID, T1.ClassID, T1.SchoolYearID, MONTH('''+CONVERT(VARCHAR(10),@FromDate,126)+''') TranMonth, YEAR('''+CONVERT(VARCHAR(10),@FromDate,126)+''') TranYear, EDM.StudentID, A.FeeID, A.Amount, A.IsMoney
FROM dbo.EDMT2010 EDM
INNER JOIN EDMT2021 T2 WITH (NOLOCK) ON  edm.StudentID = t2.StudentID
INNER JOIN EDMT2020 T1 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
LEFT JOIN (
SELECT EDMT1091.DivisionID,EDMT1050.IsMoney, EDMT1091.Amount, MAX(FeeID) AS FeeID FROM EDMT1091
LEFT JOIN EDMT1090 ON EDMT1090.APK = EDMT1091.APKMaster
LEFT JOIN EDMT1050 WITH (NOLOCK) ON EDMT1091.DivisionID IN (EDMT1091.DivisionID,''@@@'') AND EDMT1091.ReceiptTypeID= EDMT1050.ReceiptTypeID  
WHERE ISNULL(EDMT1050.IsMoney,0) IN (2,3)
GROUP BY EDMT1091.DivisionID,EDMT1050.IsMoney, EDMT1091.Amount
) A ON EDM.DivisionID = A.DivisionID
WHERE  EDM.DivisionID  IN ('''+@DivisionID+''')
)A ORDER BY A.DivisionID, A.StudentID, A.IsMoney
 '



END 
 
PRINT   @sSQL2
exec (@sSQL1 + @sSQL2)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
