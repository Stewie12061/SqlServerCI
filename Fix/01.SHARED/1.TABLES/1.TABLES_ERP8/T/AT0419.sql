-- <Summary>
---- Danh mục chuyển nhượng thanh toán
-- <History>
---- Create on Kiều Nga on 01/04/2022

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0419]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0419](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] VARCHAR(50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[PlotID] VARCHAR(50) NULL,
    [CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL
	CONSTRAINT [PK_AT0419] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON

)) ON [PRIMARY]
END
