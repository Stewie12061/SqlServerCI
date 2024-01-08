IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load form xem thông tin danh mục loại hình thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục loại hình thu \ Xem thông tin loại hình thu
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
	EDMP1053 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = 'F3D1B1FB-81A1-4A0D-9981-E4D7A82DCF73'

	EDMP1053 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE EDMP1053
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
     
SET @sSQL = @sSQL + N'
	SELECT TOP 1 EDMT1050.APK, EDMT1050.DivisionID, EDMT1050.ReceiptTypeID, EDMT1050.ReceiptTypeName, 
	T01.AnaName AS AnaRevenueID, EDMT1050.IsCommon, EDMT1050.[Disabled], 
	EDMT1050.CreateUserID, EDMT1050.CreateDate, EDMT1050.LastModifyUserID, EDMT1050.LastModifyDate,
	T02.AccountName as AccountID, E2.Description as TypeOfFee,
STUFF(ISNULL((	SELECT  '', '' + X.Description FROM  
												(	SELECT T1.APKMaster, T1.DivisionID, T1.Business, T2.Description
													FROM EDMT1051 T1 WITH (NOLOCK)
													JOIN EDMT0099 T2 WITH (NOLOCK) ON T2.CodeMaster=''BUSINESS'' AND T1.Business=T2.ID
												) X
								WHERE X.APKMaster = CONVERT(VARCHAR(50), EDMT1050.APK)
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS Business,
STUFF(ISNULL((	SELECT  '', '' + X.Description FROM  
												(	SELECT T1.APKMaster, T1.DivisionID, T1.StudentStatus, T2.Description
													FROM EDMT1052 T1 WITH (NOLOCK)
													JOIN EDMT0099 T2 WITH (NOLOCK) ON T2.CodeMaster=''StudentStatus'' AND T1.StudentStatus=T2.ID
												) X
								WHERE X.APKMaster = CONVERT(VARCHAR(50), EDMT1050.APK)
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS StudentStatus,
	EDMT1050.IsObligatory,EDMT1050.IsReserve,EDMT1050.IsTransfer,
	EDMT1050.Note
	FROM EDMT1050 WITH (NOLOCK) 
	LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.DivisionID IN (EDMT1050.DivisionID,''@@@'') AND T01.AnaID = EDMT1050.AnaRevenueID
	LEFT JOIN AT1005 T02 WITH (NOLOCK) ON T02.AccountID = EDMT1050.AccountID
	LEFT JOIN EDMT0099 E2 WITH (NOLOCK) ON E2.CodeMaster=''TypeOfFee'' AND EDMT1050.TypeOfFee = E2.ID

	WHERE EDMT1050.APK = '''+@APK+''' 
'
EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
