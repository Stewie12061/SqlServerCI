IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master phiếu nhập đầu ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Thi on 15/10/2020
----Modified by: Đình Ly on 03/03/2021: load dữ liệu cho các Bảng nghiệp vụ và Phiếu kế thừa.
-- <Example> EXEC QCP2004 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2004]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T1.APK, T1.DivisionID, T1.VoucherTypeID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth, T1.TranYear, 
			T1.ShiftID, T2.ShiftName, 
			T10.DepartmentID, T10.DepartmentName,
			T3.MachineID, T3.MachineName, T3.MachineNameE,
			T1.EmployeeID01, T4.FullName AS EmployeeName01,
			T1.EmployeeID02, T5.FullName AS EmployeeName02,
			T1.EmployeeID03, T6.FullName AS EmployeeName03,
			T1.EmployeeID04, T7.FullName AS EmployeeName04,
			T1.EmployeeID05, T8.FullName AS EmployeeName05,
			T1.EmployeeID06, T9.FullName AS EmployeeName06,
			T1.Description, T1.Notes01, T1.Notes02, T1.Notes03, T1.Status,
			T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID,
			T1.InheritTable, T1.InheritVoucher
		FROM QCT2000_TEMP T1  WITH (NOLOCK)
			LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
			LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
			LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T1.EmployeeID01 = T4.EmployeeID
			LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID02 = T5.EmployeeID
			LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T1.EmployeeID03 = T6.EmployeeID
			LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T1.EmployeeID04 = T7.EmployeeID
			LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T1.EmployeeID05 = T8.EmployeeID
			LEFT JOIN AT1103 T9 WITH (NOLOCK) ON T1.EmployeeID06 = T9.EmployeeID
			LEFT JOIN AT1102 T10 WITH (NOLOCK) ON T10.DivisionID IN (T1.DivisionID,'@@@') AND T10.DepartmentID = T1.DepartmentID
		WHERE T1.APK = @APK
		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
