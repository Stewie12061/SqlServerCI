IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2019_DXP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2019_DXP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Trả ra số cấp xét duyệt và người duyệt từng cấp khi load lưới tại đơn xin phép duyệt hàng loạt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 21/06/2019 by Như Hàn
----Modyfied on 27/06/2022 by Nhựt Trường: [2022/05/IS/0202] - Customize NEW TOYO, bổ sung quyền xét duyệt cho phòng 'Phó Tổng Giám Đốc'.
----Modyfied on 12/09/2022 by Thanh Lượng: [2022/07/IS/0139] - Thêm điều kiện(EmployeeStatus=1) chỉ hiện danh sách nhân viên có trạng thái "đang làm".
-- <Example>
---- 
/*
	OOP2019_DXP @DivisionID='NTY', @EmployeeID = NTVN0023
*/

CREATE PROCEDURE dbo.OOP2019_DXP
(	
	@DivisionID VARCHAR(50),
	@EmployeeID VARCHAR(50)
)
AS
DECLARE @DepartmentID1 VARCHAR(50), --- Phòng ban của người đăng nhập chương trình
		@ManagerID VARCHAR(50)

IF OBJECT_ID('tempdb..#Approve') IS NOT NULL DROP TABLE #Approve
CREATE TABLE #Approve (Levels INT, LevelNo INT, ApproveID VARCHAR(50))

			SELECT @DepartmentID1 = DepartmentID FROM HT1403 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID

			SELECT @ManagerID = ContactPerson FROM AT1102 WITH (NOLOCK) WHERE DivisionID IN ('@@@', @DivisionID) AND DepartmentID = @DepartmentID1

			INSERT INTO #Approve (Levels, LevelNo, ApproveID)
			SELECT 2 , '1', @EmployeeID

			INSERT INTO #Approve (Levels, LevelNo, ApproveID)
			SELECT 2 , '2', @ManagerID

		SELECT TOP 1 0 AS Status, ISNULL(Levels, 0) AS Levels FROM #Approve

		-- Customize NEW TOYO
		IF ((select TOP 1 CustomerName from CustomerIndex) = '81')
		BEGIN
			INSERT INTO #Approve (Levels, LevelNo, ApproveID)
			SELECT 0, 99, EmployeeID from AT1103 where DepartmentID in ('01','01.2','02') AND EmployeeID NOT IN (select ApproveID From #Approve)
		END
		-- Luồng xử lý chuẩn
		ELSE
		BEGIN
			INSERT INTO #Approve (Levels, LevelNo, ApproveID)
			SELECT 0, 99, EmployeeID from AT1103 where DepartmentID in ('01','02') AND EmployeeID NOT IN (select ApproveID From #Approve)	
		END

		SELECT AP.LevelNo, AP.ApproveID, T3.FullName
		FROM #Approve AP
		LEFT JOIN AT1103 T3 WITH(NOLOCK) ON AP.ApproveID = T3.EmployeeID
		LEFT JOIN HT1400 T4 WITH(NOLOCK) ON AP.ApproveID = T4.EmployeeID
		Where T4.EmployeeStatus=1  ---Chỉ hiện nhân viên có trạng thái "Đang làm"
		ORDER BY LevelNo

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
