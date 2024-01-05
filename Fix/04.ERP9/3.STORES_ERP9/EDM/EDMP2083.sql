IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Cập nhật trạng thái quyết định nghỉ học,điều chuyển học sinh, bảo lưu (hàng loạt)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 07/03/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2083 @DivisionID = 'BE', @UserID = 'ASOFTADMIN'

	EDMP2083 @UserID
----*/

CREATE PROCEDURE EDMP2083
(	  
	 @UserID VARCHAR(50)
)

AS 


---Nghiệp vụ quyết định nghỉ học 
  DECLARE
		@Cur_Leave CURSOR, 
		@ObjectID_Leave VARCHAR(50),
		@APK_Leave VARCHAR(50),
		@StudentID_Leave VARCHAR(50),
		@CurDivisionID_Leave VARCHAR(50),
		@LeaveDate DATETIME,
		@ArrangeClassID_Leave VARCHAR(50)

SET @Cur_Leave = CURSOR SCROLL KEYSET FOR
SELECT EDMT2080.DivisionID,EDMT2080.APK, EDMT2080.StudentID, EDMT2080.LeaveDate,EDMT2080.ArrangeClassID 
FROM  EDMT2080 WITH (NOLOCK)
WHERE EDMT2080.DeleteFlg = 0 AND EDMT2080.LeaveDate = (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))
OPEN @Cur_Leave
FETCH NEXT FROM @Cur_Leave INTO @CurDivisionID_Leave,@APK_Leave, @StudentID_Leave,@LeaveDate,@ArrangeClassID_Leave
WHILE @@FETCH_STATUS = 0
BEGIN


----Cập nhật hồ sơ học sinh 
UPDATE EDMT2010  
SET StatusID = 3,
LastModifyUserID = @UserID,
LastModifyDate = @LeaveDate
WHERE StudentID = @StudentID_Leave
AND DeleteFlg = 0 AND DivisionID = @CurDivisionID_Leave


---Cập nhật xếp lớp 

UPDATE EDMT2021 
SET EDMT2021.IsTransfer = 4,
EDMT2021.DeleteFlg = 1,
EDMT2021.LastModifyUserID = @UserID,
EDMT2021.LastModifyDate = @LeaveDate
FROM EDMT2021 WITH (NOLOCK) 
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster
WHERE EDMT2020.DivisionID = @CurDivisionID_Leave
AND EDMT2020.ArrangeClassID = @ArrangeClassID_Leave
AND EDMT2021.StudentID = @StudentID_Leave 
AND EDMT2020.DeleteFlg = 0  
AND (( EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)) OR ( EDMT2021.DeleteFlg = 1 AND EDMT2021.IsTransfer IN (3,4))) 



FETCH NEXT FROM @Cur_Leave INTO @CurDivisionID_Leave,@APK_Leave, @StudentID_Leave,@LeaveDate,@ArrangeClassID_Leave
END

Close @Cur_Leave



 
-----Nghiệp vụ điều chuyển học sinh 
DECLARE
		@Cur_Tranfer CURSOR, 
		@ObjectID_Tranfer VARCHAR(50),
		@APK_Tranfer VARCHAR(50),
		@StudentID_Tranfer VARCHAR(50),
		@CurDivisionID_Tranfer VARCHAR(50),
		@FromEffectiveDate DATETIME,
		@ArrangeClassID_Tranfer VARCHAR(50),
		@SchoolIDTo VARCHAR(50) 

SET @Cur_Tranfer = CURSOR SCROLL KEYSET FOR
SELECT EDMT2140.DivisionID,EDMT2140.APK, EDMT2140.StudentID, EDMT2140.FromEffectiveDate,EDMT2140.ArrangeClassIDFrom,EDMT2140.SchoolIDTo
FROM  EDMT2140 WITH (NOLOCK)
WHERE EDMT2140.DeleteFlg = 0 AND EDMT2140.FromEffectiveDate = (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))
OPEN @Cur_Tranfer   
FETCH NEXT FROM @Cur_Tranfer INTO @CurDivisionID_Tranfer,@APK_Tranfer, @StudentID_Tranfer,@FromEffectiveDate,@ArrangeClassID_Tranfer,@SchoolIDTo
WHILE @@FETCH_STATUS = 0
BEGIN


--- Cập nhật trạng thái mới 

-----Chuyển lớp 
IF @CurDivisionID_Tranfer = @SchoolIDTo
BEGIN 
UPDATE EDMT2021 
SET IsTransfer = 1,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = @FromEffectiveDate
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster AND EDMT2020.DeleteFlg = 0 
WHERE EDMT2020.ArrangeClassID  = @ArrangeClassID_Tranfer
AND
EDMT2021.StudentID = @StudentID_Tranfer
AND EDMT2021.DeleteFlg = 0 

END
 
IF @CurDivisionID_Tranfer != @SchoolIDTo
BEGIN 
-----Bổ sung cập nhật Trạng thái xếp lớp là chuyển trường 
UPDATE EDMT2021 
SET IsTransfer = 5,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = @FromEffectiveDate
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster AND EDMT2020.DeleteFlg = 0 
WHERE EDMT2020.ArrangeClassID  = @ArrangeClassID_Tranfer AND
EDMT2021.StudentID = @StudentID_Tranfer
AND EDMT2021.DeleteFlg = 0 


----Cập nhật trạng thái hồ sơ học sinh chuyển trường 


UPDATE T1
SET T1.StatusID = 5,
	T1.LastModifyUserID = @UserID,
	T1.LastModifyDate = @FromEffectiveDate
FROM EDMT2010 T1 WITH (NOLOCK) 
WHERE T1.DivisionID = @CurDivisionID_Tranfer AND T1.StudentID = @StudentID_Tranfer AND T1.DeleteFlg = 0 
	 

