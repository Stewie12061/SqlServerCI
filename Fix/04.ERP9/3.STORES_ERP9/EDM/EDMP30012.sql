IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Báo cáo tình hình hoạt động
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khánh Đoan on 22/11/2019
----Update by:	Lương Mỹ on 15/01/2020

-- <Example>
/*

	 EXEC EDMP30012  @DivisionID = 'BE',@UserID = 'ASOFTSUPPORT',@FromDate = '2019-11-01',@ToDate = '2019-11-30' , @Type = 1


*/

CREATE PROCEDURE EDMP30012 ( 
		@DivisionID VARCHAR(MAX),
		@UserID VARCHAR(50),
		@ToDate DATETIME 
) 
AS 
    DECLARE @sSQL NVARCHAR(MAX) = N'',
			@SchoolYearID VARCHAR(50),
            @PreMonth DATETIME,
			@Today DATETIME,
			@GradeID VARCHAR(MAX),
			@Columns NVARCHAR(MAX) = '', -- Biến chứa tên cột 
			@OrderBy NVARCHAR(MAX) = '' -- OrderBy

	SET @OrderBy = N' Order By DivisionID'
	SET @ToDay =  CONVERT(DATE,GETDATE())

	SET @PreMonth = DATEADD(MONTH, -1, @ToDate);


	IF @ToDate > @ToDay
	BEGIN
		SET @ToDate = @ToDay
	END	

	--SELECT @GradeID =STRING_AGG( ISNULL(GradeID, ' '), ''',''') 
	--	FROM EDMT1000 WITH (NOLOCK) 
	--	WHERE [Disabled]=0

	-- BÁO CÁO TỔNG SỐ LƯỢNG HỌC SINH HIỆN TẠI SO VỚI THÁNG TRƯỚC #Table1
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(500),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS TeacherIDTotal, CONVERT(NVARCHAR(500),'') AS Note,
	CONVERT(VARCHAR(50),'') AS GradeID, CONVERT(NVARCHAR(50),'') AS GradeName,
	CONVERT(VARCHAR(50),'') AS SchoolYearID,
	CONVERT(DECIMAL(28,8), 100) AS StudentTotal, CONVERT(DECIMAL(28,8), 100) AS Availabe, CONVERT(DECIMAL(28,8), 100) AS StudentLastMonth,
	CONVERT(DECIMAL(28,8), 100) AS StudentBooking, CONVERT(DECIMAL(28,8), 100) AS StudentIncrease, CONVERT(DECIMAL(28,8), 100) AS StudentDecrease,
	CONVERT(NVARCHAR(500),'') AS Power,
	CONVERT(DECIMAL(28,8), 100) AS AbsentPermission, CONVERT(DECIMAL(28,8), 100) AS Absent, CONVERT(NVARCHAR(500), 100) AS NoteDecrease
	INTO  #Table1

	INSERT INTO #Table1
	EXEC EDMP30004 @DivisionID,@ToDate,@ToDate,'',1


	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID
	INTO  #DivisionFilter

	INSERT INTO #DivisionFilter
	SELECT *
	FROM dbo.StringSplit(@DivisionID,''',''')
	WHERE Value <> ','
	--SELECT * FROM	#DivisionFilter


