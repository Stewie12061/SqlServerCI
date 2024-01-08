IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2041]
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
----Created by: Thanh Thi on 15/10/2020
-- <Example> EXEC QCP2041 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2041]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T10.APK, T10.DivisionID, T10.VoucherTypeID, T10.VoucherNo, T10.VoucherDate, T10.TranMonth, T10.TranYear, T1.VoucherDate AS ManufacturingDate,
		T1.ShiftID, T2.ShiftName, T3.MachineID, T3.MachineName, T3.MachineNameE, T10.Notes, T1.APK AS Voucher_QCT2000,
		T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
		FROM QCT2010 T10 WITH (NOLOCK)
		JOIN QCT2000 T1 WITH (NOLOCK) ON T10.APKMaster = T1.APK
		LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
		LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
		WHERE T10.APK = @APK
		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
