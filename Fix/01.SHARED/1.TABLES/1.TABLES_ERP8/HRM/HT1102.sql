-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified on 28/12/2015 by Phương Thảo: Bổ sung trường ManagerDutyID - Cấp quản lý trực tiếp
---- Modified on 10/03/2016 by Tiểu Mai: Bổ sung trường IsApproveRecruit - Duyệt tuyển dụng (ANGEL)
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1102]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1102](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DutyID] [nvarchar](50) NOT NULL,
	[DutyName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NOT NULL,
	[LastModifyDate] [datetime] NULL,
	[DutyRate] [decimal](28, 8) NULL,
 CONSTRAINT [PK_HT1102] PRIMARY KEY NONCLUSTERED 
(
	[DutyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default 
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1102_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1102] ADD  CONSTRAINT [DF_HT1102_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1102_LastModifyDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1102] ADD  CONSTRAINT [DF_HT1102_LastModifyDate]  DEFAULT (getdate()) FOR [LastModifyDate]
END


-- Add Column

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1102' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1102' AND col.name = 'ManagerDutyID')
        ALTER TABLE HT1102 ADD ManagerDutyID NVARCHAR(50) NULL
    END
    
-- Add Column by Tiểu Mai on 10/03/2016
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1102' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1102' AND col.name = 'IsApproveRecruit')
        ALTER TABLE HT1102 ADD IsApproveRecruit TINYINT DEFAULT(0) NOT NULL
    END	

-- Add Column by Đình Hòa on 25/01/2021 (Thêm column DutyGroupID đang thiếu do merger fix) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1102' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1102' AND col.name = 'DutyGroupID')
        ALTER TABLE HT1102 ADD DutyGroupID NVARCHAR(50) NULL
    END	

