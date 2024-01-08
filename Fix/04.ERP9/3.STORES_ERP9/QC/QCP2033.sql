IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2033]
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
-- <Example> EXEC QCP2013 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2033]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T10.APK, T10.DivisionID, T10.VoucherTypeID, T10.VoucherNo, T10.VoucherDate, T10.TranMonth, T10.TranYear, 
		CASE WHEN T1.VoucherDate IS NOT NULL THEN T1.VoucherDate ELSE T10.InheritDate END AS ManufacturingDate,
		CASE WHEN T1.ShiftID IS NOT NULL THEN T1.ShiftID ELSE T10.InheritShift END AS ShiftID, 
		CASE WHEN T1.ShiftID IS NOT NULL THEN T2.ShiftName ELSE T21.ShiftName END AS ShiftName, 
		CASE WHEN T1.MachineID IS NOT NULL THEN T1.MachineID ELSE T10.InheritMachine END AS MachineID, 
		CASE WHEN T1.MachineID IS NOT NULL THEN T3.MachineName ELSE T31.MachineName END AS MachineName, 
		CASE WHEN T1.MachineID IS NOT NULL THEN T3.MachineNameE ELSE T31.MachineNameE END AS MachineNameE, 
		T10.Notes, T1.VoucherNo AS Voucher_QCT2000,
		T10.CreateDate, T4.FullName CreateUserID, T10.LastModifyDate, T5.FullName LastModifyUserID
		FROM QCT2010 T10 WITH (NOLOCK)
		LEFT JOIN QCT2000 T1 WITH (NOLOCK) ON T10.APKMaster = T1.APK
		LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
		LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
		LEFT JOIN HT1020 T21 WITH (NOLOCK) ON T10.InheritShift = T21.ShiftID 
		LEFT JOIN CIT1150 T31 WITH (NOLOCK) ON T10.InheritMachine = T31.MachineID
		LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID IN (T10.DivisionID,'@@@') AND T4.EmployeeID = T10.CreateUserID
		LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID IN (T10.DivisionID,'@@@') AND T5.EmployeeID = T10.LastModifyUserID
		WHERE T10.APK = @APK
		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
