IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2081]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load nghiệp vụ Quyết định nghi học (MASTER) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 28/11/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2081 @DivisionID = 'VS', @UserID = 'ASOFTADMIN', @APK = 'DF74CDCC-89B8-40F3-90A3-58353EB3147A', @LanguageID ='vi-VN'

	EDMP2081 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2081
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = N'
	SELECT TOP 1 T1.APKVoucher, T1.DivisionID,T1.VoucherLeaveSchool, T1.DecisiveDate,	
	T1.ProponentID,  A1.FullName AS ProponentName,  
	T1.DeciderID,  A2.FullName AS DeciderName,  
	T1.LeaveDate,T1.SchoolYearID
	,A3.GradeID,A4.GradeName,
	A3.ClassID, A5.ClassName,
	T1.IsGraduate, T1.Reason, T1.[Description]
	FROM EDMT2080 T1 WITH (NOLOCK)
	LEFT JOIN AT1103  A1 WITH (NOLOCK) ON T1.ProponentID = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN AT1103  A2 WITH (NOLOCK) ON T1.DeciderID   = A2.EmployeeID AND A2.DivisionID IN (T1.DivisionID,''@@@'')
	INNER JOIN EDMT2020 A3 WITH (NOLOCK) ON A3.ArrangeClassID = T1.ArrangeClassID AND A3.DeleteFlg = 0 
	INNER JOIN EDMT1000 A4 WITH (NOLOCK) ON A4.GradeID = A3.GradeID
	INNER JOIN EDMT1020 A5 WITH (NOLOCK) ON A5.ClassID = A3.ClassID

	WHERE ISNULL(T1.APKVoucher, T1.APK) = '''+@APK+'''

'

PRINT @sSQL
 EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

