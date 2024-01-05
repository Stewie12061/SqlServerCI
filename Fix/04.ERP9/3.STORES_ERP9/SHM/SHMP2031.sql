IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail Cập nhật chuyển nhượng cổ phần
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hoàng Vũ on 28/09/2018
-- <Example> EXEC SHMP2031 @DivisionID = 'BS', @UserID = 'a', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575'

CREATE PROCEDURE SHMP2031
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	SELECT S31.APK, S31.APKMaster, S31.DivisionID, S31.ShareTypeID, S10.ShareTypeName
		 , S31.QuantityTransfered , S31.UnitPrice, S31.AmountTransfered, S31.OrderNo, S31.DeleteFlg
		 , S31.APKMInherited, S31.APKDInherited, S31.CreateDate, S31.LastModifyDate, S31.CreateUserID, S31.LastModifyUserID
	FROM SHMT2031 S31 WITH (NOLOCK) LEFT JOIN SHMT1010 S10 WITH (NOLOCK) ON S31.ShareTypeID = S10.ShareTypeID
	WHERE S31.APKMaster = @APK and S31.DeleteFlg = 0
	Order by S31.OrderNo

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


