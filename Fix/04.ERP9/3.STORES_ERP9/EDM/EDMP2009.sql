IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
----	Hồ sơ Học sinh ở Đơn vị hiện tại
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: [Lương Mỹ] on [25/7/2019]
----Modify by Hồng Thảo on 22/10/2019: Bổ sung order by lấy học sinh mới nhất cho trường hợp học sinh học lại 
----Modify by Đình Hoà on 01/10/2020: Update lại InheritTranfer khi kế thừa học sinh 
-- <Example>
---- 
---- EDMP2009 @DivisionID = 'BE',  @UserID = 'ASOFTADMIN',@StudentID = 'LU-A019'


CREATE PROCEDURE [dbo].[EDMP2009]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @StudentID VARCHAR(50)
)
AS 


BEGIN 

	DECLARE @result table (APK varchar(36), DivionID varchar(50), StudentID varchar(50))
	DECLARE @inheritAPK varchar(36) = 
			(select TOP 1 InheritTranfer from EDMT2000 WITH(NOLOCK) where StudentID = @StudentID AND DeleteFlg = 0 ORDER BY CreateDate DESC)

	WHILE exists(select 1 from EDMT2000 WITH(NOLOCK) where APK = @inheritAPK)
	BEGIN
	INSERT INTO @result(APK, DivionID, StudentID)
	SELECT APK, DivisionID, StudentID
	FROM EDMT2000 WITH(NOLOCK)
	WHERE APK = @inheritAPK
		

		SET @inheritAPK = (SELECT APK
		FROM EDMT2000 WITH(NOLOCK)
		WHERE APK = @inheritAPK)

		UPDATE EDMT2000
		SET InheritTranfer = NULL
		WHERE StudentID = @StudentID

		SET @inheritAPK = ( SELECT APK FROM EDMT2000 WITH(NOLOCK) WHERE InheritTranfer = @inheritAPK)
		print @inheritAPK
	
	END

	SELECT * FROM @result where DivionID = @DivisionID

END 












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
