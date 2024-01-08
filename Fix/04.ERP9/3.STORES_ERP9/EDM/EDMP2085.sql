IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Kiểm tra ngày hiệu lực của học sinh nghiệp vụ điều chuyển,bảo lưu, nghỉ học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo	on	03/04/2019
----Updated by:	Lương Mỹ	on	09/10/2019

-- <Example>
---- 
/*-- <Example>
	EDMP2085 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@StudentID = 'BE-U003', @DateFrom = '',@DateTo = '',  @Mode = '1'

	EDMP2085 @DivisionID, @UserID,@StudentID, @DateFrom,@DateTo, @Mode
----*/

CREATE PROCEDURE EDMP2085
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @DateFrom DATETIME,
	 @DateTo DATETIME,
	 @Mode VARCHAR(10)	--	0: NGHỈ HỌC
						--	1: ĐIỀU CHUYỂN HỌC SINH
						--	2: BẢO LƯU
)

AS 


	DECLARE @DateEffect DATETIME 
	SET @DateEffect =  DATEADD(DAY, 1, GETDATE()) --GETDATE()

	DECLARE @Result table (	APK VARCHAR(50), 
							DivionID VARCHAR(50),
							VoucherID VARCHAR(50),
							Type VARCHAR(25),
							StudentID VARCHAR(50),
							DateFrom DATETIME
	)

	-- Nghỉ học
	INSERT INTO	@Result(APK,DivionID,VoucherID,StudentID,DateFrom,Type)
	SELECT EDMT2080.APK, EDMT2080.DivisionID, EDMT2080.VoucherLeaveSchool, 
			EDMT2080.StudentID, EDMT2080.LeaveDate, 'LeaveSchool' AS Type
	FROM EDMT2080 WITH (NOLOCK) 
	WHERE DivisionID = @DivisionID 
		AND StudentID = @StudentID 
		AND EDMT2080.LeaveDate >= CONVERT(VARCHAR(10), CONVERT(DATE, @DateEffect,120), 126)
		AND EDMT2080.DeleteFlg = 0

	-- Bảo lưu
	INSERT INTO	@Result(APK,DivionID,VoucherID,StudentID,DateFrom,Type)
	SELECT EDMT2150.APK, EDMT2150.DivisionID, EDMT2150.ReserveID, 
			EDMT2150.StudentID, EDMT2150.FromDate, 'Reserve' AS Type
	FROM EDMT2150 WITH (NOLOCK) 
	WHERE DivisionID = @DivisionID
		AND StudentID = @StudentID 
		AND EDMT2150.FromDate >= CONVERT(VARCHAR(10), CONVERT(DATE, @DateEffect,120), 126)
		AND EDMT2150.DeleteFlg = 0

	-- Chuyển trường
	INSERT INTO	@Result(APK,DivionID,VoucherID,StudentID,DateFrom,Type)
	SELECT EDMT2140.APK, EDMT2140.DivisionID, EDMT2140.TranferStudentNo, 
			EDMT2140.StudentID, EDMT2140.FromEffectiveDate, 'Transfer' AS Type
	FROM EDMT2140 WITH (NOLOCK) 
	WHERE DivisionID = @DivisionID
		AND StudentID = @StudentID 
		AND EDMT2140.FromEffectiveDate >= CONVERT(VARCHAR(10), CONVERT(DATE, @DateEffect,120), 126) 
		AND EDMT2140.DeleteFlg = 0
		--AND EDMT2140.SchoolIDTo <> @DivisionID


	--- Bảng tổng kết
	SELECT * 
	FROM @Result
	ORDER BY DateFrom

-----Nghiệp vụ quyết định nghỉ học 
--IF @Mode = '0'
--BEGIN 
--	PRINT '12321'
--	-- Xét Bảo lưu, Nghỉ học, Chuyển trường
--	-- Bảng tổng kết
--	SELECT * 
--	FROM @Result
--	ORDER BY DateFrom

--END 

 
-----	Nghiệp vụ Điều chuyển học sinh - Trường hợp Chuyển trường
--ELSE IF @Mode = '1'  
--BEGIN 
--	PRINT 'a'

--	-- Xét Nghỉ học, Chuyển trường => Nếu đã bảo lưu thì vẫn có thể Chuyển trường
--	-- Bảng tổng kết
--	SELECT *
--	FROM @Result
--	WHERE Type IN ('LeaveSchool','Transfer')
--	ORDER BY DateFrom

--END 

-----	Nghiệp vụ Bảo lưu
--ELSE IF @Mode = '2' 
--BEGIN 

--	PRINT @Mode

--	-- Bảo lưu
--	INSERT INTO	@Result(APK,DivionID,VoucherID,StudentID,DateFrom,Type)
--	SELECT EDMT2150.APK, EDMT2150.DivisionID, EDMT2150.ReserveID, 
--			EDMT2150.StudentID, EDMT2150.FromDate, 'ReserveDupticate' AS Type
--	FROM EDMT2150 WITH (NOLOCK) 
--	INNER JOIN @Result ON [@Result].Type = 'Reserve' 
--	WHERE EDMT2150.DivisionID = @DivisionID
--		AND EDMT2150.StudentID = @StudentID 
--		AND (@DateFrom BETWEEN EDMT2150.FromDate AND EDMT2150.ToDate)
--		AND EDMT2150.DeleteFlg = 0

--	-- Xét Nghỉ học, Chuyển trường => Nếu đã bảo lưu thì vẫn có thể Chuyển trường
--	-- Bảng tổng kết
--	SELECT * 
--	FROM @Result
--	WHERE Type IN ('LeaveSchool','Transfer','ReserveDupticate')
--	ORDER BY DateFrom

--END 
 

 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
