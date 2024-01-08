
-- <Summary>
---- Script tạo bảng thuần để khi chạy tools không gặp lỗi.
---- Target: HP0197.
-- <History>
---- Create on 05/08/2020 by Văn Tài
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HQ2406A]') AND TYPE IN (N'U'))
BEGIN
    CREATE TABLE HQ2406A (
			APK VARCHAR(50),
			DivisionID varchar(50),
			TranMonth int,
			Tranyear int,
			AbsentCardNo varchar(50),
			AbsentDate datetime,
			AbsentTime nvarchar(100),
			MachineCode NVARCHAR(50),
			IOCode TINYINT,
			InputMethod TINYINT,
			EmployeeID VARCHAR(50),
			Notes nvarchar(250),
			ShiftCode NVARCHAR(50),
			IsError tinyint,
			ActualDate DATETIME
		)
END