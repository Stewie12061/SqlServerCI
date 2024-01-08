IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Detail Cập nhật đăng ký mua cổ phần
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 28/09/2018
-- <Example> EXEC SHMP2021 @DivisionID = 'BS', @UserID = 'a', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575'

CREATE PROCEDURE SHMP2021
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	SELECT T1.APK, T1.APKMaster, T1.DivisionID, T1.ShareTypeID, T1.UnitPrice, T1.QuantityBuyable, T1.QuantityRegistered
			, T1.QuantityApproved, T1.AmountBought, T1.DeleteFlg, T1.APKMInherited, T1.APKDInherited, T1.CreateDate
			, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
			, T2.ShareTypeName
	FROM SHMT2021 T1 WITH (NOLOCK) LEFT JOIN SHMT1010 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,'@@@') AND T1.ShareTypeID = T2.ShareTypeID
	WHERE T1.APKMaster = @APK and T1.DeleteFlg = 0
	Order by T1.OrderNo

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


