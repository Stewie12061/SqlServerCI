  IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP1022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load form tab xem thông tin danh mục đợt phát hành (Master)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 11/9/2018 by Xuân Minh
----Edited by Hoàng Vũ, on 11/9/2018
-- <Example> EXEC SHMP1022 @DivisionID = 'BS', @UserID = '', @APK = 'DAF414E6-68E3-42D2-8B69-D27DD6D9C603'

CREATE PROCEDURE SHMP1022
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50)
)
AS 

	SELECT SHMT1020.APK, SHMT1020.DivisionID, SHMT1020.SHPublishPeriodID, SHMT1020.SHPublishPeriodName,SHMT1020.SHPublishPeriodDate
			, SHMT1020.QuantityPreferredShare, SHMT1020.QuantityCommonShare,SHMT1020.QuantityTotal,SHMT1020.Description
			, SHMT1020.IsCommon, T01.Description AS IsCommonName, SHMT1020.[Disabled], T02.Description AS DisableName
			, SHMT1020.CreateUserID, SHMT1020.CreateDate, SHMT1020.LastModifyUserID, SHMT1020.LastModifyDate
	FROM SHMT1020 WITH (NOLOCK) 
						LEFT JOIN AT0099 T01 WITH (NOLOCK) ON SHMT1020.IsCommon=T01.ID AND T01.CodeMaster='AT00000004'
						LEFT JOIN AT0099 T02 WITH (NOLOCK) ON SHMT1020.Disabled=T02.ID AND T02.CodeMaster='AT00000004'
	WHERE SHMT1020.APK = @APK

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
