IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Detail Cập nhật chia cổ tức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hoàng Vũ on 28/09/2018
-- <Example> EXEC SHMP2041 @DivisionID = 'BS', @UserID = 'a', @APK = '214A4078-CD03-48A4-81D5-A35CC0F5C575'

CREATE PROCEDURE SHMP2041
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	SELECT T1.APK, T1.APKMaster, T1.DivisionID, T1.ObjectID, T2.ObjectName, T1.HoldQuantity, T1.AmountPayable
		, ISNULL(SUM(A90.ConvertedAmount),0) AS AmountPaid, T1.AmountPayable - ISNULL(Sum(A90.ConvertedAmount),0) AS AmountRemainning, T1.OrderNo, T1.DeleteFlg, T1.APKMInherited, T1.APKDInherited
		, T1.CreateDate, T1.LastModifyDate, T1.CreateUserID, T1.LastModifyUserID
	FROM SHMT2041 T1 WITH (NOLOCK) 
	LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T1.ObjectID = T2.ObjectID
	LEFT JOIN AT9000 A90 WITH (NOLOCK) ON T1.DivisionID = A90.DivisionID AND CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), A90.InheritTransactionID) 
			AND CONVERT(VARCHAR(50), T1.APKMaster )= CONVERT(VARCHAR(50), A90.InheritVoucherID )

	WHERE T1.APKMaster = @APK AND T1.DeleteFlg = 0
	GROUP BY T1.APK, T1.APKMaster, T1.DivisionID, T1.ObjectID, T2.ObjectName, T1.HoldQuantity, T1.AmountPayable
		, T1.OrderNo, T1.DeleteFlg, T1.APKMInherited, T1.APKDInherited
		, T1.CreateDate, T1.LastModifyDate, T1.CreateUserID, T1.LastModifyUserID
	ORDER BY T1.OrderNo
    


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
