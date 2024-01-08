IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load thực đơn ngày master 
-- <Param>
----
-- <Return>
----
-- <History>
----Created by: Hồng Thảo 
-- <Example>
/*
	SELECT * FROM NMT2010 
   NMP2011 @DivisionID = 'BE' , @UserID = '', @APK = '4AEDB4CB-A08D-4C45-B7DD-95E01E10BA4E'
*/

 CREATE PROCEDURE NMP2011
(
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@APK VARCHAR(50)
)
AS
Begin
		DECLARE @sSQL NVARCHAR (MAX),
				@sWhere NVARCHAR(MAX)
		
 


SET @sSQL = 'SELECT T1.APK,T1.DivisionID,T1.GradeID,T2.GradeName, T1.FromDate, T1.ToDate
			 FROM NMT2010 T1 WITH (NOLOCK) 
			 LEFT JOIN EDMT1000 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.GradeID = T2.GradeID 
			 WHERE T1.DeleteFlg = 0 AND CONVERT(VARCHAR(50),T1.APK) = '''+@APK+''' 
		
		
		
		'
					
		EXEC (@sSQL)
		PRINT (@sSQL)
End


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
