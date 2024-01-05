

--- Created on 30/05/2014 by Phan thanh hoang vu
--- Lưu trữ thông tin người dùng theo cửa hàng
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST0026]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST0026](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[ShopID] [varchar](50) NOT NULL,
	[EmployeeID] [varchar](50) NOT NULL,
	[EmployeeName] [nvarchar](250) NOT NULL,
	[CreateUserID] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_POST0026] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
End


---Hoàng vũ---CustomizeIndex = 79 (MINGSANG) thì khóa sẽ là [DivisionID, ShopID, EmployeeID] thay thế cho [DivisionID, EmployeeID]
---Mục đích: để phục vụ cho nhân thuộc nhiều cửa hàng
--DECLARE @CustomizeName int
--Set @CustomizeName = (Select CustomerName from CustomerIndex)
--If @CustomizeName = 79 
--BEGIN
--	IF EXISTS (SELECT Top 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'POST0026')
--	Begin
--		--Thay đối khóa chính từ 2 khóa [DivisionID, EmployeeID] sang 3 khóa [DivisionID, ShopID, EmployeeID]
--		ALTER TABLE POST0026 DROP CONSTRAINT PK_POST0026
--		ALTER TABLE POST0026 ADD CONSTRAINT PK_POST0026 PRIMARY KEY (DivisionID, ShopID, EmployeeID)
--	END
--END

--Chuyển từ MINHSANG qua bản chuẩn
IF EXISTS (SELECT Top 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'POST0026')
	Begin
		--Thay đối khóa chính từ 2 khóa [DivisionID, EmployeeID] sang 3 khóa [DivisionID, ShopID, EmployeeID]
		ALTER TABLE POST0026 DROP CONSTRAINT PK_POST0026
		ALTER TABLE POST0026 ADD CONSTRAINT PK_POST0026 PRIMARY KEY (DivisionID, ShopID, EmployeeID)
	END