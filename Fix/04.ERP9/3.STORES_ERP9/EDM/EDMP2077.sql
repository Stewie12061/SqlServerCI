IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2077]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2077]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
----- Xử lý thêm giáo viên khi điều chuyển (hàng loạt)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 23/9/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2076 

	EDMP2077 @UserID
----*/

CREATE PROCEDURE EDMP2077
( 
	 @UserID VARCHAR(50)

)

AS 
 

DECLARE @EmployeeTypeID VARCHAR(50),
		@SchoolYearID VARCHAR(50) 


----Lấy năm học 

SELECT TOP 1 @SchoolYearID = SchoolYearID FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND  (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME)) BETWEEN DateFrom AND DateTo


DECLARE
		@Cur_TranferTeacher CURSOR, 
		@APK VARCHAR(50),
		@APKMaster VARCHAR(50),
		@DivisionID VARCHAR(50)

SET @Cur_TranferTeacher = CURSOR SCROLL KEYSET FOR
SELECT EDMT2070.DivisionID, EDMT2071.APK AS APKMaster
FROM  EDMT2070 WITH (NOLOCK)
LEFT JOIN EDMT2071 WITH (NOLOCK) ON EDMT2070.APK = EDMT2071.APKMaster AND EDMT2070.DeleteFlg = EDMT2071.DeleteFlg
WHERE EDMT2070.DeleteFlg = 0 AND EDMT2070.DecisionDate = (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))
OPEN @Cur_TranferTeacher
FETCH NEXT FROM @Cur_TranferTeacher INTO @DivisionID,@APKMaster
WHILE @@FETCH_STATUS = 0
BEGIN



---- Lấy thông tin khối lớp 
DECLARE @DecisionDate DATETIME,
		@TeacherID VARCHAR(50),
		@GradeIDTo VARCHAR(50),
		@ClassIDTo VARCHAR(50),
		@GradeIDFrom VARCHAR(50),
		@ClassIDFrom VARCHAR(50),
		@DivisionIDTo VARCHAR(50),
		@DivisionIDFrom VARCHAR(50)



SELECT @DivisionIDFrom = T1.DivisionID ,@DivisionIDTo = T1.DivisionIDTo,
	   @TeacherID = T2.TeacherID, @GradeIDTo = T2.GradeIDTo,@ClassIDTo = T2.ClassIDTo,
       @GradeIDFrom = T2.GradeIDFrom, @ClassIDFrom = T2.ClassIDFrom,
	   @DecisionDate = T1.DecisionDate
	   ----, @User = T2.CreateUserID
FROM EDMT2070 T1 WITH (NOLOCK)
LEFT JOIN EDMT2071 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0
WHERE T2.APK = @APKMaster  AND T1.DeleteFlg = 0
AND T1.DecisionDate = (SELECT CAST(CAST(GETDATE() AS DATE) AS DATETIME))

 
-----Xác định  giáo viên/ bảo mẫu 

SELECT @EmployeeTypeID = AT1103.EmployeeTypeID FROM AT1103 WITH (NOLOCK) WHERE AT1103.EmployeeID = @TeacherID

PRINT  @EmployeeTypeID

-----xóa giáo viên bảo mẫu ở lớp cũ 

-----Xóa giáo viên 
IF @DivisionIDFrom = @DivisionIDTo
BEGIN 

DECLARE @APKDetailOldGV VARCHAR(50) 


SELECT TOP 1  @APKDetailOldGV = T2.APK
FROM EDMT2030 T1 WITH (NOLOCK)
LEFT JOIN EDMT2031 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
WHERE T1.DivisionID = @DivisionID AND T2.TeacherID = @TeacherID AND T1.DeleteFlg = 0 
AND T1.SchoolYearID = @SchoolYearID AND T1.GradeID = @GradeIDFrom AND T1.ClassID = @ClassIDFrom



IF EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
			LEFT JOIN EDMT2031 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
			WHERE T1.DivisionID = @DivisionID AND T2.TeacherID = @TeacherID AND T1.DeleteFlg = 0 
			AND T1.SchoolYearID = @SchoolYearID AND T1.GradeID = @GradeIDFrom AND T1.ClassID = @ClassIDFrom
			)
