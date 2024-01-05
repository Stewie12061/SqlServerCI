IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2171]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT2171](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[Orders] [int] NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[EmployeeID] [nvarchar](250) NULL,
	[DepartmentID] [varchar](50) NULL,
	[SectionID] [varchar](50) NULL,
	[SubsectionID] [varchar](50) NULL,
	[Note] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_HRMT2171] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

-- Sửa đổi dữ liệu của cột FirstLoaDays thành kiểu decimal
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2171' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2171' AND col.name='Orders')
			BEGIN
			ALTER TABLE HRMT2171 ADD Orders INT NULL 
			END
	END


	