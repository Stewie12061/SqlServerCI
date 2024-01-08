---- Create by Đặng Thị Tiểu Mai on 12/5/2016 9:23:26 AM
---- Phương pháp tính phép năm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1029]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1029]
(
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
	[DivisionID] NVARCHAR(50) NOT NULL,
	[MethodVacationID] NVARCHAR(50) NOT NULL,
	[MethodVacationName] NVARCHAR(250) NULL,
	[VacationDay] DECIMAL(28,8) NULL,
	[Disabled] TINYINT DEFAULT (0) NULL,
	[SeniorityID] NVARCHAR(50) NULL,
	[IsWorkDate] TINYINT DEFAULT (0) NULL,
	[IsManagaVacation] TINYINT DEFAULT (0) NULL,
	[IsToMonthPlus] TINYINT DEFAULT (0) NULL,
	[ToMonthPlus] INT NULL,
	[IsPrevVacationDay] TINYINT DEFAULT (0) NULL,
	[MaxPrevVacationDay] DECIMAL(28,8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL
CONSTRAINT [PK_HT1029] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [MethodVacationID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
