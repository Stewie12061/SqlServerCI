IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2048]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2048]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
----	Lấy danh sách Xếp lớp học sinh đang học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: [Lương Mỹ] on [26/7/2019]
-- <Example>
---- 
---- exec EDMP2048 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN',@APK = '16cf6498-552d-40fe-83fd-688eea9896d2', @PageNumber=1, @PageSize=25


CREATE PROCEDURE [dbo].[EDMP2048]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 


BEGIN 

	DECLARE @StudentID VARCHAR(50) = ''

	SELECT TOP 1 @StudentID = E2010.StudentID
	FROM EDMT2010 E2010 WITH(NOLOCK)
	WHERE CONVERT(VARCHAR(50), E2010.APK) = @APK
	print @StudentID


	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY EDMT1040.DateTo DESC, E21.LastModifyDate DESC)) AS RowNum, COUNT(*) OVER () AS TotalRow,
	E20.DivisionID, E20.ArrangeClassID, E20.SchoolYearID + ' (' + CONVERT(VARCHAR(10), EDMT1040.DateFrom, 103) + ' - ' + CONVERT(VARCHAR(10), EDMT1040.DateTo, 103) + ')' AS SchoolYearID,
	E20.GradeID,EDMT1000.GradeName, E20.ClassID, EDMT1020.ClassName, E21.IsTransfer AS StatusID, E0099.Description AS StatusName,
	EDMT1040.DateFrom, EDMT1040.DateTo, E21.LastModifyDate
	FROM EDMT2020 E20 WITH (NOLOCK) 
	LEFT JOIN EDMT2021 E21 WITH (NOLOCK) ON E21.APKMaster = E20.APK AND E21.DivisionID = E20.DivisionID
	LEFT JOIN EDMT1040 WITH (NOLOCK) ON E20.SchoolYearID = EDMT1040.SchoolYearID AND EDMT1040.DivisionID IN ('@@@', E20.DivisionID)
	LEFT JOIN EDMT0099 E0099 WITH (NOLOCK) ON E0099.CodeMaster = 'MoveStatus' AND E0099.ID = E21.IsTransfer 
	LEFT JOIN EDMT1000 WITH (NOLOCK) ON EDMT1000.GradeID = E20.GradeID AND EDMT1000.DivisionID IN ('@@@' , E20.DivisionID)
	LEFT JOIN EDMT1020 WITH (NOLOCK) ON EDMT1020.ClassID = E20.ClassID AND EDMT1020.DivisionID IN ('@@@' , E20.DivisionID)

	WHERE E20.DivisionID = @DivisionID AND E21.StudentID = @StudentID AND E20.DeleteFlg = 0 AND
		(( E21.DeleteFlg = 0) OR ( E21.DeleteFlg = 1 AND E21.IsTransfer IN (1,3,4,5)))

	ORDER BY EDMT1040.DateTo DESC, E21.LastModifyDate DESC
	OFFSET (@PageNumber-1) * @PageSize ROWS
	FETCH NEXT @PageSize ROWS ONLY
END 















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
