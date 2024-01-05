-- <Summary>
---- Lưu thông tin bảng lương sản phẩm công đoạn của nhân viên (MAITHU)
-- <History>
---- Create on 21/05/2021 by Lê Hoàng
---- Modified on ... by ... :
---- <Example>

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1906]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1906](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[DutyID] [nvarchar](50) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[CalculateDate] [datetime] NULL,
	[PhaseID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[Coefficient] [decimal](28, 8) NULL,---hệ số từ khai báo hệ số nhân viên-công đoạn-sản phẩm
	[Amount] [decimal](28, 8) NULL,---từ chấm công sản phẩm theo công đoạn
	[ProductSalary] [decimal](28, 8) NULL,---ProductSalary = Coefficient * Amount
	[RefAPK] [uniqueidentifier] NULL,---lưu vết dòng chấm công qua
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_HT1906] PRIMARY KEY NONCLUSTERED 
(
	[APK]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
