IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- EDMR30003: bc so diem danh hoc vien
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 15/12/2018
-- <Example>
---- 
--	EDMP30003 @DivisionID = 'BE',@LanguageID = 'vi-VN',@DateFrom = '2019-03-01 00:00:00',@DateTo = '2019-04-30 00:00:00',@SchoolYearID= '2016-2017',@GradeID= '',@ClassID= ''
--- EDMP30003 @DivisionID = 'BE',@LanguageID = 'vi-VN',@DateFrom = '2019-03-01 00:00:00',@DateTo = '2019-03-30 00:00:00',@SchoolYearID= 'N2019-2020',@GradeID= '',@ClassID= ''

CREATE PROCEDURE [dbo].[EDMP30003]
( 
	 @DivisionID VARCHAR(MAX),
	 @LanguageID VARCHAR(50),
	 @DateFrom DATETIME,
	 @DateTo DATETIME,
	 @SchoolYearID VARCHAR(50),
	 @GradeID VARCHAR(MAX), 
	 @ClassID VARCHAR(MAX)
)
AS 
SET NOCOUNT ON

 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX) 

-- HD: hiện diện, CP: phép, KP: không phép
--Năm học bắt buộc nhập, nếu trống thì lấy năm học theo theo ngày đến
IF ISNULL(@SchoolYearID,'') = ''
	SELECT TOP 1 @SchoolYearID = SchoolYearID FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 
	AND CONVERT(VARCHAR(10),@DateTo,126) BETWEEN CONVERT(VARCHAR(10), CONVERT(DATE, DateFrom,120), 126) AND CONVERT(VARCHAR(10), CONVERT(DATE, DateTo,120), 126)

 

 ---LẤY DANH SÁCH ĐIỂM DANH ĐÃ LOẠI TRỪ NHỮNG NGÀY ĐIỂM DANH GIỐNG NHAU (LẤY NGÀY SAU CÙNG)
SET @sSQL1 = N'
SELECT T1.DivisionID,T1.GradeID,T1.AttendanceDate, T1.SchoolYearID, T1.ClassID,T1.VoucherNo
INTO #Data 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID 
			AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0
			 ORDER BY T3.CreateDate DESC) A
WHERE   T1.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0 
AND T1.CreateDate = A.CreateDate
 
ORDER BY T1.AttendanceDate


'



SET @sSQL = '
SELECT  A.DivisionID, A.ClassID,D.ClassName, B.StudentID,C.StudentName, A.AttendanceDate
		, B.AvailableStatusID
		, CASE WHEN B.AvailableStatusID = ''HD'' THEN ''X''
				WHEN B.AvailableStatusID = ''CP'' THEN ''P'' 
		ELSE B.AvailableStatusID END AS cValue
	FROM EDMT2040 A WITH(NOLOCK) 
	INNER JOIN EDMT2041 B WITH(NOLOCK) ON A.APK = B.APKMaster
	LEFT JOIN EDMT2010 C WITH (NOLOCK) ON C.DivisionID = A.DivisionID AND C.StudentID = B.StudentID AND C.DeleteFlg = 0 
	LEFT JOIN EDMT1020 D WITH (NOLOCK) ON D.ClassID = A.ClassID
	WHERE A.DivisionID IN (''' + @DivisionID + ''')  AND A.DeleteFlg = 0 AND B.DeleteFlg = 0 
	AND A.AttendanceDate BETWEEN ''' + CONVERT(VARCHAR(8), @DateFrom, 112) + ''' AND ''' + CONVERT(VARCHAR(8), @DateTo, 112) + '''
	AND A.SchoolYearID = ''' + @SchoolYearID + '''
	AND EXISTS (SELECT VoucherNo  FROM #Data T1 WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
'


IF @GradeID <> '' SET @sSQL += ' AND A.GradeID = ''' + @GradeID + ''' '
IF @ClassID <> '' SET @sSQL += ' AND A.ClassID = ''' + @ClassID + ''' '
SET @sSQL += ' ORDER BY  A.AttendanceDate ASC,A.ClassID'

---PRINT @sSQL
EXEC(@sSQL1+@sSQL)

 











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