BEGIN 

  UPDATE EDMT2031 
  SET DeleteFlg = 1,
  LastModifyDate = @DecisionDate,
  LastModifyUserID = @UserID
  WHERE APK = @APKDetailOldGV


END 




---Xóa bảo mẫu 
DECLARE @APKDetailOldBM VARCHAR(50) 


SELECT TOP 1  @APKDetailOldBM = T2.APK
FROM EDMT2030 T1 WITH (NOLOCK)
LEFT JOIN EDMT2032 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
WHERE T1.DivisionID = @DivisionID AND T2.NannyID = @TeacherID AND T1.DeleteFlg = 0 
AND T1.SchoolYearID = @SchoolYearID AND T1.GradeID = @GradeIDFrom AND T1.ClassID = @ClassIDFrom



IF EXISTS ( SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
			LEFT JOIN EDMT2032 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
			WHERE T1.DivisionID = @DivisionID AND T2.NannyID = @TeacherID AND T1.DeleteFlg = 0 
			AND T1.SchoolYearID = @SchoolYearID AND T1.GradeID = @GradeIDFrom AND T1.ClassID = @ClassIDFrom
			)
BEGIN 

  UPDATE EDMT2032
  SET DeleteFlg = 1,
  LastModifyDate = @DecisionDate,
  LastModifyUserID = @UserID
  WHERE APK = @APKDetailOldBM

END 


END 


-----CHUYỂN TRƯỜNG XÓA GV,BM RA KHỎI TRƯỜNG 
IF @DivisionIDFrom != @DivisionIDTo
BEGIN 

---XÓA GIÁO VIÊN 

UPDATE EDMT2031 
SET DeleteFlg = 1,
    LastModifyDate = @DecisionDate,
    LastModifyUserID = @UserID
FROM EDMT2031 WITH(NOLOCK)
WHERE CONVERT(VARCHAR(50),APK) IN (SELECT T1.APK FROM EDMT2031 T1 WITH(NOLOCK) WHERE T1.DivisionID = @DivisionIDFrom AND T1.TeacherID = @TeacherID AND T1.DeleteFlg = 0 )
AND EDMT2031.DeleteFlg = 0


----XÓA BẢO MẪU  

UPDATE EDMT2032 
SET DeleteFlg = 1,
    LastModifyDate = @DecisionDate,
    LastModifyUserID = @UserID
FROM EDMT2032 WITH(NOLOCK)
WHERE CONVERT(VARCHAR(50),APK) IN (SELECT T1.APK FROM EDMT2032 T1 WITH(NOLOCK) WHERE T1.DivisionID = @DivisionIDFrom AND T1.NannyID = @TeacherID AND T1.DeleteFlg = 0 )
AND EDMT2032.DeleteFlg = 0



END 





-----Đã tồn tại phân công cho khối, lớp 

