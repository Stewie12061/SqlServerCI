IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Tab thông tin EDMF1012: Danh mục định mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 28/08/2018
-- <Example>
---- 
--	EDMP1012 @DivisionID='MK', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'EE9DFD4C-430D-4B1E-9599-9F223283FE4A'

CREATE PROCEDURE [dbo].[EDMP1012]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @sSQL NVARCHAR (MAX)

SET @sSQL = N'SELECT a.DivisionID, a.APK, a.QuotaID, a.Disabled, a.Description, a.IsCommon
	, a.CreateUserID, a.CreateDate, a.LastModifyUserID, a.LastModifyDate
	FROM EDMT1010 a WITH(NOLOCK)
	WHERE a.APK = ''' + @APK + ''' 
'
--PRINT @sSQL
EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

