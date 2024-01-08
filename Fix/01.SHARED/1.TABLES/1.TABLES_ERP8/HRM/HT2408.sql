

-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2408]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2408](
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
	CONSTRAINT [PK_HT2408] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT2408__InputMet__7327C775]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2408] ADD  CONSTRAINT [DF__HT2408__InputMet__7327C775]  DEFAULT ((0)) FOR [InputMethod]
END
--Thêm cột APKMaster để link với bảng đơn xin phép khi bỏ duyệt thì tự động xóa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2408' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col
				   INNER JOIN sysobjects obj ON obj.id = col.id 
	               WHERE col.name='APKMaster' AND obj.name='HT2408')
	               ALTER TABLE HT2408  ADD APKMaster VARCHAR(50) NULL 
END

-- Modify by Phương Thảo on 20/04/2016: Thêm cột IsScan để hỗ trợ sp đẩy dữ liệu bất thường
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2408' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT2408' AND col.name = 'IsScan')
        ALTER TABLE HT2408 ADD IsScan TINYINT NULL Default 0
    END

-- Modified by Bảo Thy on 04/10/2016: Thêm cột IsAO để phân biệt dòng quét thẻ thực tế của nhân viên và của Approval Online
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2408' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT2408' AND col.name = 'IsAO')
        ALTER TABLE HT2408 ADD IsAO TINYINT NULL
    END

-- Modified by Tuấn Anh on 03/07/2020: Thêm cột AOType để phân biệt các loại đơn Approval Online
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2408' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT2408' AND col.name = 'AOType')
        ALTER TABLE HT2408 ADD AOType VARCHAR(50) NULL
    END