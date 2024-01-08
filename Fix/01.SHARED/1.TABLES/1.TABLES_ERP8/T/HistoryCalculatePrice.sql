-- <Summary>
---- Lưu lịch sử tính giá xuất kho
-- <History>
---- Create on 17/06/2018 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HistoryCalculatePrice]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[HistoryCalculatePrice](
		[APK] [uniqueidentifier] DEFAULT NEWID(),
		[DivisionID] [nvarchar](50) NOT NULL,
		[TranMonth] [int] NOT NULL,
		[TranYear] [int] NOT NULL,
		[FromInventoryID] [nvarchar](50) NOT NULL,
		[ToInventoryID] [nvarchar](50) NOT NULL,
		[FromWareHouseID] [nvarchar](50) NOT NULL,
		[ToWareHouseID] [nvarchar](50) NOT NULL,
		[FromAccountID] [nvarchar](50) NOT NULL,
		[ToAccountID] [nvarchar](50) NOT NULL,
		[CreateUserID] [nvarchar](50) NOT NULL,
		[CreateDate] DateTime NOT NULL
	 CONSTRAINT [PK_HistoryCalculatePrice] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
