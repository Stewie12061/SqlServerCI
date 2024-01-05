IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2075]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2075]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
----- Kiểm tra trùng 1 ngày quyết định 1 giáo viên được được điều chuyển cùng 1 lớp  
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
	EDMP2075 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@TeacherID = 'ND1', @GradeIDFrom = 'NT-18-24',@ClassIDFrom = 'CONCO',@GradeIDTo = 'NT-25-36',@ClassIDTo = 'L7',@DecisionDate = '2019-09-23 00:00:00.000',@Mode = '0'

	EDMP2075 @DivisionID, @UserID,@TeacherID, @GradeIDFrom,@ClassIDFrom,@GradeIDTo,@ClassIDTo,@DecisionDate,@Mode
----*/

CREATE PROCEDURE EDMP2075
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @TeacherID VARCHAR(50),
	 @GradeIDFrom VARCHAR(50),
	 @ClassIDFrom VARCHAR(50),
	 @GradeIDTo VARCHAR(50),
	 @ClassIDTo VARCHAR(50),
	 @DecisionDate DATETIME,
	 @Mode VARCHAR(50) 
)

AS 


IF @Mode = 0 --------Kiểm tra trùng lớp hiện tại 

BEGIN 

SELECT TOP 1 ClassIDTo
FROM EDMT2070 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2071 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0  AND T1.DecisionDate = @DecisionDate  AND T2.TeacherID = @TeacherID AND T2.ClassIDFrom = @ClassIDFrom AND T2.GradeIDFrom = @GradeIDFrom 




END 


IF @Mode = 1 ---Kiểm tra trùng lớp đã điều chuyển 

BEGIN 


SELECT TOP 1 VoucherNo
FROM EDMT2070 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2071 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0  AND T1.DecisionDate = @DecisionDate AND T2.TeacherID = @TeacherID AND T2.ClassIDTo = @ClassIDTo AND T2.GradeIDTo = @GradeIDTo 



END 


 
 

 

 
 
 
 
 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
