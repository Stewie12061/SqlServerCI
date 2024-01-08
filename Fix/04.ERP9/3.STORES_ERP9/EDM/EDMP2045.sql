IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2045]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2045]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load grid form EDMF2041: khi button "Chọn" tại form chọn xếp lớp EDMF2043
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 13/11/2018
-- <Example>
---- 
--	EDMP2045 @DivisionID='BE', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @AttendanceDate = '2019-03-28 00:00:00', @ArrangeClassID = 'XL/2019/03/0010'


CREATE PROCEDURE [dbo].[EDMP2045]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @AttendanceDate DATETIME,
	 @ArrangeClassID VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(4000), @Param NVARCHAR(1000)
DECLARE @dStartMonth DATETIME, @dEndMonth DATETIME



SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @AttendanceDate), 0)


SELECT T2.StudentID,T3.StudentName,T3.DateOfBirth,T1.SchoolYearID,T1.GradeID,T1.ClassID, ISNULL (SUM(DayAvailable),0) AS DayAvailable
	, ISNULL (SUM(DayAbsentPermission),0) AS DayAbsentPermission, ISNULL (SUM(DayAbsentNotPermission),0) AS DayAbsentNotPermission
	
FROM EDMT2020 T1 WITH (NOLOCK)
INNER JOIN EDMT2021 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.StudentID = T2.StudentID  AND T1.DeleteFlg = T3.DeleteFlg

LEFT JOIN (
	SELECT B.StudentID,A.SchoolYearID,A.GradeID,A.ClassID, CASE WHEN B.AvailableStatusID = 'HD' THEN 1 ELSE 0 END AS DayAvailable
		, CASE WHEN B.AvailableStatusID = 'CP' THEN 1 ELSE 0 END AS DayAbsentPermission
		, CASE WHEN B.AvailableStatusID = 'KP' THEN 1 ELSE 0 END AS DayAbsentNotPermission
	FROM EDMT2040 A WITH(NOLOCK) INNER JOIN EDMT2041 B WITH(NOLOCK) ON A.APK = B.APKMaster
	WHERE A.AttendanceDate BETWEEN @dStartMonth  AND @AttendanceDate
		AND EXISTS (SELECT TOP 1 1 FROM 
					(SELECT B1.StudentID, A1.SchoolYearID, A1.GradeID, A1.ClassID
					 FROM EDMT2020 A1 WITH(NOLOCK) INNER JOIN EDMT2021 B1 WITH(NOLOCK) ON A1.APK = B1.APKMaster  
					 WHERE A1.ArrangeClassID = @ArrangeClassID  AND A1.DeleteFlg = 0 AND B1.DeleteFlg = 0) AS C
					 WHERE C.StudentID  = B.StudentID  AND A.SchoolYearID = C.SchoolYearID AND A.GradeID = C.GradeID AND A.ClassID = C.ClassID
					 )

		AND A.DeleteFlg = 0 AND B.DeleteFlg = 0
					
) AS Z ON Z.StudentID = T2.StudentID 

WHERE T1.ArrangeClassID = @ArrangeClassID AND T2.IsTransfer != 1 AND T3.StatusID IN ('0','1')  AND T1.DeleteFlg = 0

GROUP BY T2.StudentID,T3.StudentName,T3.DateOfBirth, T1.SchoolYearID,T1.GradeID,T1.ClassID

ORDER BY T2.StudentID,T3.StudentName



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
