IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2015]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Cập nhật xác nhận hồ sơ học sinh EDMF2015: Lưu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tình 10/10/2018
-- <Example>
/*
	exec EDMP2015 @DivisionID=N'VS',@UserID=N'ASOFTADMIN',@APKList=N'01f4cb2d-df3e-49fe-9e5a-3b1f049092dd',@ComfirmStatusID=N'dsfdsff',@RegistrationDate='2018-12-24 00:00:00',@Receiver=N''
*/

 CREATE PROCEDURE EDMP2015 (
	@DivisionID NVARCHAR(2000),
	@UserID VARCHAR(50),
	@ComfirmStatusID VARCHAR(50),
	@RegistrationDate DATETIME,
	@Receiver VARCHAR(50),
	@APKList NVARCHAR(MAX)
)
AS
--SET NOCOUNT ON
DECLARE @sSQL NVARCHAR (MAX)

SET @sSQL = 'UPDATE EDMT2010 SET ComfirmID = ''' + @ComfirmStatusID + '''
	, Receiver = ''' + @Receiver + '''
	, RegistrationDate = ''' + CONVERT(VARCHAR(8), @RegistrationDate, 112) + '''
	, LastModifyDate = GETDATE(), LastModifyUserID = ''' + @UserID + '''
WHERE APK IN ('''+ @APKList + ''')'
--print @sSQL
EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON


