IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1011_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1011_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[AP1011_1]
(
	@APK NVARCHAR(250),
	@DivisionID NVARCHAR(250),
	@AnaID NVARCHAR(250),
	@AnaTypeID NVARCHAR(250),
	@AnaName NVARCHAR(250),
	@ReAnaID NVARCHAR(250),
	@CreateDate DATETIME,
	@CreateUserID NVARCHAR(250),
	@LastModifyUserID NVARCHAR(250),
	@LastModifyDate DATETIME
)
AS
BEGIN
	IF EXISTS (SELECT 1 FROM AT1011 A1 WITH (NOLOCK)
		INNER JOIN AT0000 A2 WITH (NOLOCK) ON A2.ProjectAnaTypeID = A1.AnaTypeID
		WHERE A1.AnaID = @AnaID)
	BEGIN
		UPDATE AT1011
		SET APK= @APK, DivisionID = @DivisionID, AnaName = @AnaTypeID, CreateDate = @CreateDate
		, CreateUserID=@CreateUserID, LastModifyUserID = @LastModifyUserID, LastModifyDate = @LastModifyDate, ReAnaID = @ReAnaID
		WHERE AnaID = @AnaID AND AnaTypeID = @AnaTypeID
	END
	ELSE
	BEGIN
		INSERT INTO AT1011(APK, DivisionID, AnaID, AnaTypeID, AnaName, ReAnaID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate) 
		VALUES (@APK, @DivisionID, @AnaID, @AnaTypeID, @AnaName, @ReAnaID, @CreateDate, @CreateUserID, @LastModifyUserID, @LastModifyDate)
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
