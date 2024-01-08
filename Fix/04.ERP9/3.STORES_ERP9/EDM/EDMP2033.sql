IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load combo khối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 9/4/2019
-- <Example>
---- 
--	EDMP2033 @DivisionID='BE', @UserID='ASOFTADMIN', @SchoolYearID = '',@SreenID = 'EDMF2101'

CREATE PROCEDURE [dbo].[EDMP2033]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @SreenID VARCHAR(50)
)
AS 


IF @SreenID = 'EDMF2031' ---Phân công giáo viên 
	BEGIN

	SELECT A.GradeID, A.GradeName
	FROM EDMT1000 A WITH (NOLOCK) 
	WHERE A.DivisionID in (@DivisionID, '@@@') AND 
	EXISTS (SELECT B.GradeID FROM EDMT2020 B WHERE B.DivisionID = @DivisionID AND  B.GradeID = A.GradeID AND B.SchoolYearID = @SchoolYearID AND B.DeleteFlg = 0  )
	AND [Disabled]=0
	

END 

ELSE IF @SreenID = 'EDMF2141' ---Điều chuyển học sinh 
	BEGIN

	SELECT A.GradeID, A.GradeName
	FROM EDMT1000 A WITH (NOLOCK) 
	WHERE A.DivisionID in (@DivisionID, '@@@') AND 
	EXISTS (SELECT B.GradeID FROM EDMT2020 B WHERE B.DivisionID = @DivisionID AND  B.GradeID = A.GradeID AND B.DeleteFlg = 0 )
	AND [Disabled]=0
	

END 

ELSE IF @SreenID = 'EDMF2071' ----Điều chuyển giáo viên 
	BEGIN

	SELECT A.GradeID, A.GradeName
	FROM EDMT1000 A WITH (NOLOCK) 
	WHERE A.DivisionID in (@DivisionID, '@@@') AND 
	EXISTS (SELECT B.GradeID FROM EDMT2030 B WHERE B.DivisionID = @DivisionID AND  B.GradeID = A.GradeID AND B.DeleteFlg = 0 )
	AND [Disabled]=0
	

END 

ELSE  IF @SreenID = 'EDMF2101' ---Thời khóa biểu năm học 
		BEGIN 

		SELECT GradeID, GradeName
		FROM EDMT1000  WITH (NOLOCK) 
		WHERE DivisionID IN (@DivisionID, '@@@')
		AND [Disabled]=0


		END 











--PRINT @sSQL
--EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
