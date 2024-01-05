IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Cập nhật trạng thái khi xóa phiếu nghỉ học, điều chuyển học sinh, bảo lưu 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 11/04/2019
-- <Example>
---- 
/*-- <Example>
	 EDMP2086 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @Mode= 1,
	@XML=N'<Data><APK>84EC221E-F018-4036-8E6B-C4DDC2460514</APK></Data>
	   <Data><APK>4B5F8A20-1A45-4072-A35B-E40907D90B49</APK></Data>'

	EDMP2086 @DivisionID, @UserID,@XML,  @Mode
----*/

CREATE PROCEDURE EDMP2086
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML,
	 @Mode VARCHAR(50) --- 0: Quyết định nghỉ học, 1: điều chuyển, 2:Bảo lưu 
)

AS 


CREATE TABLE #EDMP2086 (APK VARCHAR(50))
INSERT INTO #EDMP2086 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)
	

IF @Mode = 0 ---Nghiệp vụ quyết định nghỉ học 
BEGIN 
 
 IF OBJECT_ID('tempdb..#DATA') IS NOT NULL 
DROP TABLE #DATA 

SELECT DivisionID,StudentID,OldStatusID,CreateUserID,ArrangeClassID,OldStatusArrID
INTO #DATA 
FROM EDMT2080 WITH (NOLOCK)
INNER JOIN #EDMP2086 ON EDMT2080.APK = #EDMP2086.APK 
WHERE ISNULL(OldStatusID,'') != ''


 DECLARE
		@Cur CURSOR,
		@CurDivisionID VARCHAR(50),
		@OldStatusID VARCHAR(50),
		@StudentID VARCHAR (50),
		@CreateUserID VARCHAR(50),
		@ArrangeClassID VARCHAR(50),
		@OldStatusArrID VARCHAR(50) 

SET @Cur = Cursor Scroll KeySet FOR 
SELECT DivisionID,StudentID,OldStatusID,CreateUserID,ArrangeClassID,OldStatusArrID FROM #DATA  
OPEN @Cur
FETCH NEXT FROM @Cur INTO @CurDivisionID,@StudentID,@OldStatusID,@CreateUserID,@ArrangeClassID,@OldStatusArrID
WHILE @@FETCH_STATUS = 0
	BEGIN

	---CẬP NHẬT HỒ SƠ HỌC SINH 
	UPDATE EDMT2010 
	SET StatusID = @OldStatusID,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE  DivisionID = @CurDivisionID AND DeleteFlg = 0 AND StatusID = '3' AND StudentID = @StudentID AND ISNULL(@OldStatusID,'') != ''


	------Cập nhật xếp lớp 
	UPDATE T1
	SET T1.IsTransfer = @OldStatusArrID,
	LastModifyUserID = T2.CreateUserID,
	LastModifyDate = GETDATE(),
	T1.DeleteFlg = 0 
	FROM EDMT2021 T1 WITH (NOLOCK)
	INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster 
	WHERE T1.DivisionID = @DivisionID 
	AND T2.ArrangeClassID = @ArrangeClassID
	AND T2.DeleteFlg = 0 
	AND T1.StudentID = @StudentID
	AND ISNULL(@OldStatusID,'') != '' AND T1.IsTransfer = 4


 
FETCH NEXT FROM @Cur INTO @CurDivisionID,@StudentID,@OldStatusID,@CreateUserID,@ArrangeClassID,@OldStatusArrID
    END 


Close @Cur

END 

ELSE IF @Mode = 1 ---ĐIỀU CHUYỂN HỌC SINH 
	
BEGIN 
 IF OBJECT_ID('tempdb..#EDMT2140 ') IS NOT NULL 
DROP TABLE #EDMT2140 

