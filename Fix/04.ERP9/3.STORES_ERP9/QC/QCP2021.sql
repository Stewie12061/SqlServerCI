IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master định nghĩa tiêu chuẩn (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Tấn Tài on 12/11/2020
-- <Example> EXEC QCP2041 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2021]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT QCT2020.APK, QCT2020.DivisionID, QCT2020.VoucherNo, QCT2020.VoucherDate, QCT2020.TranMonth, QCT2020.TranYear, QCT2020.Notes, QCT2020.DeleteFlg	, QCT2020.CreateDate, QCT2020.CreateUserID, QCT2020.LastModifyDate, QCT2020.LastModifyUserID, QCT2020.VoucherTypeID
			  , QCT2020.InheritDate ShiftVoucherDate, QCT2020.InheritShift ShiftID, QCT2020.InheritMachine MachineID
		FROM QCT2020 QCT2020
		WHERE QCT2020.APK = @APK
		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
