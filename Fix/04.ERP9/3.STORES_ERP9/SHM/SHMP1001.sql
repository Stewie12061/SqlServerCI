  IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form xem chi tiết nhóm cổ đông /cập nhật nhóm cổ cổ đông
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Create on 07/08/2018 by Xuân Minh
----Edited 17/10/2018: Hoàng vũ
-- <Example>
---- EXEC SHMP1001 @DivisionID='BS',@UserID='',@APK ='DAF414E6-68E3-42D2-8B69-D27DD6D9C603'

CREATE PROCEDURE SHMP1001
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50)
)
AS 
	SELECT SHMT1000.APK, SHMT1000.DivisionID, SHMT1000.ShareHolderCategoryID, SHMT1000.ShareHolderCategoryName
			, SHMT1000.Notes, SHMT1000.IsCommon, A91.Description AS IsCommonName
			, SHMT1000.Disabled, A92.Description AS DisabledName
			, SHMT1000.CreateUserID, SHMT1000.CreateDate, SHMT1000.LastModifyUserID, SHMT1000.LastModifyDate
	FROM SHMT1000 WITH (NOLOCK) LEFT JOIN AT0099 A91 WITH (NOLOCK) ON A91.ID=SHMT1000.IsCommon AND A91.CodeMaster = 'AT00000004'
								LEFT JOIN AT0099 A92 WITH (NOLOCK) ON A92.ID=SHMT1000.Disabled AND A92.CodeMaster = 'AT00000004'
	WHERE SHMT1000.APK = @APK

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
