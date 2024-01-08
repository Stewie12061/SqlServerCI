-- <Summary>
---- Master nghiệp vụ thống kê kết quả sản xuất module M (Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 15/03/2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2210]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2210]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[VoucherNo] VARCHAR(50) NOT NULL,
	[VoucherDate] DATETIME NOT NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
	[PhaseID] NVARCHAR(MAX) NULL, -- Công đoạn
	[EmployeeID] NVARCHAR(50)NULL, -- Người theo dõi
	[Description] NVARCHAR(MAX) NULL, -- Diễn giải
	[CreateDate] DATETIME NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NOT NULL
CONSTRAINT [PK_MT2210] PRIMARY KEY CLUSTERED
(
  [DivisionID] ASC,
  [VoucherNo]  ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột IsWarehouse ----------------
If Exists (Select * From sysobjects Where name = 'MT2210' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2210'  and col.name = 'IsWarehouse')
           Alter Table  MT2210 Add IsWarehouse TINYINT DEFAULT (0) NULL
END