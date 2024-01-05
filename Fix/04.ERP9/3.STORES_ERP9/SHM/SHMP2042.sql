IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Master chia cổ tức (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hoàng vũ on 28/09/2018
-- <Example> EXEC SHMP2042 @DivisionID = 'BS', @UserID = '', @APK = '5DA80878-B1E6-4E46-8E53-EA703DE45FDD'

CREATE PROCEDURE SHMP2042
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T1.APK, T1.DivisionID, T1.VoucherTypeID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth, T1.TranYear
			, T1.LockDate, T1.Description, T1.TotalHoldQuantity, T1.TotalAmount, T1.FaceValue, T1.DividendPerShare
			, T1.DeleteFlg, T1.CreateUserID, T1.LastModifyUserID, T1.CreateDate, T1.LastModifyDate
		FROM SHMT2040 T1  WITH (NOLOCK)
		WHERE T1.APK = @APK and T1.DeleteFlg = 0
		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
