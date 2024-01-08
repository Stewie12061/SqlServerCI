-- <Summary>
---- Bảng thông tin giao hàng (Detail)
-- <History>
---- Create on 01/08/2022 by Văn Tài
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2201]') AND type in (N'U'))
CREATE TABLE [SOT2201](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DVoucherNo] [nvarchar](50) NOT NULL,	--- Số chứng từ Điều phối
	[MonitorID] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[RouteID] [nvarchar](50) NOT NULL,
	[AssetID] [nvarchar](50) NULL,
	[DriverID] [nvarchar](50) NOT NULL,
	[Shipper] [nvarchar](50) NOT NULL,
	[StatusTransportation] [tinyint] NULL DEFAULT (0),
	[OrderAssignQuanty] [int] NULL,
	[Weight] [decimal](28, 8) NULL,
	[Description] [nvarchar](500) NULL,
	[Status] [tinyint] NULL DEFAULT (0),
	[DeliveryDate] [datetime] NULL,
	[RouteStartDate] [datetime] NULL,
	[RouteEndDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Disabled] [tinyint] NULL,
 CONSTRAINT [PK_SOT2201] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC,
	[MonitorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2201' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2201' AND col.name = 'DVoucherNo')
	BEGIN
		ALTER TABLE SOT2201 ADD DVoucherNo VARCHAR(50) NULL
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2201' AND col.name = 'OrderAssignQuantyty')
	BEGIN
		EXEC sp_rename 'SOT2201.OrderAssignQuantyty', 'OrderAssignQuanty';
	END

	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2201' AND col.name = 'Disable')
	BEGIN
		EXEC sp_rename 'SOT2201.Disable', 'Disabled';
	END

END
