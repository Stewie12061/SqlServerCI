-- <Summary>
---- Danh sách xác định đơn giá của bảng giá theo công đoạn (MAITHU),
---- đồng thời lưu phụ phí của sản phẩm ConditionID : Mã sản phẩm, UnitPrice : Giá trị
-- <History>
---- Create on 16/03/2021 by Lê Hoàng
---- Modified on ... by ... :
---- <Example>

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1905]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1905](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[PriceSheetID] [nvarchar](50) NOT NULL,
	[ConditionID] [nvarchar](50) NULL,
	[ValueType] [int] NULL,
	[FromValues] [decimal](28, 8) NULL,
	[ToValues] [decimal](28, 8) NULL,
	[Values] [nvarchar](50) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_HT19053] PRIMARY KEY NONCLUSTERED 
(
	[APK],
	[PriceSheetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