-- BÁO CÁO TỔNG SỐ LƯỢNG HỌC SINH NGHỈ SO VỚI TUYỂN MỚI THÁNG #Table2
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(50),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentOffline, CONVERT(DECIMAL(28,8), 100) AS StudentReserve, CONVERT(DECIMAL(28,8), 100) AS TotalOffline,
	CONVERT(DECIMAL(28,8), 100) AS StudentComeBack, CONVERT(DECIMAL(28,8), 100) AS StudentNew, CONVERT(DECIMAL(28,8), 100) AS TotalNew
	INTO  #Table2

	INSERT INTO #Table2
	SELECT A1.DivisionID, A1.DivisionName, A2.StudentOffline, A3.StudentReserve, 
	ISNULL(A2.StudentOffline,0) +  ISNULL(A3.StudentReserve,0) AS TotalOffline, 
	A4.StudentComeBack, A5.StudentNew,
	ISNULL(A4.StudentComeBack,0) +  ISNULL(A5.StudentNew,0) AS TotalNew
	FROM AT1101 A1 WITH(NOLOCK)
	LEFT JOIN(
		SELECT T1.DivisionID, COUNT(StudentID) AS StudentOffline
		FROM EDMT2080 T1 WITH(NOLOCK)
		WHERE MONTH(LeaveDate) = MONTH(@ToDate) AND  YEAR(LeaveDate) = YEAR(@ToDate) AND T1.DeleteFlg=0
		AND NOT EXISTS (SELECT TOP 1 1 FROM EDMT2012 T2 WITH(NOLOCK) WHERE T2.DateStudy >= T1.LeaveDate AND T1.StudentID= T2.StudentID AND T2.StudentStatusID=3)
		GROUP BY T1.DivisionID)A2 ON A1.DivisionID = A2.DivisionID
	LEFT JOIN(
		SELECT T1.DivisionID, COUNT(StudentID) AS StudentReserve
		FROM EDMT2150 T1 WITH(NOLOCK)
		WHERE MONTH(@ToDate) = MONTH(FromDate)
		AND YEAR(@ToDate) = YEAR(FromDate)  
		AND T1.DeleteFlg=0
		AND NOT EXISTS (SELECT TOP 1 1 FROM EDMT2012 T2 WITH(NOLOCK) WHERE T2.DateStudy >= T1.FromDate AND T1.StudentID= T2.StudentID AND T2.StudentStatusID=4)
		GROUP BY T1.DivisionID)A3 ON A1.DivisionID = A3.DivisionID
	LEFT JOIN(
	----Bé bảo lưu đi học lại + bé nghỉ học đi học lại
		SELECT T1.DivisionID, COUNT(DISTINCT T1.StudentID) AS StudentComeBack
		FROM EDMT2012 T1 WITH (NOLOCK) 
		-----LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
		WHERE T1.StudentStatusID IN (3,4) 
		AND MONTH(T1.DateStudy) = MONTH(@ToDate) AND  YEAR(T1.DateStudy) = YEAR(@ToDate) AND T1.DeleteFlg=0
		GROUP BY T1.DivisionID)A4 ON A1.DivisionID=A4.DivisionID
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng có kết quả tư vấn là: Đăng ký nhập học ( bao gồm cả chuyển trường)
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentNew
		FROM EDMT2000 T1 WITH (NOLOCK) 
		WHERE T1.ResultID =1 AND T1.DeleteFlg=0
		AND MONTH(T1.VoucherDate) = MONTH(@ToDate) AND  YEAR(T1.VoucherDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A5 ON A1.DivisionID=A5.DivisionID


-- BIỂU ĐỒ SO SÁNH TỶ LỆ TĂNG SO VỚI NGHỈ THÁNG HIỆN TẠI SO VỚI THÁNG TRƯỚC #Table3
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(50),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS TotalOfflinePresent,
	CONVERT(DECIMAL(28,8), 100) AS StudentOffline, CONVERT(DECIMAL(28,8), 100) AS StudentReserve, CONVERT(DECIMAL(28,8), 100) AS TotalOfflinePass,
	CONVERT(DECIMAL(28,8), 100) AS TotalNew
	INTO  #Table3

	INSERT INTO #Table3
	SELECT A1.DivisionID, A1.DivisionName, T2.TotalOffline AS TotalOfflinePresent, 
	A2.StudentOffline, A3.StudentReserve, 
	ISNULL(A2.StudentOffline,0) +  ISNULL(A3.StudentReserve,0) AS TotalOfflinePass,
	T2.TotalNew
	FROM AT1101 A1 WITH(NOLOCK)
	LEFT JOIN(
		SELECT T1.DivisionID, COUNT(StudentID) AS StudentOffline
		FROM EDMT2080 T1 WITH(NOLOCK)
		WHERE MONTH(LeaveDate) = MONTH(@PreMonth) AND  YEAR(LeaveDate) = YEAR(@PreMonth) AND T1.DeleteFlg=0
		AND NOT EXISTS (SELECT TOP 1 1 FROM EDMT2012 T2 WITH(NOLOCK) WHERE T2.DateStudy >= T1.LeaveDate AND T1.StudentID= T2.StudentID AND T2.StudentStatusID=3)
		GROUP BY T1.DivisionID)A2 ON A1.DivisionID = A2.DivisionID
	LEFT JOIN(
		SELECT T1.DivisionID, COUNT(StudentID) AS StudentReserve
		FROM EDMT2150 T1 WITH(NOLOCK)
		WHERE MONTH(@PreMonth) = MONTH(FromDate) 
		AND  YEAR(@PreMonth) = YEAR(FromDate)
		AND T1.DeleteFlg=0

		AND NOT EXISTS (SELECT TOP 1 1 FROM EDMT2012 T2 WITH(NOLOCK) WHERE T2.DateStudy >= T1.FromDate AND T1.StudentID= T2.StudentID AND T2.StudentStatusID=4)
		GROUP BY T1.DivisionID)A3 ON A1.DivisionID = A3.DivisionID
	INNER JOIN #Table2 T2 WITH(NOLOCK) ON T2.DivisionID = A1.DivisionID


-- BÁO CÁO TUYỂN SINH #Table4
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(50),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentNew, CONVERT(DECIMAL(28,8), 100) AS StudentTest, CONVERT(DECIMAL(28,8), 100) AS StudentOfficial,
	CONVERT(DECIMAL(28,8), 100) AS StudentTransfer, CONVERT(DECIMAL(28,8), 100) AS StudentComeBack,
	CONVERT(DECIMAL(28,8), 100) AS StudentIncrease
	INTO  #Table4

	INSERT INTO #Table4
	SELECT A1.DivisionID, A1.DivisionName, A2.StudentNew, 
	A3.StudentTest, A4.StudentOfficial, A5.StudentTransfer, A6.StudentComeBack,
	ISNULL( A3.StudentTest,0) +	ISNULL(A4.StudentOfficial,0) +	ISNULL(A5.StudentTransfer,0) + ISNULL(A6.StudentComeBack,0) AS StudentIncrease
	FROM AT1101 A1 WITH(NOLOCK)
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng ( tất cả trạng thái)
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentNew
		FROM EDMT2000 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0
		AND MONTH(T1.VoucherDate) = MONTH(@ToDate) AND  YEAR(T1.VoucherDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A2 ON A1.DivisionID=A2.DivisionID
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng: Học thử & Giữ chỗ
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentTest
		FROM EDMT2000 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0 AND T1.ResultID IN (2,3)
		AND MONTH(T1.VoucherDate) = MONTH(@ToDate) AND  YEAR(T1.VoucherDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A3 ON A1.DivisionID=A3.DivisionID
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng: Đăng ký nhập học
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentOfficial
		FROM EDMT2000 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0 AND T1.ResultID = 1 AND ISNULL(T1.InheritTranfer,'') = ''
		AND MONTH(T1.VoucherDate) = MONTH(@ToDate) AND  YEAR(T1.VoucherDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A4 ON A1.DivisionID=A4.DivisionID
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng: Chuyển trường với Đăng ký nhập học
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentTransfer
		FROM EDMT2000 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0 AND T1.ResultID = 1 AND ISNULL(T1.InheritTranfer,'') <> ''
		AND MONTH(T1.VoucherDate) = MONTH(@ToDate) AND  YEAR(T1.VoucherDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A5 ON A1.DivisionID=A5.DivisionID
	LEFT JOIN(
	----Bé bảo lưu đi học lại + bé nghỉ học đi học lại
		SELECT  T1.DivisionID, COUNT(DISTINCT T1.StudentID) AS StudentComeBack
		FROM EDMT2012 T1 WITH (NOLOCK) 
		WHERE T1.StudentStatusID IN (3,4) AND T1.DeleteFlg=0
		AND MONTH(T1.DateStudy) = MONTH(@ToDate) AND  YEAR(T1.DateStudy) = YEAR(@ToDate) AND T1.DeleteFlg=0
		GROUP BY T1.DivisionID )A6 ON A1.DivisionID=A6.DivisionID
	WHERE A1.DivisionID IN ( SELECT DivisionID FROM #DivisionFilter)
	ORDER BY A1.DivisionID



--  BÁO CÁO SỐ LƯỢNG BÉ GIẢM THÁNG HIỆN TẠI #Table5
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(50),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentLeave, CONVERT(DECIMAL(28,8), 100) AS StudentReserve,
	CONVERT(DECIMAL(28,8), 100) AS StudentDecrease
	INTO  #Table5

	INSERT INTO #Table5
	SELECT A1.DivisionID, A1.DivisionName, A2.StudentLeave, A3.StudentReserve,
	ISNULL(A2.StudentLeave,0) + ISNULL(A3.StudentReserve,0) AS StudentDecrease
	FROM AT1101 A1 WITH(NOLOCK)
	LEFT JOIN(
	----Số lượng bé học chính thức làm quyết định nghỉ học trong tháng hiện tại
		SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentLeave
		FROM EDMT2080 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0 AND T1.OldStatusID = 0 
		AND MONTH(T1.LeaveDate) = MONTH(@ToDate) AND  YEAR(T1.LeaveDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A2 ON A1.DivisionID=A2.DivisionID
	LEFT JOIN(
	----Số lượng bé bảo lưu Ngày bắt đầu bảo lưu (Từ ngày) trong tháng hiện tại
		SELECT T1.DivisionID, COUNT( T1.StudentID) AS StudentReserve
		FROM EDMT2150 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg=0
		AND MONTH(T1.FromDate) = MONTH(@ToDate) AND  YEAR(T1.FromDate) = YEAR(@ToDate)
		GROUP BY T1.DivisionID)A3 ON A1.DivisionID=A3.DivisionID
	WHERE A1.DivisionID IN ( SELECT DivisionID FROM #DivisionFilter)
	ORDER BY A1.DivisionID


--  BÁO CÁO SỐ LƯỢNG BÉ TĂNG THÁNG HIỆN TẠI #TABLE6
	SELECT TOP 0 
	CONVERT(VARCHAR(50),'') AS DivisionID, CONVERT(NVARCHAR(50),'') AS DivisionName, 
	CONVERT(DECIMAL(28,8), 100) AS StudentLastMonth, CONVERT(DECIMAL(28,8), 100) AS StudentIncrease,
	CONVERT(DECIMAL(28,8), 100) AS StudentDecrease, CONVERT(DECIMAL(28,8), 100) AS StudentTotal
	INTO  #Table6

	INSERT INTO #Table6
	SELECT A1.DivisionID, A1.DivisionName, 
	A2.StudentLastMonth, A3.StudentIncrease, A4.StudentDecrease,
	ISNULL(A2.StudentLastMonth,0) + ISNULL(A3.StudentIncrease,0) - ISNULL(A4.StudentDecrease,0) AS StudentTotal

	FROM AT1101 A1 WITH(NOLOCK)
	LEFT JOIN(
	----Số lượng phiếu thông tin tư vấn được tạo trong tháng ( tất cả trạng thái)
		SELECT T1.DivisionID, SUM(T1.StudentLastMonth) AS StudentLastMonth
		FROM #Table1 T1 WITH (NOLOCK) 
		GROUP BY T1.DivisionID)A2 ON A2.DivisionID=A1.DivisionID
	LEFT JOIN #Table4 A3 WITH(NOLOCK) ON A3.DivisionID=A1.DivisionID
	LEFT JOIN #Table5 A4 WITH(NOLOCK) ON A4.DivisionID=A1.DivisionID

	WHERE A1.DivisionID IN ( SELECT DivisionID FROM #DivisionFilter)
	ORDER BY A1.DivisionID


	--Execute
	SELECT @columns += QUOTENAME(T1.DivisionID) + ',' -- [001],[002],[003],[004],
	FROM AT1101 T1 WITH (NOLOCK)
	WHERE T1.Disabled = 0 
		AND T1.DivisionID IN ( SELECT DivisionID FROM #DivisionFilter)
	ORDER BY T1.DivisionID


	IF @columns <> ''
	BEGIN
		-- Giá trị của @columns = [CL05],[CL06],[CL07],[CL08],[CL09],[CL10],[CL11],[001],[002],[003],[004],
		SET @columns = LEFT(@columns, LEN(@columns) - 1) -- Bỏ dấu phẩy cuối

		-- Bảng Division Lọc
		SELECT T1.DivisionID, T1.DivisionName
		FROM AT1101 T1 WITH (NOLOCK)
		WHERE T1.Disabled = 0 
			AND T1.DivisionID IN ( SELECT DivisionID FROM #DivisionFilter)
		ORDER BY T1.DivisionID

		--#Table1
		SET @sSQL = @sSQL + N'
			SELECT (N''Tháng '' + ''' + CONVERT(VARCHAR(10),MONTH(@ToDate)) + ''' + ''/''+ ''' + CONVERT(VARCHAR(10),YEAR(@ToDate))+ ''') AS Title,*			
			FROM   
				(
					SELECT DivisionID
					, StudentTotal					
					FROM #Table1
				) t
				PIVOT(
				sum(StudentTotal)
					FOR DivisionID IN ('+ @columns +N')
				) AS StudentTotal_pivot_table
				
			UNION ALL
			SELECT (N''Tháng '' + ''' + CONVERT(VARCHAR(10),MONTH(@PreMonth)) + ''' + ''/''+ ''' + CONVERT(VARCHAR(10),YEAR(@PreMonth))+ ''') Title,*			
			FROM   
				(
					SELECT DivisionID
					, StudentLastMonth					
					FROM #Table1
				) t
				PIVOT(
				sum(StudentLastMonth)
					FOR DivisionID IN ('+ @columns +N')
				) AS StudentTotal_pivot_table	
			'
			PRINT @sSQL
		--#Table2
		SET @sSQL = @sSQL + N'
			SELECT N''Đã nghỉ'' Title,*			
			FROM   
				(
					SELECT DivisionID
					, TotalOffline					
					FROM #Table2
				) t
				PIVOT(
				SUM(TotalOffline)
					FOR DivisionID IN ('+ @columns +N')
				) AS StudentTotal_pivot_table
				
			UNION ALL
			SELECT N''Tuyển mới'' Title,*			
			FROM   
				(
					SELECT DivisionID
					, TotalNew					
					FROM #Table2
				) t
				PIVOT(
				SUM(TotalNew)
					FOR DivisionID IN ('+ @columns +N')
				) AS StudentTotal_pivot_table	
			'
		--#Table3
		SET @sSQL = @sSQL + N'
			SELECT (N''Tỷ lệ bé tăng so với nghỉ tháng '' + ''' + CONVERT(VARCHAR(10),MONTH(@ToDate)) + ''' + ''/''+ ''' + CONVERT(VARCHAR(10),YEAR(@ToDate))+ ''') as Title,*			
			FROM   
				(
					SELECT DivisionID
					, ISNULL(TotalNew,0) -  ISNULL(TotalOfflinePresent,0) AS TotalOfflinePresent					
					FROM #Table3
				) t
				PIVOT(
				SUM(TotalOfflinePresent)
					FOR DivisionID IN ('+ @columns +N')
				) AS StudentTotal_pivot_table
				
			UNION ALL

			SELECT (N''Tỷ lệ bé tăng so với nghỉ tháng '' + ''' + CONVERT(VARCHAR(10),MONTH(@PreMonth)) + ''' + ''/''+ ''' + CONVERT(VARCHAR(10),YEAR(@PreMonth))+ ''') as Title,*			
			FROM   
				(
					SELECT DivisionID
					, ISNULL(TotalNew,0) -  ISNULL(TotalOfflinePass,0) AS TotalOfflinePass				
					FROM #Table3
				) t
				PIVOT(
				SUM(TotalOfflinePass)
					FOR DivisionID IN ('+ @columns +')
				) AS StudentTotal_pivot_table	

				

			'
			SET @sSQL = @sSQL + '
				SELECT * FROM #Table4 ' + @OrderBy + '
			'
			SET @sSQL = @sSQL + '
				SELECT * FROM #Table5 ' + @OrderBy + '
			'SET @sSQL = @sSQL + '
				SELECT * FROM #Table6 ' + @OrderBy + '
			'
			EXEC (@sSQL)



	END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


