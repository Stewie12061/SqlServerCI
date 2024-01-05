IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Danh sách chủ đề Tuần theo Tháng - Khối - Lớp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lương Mỹ, Date: 14/11/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2124 @DivisionID = 'BE', @UserID = 'asoftadmin',@Mode = '1', @TermID = '',@ProgramID = '',

----*/
CREATE PROCEDURE EDMP2124
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @APK VARCHAR(50)
)

AS 

	SELECT T2.Week, T2.Topic, T2.Description
	FROM EDMT2120 T1 WITH (NOLOCK)
	INNER JOIN EDMT2121 T2 ON T2.APKMaster = T1.APK AND T2.DeleteFlg=T1.DeleteFlg
	WHERE T1.DeleteFlg = 0 
		AND T1.GradeID = @GradeID
		AND ISNULL(T1.ClassID, '') = ISNULL(@ClassID,'')
		AND T1.TranMonth = @TranMonth
		AND T1.TranYear = @TranYear
		AND CONVERT(VARCHAR(50),T1.APK) <> @APK
		ORDER BY T2.Week






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