END 



FETCH NEXT FROM @Cur_Tranfer INTO @CurDivisionID_Tranfer,@APK_Tranfer, @StudentID_Tranfer,@FromEffectiveDate,@ArrangeClassID_Tranfer,@SchoolIDTo
END

Close @Cur_Tranfer



----Xếp lớp mới

IF OBJECT_ID('tempdb..#EDMP2083') IS NOT NULL 
DROP TABLE #EDMP2083
----Lấy ra xếp lớp mới 
  SELECT EDMT2140.DivisionID,EDMT2140.StudentID,EDMT2020.APK,EDMT2140.FromEffectiveDate
  INTO #EDMP2083
  FROM EDMT2140 WITH (NOLOCK)
  LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2140.ArrangeClassIDTo = EDMT2020.ArrangeClassID
  WHERE EDMT2020.ArrangeClassID IN (SELECT ArrangeClassIDTo FROM EDMT2140 WITH (NOLOCK) 
									WHERE  DeleteFlg = 0 
									AND (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) = FromEffectiveDate  AND ISNULL(ArrangeClassIDTo,'') != '') 
  AND EDMT2020.DeleteFlg = 0 AND EDMT2140.DeleteFlg = 0
  AND (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) = FromEffectiveDate  AND ISNULL(ArrangeClassIDTo,'') != ''


  ----Duyệt tưng học sinh để tiến hành insert or update xếp lớp 

  DECLARE
		@Cur CURSOR, 
		@ObjectID VARCHAR(50),
		@APK VARCHAR(50),
		@StudentID VARCHAR(50),
		@CurDivisionID VARCHAR(50),
		@FromEffectiveDate1 DATETIME 

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DivisionID,APK, StudentID,FromEffectiveDate
FROM #EDMP2083
OPEN @Cur
FETCH NEXT FROM @Cur INTO @CurDivisionID,@APK, @StudentID,@FromEffectiveDate1
WHILE @@FETCH_STATUS = 0
BEGIN

 

IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2021 WITH (NOLOCK) WHERE APKMaster = @APK AND StudentID = @StudentID AND DeleteFlg = 0 )
	BEGIN 
		INSERT INTO EDMT2021 (DivisionID, APKMaster, StudentID,IsTransfer,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT #EDMP2083.DivisionID,@APK,@StudentID,2,@UserID, @FromEffectiveDate1,@UserID, @FromEffectiveDate1
		FROM #EDMP2083 WITH (NOLOCK) 
		WHERE StudentID = @StudentID AND APK = @APK
	END 
	ELSE IF EXISTS (SELECT TOP 1 1 FROM EDMT2021 WITH (NOLOCK) WHERE APKMaster = @APK AND StudentID = @StudentID AND DeleteFlg = 0 )
	BEGIN 

	UPDATE EDMT2021 
	SET IsTransfer = 2,
	LastModifyUserID = @UserID,
	LastModifyDate = @FromEffectiveDate1
	FROM EDMT2021 WITH (NOLOCK) 
	WHERE APKMaster = @APK AND StudentID = @StudentID
	AND DeleteFlg = 0

	END 


FETCH NEXT FROM @Cur INTO @CurDivisionID,@APK, @StudentID,@FromEffectiveDate1
END

Close @Cur



---Nghiệp vụ bảo lưu 
 
DECLARE
		@Cur_Reserve CURSOR, 
		@ObjectID_Reserve VARCHAR(50),
		@APK_Reserve VARCHAR(50),
		@StudentID_Reserve VARCHAR(50),
		@CurDivisionID_Reserve VARCHAR(50),
		@FromDate DATETIME,
		@SchoolYearID_Reserve VARCHAR(50),
		@ClassID VARCHAR(50)

SET @Cur_Reserve = CURSOR SCROLL KEYSET FOR
SELECT EDMT2150.DivisionID,EDMT2150.APK, EDMT2150.StudentID, EDMT2150.FromDate,EDMT2150.SchoolYearID,EDMT2150.ClassID
FROM  EDMT2150 WITH (NOLOCK)
WHERE EDMT2150.DeleteFlg = 0 AND EDMT2150.FromDate = (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))
OPEN @Cur_Reserve
FETCH NEXT FROM @Cur_Reserve INTO @CurDivisionID_Reserve,@APK_Reserve, @StudentID_Reserve,@FromDate,@SchoolYearID_Reserve,@ClassID
WHILE @@FETCH_STATUS = 0
BEGIN




---Cập nhật hồ sơ học sinh 
UPDATE EDMT2010
SET StatusID = 4,
LastModifyUserID = @UserID,
LastModifyDate = @FromDate
WHERE StudentID = @StudentID_Reserve
AND DeleteFlg = 0



---Cập nhật xếp lớp 

UPDATE EDMT2021 
SET EDMT2021.IsTransfer = 3,
EDMT2021.DeleteFlg = 1,
EDMT2021.LastModifyUserID = @UserID,
EDMT2021.LastModifyDate = @FromDate
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster
WHERE EDMT2020.SchoolYearID  = @SchoolYearID_Reserve
AND EDMT2021.StudentID = @StudentID_Reserve
AND EDMT2020.DeleteFlg = 0  
AND EDMT2020.ClassID = @ClassID
AND (( EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)) OR ( EDMT2021.DeleteFlg = 1 AND EDMT2021.IsTransfer IN (3,4))) 
 
 
 
FETCH NEXT FROM @Cur_Reserve INTO @CurDivisionID_Reserve,@APK_Reserve, @StudentID_Reserve,@FromDate,@SchoolYearID_Reserve,@ClassID
END

Close @Cur_Reserve








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
