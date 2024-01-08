  IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form xem thông tin danh mục loại cổ phần
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 11/09/2018 by Xuân Minh
----Edited by Hoàng Vũ, on 17/10/2018
-- <Example> EXEC SHMP1011 @DivisionID = 'BS', @UserID = '', @APK = '9220DD8A-3CA9-4B3E-AD47-7BBE8825790F'


CREATE PROCEDURE SHMP1011
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50)
)
AS 
	SELECT SHMT1010.APK, SHMT1010.DivisionID, SHMT1010.ShareTypeID, SHMT1010.ShareTypeName,SHMT1010.UnitPrice,SHMT1010.PreferentialDescription
			, SHMT1010.TransferCondition, SHMT1010.LimitTransferYear,SHMT1010.SharedKind, T03.Description AS SharedKindName
			, SHMT1010.IsCommon, T01.Description AS IsCommonName, SHMT1010.[Disabled], T02.Description AS DisableName
			, SHMT1010.CreateUserID, SHMT1010.CreateDate, SHMT1010.LastModifyUserID, SHMT1010.LastModifyDate
	FROM SHMT1010 WITH (NOLOCK) 
			LEFT JOIN AT0099 T01 WITH (NOLOCK) ON SHMT1010.IsCommon=T01.ID AND T01.CodeMaster='AT00000004'
			LEFT JOIN AT0099 T02 WITH (NOLOCK) ON SHMT1010.Disabled=T02.ID AND T02.CodeMaster='AT00000004'
			LEFT JOIN AT0099 T03 WITH (NOLOCK) ON SHMT1010.SharedKind=T03.ID AND T03.CodeMaster='AT00000053'
	WHERE SHMT1010.APK = @APK

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
