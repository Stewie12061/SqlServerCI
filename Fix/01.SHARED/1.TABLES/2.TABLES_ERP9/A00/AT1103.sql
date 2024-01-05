-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 20/11/2015 by Hoàng vũ: CusmizeIndex = 51 (Khách hàng hoáng trần), bổ sung thêm 2 trường SipID, SipPassword tài khoản mặc định của nhân viên dùng crm
---- Modified on hoàng vũ by 15/02/2017: Bổ sung trường GroupID để xử ngầm trường hợp add người dùng vào nhóm và add DivisionID vào nhóm
------ Modified on 18/02/2017 by Thị Phượng: Bổ sung các trường Cho phân hệ CRM
---- Modified on 09/08/2017 by Hoàng vũ: Bổ sung các Tổ nhóm
---- Modified on 15/01/2018	by Khả Vi: bổ sung số lượng tối đa, loại chức năng
-- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1103]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1103](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[EmployeeTypeID] [nvarchar](50) NULL,
	[HireDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[BirthDay] [datetime] NULL,
	[Address] [nvarchar](250) NULL,
	[Tel] [nvarchar](100) NULL,
	[Fax] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[IsUserID] [tinyint] NOT NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT1103] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--Alter Pimary key 
		IF EXISTS (SELECT Top 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'AT1103')
		Begin
			--Thay đối khóa chính từ 2 khóa sang 1 khóa (DivisionID, EmployeeID) -> (EmployeeID)
			ALTER TABLE AT1103 DROP CONSTRAINT pk_AT1103
			ALTER TABLE AT1103 ADD CONSTRAINT pk_AT1103 PRIMARY KEY (EmployeeID)
		End
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1103_IsUserID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1103] ADD  CONSTRAINT [DF_AT1103_IsUserID]  DEFAULT ((0)) FOR [IsUserID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1103_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1103] ADD  CONSTRAINT [DF_AT1103_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

--SipID: Dùng cho CRM, giá trị này do bên tổng đài cung cap
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'SipID')
        ALTER TABLE AT1103 ADD SipID NVARCHAR(50) NULL
    END

--SipPassword: Dùng cho CRM, giá trị này do bên tổng đài cung cap
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'SipPassword')
        ALTER TABLE AT1103 ADD SipPassword NVARCHAR(50) NULL
    END
		
--Add Columns
		----------------Thêm nhóm người dùng {xử cho POS-CLOUD}-----------------------
		IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT1103' AND xtype='U')
		BEGIN
			IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name='AT1103' AND col.name='GroupID')
			ALTER TABLE AT1103 ADD GroupID nvarchar(250) NULL
		END
--Thị Phượng on 13/02/2017 Các cột bổ sung trong CRM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'Signature') 
   ALTER TABLE AT1103 ADD Signature NVARCHAR(max) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'Image01ID') 
   ALTER TABLE AT1103 ADD Image01ID IMAGE NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'DutyID') 
   ALTER TABLE AT1103 ADD DutyID VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'PermissionUser') 
   ALTER TABLE AT1103 ADD PermissionUser VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'Nationality') 
   ALTER TABLE AT1103 ADD Nationality VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'IndentificationNo') 
   ALTER TABLE AT1103 ADD IndentificationNo VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'PassportNo') 
   ALTER TABLE AT1103 ADD PassportNo NVARCHAR(250) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'BankAccountNumber') 
   ALTER TABLE AT1103 ADD BankAccountNumber NVARCHAR(250) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'Gender') 
   ALTER TABLE AT1103 ADD Gender VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'MarriedStatus') 
   ALTER TABLE AT1103 ADD MarriedStatus VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'IsCommon') 
   ALTER TABLE AT1103 ADD IsCommon TINYINT NULL 
END
-- Bổ sung tổ nhóm, nếu nhân viên thuộc tổ nhóm thì sẽ lên hiển thị sơ đồ tổ chức nếu tổ nhóm được gắn vào sơ đồ tổ chức
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'TeamID')
   ALTER TABLE AT1103 ADD TeamID VARCHAR(50) NULL
END
-- Bổ sung số lượng tối đa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'QuantityMax')
   ALTER TABLE AT1103 ADD QuantityMax DECIMAL(28,8) NULL
END
-- Bổ sung loại chức năng 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'FunctionID')
   ALTER TABLE AT1103 ADD FunctionID VARCHAR(50) NULL
END

---- Modified by Hồng Thảo on 06/04/2019: Bổ sung trường Đối tượng phụ thuộc

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'InheritConsultantID') 
   ALTER TABLE AT1103 ADD InheritConsultantID VARCHAR(50) NULL 
END


--Modified by Trà Giang on 06/03/2020: Bổ sung trường Nhân viên phụ kho ( NN = 108) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'AssistantWarehouseID') 
   ALTER TABLE AT1103 ADD AssistantWarehouseID NVARCHAR(50) NULL
END

--Modified by Hoài Bảo on 18/10/2022: Bổ sung trường TokenBearer
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1103' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1103' AND col.name = 'TokenBearer') 
   ALTER TABLE AT1103 ADD TokenBearer NVARCHAR(MAX) NULL
END