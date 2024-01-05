IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2043]
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
----Modified by Lê Hoàng on 27/05/2021 : Trả thông tin CreateUserID, LastModifyUserID là tên người dùng
-- <Example> EXEC QCP2013 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2043]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T10.APK, T10.DivisionID, T10.VoucherTypeID, T10.VoucherNo, T10.VoucherDate, T10.TranMonth, T10.TranYear, T1.VoucherDate AS ManufacturingDate,
		T1.ShiftID, T2.ShiftName, T3.MachineID, T3.MachineName, T3.MachineNameE, T10.Notes, T1.VoucherNo AS Voucher_QCT2000,
		T1.CreateDate, A09.FullName AS CreateUserID, T1.LastModifyDate, A10.FullName AS LastModifyUserID
		FROM QCT2010 T10 WITH (NOLOCK)
		JOIN QCT2000 T1 WITH (NOLOCK) ON T10.APKMaster = T1.APK
		LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
		LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
		LEFT JOIN AT1103 A09 WITH (NOLOCK) ON A09.EmployeeID = T10.CreateUserID
		LEFT JOIN AT1103 A10 WITH (NOLOCK) ON A10.EmployeeID = T10.LastModifyUserID
		WHERE T10.APK = @APK AND T10.DivisionID = @DivisionID
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
