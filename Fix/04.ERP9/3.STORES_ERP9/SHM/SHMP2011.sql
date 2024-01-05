IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load detail Cập nhật sổ cổ đông
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 26/09/2018
----Edited by: Hoàng Vũ on 23/10/2018
-- <Example> EXEC SHMP2011 @DivisionID = 'BS', @UserID = '', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575'

CREATE PROCEDURE SHMP2011
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 
BEGIN
	SELECT T11.APK,T11.DivisionID,T11.APKMaster,T11.ShareTypeID,T10.ShareTypeName,T10.PreferentialDescription
			, T10.TransferCondition
			, Isnull(T11.UnitPrice, 0) as UnitPrice
			, ISNULL(T11.IncrementQuantity,0) - ISNULL(T11.DecrementQuantity,0) as IncrementQuantity
			, ISNULL(T11.UnitPrice,0)* (ISNULL(T11.IncrementQuantity,0) - ISNULL(T11.DecrementQuantity,0)) AS ShareAmount
			, T11.Description
			, T11.TransactionDate
			, Case when Isnull(T11.TransactionTypeID, 0) = 1 then T20.VoucherNo
				   when Isnull(T11.TransactionTypeID, 0) = 2 then T30.VoucherNo
				   Else NULL end as RefVoucherNo
			, T11.TransactionTypeID
			, T11.APKMInherited,T11.APKDInherited
			, T11.CreateUserID,T11.CreateDate,T11.LastModifyUserID,T11.LastModifyDate
	FROM SHMT2011 T11 WITH (NOLOCK) LEFT JOIN SHMT1010 T10 WITH (NOLOCK) ON T11.ShareTypeID = T10.ShareTypeID
								    LEFT JOIN SHMT2020 T20 WITH (NOLOCK) ON T20.DivisionID = T11.DivisionID and T20.APK = T11.APKMInherited and T20.DeleteFlg = 0
									LEFT JOIN SHMT2030 T30 WITH (NOLOCK) ON T30.DivisionID = T11.DivisionID and T30.APK = T11.APKMInherited and T30.DeleteFlg = 0
	WHERE T11.APKMaster = @APK and T11.DeleteFlg = 0
	Order by T11.TransactionDate Desc, T11.OrderNo
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


