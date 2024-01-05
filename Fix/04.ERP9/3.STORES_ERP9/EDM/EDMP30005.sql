IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















-- <Summary>
---- EDMR30005: bc si so hang ngay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 30/11/2018
----Modify by: Đình Hoà, Date: 10/02/2020 - Thay đổi các tên bí danh của các bange ở Mode = 2 bảng chuyển trường
----									  - Thay đổi câu lệnh load sĩ số học sinh của tháng trước
-- <Example>
---- 
--	exec sp_executesql N'EDMP30005 @DivisionID=N''BE'',@ClassID=null,@Date=N''2019-10-01 00:00:00'',@SchoolYearID=null,@Mode=N''0''',N'@CreateUserID nvarchar(4),@LastModifyUserID nvarchar(4),@DivisionID nvarchar(2)',@CreateUserID=N'TEST',@LastModifyUserID=N'TEST',@DivisionID=N'BE'


--- EDMP30005 @DivisionID,@Date, @SchoolYearID,@ClassID, @Mode
--- 

CREATE PROCEDURE [dbo].[EDMP30005]
( 
	 @DivisionID VARCHAR(MAX),
	 @Date DATETIME,
	 @SchoolYearID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @Mode VARCHAR(50)
)
AS 
SET NOCOUNT ON

 
DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(MAX) =''
DECLARE @dStartMonth DATETIME, @dStartPreMonth DATETIME, @dEndPreMonth DATETIME, @dEndMonth DATETIME
DECLARE @DayAvailable INT = 0, @DayAbsentPermission INT = 0, @DayAbsentNotPermission INT = 0
DECLARE @FromDate DATETIME 

---Đầu tháng 
SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @Date), 0)
---Cuối tháng 
SELECT @dEndMonth = DATEADD(dd,-(DAY(DATEADD(mm,1,@Date))),DATEADD(mm,1,@Date))
---Đầu tháng trước 
SELECT @dStartPreMonth = DATEADD(mm, -1, @dStartMonth)
---Ngày cuối tháng trước 
SELECT @dEndPreMonth = DATEADD(dd, -1, @dStartMonth)


