IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2047]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2047]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
----	Cập nhật trạng thái Học lại cho học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: [Lương Mỹ] on [25/7/2019]
-- <Example>
---- 
---- EDMP2047 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN',@StudentID = '0000237', @Mode = 0


CREATE PROCEDURE [dbo].[EDMP2047]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @Mode TINYINT -- 4 Mode :  -- 1: Học thử => Học chính thức 
								-- 2: Giữ chỗ => Học chính thức
								-- 3: Giữ chỗ => Nghỉ học
								-- 4: Bảo lưu/Nghỉ học => Học lại
)
AS 

BEGIN 

	DECLARE @APK VARCHAR(50) 
	DECLARE @ArrangeClassID  VARCHAR(50) = ''
	DECLARE @SchoolYearID  VARCHAR(50) = ''
	DECLARE @Status_EDMT2021 TINYINT = 0 --- SELECT * FROM EDMT0099 WHERE CodeMaster LIKE '%MoveStatus%'
	DECLARE @Status_EDMT2010 TINYINT = 0 --- SELECT * FROM EDMT0099 WHERE CodeMaster LIKE '%StudentStatus%'
	DECLARE @APK_EDMT2012 VARCHAR(50) = NULL --- 

	SELECT TOP 1 @APK_EDMT2012 = T1.APK 
	FROM EDMT2012 T1
	WHERE T1.StudentID = @StudentID
	ORDER BY T1.CreateDate DESC

	SELECT TOP 1 @Status_EDMT2010 = T1.StatusID 
	FROM EDMT2010 T1
	WHERE T1.StudentID = @StudentID AND T1.DeleteFlg = 0
	ORDER BY T1.CreateDate DESC

	INSERT INTO EDMT2012(DivisionID,StudentID,InheritAPKStudent,DateStudy,StudentStatusID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate) 
				VALUES(@DivisionID,@StudentID,@APK_EDMT2012,GETDATE(),@Status_EDMT2010,@UserID,GETDATE(),@UserID,GETDATE())

IF @Mode = 1 -- Học thử => Học chính thức 
BEGIN

	SELECT TOP 1 @APK = E21.APK, @ArrangeClassID = E20.ArrangeClassID, @SchoolYearID = E20.SchoolYearID, @Status_EDMT2021 = E21.IsTransfer
	FROM EDMT2020 E20 WITH (NOLOCK) 
	LEFT JOIN EDMT2021 E21 WITH (NOLOCK) ON E21.APKMaster = E20.APK AND E20.DeleteFlg = E21.DeleteFlg
	LEFT JOIN EDMT1040 E1040 WITH (NOLOCK) ON E20.SchoolYearID = E1040.SchoolYearID AND E1040.DivisionID IN ('@@@', E20.DivisionID)

	WHERE E21.StudentID = @StudentID AND E21.IsTransfer IN (3,4) AND E21.DeleteFlg = 0
	ORDER BY E1040.DateTo DESC, E21.LastModifyDate DESC 

	

	-- Cập nhật trạng thái Hồ sơ học sinh
	UPDATE EDMT2010
	Set StatusID = 0,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE StudentID = @StudentID AND DeleteFlg = 0 AND StatusID = 1 -- Học thử
END

IF @Mode = 2 -- Giữ chỗ => Học chính thức
BEGIN

	SELECT TOP 1 @APK = E21.APK, @ArrangeClassID = E20.ArrangeClassID, @SchoolYearID = E20.SchoolYearID, @Status_EDMT2021 = E21.IsTransfer
	FROM EDMT2020 E20 WITH (NOLOCK) 
	LEFT JOIN EDMT2021 E21 WITH (NOLOCK) ON E21.APKMaster = E20.APK AND E20.DeleteFlg = E21.DeleteFlg
	LEFT JOIN EDMT1040 E1040 WITH (NOLOCK) ON E20.SchoolYearID = E1040.SchoolYearID AND E1040.DivisionID IN ('@@@', E20.DivisionID)

	WHERE E21.StudentID = @StudentID AND E21.IsTransfer IN (3,4) AND E21.DeleteFlg = 0
	ORDER BY E1040.DateTo DESC, E21.LastModifyDate DESC 

	-- Cập nhật trạng thái Hồ sơ học sinh
	UPDATE EDMT2010
	Set StatusID = 0,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE StudentID = @StudentID AND DeleteFlg = 0 AND StatusID = 2 -- Giữ chỗ

END

