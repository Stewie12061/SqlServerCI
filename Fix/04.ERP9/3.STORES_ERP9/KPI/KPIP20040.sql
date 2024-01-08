IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP20040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP20040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Xóa dữ liệu lương mềm bảng KPIT2040.
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created on 08/06/2021 by Nhựt Trường
-- <Example> EXEC KPIP20040 'DTI', ''
CREATE PROCEDURE KPIP20040
( 
	@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@UserID Varchar(50),
	@APKList NVARCHAR(MAX)
)

AS

BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@APKList_New AS NVARCHAR(max)

	SET @APKList_New = replace(@APKList, ',',''',''')

	SET @sSQL='
	DELETE KPIT2040
	WHERE DivisionID = '''+@DivisionID+'''
	AND Cast(APK as nvarchar(Max)) IN ('''+@APKList_New+''') '

	EXEC (@sSQL)
END