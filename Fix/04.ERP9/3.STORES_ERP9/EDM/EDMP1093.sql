IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load from xem thông tin biểu phí 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo, Date: 06/09/2018
----Modified by on
-- <Example>
---- 
/*-- <Example>
	EDMP1093 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '804E3816-8CEA-4EEB-9019-021AD183F0D1'
	
	EDMP1093 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE EDMP1093
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
     
SET @sSQL = @sSQL + N'
	SELECT T1.APK, T1.DivisionID, T1.FeeID, T1.FeeName, 
	T1.SchoolYearID, T2.GradeName AS GradeID,
	T1.[Disabled], T1.IsCommon,T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate
	FROM EDMT1090 T1 WITH (NOLOCK) 
	LEFT JOIN EDMT1000 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.GradeID = T1.GradeID
	WHERE T1.APK = '''+@APK+''''
EXEC (@sSQL)
--PRINT(@sSQL)

   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
