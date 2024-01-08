-- <Summary>
---- Chi tiết bảng giá theo số lượng nhóm hàng 
-- <History>
---- Create on 01/11/2021 by Kiều Nga
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0154]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0154](
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[ID] [nvarchar](50) NOT NULL,
	[OrderNo] [int] NOT NULL,
	[InventoryTypeID] [nvarchar](50) NOT NULL,
	[InventoryTypeName] [nvarchar](250) NULL,
	[FromValues] [decimal](28, 8) NULL,
	[ToValues] [decimal](28, 8) NULL,
	[Notes] [nvarchar](250) NULL,	
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,		
 CONSTRAINT [PK_CT0154] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[APK] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

