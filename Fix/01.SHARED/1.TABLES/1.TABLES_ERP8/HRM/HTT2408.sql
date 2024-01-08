﻿-- <Summary>
----  Bảng tạm chứa dữ liệu dùng cho các store châm công
-- <History>
---- Create on 09/12/2013 by Lưu Khánh Vân
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HTT2408]') AND type in (N'U'))
CREATE TABLE [dbo].[HTT2408]
(
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
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
 CONSTRAINT [PK_HTT2408] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HTT2408_APK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HTT2408] ADD  CONSTRAINT [DF_HTT2408_APK]  DEFAULT (newid()) FOR [APK]
END

---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HTT2408' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HTT2408' AND col.name='IsAO')
		ALTER TABLE HTT2408 ADD IsAO TINYINT NULL
	END
-- Modified by Tuấn Anh on 03/07/2020: Thêm cột AOType để phân biệt các loại đơn Approval Online
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HTT2408' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HTT2408' AND col.name = 'AOType')
        ALTER TABLE HTT2408 ADD AOType VARCHAR(50) NULL
    END