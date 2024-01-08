-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2408_MK]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2408_MK](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[AbsentCardNo] [nvarchar](50) NULL,
	[AbsentDate] [datetime] NULL,
	[AbsentTime] [nvarchar](100) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[MachineCode] [nvarchar](50) NULL,
	[ShiftCode] [nvarchar](50) NULL,
	[IOCode] [tinyint] NULL,
	[InputMethod] [tinyint] NOT NULL,
	CONSTRAINT [PK_HT2408_MK] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT2408_MK__InputMet__7327C775]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2408_MK] ADD  CONSTRAINT [DF__HT2408_MK__InputMet__7327C775]  DEFAULT ((0)) FOR [InputMethod]
END
--Thêm cột APKMaster để link với bảng đơn xin phép khi bỏ duyệt thì tự động xóa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2408_MK' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col
				   INNER JOIN sysobjects obj ON obj.id = col.id 
	               WHERE col.name='APKMaster' AND obj.name='HT2408_MK')
	               ALTER TABLE HT2408_MK  ADD APKMaster VARCHAR(50) NULL 
END
--Thêm cột bổ sung hay xóa để kiểm tra dữ liệu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2408_MK' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col
				   INNER JOIN sysobjects obj ON obj.id = col.id 
	               WHERE col.name='EditType' AND obj.name='HT2408_MK')
	               ALTER TABLE HT2408_MK  ADD EditType TINYINT NULL 
END