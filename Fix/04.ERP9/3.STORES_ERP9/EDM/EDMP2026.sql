IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2026]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kiểm tra học sinh detail đã được sử dụng ở nghiệp vụ nào 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 19/8/2019
-- <Example>
---- 
/*-- <Example>
	EXEC EDMP2026 @DivisionID = 'BE', @UserID= '', @SchoolYearID = '2018-2019',@ClassID = 'L3',@StudentID = 'BE-Q030',@ScreenID = ''
 
	EDMP2026 @DivisionID, @UserID, @SchoolYearID,@ClassID,@StudentID,@ScreenID 
----*/
CREATE PROCEDURE EDMP2026
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @StudentID VARCHAR(50),
	 @TableID VARCHAR(50) 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''

IF @TableID = 'EDMT2020'
BEGIN 

---ĐIỂM DANH 
SELECT T1.VoucherNo, T1.SchoolYearID,T1.ClassID
FROM EDMT2040 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.SchoolYearID = @SchoolYearID AND T1.ClassID = @ClassID AND T2.StudentID = @StudentID

UNION ALL 

---KẾT QUẢ HỌC TẬP
SELECT EDMT2050.VoucherResult AS VoucherNo, EDMT2050.SchoolYearID, EDMT2050.ClassID
FROM EDMT2050 WITH (NOLOCK) 
WHERE EDMT2050.DivisionID = @DivisionID AND EDMT2050.DeleteFlg = 0 AND EDMT2050.SchoolYearID = @SchoolYearID AND EDMT2050.ClassID = @ClassID AND EDMT2050.StudentID = @StudentID 

UNION ALL 

----ĐĂNG KÝ DICH VỤ 
SELECT DISTINCT T1.VoucherNo,T1.SchoolYearID,  T2.ClassID
FROM EDMT2130 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2131 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = T1.DeleteFlg 
WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0 AND T1.SchoolYearID = @SchoolYearID AND T2.ClassID = @ClassID AND T2.StudentID = @StudentID 
 

 UNION ALL 
 ----DỰ THU HỌC PHÍ 

 SELECT T1.EstimateID AS VoucherNo, T1.SchoolYearID,  T1.ClassID
 FROM EDMT2160 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2161 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
 WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0  AND T1.SchoolYearID = @SchoolYearID AND T1.ClassID = @ClassID AND T2.StudentID = @StudentID

  
END 





PRINT (@sSQL)
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