SELECT EDMT2140.APK,DivisionID,ArrangeClassIDTo,ArrangeClassIDFrom,StudentID,OldStatusID,CreateUserID,FromEffectiveDate
INTO #EDMT2140 
FROM EDMT2140 WITH (NOLOCK)
INNER JOIN #EDMP2086 ON EDMT2140.APK = #EDMP2086.APK 
WHERE ISNULL(OldStatusID,'') != ''



 DECLARE
		@CurTranfer CURSOR, 
		@OldStatusID1 VARCHAR(50),
		@StudentID1 VARCHAR (50),
		@ArrangeClassIDTo VARCHAR(50),
		@ArrangeClassIDFrom VARCHAR(50),
		@APKEDMT2140 VARCHAR(50),
		@CreateUserID1 VARCHAR(50),
		@APKEDMT2020 VARCHAR(50),
		@DivisionTranfer VARCHAR(50),
		@FromEffectiveDate VARCHAR (50),
		@APKDetail VARCHAR(50) 

SET @CurTranfer = Cursor Scroll KeySet FOR 
SELECT APK,DivisionID,ArrangeClassIDTo,ArrangeClassIDFrom,StudentID,OldStatusID,CreateUserID,FromEffectiveDate FROM #EDMT2140  WITH (NOLOCK)
OPEN @CurTranfer
FETCH NEXT FROM @CurTranfer INTO @APKEDMT2140,@DivisionTranfer,@ArrangeClassIDTo,@ArrangeClassIDFrom,@StudentID1,@OldStatusID1,@CreateUserID1,@FromEffectiveDate
WHILE @@FETCH_STATUS = 0
	BEGIN

---Cập nhật xếp lớp cũ 
/*
UPDATE T1
SET T1.IsTransfer = @OldStatusID1,
	LastModifyUserID = T2.CreateUserID,
	LastModifyDate = T1.CreateDate
FROM EDMT2021 T1 WITH (NOLOCK)
INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster 
WHERE T1.DivisionID = @DivisionID AND T2.ArrangeClassID = @ArrangeClassIDFrom 
AND T2.DeleteFlg = 0 AND T1.DeleteFlg = 0 AND T1.StudentID = @StudentID1 AND T1.IsTransfer = 1 AND ISNULL(@OldStatusID1,'') != ''
*/

 SELECT @APKEDMT2020 = APK FROM EDMT2020 WITH (NOLOCK) WHERE EDMT2020.DeleteFlg = 0 AND EDMT2020.ArrangeClassID = @ArrangeClassIDFrom

 ---Trường hợp nếu lớp đó vừa chuyển đi nhưng vừa chuyển đến 

SELECT TOP 1  @APKDetail = EDMT2021.APK 
FROM EDMT2020 WITH(NOLOCK) 
LEFT JOIN EDMT2021 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster
WHERE EDMT2020.DivisionID = @DivisionID AND EDMT2020.ArrangeClassID = @ArrangeClassIDFrom AND EDMT2020.DeleteFlg = 0 
AND EDMT2021.StudentID = @StudentID1 AND ISNULL(@OldStatusID1,'') != '' AND EDMT2021.IsTransfer IN (1,5)
ORDER BY EDMT2021.LastModifyDate DESC 


UPDATE T1
SET T1.IsTransfer = @OldStatusID1,
	T1.DeleteFlg = 0,
    LastModifyUserID = @CreateUserID1,
	LastModifyDate = GETDATE()
FROM EDMT2021 T1 WITH (NOLOCK)
WHERE T1.APK = @APKDetail 

---Cập nhật trạng thái bé điều chuyển về lại trạng thái cũ  
UPDATE T1
SET T1.StatusID = 0,
	T1.LastModifyUserID = @UserID,
	T1.LastModifyDate = GETDATE()
FROM EDMT2010 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2140 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID 
WHERE T1.DivisionID = @DivisionID AND T1.StudentID = @StudentID1 AND T1.StatusID = 5
	  AND T2.DivisionID != T2.SchoolIDTo AND T2.APK = @APKEDMT2140 


---Cập nhật xếp lớp mới 

