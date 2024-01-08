---- Create by Hoàng Long on 26/07/2023
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0170]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[AT0170](
        [APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
		[APKMaster] UNIQUEIDENTIFIER NULL,
        [DivisionID] [nvarchar](50) NOT NULL,
        [Year] [int] NULL,
		[Month] [int] NULL,
        [SalesMonth] [decimal](28, 8) NULL,
        [EmployeeID] [nvarchar](50) NULL,
        [ObjectID] [nvarchar](50) NULL,
		[InventoryID] [nvarchar](50) NULL,
        [TargetMonth] [decimal](28, 8) NULL,
		[CreateUserID] NVARCHAR(50) NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyUserID] NVARCHAR(50) NULL,
		[LastModifyDate] DATETIME NULL,
        CONSTRAINT [PK_AT0170] PRIMARY KEY NONCLUSTERED ([APK] ASC)
        WITH (
            PAD_INDEX = OFF,
            STATISTICS_NORECOMPUTE = OFF,
            IGNORE_DUP_KEY = OFF,
            ALLOW_ROW_LOCKS = ON,
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY]
END

