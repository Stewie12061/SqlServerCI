IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Master chuyển nhượng cổ phẩn (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hoàng Vũ on 26/10/2018
-- <Example> EXEC SHMP2032 @DivisionID = 'BS', @UserID = '', @APK = '5DA80878-B1E6-4E46-8E53-EA703DE45FDD'

CREATE PROCEDURE SHMP2032
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT S30.APK, S30.DivisionID, S30.VoucherTypeID, S30.VoucherNo, S30.VoucherDate, S30.TranMonth, S30.TranYear
				, S30.FromObjectID, A21.ObjectName as FromObjectName
				, S30.BeforeFromQuantity, S30.AfterFromQuantity
				, S30.ToObjectID, A22.ObjectName as ToObjectName
				, S30.BeforeToQuantity, S30.AfterToQuantity
				, S30.Description, S30.TransferFree, S30.TotalQuantityTransfered, S30.TotalAmountTransfered
				, S30.DeleteFlg, S30.CreateUserID, S30.LastModifyUserID, S30.CreateDate, S30.LastModifyDate
		FROM SHMT2030 S30  WITH (NOLOCK) 
							LEFT JOIN AT1202 A21 WITH (NOLOCK) ON A21.ObjectID=S30.FromObjectID
							LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.ObjectID=S30.ToObjectID
		WHERE S30.APK = @APK and S30.DeleteFlg = 0

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
