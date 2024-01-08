IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1409]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP1409]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Hoang Trong Khanh
-----Created date: 12/03/2012
-----purpose: Xóa các dữ liệu của các bảng liên quan khi xóa một nhân viên (Chuyển từ trigger HX1400 qua )
---- Modified on 29/12/2015 by Phương Thảo: Bổ sung lưu vào bảng AT1103 (Người dùng) nếu @IsAutoCreateUser = 1. 
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
------------------------------------------- Chỉnh sửa lại store: Bỏ vòng lặp
CREATE PROCEDURE 	[dbo].[HP1409] 
					@DivisionID nvarchar(50),
					@EmployeeID nvarchar(50)
AS

Declare @IsTranferEmployee Tinyint,
		@IsAutoCreateUser Tinyint

SELECT  TOP 1 @IsTranferEmployee = IsTranferEmployee
FROM	HT0000
WHERE DivisionID = @DivisionID

SELECT @IsAutoCreateUser = IsAutoCreateUser
FROM	HT1400 WITH (NOLOCK)
WHERE	EmployeeID = @EmployeeID And DivisionID = @DivisionID 


--- Lưu dữ liệu vào bảng AT1202 (Danh mục đối tượng - CI)
IF(@IsTranferEmployee = 1)
BEGIN
	IF NOT EXISTS(SELECT ObjectID FROM AT1202 WHERE ObjectID=@EmployeeID and DivisionID IN (@DivisionID, '@@@'))
	INSERT INTO AT1202 (DivisionID,ObjectID,ObjectName,[Address],Tel,PhoneNumber,Email,IsCustomer,IsSupplier,IsUpdateName)
	SELECT	DivisionID, EmployeeID, LastName + ' ' + MiddleName + ' ' + FirstName,  
			PermanentAddress, HomePhone, MobiPhone, Email, 1,0,0
	FROM	HT1400 WITH (NOLOCK)
	WHERE	EmployeeID = @EmployeeID And DivisionID = @DivisionID 
	
END

IF(@IsAutoCreateUser = 1)
BEGIN
	IF NOT EXISTS(SELECT EmployeeID FROM AT1103 WHERE EmployeeID=@EmployeeID and DivisionID = @DivisionID)
	INSERT INTO AT1103 (DivisionID, EmployeeID, FullName, DepartmentID, HireDate, BirthDay,Address,
						Tel, Fax, Email, IsUserID, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate)
	SELECT	H00.DivisionID, H00.EmployeeID, H00.LastName + ' ' + H00.MiddleName + ' ' + H00.FirstName,  H00.DepartmentID, 
			H03.WorkDate, H00.Birthday, H00.PermanentAddress, H00.MobiPhone, H00.HomeFax, H00.Email, 1,
			H00.CreateDate, H00.CreateUserID, H00.LastModifyUserID, H00.LastModifyDate
	FROM	HT1400 H00 WITH (NOLOCK) 
	INNER JOIN HT1403 H03 WITH (NOLOCK) ON H00.EmployeeID = H03.EmployeeID AND H00.DivisionID = H03.DivisionID
	WHERE	H00.EmployeeID = @EmployeeID And H00.DivisionID = @DivisionID 

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