IF EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
			WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
			AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID
			)
	BEGIN 

	 

	 IF @EmployeeTypeID = 'GV' AND ISNULL(@TeacherID,'') != ''
	 BEGIN 
	 -----INSERT GIÁO VIÊN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
				   LEFT JOIN EDMT2031 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
				   WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
				   AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID AND T2.TeacherID = @TeacherID)
	BEGIN 
	INSERT INTO EDMT2031 (DivisionID,APKMaster,TeacherID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	SELECT T1.DivisionID,T1.APK, @TeacherID,@UserID, @DecisionDate,@UserID, @DecisionDate
	FROM EDMT2030 T1 WITH (NOLOCK)
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
	AND T1.ClassID = @ClassIDTo  AND T1.SchoolYearID = @SchoolYearID  

	PRINT @DivisionID
	END 



	END 

	------INSERT BẢO MẪU 
	IF @EmployeeTypeID = 'BM' AND ISNULL(@TeacherID,'') != ''
	BEGIN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
					LEFT JOIN EDMT2032 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
					WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
					AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID AND T2.NannyID = @TeacherID)
	BEGIN 
	INSERT INTO EDMT2032 (DivisionID,APKMaster,NannyID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	SELECT T1.DivisionID,T1.APK, @TeacherID,@UserID, @DecisionDate,@UserID, @DecisionDate 
	FROM EDMT2030 T1 WITH (NOLOCK)
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
	AND T1.ClassID = @ClassIDTo  AND T1.SchoolYearID = @SchoolYearID 

	END 


	END 



	END 


 -----Chưa tạo phân công giáo viên/bảo mẫu

 IF @DivisionIDTo = @DivisionIDFrom
 BEGIN 
 
     IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
			LEFT JOIN EDMT2031 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
			WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0
		    AND T1.GradeID = @GradeIDTo AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID
			)
      BEGIN 

	------Tạo chứng từ tăng tự động 
	DECLARE
	@IsAutomatic NVARCHAR(100),
	@OutputOrder TINYINT, 
	@OutputLen TINYINT,
	@IsS1 NVARCHAR(50),		@IsS2 NVARCHAR(50),		@IsS3 NVARCHAR(50), 
	@Separated TINYINT,
	@Separator NVARCHAR(10),
	@VoucherEDMT2030 VARCHAR(50) 
	
	-- Lấy thiết lập mặc định có sinh số đối tượng tự động hay không
	

	 SELECT TOP 1 @IsS1 = ISNULL(AT1007.S1,''),
	 @IsS2 = ISNULL(AT1007.S2,''),
	 @IsS3 = ISNULL(AT1007.S3,''),
	 @OutputLen = AT1007.OutputLength,
	 @OutputOrder = AT1007.OutputOrder,
	 @Separated = AT1007.Separated,
	 @Separator = AT1007.Separator
	 FROM AT1007 WITH (NOLOCK) 
     INNER JOIN EDMT0000 WITH (NOLOCK) ON AT1007.DivisionID IN (EDMT0000.DivisionID, '@@@')  AND AT1007.VoucherTypeID = EDMT0000.VoucherAssignedTeacher
     WHERE EDMT0000.DivisionID = @DivisionID


  ------Tạo mã tăng tự động 
	EXEC AP0000 @DivisionID, @VoucherEDMT2030  Output, 'EDMT2030', @IsS1, @IsS2, @IsS3, @OutputLen, @OutputOrder, @Separated, @Separator
	
  ----INSERT MASTER 

  IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) WHERE  T1.VoucherNo = @VoucherEDMT2030 )
  BEGIN 
  INSERT INTO EDMT2030 (DivisionID,VoucherNo,SchoolYearID,GradeID,ClassID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,DeleteFlg)
  VALUES (@DivisionID,@VoucherEDMT2030,@SchoolYearID,@GradeIDTo,@ClassIDTo,@UserID, @DecisionDate,@UserID, @DecisionDate,0)
 



   ------INSERT DETAIL 

 IF @EmployeeTypeID = 'GV' AND ISNULL(@TeacherID,'') != ''
	 BEGIN 
	 -----INSERT GIÁO VIÊN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
				   LEFT JOIN EDMT2031 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
				   WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
				   AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID AND T2.TeacherID = @TeacherID)
	BEGIN 
	INSERT INTO EDMT2031 (DivisionID,APKMaster,TeacherID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	SELECT T1.DivisionID,T1.APK, @TeacherID,@UserID, @DecisionDate,@UserID, @DecisionDate
	FROM EDMT2030 T1 WITH (NOLOCK)
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
	AND T1.ClassID = @ClassIDTo  AND T1.SchoolYearID = @SchoolYearID  

	END 

	END 


	------INSERT BẢO MẪU 
	IF @EmployeeTypeID = 'BM' AND ISNULL(@TeacherID,'') != ''
	BEGIN 

	IF NOT EXISTS (SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK)
					LEFT JOIN EDMT2032 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
					WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
					AND T1.ClassID = @ClassIDTo AND T1.SchoolYearID = @SchoolYearID AND T2.NannyID = @TeacherID)
	BEGIN 
	INSERT INTO EDMT2032 (DivisionID,APKMaster,NannyID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
	SELECT T1.DivisionID,T1.APK, @TeacherID,@UserID, @DecisionDate,@UserID, @DecisionDate 
	FROM EDMT2030 T1 WITH (NOLOCK)
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.GradeID = @GradeIDTo 
	AND T1.ClassID = @ClassIDTo  AND T1.SchoolYearID = @SchoolYearID 

	END 

   END 




	END 

   END
 
 END 
 


 FETCH NEXT FROM @Cur_TranferTeacher INTO @DivisionID,@APKMaster
END

Close @Cur_TranferTeacher

 



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
