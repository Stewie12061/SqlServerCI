-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 19/01/2016:  Cập nhật chỉ tiêu doanh số bán hàng của nhân viên.
---- Modified by Tiểu Mai on 10/06/2016: Bổ sung thông tin nhân viên, đối tượng, loại mặt hàng
---- Modified by Hải Long on 08/12/2016: Bổ sung loại mặt hàng (MPT đơn hàng bán số 4)
---- Modified on 24/12/2021 by Nhật Thanh: Merge code Angel - Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0161]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0161](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TargetsID] [nvarchar](50) NOT NULL,
	[TransactonID] [nvarchar](50) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[EmployeeLevel] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[SalesMonth] [decimal](28, 8) NULL,
	[SalesQuarter] [decimal](28, 8) NULL,
	[SalesYear] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	CONSTRAINT [PK_AT0161] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0161' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'EmployeeID')
    ALTER TABLE AT0161 ADD EmployeeID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'ObjectID')
    ALTER TABLE AT0161 ADD ObjectID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'InventoryTypeID')
    ALTER TABLE AT0161 ADD InventoryTypeID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'Orders')
    ALTER TABLE AT0161 ADD Orders DECIMAL(28,8) NULL
    
    -- Bổ sung loại mặt hàng (MPT đơn hàng bán số 4)
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'InventoryTypeID2')
    ALTER TABLE AT0161 ADD InventoryTypeID2 NVARCHAR(50) NULL
END        

--- Modified by Nhật Thanh on 14/12/2021: Bổ sung 5 trường ghi nhận 5 cấp nhân viên cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0161' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'SOAna01ID')
    ALTER TABLE AT0161 ADD SOAna01ID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'SOAna02ID')
    ALTER TABLE AT0161 ADD SOAna02ID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'SOAna03ID')
    ALTER TABLE AT0161 ADD SOAna03ID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'SOAna04ID')
    ALTER TABLE AT0161 ADD SOAna04ID NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'SOAna05ID')
    ALTER TABLE AT0161 ADD SOAna05ID NVARCHAR(50) NULL

	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'DivisionID')
    ALTER TABLE AT0161 ALTER COLUMN DivisionID NVARCHAR(50) NOT NULL
END  

--- Modified by Thanh Lượng on 10/07/2023: Bổ sung Người duyệt cho KH GREE
If Exists (Select * From sysobjects Where name = 'AT0161' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT0161'  and col.name = 'Levels')
    Alter Table AT0161 ADD Levels INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT0161'  and col.name = 'StatusSS')
    Alter Table AT0161 ADD StatusSS TinyInt NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'ApprovingLevel')
    ALTER TABLE AT0161 ADD ApprovingLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'ApproveLevel')
    ALTER TABLE AT0161 ADD ApproveLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'AT0161' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE AT0161 ADD APKMaster_9000 uniqueidentifier NULL
	END
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'AT0161'  and col.name = 'ApprovalNotes')
	ALTER TABLE AT0161 ADD ApprovalNotes NVARCHAR(250) NULL

	-- Bổ sung cột Phiếu kế thừa
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'AT0161'  and col.name = 'ApprovalNotes')
	ALTER TABLE AT0161 ADD ApprovalNotes NVARCHAR(250) NULL
END
