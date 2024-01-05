-- <Summary>
---- 
-- <History>
---- Create on 12/07/2019 by Khánh Đoan
----- Danh mục vị trí ô
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CT0199]') AND type in (N'U'))
CREATE TABLE [dbo].[CT0199](
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[LocationID] VARCHAR(50) NOT NULL,
	[LocationName] NVARCHAR(250) NULL,
	[WarehouseID] VARCHAR(50) NOT NULL,
	[InventoryTypeID] VARCHAR(50) NOT NULL,
	[Disabled] TINYINT NULL,
	[IsEmpty] TINYINT NULL,
	[CreateDate] DATETIME NULL,
	[CreateUserID] NVARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[LastModifyUserID] NVARCHAR(50) NULL
 CONSTRAINT [PK_CT0199] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[LocationID] 
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