IF @Mode = 3 -- Giữ chỗ => Nghỉ học
BEGIN 

	SELECT TOP 1 @APK = E21.APK, @ArrangeClassID = E20.ArrangeClassID, @SchoolYearID = E20.SchoolYearID, @Status_EDMT2021 = E21.IsTransfer
	FROM EDMT2020 E20 WITH (NOLOCK) 
	LEFT JOIN EDMT2021 E21 WITH (NOLOCK) ON E21.APKMaster = E20.APK AND E20.DeleteFlg = E21.DeleteFlg
	LEFT JOIN EDMT1040 E1040 WITH (NOLOCK) ON E20.SchoolYearID = E1040.SchoolYearID AND E1040.DivisionID IN ('@@@', E20.DivisionID)

	WHERE E21.StudentID = @StudentID AND E21.IsTransfer IN (3,4) AND E21.DeleteFlg = 0
	ORDER BY E1040.DateTo DESC, E21.LastModifyDate DESC 

	-- Cập nhật trạng thái Hồ sơ học sinh
	UPDATE EDMT2010
	Set StatusID = 3,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE StudentID = @StudentID AND DeleteFlg = 0 AND StatusID = 2
END

IF @Mode = 4  -- Bảo lưu/Nghỉ học => Học lại
	BEGIN	

	SELECT TOP 1 @APK = E21.APK, @ArrangeClassID = E20.ArrangeClassID, @SchoolYearID = E20.SchoolYearID, @Status_EDMT2021 = E21.IsTransfer
	FROM EDMT2020 E20 WITH (NOLOCK) 
	LEFT JOIN EDMT2021 E21 WITH (NOLOCK) ON E21.APKMaster = E20.APK AND E20.DeleteFlg = E21.DeleteFlg
	LEFT JOIN EDMT1040 E1040 WITH (NOLOCK) ON E20.SchoolYearID = E1040.SchoolYearID AND E1040.DivisionID IN ('@@@', E20.DivisionID)

	WHERE E21.StudentID = @StudentID AND E21.IsTransfer IN (3,4) AND E21.DeleteFlg = 0
	ORDER BY E1040.DateTo DESC, E21.LastModifyDate DESC 

	-- Cập nhật trạng thái Hồ sơ học sinh
	UPDATE EDMT2010
	Set StatusID = 0,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE StudentID = @StudentID AND DeleteFlg = 0 AND StatusID IN (3,4)

	DECLARE @DateFrom  DateTime = null
	DECLARE @DateTo  DateTime = null

	-- Thời gian năm học hiện tại
	SELECT TOP 1 @DateFrom = EDMT1040.DateFrom, @DateTo = EDMT1040.DateTo
	FROM EDMT1040 WITH (NOLOCK) 
	WHERE EDMT1040.DivisionID IN ('@@@', @DivisionID) AND CAST(CAST(GETDATE() AS DATE) AS DATETIME) BETWEEN EDMT1040.DateFrom AND EDMT1040.DateTo


	-- Cập nhật trạng thái ở Xếp lớp
	UPDATE EDMT2021
	Set DeleteFlg = 1
	WHERE CONVERT(VARCHAR(50), APK) = @APK AND LastModifyDate BETWEEN @DateFrom AND @DateTo

	--IF @Status_EDMT2021 = 3 --- Bảo lưu
	--BEGIN

	--	DECLARE @APK_EDMT2150 VARCHAR(50) = ''
	--	SELECT TOP 1 @APK_EDMT2150 = EDMT2150.APK
	--	FROM EDMT2150 WITH (NOLOCK)
	--	WHERE  EDMT2150.DivisionID = @DivisionID AND EDMT2150.SchoolYearID = @SchoolYearID AND EDMT2150.StudentID = @StudentID AND DeleteFlg = 0
	--	ORDER BY EDMT2150.ToDate DESC

	--	-- Cập nhật trạng thái cũ ở Bảo lưu
	--	UPDATE EDMT2150
	--	Set OldStatusID = 6 -- Học lại -- Select * From EDMT0099 Where CodeMaster = 'StudentStatus'
	--	WHERE CONVERT(VARCHAR(50), APK) = @APK_EDMT2150  
			 


	--END

	--ELSE IF @Status_EDMT2021 = 4 --- Nghỉ học
	--BEGIN

	--	DECLARE @APK_EDMT2080 VARCHAR(50) = ''
	--	SELECT TOP 1 @APK_EDMT2080 = EDMT2080.APK
	--	FROM EDMT2080 WITH (NOLOCK)
	--	WHERE  EDMT2080.DivisionID = @DivisionID AND EDMT2080.ArrangeClassID = @ArrangeClassID AND EDMT2080.StudentID = @StudentID AND DeleteFlg = 0
	--	ORDER BY EDMT2080.LeaveDate DESC

	--	-- Cập nhật trạng thái cũ ở Quyết định nghỉ học
	--	UPDATE EDMT2080
	--	Set OldStatusID = 6 -- Học lại -- Select * From EDMT0099 Where CodeMaster = 'StudentStatus'
	--	WHERE CONVERT(VARCHAR(50), APK) = @APK_EDMT2080  

	--END

	END
END 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