UPDATE T1
SET T1.IsTransfer = 0,
	T1.DeleteFlg = 1,
    LastModifyUserID = @CreateUserID1,
	LastModifyDate = GETDATE()
FROM EDMT2021 T1 WITH (NOLOCK)
INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster 
WHERE T1.DivisionID = @DivisionID AND T2.ArrangeClassID = @ArrangeClassIDTo AND T2.DeleteFlg = 0 AND T1.DeleteFlg = 0 
AND T1.StudentID = @StudentID1 AND ISNULL(@OldStatusID1,'') != '' AND T1.IsTransfer = 2



 
FETCH NEXT FROM @CurTranfer INTO @APKEDMT2140,@DivisionTranfer,@ArrangeClassIDTo,@ArrangeClassIDFrom,@StudentID1,@OldStatusID1,@CreateUserID1,@FromEffectiveDate
    END 


Close @CurTranfer


END 



ELSE IF @Mode = 2 ---Nghiệp vụ bảo lưu 

BEGIN 
 IF OBJECT_ID('tempdb..#EDMT2150') IS NOT NULL 
DROP TABLE #EDMT2150 

SELECT DivisionID,StudentID,OldStatusID,SchoolYearID,ClassID,OldStatusArrID,CreateUserID
INTO #EDMT2150
FROM EDMT2150 WITH (NOLOCK)
INNER JOIN #EDMP2086 ON EDMT2150.APK = #EDMP2086.APK 
WHERE ISNULL(OldStatusID,'') != ''

 DECLARE
		@CurReserve CURSOR, 
		@CurDivisionID2 VARCHAR(50),
		@OldStatusID2 VARCHAR(50),
		@StudentID2 VARCHAR (50),
		@CreateUserID2 VARCHAR(50),
		@SchoolYearID2 VARCHAR(50),
		@ClassID2 VARCHAR(50),
		@OldStatusArrID2 VARCHAR(50) 

SET @CurReserve = Cursor Scroll KeySet FOR 
SELECT DivisionID,StudentID,OldStatusID,SchoolYearID,ClassID,OldStatusArrID,CreateUserID FROM #EDMT2150 WITH (NOLOCK)
OPEN @CurReserve
FETCH NEXT FROM @CurReserve INTO @CurDivisionID2,@StudentID2,@OldStatusID2,@SchoolYearID2,@ClassID2,@OldStatusArrID2,@CreateUserID2
WHILE @@FETCH_STATUS = 0
	BEGIN
	-----Cập nhật hồ sơ học sinh 
	UPDATE EDMT2010 
	SET StatusID = @OldStatusID2,
		LastModifyUserID = @UserID,
		LastModifyDate = GETDATE()
	WHERE  DivisionID = @CurDivisionID2 AND DeleteFlg = 0 AND StatusID = '4' AND StudentID = @StudentID2 AND ISNULL(@OldStatusID2,'') != ''

	------Cập nhật xếp lớp 
	UPDATE T1
	SET T1.IsTransfer = @OldStatusArrID2,
	T1.LastModifyUserID = @CreateUserID2,
	T1.LastModifyDate = GETDATE(),
	T1.DeleteFlg = 0 
	FROM EDMT2021 T1 WITH (NOLOCK)
	INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.APK = T1.APKMaster 
	WHERE T1.DivisionID = @DivisionID 
	AND T2.SchoolYearID = @SchoolYearID2
	AND T2.ClassID = @ClassID2
	AND T2.DeleteFlg = 0 
	AND T1.StudentID = @StudentID2
	AND ISNULL(@OldStatusArrID2,'') != '' AND T1.IsTransfer = 3




 
FETCH NEXT FROM @CurReserve INTO @CurDivisionID2,@StudentID2,@OldStatusID2,@SchoolYearID2,@ClassID2,@OldStatusArrID2,@CreateUserID2
    END 


Close @CurReserve


END 
















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
