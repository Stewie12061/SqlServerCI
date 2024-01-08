-- Xử lý bảng tạm cho store AP1510
-- Created by Xuân Nguyên	on	12/08/2022.

If Exists (Select * From sysobjects Where name = 'AT1591' and xtype ='U') 
	DROP TABLE AT1591

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AT1591](
	[DivisionID] [varchar](50) NULL,
	[AssetID] [varchar](250) NULL,
	[ChangePeriod] [int] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[AccDepAmount] [decimal](28, 8) NULL
) ON [PRIMARY]
GO