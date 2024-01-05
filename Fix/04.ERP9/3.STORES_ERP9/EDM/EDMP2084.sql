IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2084]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Cập nhật trạng thái quyết định nghỉ học,điều chuyển học sinh, bảo lưu từng nghiệp vụ 
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
	EDMP2084 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@StudentID = '', @Mode = '2', @APK = '9329D066-7C97-4BD6-B28F-F08026394A08'

	EDMP2084 @DivisionID, @UserID,@StudentID, @Mode
----*/

CREATE PROCEDURE EDMP2084
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @APK VARCHAR(50), 
	 @Mode VARCHAR(50) --0: NGHỈ HỌC, 1: ĐIỀU CHUYỂN HỌC SINH, 2: BẢO LƯU
)

AS 


---Nghiệp vụ quyết định nghỉ học 

IF @Mode = 0 
BEGIN 

-----Cập nhật trạng thái hồ sơ học sinh 
UPDATE EDMT2010  
SET StatusID = 3,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT LeaveDate FROM EDMT2080 WITH (NOLOCK) WHERE APK = @APK)
WHERE StudentID IN  (SELECT StudentID FROM EDMT2080 WITH (NOLOCK) WHERE DivisionID = @DivisionID  AND DeleteFlg = 0 
					AND LeaveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK) 
AND DeleteFlg = 0



-----Cập nhật xếp lớp hiện tại 
UPDATE EDMT2021 
SET IsTransfer = 4,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT TOP 1 LeaveDate FROM EDMT2080 WITH (NOLOCK) WHERE APK = @APK)
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster  
WHERE EDMT2020.ArrangeClassID  IN ( SELECT ArrangeClassID FROM EDMT2080 WITH (NOLOCK) WHERE DivisionID = @DivisionID  AND DeleteFlg = 0 
									AND LeaveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK) 
AND
EDMT2021.StudentID IN (SELECT StudentID FROM EDMT2080 WITH (NOLOCK) WHERE DivisionID = @DivisionID  AND DeleteFlg = 0 
						AND LeaveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK)
AND EDMT2020.DeleteFlg = 0 
AND (( EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)) OR ( EDMT2021.DeleteFlg = 1 AND EDMT2021.IsTransfer IN (3,4))) 




END 

 
-------Nghiệp vụ điều chuyển học sinh 

-------Cập nhật xếp lớp cũ của học sinh là trạng thái chuyển lớp 
ELSE IF @Mode = 1  
BEGIN 
-----Chuyển lớp 
UPDATE EDMT2021 
SET IsTransfer = 1,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT TOP 1 FromEffectiveDate FROM EDMT2140 WITH (NOLOCK) WHERE APK = @APK) 
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster AND EDMT2020.DeleteFlg = 0 
WHERE EDMT2020.ArrangeClassID  IN ( SELECT ArrangeClassIDFrom FROM EDMT2140 WITH (NOLOCK) 
							   WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND StudentID = @StudentID 
								AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK AND EDMT2140.DivisionID = EDMT2140.SchoolIDTo ) AND
EDMT2021.StudentID IN	(SELECT StudentID FROM EDMT2140 WITH (NOLOCK) 
						  WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND StudentID = @StudentID 
						   AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK AND EDMT2140.DivisionID = EDMT2140.SchoolIDTo)
AND EDMT2021.DeleteFlg = 0 


-----Bổ sung cập nhật rạng thái xếp lớp là chuyển trường 
UPDATE EDMT2021 
SET IsTransfer = 5,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT TOP 1 FromEffectiveDate FROM EDMT2140 WITH (NOLOCK) WHERE APK = @APK) 
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster AND EDMT2020.DeleteFlg = 0 
WHERE EDMT2020.ArrangeClassID  IN ( SELECT ArrangeClassIDFrom FROM EDMT2140 WITH (NOLOCK) 
							   WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND StudentID = @StudentID 
								AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK AND EDMT2140.DivisionID != EDMT2140.SchoolIDTo ) AND
EDMT2021.StudentID IN	(SELECT StudentID FROM EDMT2140 WITH (NOLOCK) 
						   WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND StudentID = @StudentID 
						   AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK AND EDMT2140.DivisionID != EDMT2140.SchoolIDTo)
AND EDMT2021.DeleteFlg = 0 




--------Cập nhật trạng thái chuyển trường 
UPDATE T1
SET T1.StatusID = 5,
	T1.LastModifyUserID = @UserID,
	T1.LastModifyDate = (SELECT TOP 1 FromEffectiveDate FROM EDMT2140 WITH (NOLOCK) WHERE APK = @APK) 
FROM EDMT2010 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2140 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DivisionID = @DivisionID AND T1.StudentID IN (SELECT StudentID FROM EDMT2140 WITH (NOLOCK) 
													   WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND StudentID = @StudentID
													   AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND APK = @APK   )
	  AND T2.DivisionID != T2.SchoolIDTo