IF @ClassID <> ''
		SET @sWhere = @sWhere + ' AND T2.ClassID = ''' + @ClassID + ''' '



IF ISNULL (@SchoolYearID,'') = ''
	SELECT TOP 1 @SchoolYearID = SchoolYearID, @FromDate = DateFrom FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND @Date BETWEEN DateFrom AND DateTo


------Truyền nhiều Division 
 

IF OBJECT_ID('tempdb..#Data ') IS NOT NULL 
DROP TABLE #Data 

---LẤY DANH SÁCH ĐIỂM DANH ĐÃ LOẠI TRỪ NHỮNG NGÀY ĐIỂM DANH GIỐNG NHAU (LẤY NGÀY SAU CÙNG)
SELECT T1.DivisionID,T1.GradeID,T1.AttendanceDate, T1.SchoolYearID, T1.ClassID,T1.VoucherNo
INTO #Data 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg =0
			 ORDER BY T3.CreateDate DESC) A
WHERE   T1.SchoolYearID = @SchoolYearID AND T1.DeleteFlg = 0 
AND T1.CreateDate = A.CreateDate
 
ORDER BY T1.AttendanceDate


IF @Mode = 0 
BEGIN 
-----Lấy sỉ số lớp của tháng hiện tại 
SELECT COUNT(DISTINCT T2.StudentID) AS Quantity,T1.ClassID,T1.DivisionID
INTO #Temp1
FROM EDMT2040 T1 WITH (NOLOCK)
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
LEFT JOIN EDMT1040 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,'@@@') AND T3.SchoolYearID = T1.SchoolYearID
WHERE   T1.SchoolYearID = @SchoolYearID AND T1.AttendanceDate BETWEEN T3.DateFrom AND @Date
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
AND T1.DeleteFlg = 0
GROUP BY T1.ClassID,T1.DivisionID


---SỈ SỐ HỌC SINH HIỆN DIỆN TRONG THÁNG HIỆN TẠI 
SELECT ISNULL(COUNT(T2.StudentID),0) AS DayAvailable,T1.ClassID,T1.DivisionID
INTO #Temp2_1
FROM EDMT2040 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE   T1.SchoolYearID = @SchoolYearID  AND T2.AvailableStatusID = 'HD' AND T1.AttendanceDate = @Date ----BETWEEN @dStartMonth AND @Date  
AND T1.DeleteFlg = 0
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
GROUP BY T2.AvailableStatusID,T1.ClassID,T1.DivisionID


---SỈ SỐ HỌC SINH VẮNG CÓ PHÉP TRONG THÁNG HIỆN TẠI 
SELECT ISNULL(COUNT(T2.StudentID),0) AS DayAbsentPermission,T2.AvailableStatusID,T1.ClassID,T1.DivisionID
INTO #Temp2
FROM EDMT2040 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE  T1.SchoolYearID = @SchoolYearID  AND T2.AvailableStatusID = 'CP' AND T1.AttendanceDate = @Date ----BETWEEN @dStartMonth AND @Date
AND T1.DeleteFlg = 0 
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
GROUP BY T2.AvailableStatusID,T1.ClassID,T1.DivisionID



---SỈ SỐ VẮNG KHÔNG PHÉP TRONG THÁNG HIỆN TẠI  
SELECT ISNULL(COUNT(T2.StudentID),0) AS DayAbsentNotPermission,T2.AvailableStatusID,T1.ClassID,T1.DivisionID
INTO #Temp3
FROM EDMT2040 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE  T1.SchoolYearID = @SchoolYearID AND T2.AvailableStatusID = 'KP' AND T1.AttendanceDate = @Date ----BETWEEN @dStartMonth AND @Date
AND T1.DeleteFlg = 0 
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
GROUP BY T2.AvailableStatusID,T1.ClassID,T1.DivisionID



---Bé nghỉ luôn 


--SELECT COUNT(EDMT2021.StudentID) AS DayLeaveSchool, EDMT2020.ClassID,	EDMT2020.DivisionID
--	--EDMT2020.DivisionID, EDMT2020.ArrangeClassID, EDMT2021.IsTransfer AS StatusID, EDMT2021.LastModifyDate
--	INTO #Temp5
--	FROM EDMT2020 WITH (NOLOCK) 
--	LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
--	LEFT JOIN EDMT2010 E2010 WITH(NOLOCK) ON EDMT2021.StudentID = E2010.StudentID AND E2010.DeleteFlg = 0
--	WHERE  EDMT2020.DeleteFlg = 0
--		--			(Bảo lưu & Nghỉ học)					OR		(Chuyển trường)
--		AND ( (EDMT2021.DeleteFlg = 1 AND EDMT2021.IsTransfer IN (3,4)) OR (E2010.StatusID = 5 AND EDMT2021.DeleteFlg = 1))
--		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) = @Date
--		GROUP BY EDMT2020.ClassID, EDMT2020.DivisionID 
		

SELECT COUNT(StudentID) AS DayLeaveSchool, A.DivisionID,A.ClassID
INTO #Temp5
FROM 
(
SELECT T1.DivisionID,
T1.LeaveDate,T1.StudentID, T3.ClassID,
'LeaveSchool' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
WHERE  T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) =  @Date 
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)
  

 UNION ALL 
 
 -----Bảo lưu  
 SELECT T1.DivisionID,
 T1.FromDate AS LeaveDate,T1.StudentID,T1.ClassID, 
 'Reserve' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) = @Date
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )
 
 UNION ALL 

 ---Chuyển trường 
 SELECT T1.DivisionID,
 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.ClassID, 
 'Transfer' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 WHERE  T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) = @Date
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
) AS A
GROUP BY A.ClassID, A.DivisionID




  
------Bé tăng, học lại

--SELECT COUNT(EDMT2021.StudentID) AS DayStudentIncrease, EDMT2020.ClassID,	EDMT2020.DivisionID
--	INTO #Temp7
--	FROM EDMT2020  WITH (NOLOCK) 
--	LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
--	WHERE EDMT2020.DeleteFlg = 0
--		--	0: Bé tăng,học lại || 2: Bé điều chuyển đến
--		AND ( (EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)))
--		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) = @Date
--		GROUP BY EDMT2020.ClassID, EDMT2020.DivisionID 


SELECT ISNULL(XL,0) + ISNULL(DC,0) + ISNULL(NH,0) AS DayStudentIncrease,T1.ClassID, T1.DivisionID
INTO #Temp7
FROM EDMT2020 T1 WITH (NOLOCK) 
LEFT JOIN 
(
SELECT COUNT(EDMT2021.StudentID) AS XL, EDMT2020.ClassID,	EDMT2020.DivisionID
	FROM EDMT2020  WITH (NOLOCK) 
	LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
	WHERE EDMT2020.DeleteFlg = 0
		--	0: Bé tăng,học lại || 2: Bé điều chuyển đến
		AND ( (EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)))
		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) = @Date
		GROUP BY EDMT2020.DivisionID,EDMT2020.ClassID 
) AS T2 ON T1.DivisionID = T2.DivisionID AND T1.ClassID = T2.ClassID 
  
LEFT JOIN 
(
SELECT T1.ClassID,	T1.DivisionID,COUNT(T2.StudentID) AS NH
FROM EDMT2020 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DivisionID = T1.DivisionID
WHERE 	 T2.DeleteFlg = 1 AND T2.IsTransfer IN (3,4) AND
CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) = @Date
		GROUP BY T1.DivisionID,T1.ClassID
) AS T3 ON T1.DivisionID = T3.DivisionID AND T1.ClassID = T3.ClassID 

LEFT JOIN ----Bổ sung trường hợp nếu ngày 18/10 bé đc thêm nhưng ngày 30/10 điều chuyển in lại báo cáo ngày 18 thì vẫn hiện bé tăng 
(
SELECT A1.ClassID,	A1.DivisionID,COUNT(A2.StudentID) AS DC
FROM EDMT2020 A1 WITH (NOLOCK) 
LEFT JOIN EDMT2021 A2 WITH (NOLOCK) ON A1.APK = A2.APKMaster AND A2.DivisionID = A1.DivisionID
WHERE 	 A2.DeleteFlg = 1 AND A2.IsTransfer = 1  AND
CONVERT(VARCHAR(10), CONVERT(DATE, A2.CreateDate,120), 126) = @Date
AND EXISTS (SELECT A5.StudentID FROM EDMT2140 A5 WITH (NOLOCK) WHERE A5.DivisionID = A1.DivisionID AND A5.StudentID = A2.StudentID 
			  AND A5.DeleteFlg = 0 AND A5.DivisionID != A5.SchoolIDTo)
		GROUP BY A1.DivisionID,A1.ClassID
) AS T4 ON T4.DivisionID = T1.DivisionID AND T1.ClassID = T4.ClassID 



 

-----Giáo viên (SUM GIÁO VIÊN VÀ BẢO MẪU )

SELECT SUM ( EDMT2030.TeacherID + EDMT2030.NannyID) AS TeacherQuantity, EDMT2030.ClassID,EDMT2030.DivisionID 
INTO #Temp6
FROM 
(
SELECT COUNT(DISTINCT B.TeacherID) AS TeacherID,COUNT(DISTINCT C.NannyID) AS NannyID, A.ClassID,A.DivisionID 
FROM EDMT2030 A WITH (NOLOCK)
LEFT JOIN EDMT2031 B WITH (NOLOCK) ON A.APK = B.APKMaster AND A.DeleteFlg = B.DeleteFlg
LEFT JOIN EDMT2032 C WITH (NOLOCK) ON C.APKMaster =  A.APK AND  A.DeleteFlg = C.DeleteFlg
WHERE   A.SchoolYearID = @SchoolYearID AND A.DeleteFlg = 0 AND B.DeleteFlg = 0 
GROUP BY A.ClassID ,A.DivisionID
) AS EDMT2030 
GROUP BY EDMT2030.ClassID,EDMT2030.DivisionID 



-- -----SỈ SỐ THÁNG TRƯỚC 
--SELECT COUNT(DISTINCT T2.StudentID) AS QuantityPreMonth,T1.ClassID,T1.DivisionID
--INTO #Temp4
--FROM EDMT2040 T1 WITH (NOLOCK)
--LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
--LEFT JOIN EDMT1040 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,'@@@') AND T3.SchoolYearID = T1.SchoolYearID 
--WHERE    T1.SchoolYearID = @SchoolYearID  AND T1.AttendanceDate =  @dEndPreMonth AND T1.DeleteFlg = 0 
--AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.VoucherNo = T1.VoucherNo)
--GROUP BY T1.ClassID,T1.DivisionID

-- SELECT COUNT(EDMT2021.StudentID)  AS TotalStudent, EDMT2020.ClassID,	EDMT2020.DivisionID, B.Leave
-- INTO #Temp8
-- FROM EDMT2020 WITH (NOLOCK) 
-- LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
-- LEFT JOIN 
-- (SELECT COUNT(StudentID) AS Leave, A.DivisionID,A.ClassID
--  FROM 
--(
------Nghỉ học
--SELECT T1.DivisionID,
--T1.LeaveDate,T1.StudentID, T3.ClassID,
--'LeaveSchool' AS [Name]
--FROM EDMT2080 T1 WITH (NOLOCK) 
--LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
--WHERE  T1.DeleteFlg = 0
--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @FromDate  AND @dEndPreMonth
--AND T1.OldStatusID != 4 
--AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)
  

-- UNION ALL 
 
-- -----Bảo lưu 
-- SELECT T1.DivisionID,
-- T1.FromDate AS LeaveDate,T1.StudentID,T1.ClassID, 
-- 'Reserve' AS [Name] 
-- FROM EDMT2150 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @FromDate  AND @dEndPreMonth
--  AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

-- UNION ALL 

-- ---Chuyển trường 
-- SELECT T1.DivisionID,
-- T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.ClassID, 
-- 'Transfer' AS [Name] 
-- FROM EDMT2140 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @FromDate  AND @dEndPreMonth
-- AND T1.DivisionID != T1.SchoolIDTo
-- AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
--) AS A
--GROUP BY A.DivisionID,A.ClassID
-- )  AS B ON B.DivisionID = EDMT2020.DivisionID AND EDMT2020.ClassID = B.ClassID
 
-- WHERE  EDMT2020.DeleteFlg = 0
--		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = EDMT2021.DivisionID AND 
--						EDMT2021.StudentID = A1.StudentID  AND EDMT2021.APK = A1.APK 
--						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (EDMT2021.IsTransfer IN (1,2) AND EDMT2021.DeleteFlg = 1 
--						AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) < @dEndPreMonth))

--		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) <= @dEndPreMonth		
-- GROUP BY EDMT2020.ClassID,	EDMT2020.DivisionID, B.Leave

--Load sĩ số học sinh của tháng trước so với @Date
SELECT COUNT(EDMT2021.StudentID)  AS TotalStudent, EDMT2020.ClassID, EDMT2020.DivisionID
INTO #Temp8
FROM EDMT2020 
LEFT JOIN EDMT2021  ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
WHERE (
---TRường hợp : lấy học sinh đã học ở lớp đó và không có thay đổi trạng thái IsTranfer và ngày xếp lớp(ngày tạo) phải nhỏ hơn ngày cuối cùng của tháng
--- Loại bỏ các trường hợp thay đổi cùng một ngày với ngày xếp lớp(ngày tạo)
		(EDMT2021.CreateDate = EDMT2021.LastModifyDate AND EDMT2021.IsTransfer NOT IN (1,3,4,5)
		 AND CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) >= CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126))
	   OR 
---Trường hợp : Lấy các học sinh đã có trạng thái IsTranfer thay đổi nhưng ngày cập nhật không nằm trong điều kiện thì vẫn ở trong lớp đó
	   (CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) >= CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) < CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126))
	 ) 
GROUP BY EDMT2020.ClassID, EDMT2020.DivisionID


SET @sSQL = N'
-----xuất ra báo cáo 
SELECT DISTINCT T1.DivisionID,T9.DivisionName, T2.ClassID,T8.ClassName, T2.Quantity, T3.AvailableStatusID,T10.DayAvailable,T3.DayAbsentPermission,
--(ISNULL(TotalStudent,0) - ISNULL(Leave,0)) QuantityPreMonth,
ISNULL(T5.TotalStudent,0) AS QuantityPreMonth,
 T6.DayLeaveSchool, T7.TeacherQuantity, T4.DayAbsentNotPermission,T11.DayStudentIncrease
FROM EDMT2020 T1 WITH (NOLOCK) 
LEFT JOIN #Temp1 T2 WITH (NOLOCK) ON T1.ClassID = T2.ClassID AND T1.DivisionID = T2.DivisionID
LEFT JOIN #Temp2 T3 WITH (NOLOCK) ON T1.ClassID = T3.ClassID AND T1.DivisionID = T3.DivisionID
LEFT JOIN #Temp2_1 T10 WITH (NOLOCK) ON T1.ClassID = T10.ClassID AND T1.DivisionID = T10.DivisionID
LEFT JOIN #Temp3 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID AND T1.DivisionID = T4.DivisionID
LEFT JOIN #Temp8 T5 WITH (NOLOCK) ON T1.ClassID = T5.ClassID AND T1.DivisionID = T5.DivisionID
LEFT JOIN #Temp5 T6 WITH (NOLOCK) ON T1.ClassID = T6.ClassID AND T1.DivisionID = T6.DivisionID 
LEFT JOIN #Temp6 T7 WITH (NOLOCK) ON T1.ClassID = T7.ClassID AND T1.DivisionID = T7.DivisionID
LEFT JOIN EDMT1020 T8 WITH (NOLOCK) ON T8.DivisionID IN (T1.DivisionID,''@@@'') AND T8.ClassID = T2.ClassID
LEFT JOIN AT1101 T9 WITH (NOLOCK) ON T9.DivisionID = T1.DivisionID
LEFT JOIN #Temp7 T11 WITH (NOLOCK) ON T1.ClassID = T11.ClassID AND T1.DivisionID = T11.DivisionID
WHERE T1.DivisionID IN ('''+@DivisionID+''') AND T1.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0 AND ISNULL(T2.ClassID,'''') != ''''
 '+ @sWhere +'
'

PRINT (@sSQL)
END 



ELSE IF @Mode = 1 ----danh sách học sinh nghỉ luôn trong tháng (nghỉ học + bảo lưu + chuyển trường )
BEGIN 

DECLARE @sWhere1 NVARCHAR(MAX) = ''

IF @ClassID <> ''
		SET @sWhere1 = @sWhere1 + ' AND T3.ClassID = ''' + @ClassID + ''' '

SET @sSQL = N'
SELECT T1.DivisionID,T1.LeaveDate,T1.StudentID,T5.StudentName, T3.ClassID, T4.ClassName,T1.Reason,
CASE WHEN ISNULL(FatherMobiphone,'''') != '''' THEN FatherMobiphone ELSE MotherMobiphone END AS PhoneNumber,
''LeaveSchool'' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = T3.ClassID
LEFT JOIN EDMT2010 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.StudentID = T1.StudentID AND T5.DeleteFlg = 0
WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T3.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)
  '+ @sWhere1 +'

 UNION ALL 
 
 -----Bảo lưu 
 SELECT T1.DivisionID,T1.FromDate AS LeaveDate,T1.StudentID, T2.StudentName,T1.ClassID, T3.ClassName,T1.Reason,
 CASE WHEN ISNULL(T2.FatherMobiphone,'''') != '''' THEN T2.FatherMobiphone ELSE T2.MotherMobiphone END AS PhoneNumber,
 ''Reserve'' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
 LEFT JOIN EDMT1020 T3 WITH (NOLOCK) ON T3.ClassID = T1.ClassID
 LEFT JOIN EDMT2020 T4 WITH(NOLOCK) ON T1.SchoolYearID = T4.SchoolYearID AND T1.GradeID = T4.GradeID AND T1.ClassID = T4.ClassID AND T4.DeleteFlg = 0
 WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
 AND T1.SchoolYearID = '''+@SchoolYearID+'''
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T4.APK AND T1.StudentID = EDMT2021.StudentID )
  '+ @sWhere1 +'

 UNION ALL 

 ---chuyển trường 
 SELECT T1.DivisionID,T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T2.StudentName, T3.ClassID, T4.ClassName,T1.Reason,
 CASE WHEN ISNULL(T2.FatherMobiphone,'''') != '''' THEN T2.FatherMobiphone ELSE T2.MotherMobiphone END AS PhoneNumber,
 ''Transfer'' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.ClassID = T3.ClassID
 WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  '+ @sWhere1 +'


'



END 

ELSE IF @Mode = 2 ----Bé mới trong tháng (CHUYỂN ĐẾN + THÊM Ở XẾP LỚP)
BEGIN 


DECLARE @sWhere2 NVARCHAR(MAX) = ''

IF @ClassID <> ''
		SET @sWhere2 = @sWhere2 + ' AND T1.ClassID = ''' + @ClassID + ''' '

SET @sSQL = N'
SELECT T1.DivisionID,T2.StudentID,T3.StudentName,  T1.ClassID,T4.ClassName,
CASE WHEN ISNULL(T3.FatherMobiphone,'''') != '''' THEN T3.FatherMobiphone ELSE T3.MotherMobiphone END AS PhoneNumber
FROM EDMT2020 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2021 T2  WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DivisionID = T1.DivisionID
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID AND T3.DeleteFlg = 0
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ClassID = T1.ClassID 
WHERE T1.DivisionID IN ('''+@DivisionID+''') AND T1.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0
---	0: Bé tăng,học lại || 2: Bé điều chuyển đến
AND ( (T2.DeleteFlg = 0 AND T2.IsTransfer IN (0,2)))
AND CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.SchoolYearID = T1.SchoolYearID AND A.GradeID = T1.GradeID AND A.ClassID = T1.ClassID ) 
 '+ @sWhere2 +'
		  
UNION ALL 

SELECT T1.DivisionID,T2.StudentID,T3.StudentName, T1.ClassID,	T4.ClassName,
CASE WHEN ISNULL(T3.FatherMobiphone,'''') != '''' THEN T3.FatherMobiphone ELSE T3.MotherMobiphone END AS PhoneNumber
FROM EDMT2020 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DivisionID = T1.DivisionID
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID AND T3.DeleteFlg = 0
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ClassID = T1.ClassID 
WHERE T1.DivisionID IN ('''+@DivisionID+''') AND T1.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0 AND 
T2.DeleteFlg = 1 AND T2.IsTransfer IN (3,4) AND 
CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
AND EXISTS (SELECT TOP 1 1  FROM #Data A WHERE T1.DivisionID = A.DivisionID AND A.SchoolYearID = T1.SchoolYearID AND A.GradeID = T1.GradeID AND A.ClassID = T1.ClassID ) 
 '+ @sWhere2 +'

  UNION ALL 
 ---CHUYỂN TRƯỜNG 
SELECT T1.DivisionID,T2.StudentID,T3.StudentName, T1.ClassID, T4.ClassName,
CASE WHEN ISNULL(T3.FatherMobiphone,'''') != '''' THEN T3.FatherMobiphone ELSE T3.MotherMobiphone END AS PhoneNumber
 FROM EDMT2020 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
 LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID AND T3.DeleteFlg = 0
 LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ClassID = T1.ClassID 
 WHERE T1.DivisionID IN ('''+@DivisionID+''') AND T1.SchoolYearID = '''+@SchoolYearID+''' AND T1.DeleteFlg = 0 AND
 T2.DeleteFlg = 1 AND T2.IsTransfer = 1 AND 
 CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126)  BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@dEndMonth,126)+'''
 AND EXISTS (SELECT A5.StudentID FROM EDMT2140 A5 WITH (NOLOCK) WHERE A5.DivisionID = T1.DivisionID AND A5.StudentID = T2.StudentID 
			  AND A5.DeleteFlg = 0 AND A5.DivisionID != A5.SchoolIDTo)
 '+ @sWhere2 +'

'

 
END 


--PRINT (@sSQL)
EXEC (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
