IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy danh sách nhân viên có sinh nhật vào hôm nay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Đoàn Duy on 16/03/2021
---- Modified by: Đoàn Duy on 19/04/2021 - Sửa điều kiện không load nhân viên đã nghỉ việc
---- Modified by: Hoài Thanh on 20/12/2021 - Sửa điều kiện không load nhân viên đã nghỉ việc (dựa trên khóa tài khoản ở bảng AT1405)
---- Modified by: Văn Tài	 on 20/03/2023 - Điều chỉnh trường hợp truy theo AT1103 phát sinh n DivisionID nếu tài khoản không dùng chung.
---- Modified by: Hoàng Long on 31/08/2023 - Điều chỉnh trường hợp không hiển thị ngày sinh nhật cho khách hàng CSG
-- <Example>
/*
 EXEC OOP0003 @IsUpcommingBirthDate = 1
 */

CREATE PROCEDURE OOP0003
( 
	@IsUpcommingBirthDate BIT  = 0 --Cờ để lấy những nhân viên sắp đến sinh nhật
) 
AS
DECLARE @CustomerIndex int
SELECT @CustomerIndex = CustomerName FROM CustomerIndex

BEGIN
	IF(@CustomerIndex <> 152) -- CSG
			BEGIN
			IF (@IsUpcommingBirthDate = 1)
				Begin    
					SELECT DISTINCT H1.EmployeeID, a1.FullName, H1.BirthDay 
					FROM AT1103 a1 WITH (NOLOCK)
					LEFT JOIN HT1400 H1 WITH (NOLOCK) ON H1.EmployeeID =  a1.EmployeeID
					INNER JOIN AT1405 a2 WITH (NOLOCK) ON a1.EmployeeID = a2.UserID
					WHERE (CONVERT(float, DATEADD(yyyy, DATEDIFF(yyyy, H1.BirthDay, GETDATE()), H1.BirthDay)) - CONVERT(FLOAT,GETDATE())) BETWEEN 0 AND 5 
						AND ISNULL(a2.IsLock, 0) = 0 AND ISNULL(a2.[Disabled], 0) = 0
					ORDER BY H1.BirthDay
				End
			Else
				Begin
					SELECT DISTINCT H1.EmployeeID, a1.FullName, H1.BirthDay 
					FROM AT1103 a1 WITH (NOLOCK)
					LEFT JOIN HT1400 H1 WITH (NOLOCK) ON H1.EmployeeID =  a1.EmployeeID
					INNER JOIN AT1405 a2 WITH (NOLOCK) ON a1.EmployeeID = a2.UserID
					WHERE CONVERT(VARCHAR(5),H1.Birthday,110) = CONVERT(VARCHAR(5), GETDATE(), 110)
						AND ISNULL(a2.IsLock, 0) = 0 AND ISNULL(a2.[Disabled], 0) = 0
					ORDER BY H1.BirthDay
				End 	
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