------Xếp lớp mới

IF OBJECT_ID('tempdb..#EDMP2084') IS NOT NULL 
DROP TABLE #EDMP2084

  SELECT EDMT2140.DivisionID,EDMT2140.StudentID,EDMT2020.APK,EDMT2140.CreateUserID,EDMT2140.FromEffectiveDate 
  INTO #EDMP2084
  FROM EDMT2140 WITH (NOLOCK)
  LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2140.ArrangeClassIDTo = EDMT2020.ArrangeClassID 
  WHERE EDMT2020.ArrangeClassID IN (SELECT ArrangeClassIDTo FROM EDMT2140 WITH (NOLOCK) 
									WHERE DivisionID = @DivisionID AND DeleteFlg = 0 AND APK = @APK 
									AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND ISNULL(ArrangeClassIDTo,'') != '') 
  AND EDMT2140.DeleteFlg = 0 AND EDMT2020.DeleteFlg = 0
  AND EDMT2140.APK = @APK 
  AND FromEffectiveDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) AND ISNULL(ArrangeClassIDTo,'') != ''

	IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2021 WITH (NOLOCK) WHERE APKMaster IN (SELECT APK FROM #EDMP2084 WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID) 
					AND EDMT2021.StudentID IN (SELECT StudentID FROM #EDMP2084 WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID) AND EDMT2021.DeleteFlg = 0  )
	BEGIN 
		INSERT INTO EDMT2021 (DivisionID, APKMaster, StudentID,IsTransfer,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT #EDMP2084.DivisionID,#EDMP2084.APK,#EDMP2084.StudentID,2,#EDMP2084.CreateUserID, FromEffectiveDate ,CreateUserID, FromEffectiveDate 
		FROM #EDMP2084 WITH (NOLOCK)
	END 
	ELSE IF EXISTS (SELECT TOP 1 1 FROM EDMT2021 WITH (NOLOCK) WHERE APKMaster IN (SELECT APK FROM #EDMP2084 WITH (NOLOCK) WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID) 
					AND EDMT2021.StudentID IN (SELECT StudentID FROM #EDMP2084 WITH (NOLOCK) WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID) AND EDMT2021.DeleteFlg = 0  )
	BEGIN 

	UPDATE EDMT2021 
	SET IsTransfer = 2,
	LastModifyUserID = @UserID,
	LastModifyDate = (SELECT TOP 1 FromEffectiveDate  FROM #EDMP2084 WITH (NOLOCK))
	FROM EDMT2021 WITH (NOLOCK)
	WHERE APKMaster IN (SELECT APK FROM #EDMP2084 WITH (NOLOCK) WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID) 
		  AND StudentID IN (SELECT StudentID FROM #EDMP2084 WITH (NOLOCK) WHERE  EDMT2021.DivisionID = #EDMP2084.DivisionID)
		  AND DeleteFlg = 0 

	END 


END 

ELSE IF @Mode= 2 -----Nghiệp vụ bảo lưu 
BEGIN 

----Cập nhật hồ sơ học sinh 
UPDATE EDMT2010
SET StatusID = 4,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT TOP 1 FromDate FROM EDMT2150 WITH (NOLOCK) WHERE APK = @APK) 
WHERE StudentID IN (SELECT StudentID FROM EDMT2150 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DeleteFlg = 0 
					AND FromDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))
				    AND APK = @APK) 
AND DeleteFlg = 0


----Cập nhật xếp lớp 
UPDATE EDMT2021 
SET IsTransfer = 3,
DeleteFlg = 1,
LastModifyUserID = @UserID,
LastModifyDate = (SELECT TOP 1 FromDate FROM EDMT2150 WITH (NOLOCK) WHERE APK = @APK) 
FROM EDMT2021 WITH (NOLOCK)
LEFT JOIN EDMT2020 WITH (NOLOCK) ON EDMT2020.APK = EDMT2021.APKMaster AND EDMT2020.DeleteFlg = 0
WHERE EDMT2020.SchoolYearID IN ( SELECT SchoolYearID FROM EDMT2150 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DeleteFlg = 0 
								 AND FromDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))  AND APK = @APK) 
AND
EDMT2021.StudentID IN (SELECT StudentID FROM EDMT2150 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DeleteFlg = 0 
						AND FromDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))  AND APK = @APK)
 
AND EDMT2020.ClassID IN (SELECT ClassID FROM EDMT2150 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND DeleteFlg = 0 
						 AND FromDate <= (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))  AND APK = @APK)

AND (( EDMT2021.DeleteFlg = 0 AND EDMT2021.IsTransfer IN (0,2)) OR ( EDMT2021.DeleteFlg = 1 AND EDMT2021.IsTransfer IN (3,4))) 


END 
 
 
 












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
