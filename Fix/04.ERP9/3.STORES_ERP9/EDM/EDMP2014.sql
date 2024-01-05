IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Đổ nguồn grid Cập nhật xác nhận hồ sơ học sinh EDMF2015
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tình 10/10/2018
----Modified by Hồng Thảo on 08/04/2019: Bổ sung truyền biến mode để phân biết form gọi từ màn hình EDMF2010, EDMF2012 
-- <Example>
/*
	EXEC EDMP2014 @DivisionID=N'VS', @UserID=N'CALL002', @LanguageID = 'vi-VN', @APKList=N'5A119F89-926E-4D38-8A00-952D3AA09173', @Mode = ''
*/

 CREATE PROCEDURE EDMP2014 (
	@DivisionID NVARCHAR(2000),
	@UserID VARCHAR(50),
	@LanguageID VARCHAR(50),
	@APKList NVARCHAR(MAX),
	@Mode VARCHAR(50) ---0 Gọi từ màn hình truy vấn, 1: gọi từ màn hình xem chi tiết 
)
AS
SET NOCOUNT ON
DECLARE @sSQL NVARCHAR (MAX),
        @OrderBy NVARCHAR(500)



SET @OrderBy = ' A.StudentID' 



IF @Mode = 0 
BEGIN 
SET @sSQL = '
	SELECT A.APK, A.StudentID, A.DivisionID, A.StudentName, A.GradeID, C.GradeName,A.Receiver AS ReceiverID, D.FullName AS ReceiverName
	FROM EDMT2010 A WITH(NOLOCK) 
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN AT1103 D ON D.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND D.EmployeeID = A.Receiver 
	WHERE A.APK IN ('''+ @APKList + ''') AND ISNULL(A.ComfirmID,'''') = ''''
	ORDER BY ' + @OrderBy + '
	

'

END 

ELSE IF @Mode = 1 
BEGIN 
SET @sSQL = '
	SELECT A.APK, A.StudentID, A.DivisionID, A.StudentName, A.GradeID, C.GradeName,A.Receiver AS ReceiverID, D.FullName AS ReceiverName
	FROM EDMT2010 A WITH(NOLOCK) 
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN AT1103 D ON D.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND D.EmployeeID = A.Receiver 
	WHERE A.APK IN ('''+ @APKList + ''')
	ORDER BY ' + @OrderBy + '
	

'



END 




--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
