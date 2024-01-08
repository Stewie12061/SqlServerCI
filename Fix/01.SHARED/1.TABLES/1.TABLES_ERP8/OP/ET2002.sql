﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Ngoc Nhut
-- Modified by Kim Thư on 07/05/2019: Bổ sung DescriptionEN và DescriptionVN lưu diễn giải ở OF3025
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[et2002]') AND type in (N'U'))
CREATE TABLE [dbo].[ET2002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TemplateVoucherID] [nvarchar](50) NULL,
	[TemplateBatchID] [nvarchar](50) NULL,
	[TemplateTransactionID] [nvarchar](50) NULL,
	[TemplateID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[inv_no] [nvarchar](50) NULL,
	[settlemt_option] [nvarchar](50) NULL,
	[inv_date] [datetime] NULL,
	[curr_code] [nvarchar](50) NULL,
	[inv_amt] [decimal](28, 8) NULL,
	[awb_nbr] [nvarchar](50) NULL,
	[billto_freight] [decimal](28, 8) NULL,
	[discount_amt] [decimal](28, 8) NULL,
	[freight_after_discount] [decimal](28, 8) NULL,
	[Total_Non_Fuel_Surchrg] [decimal](28, 8) NULL,
	[awb_amt] [decimal](28, 8) NULL,
	[exchange_rate] [decimal](28, 8) NULL,
	[icpc_child_acct_nbr] [nvarchar](50) NULL,
	[ship_date] [datetime] NULL,
	[orig_locn] [nvarchar](250) NULL,
	[dest_locn] [nvarchar](250) NULL,
	[service_type] [nvarchar](50) NULL,
	[SvcAbbrev] [nvarchar](250) NULL,
	[in_out_bound] [tinyint] NULL,
	[in_out_bound_desc] [nvarchar](250) NULL,
	[no_pieces] [decimal](28, 8) NULL,
	[ActualWgtV] [decimal](28, 8) NULL,
	[Aut] [nvarchar](100) NULL,
	[ChrgbleWgtV] [decimal](28, 8) NULL,
	[CUt] [nvarchar](100) NULL,
	[Dimension] [nvarchar](100) NULL,
	[bill_to_flag] [nvarchar](100) NULL,
	[rebill_reason] [nvarchar](100) NULL,
	[entry_batch_no] [nvarchar](100) NULL,
	[Del_DateTime] [nvarchar](100) NULL,
	[Pod_Signature] [nvarchar](100) NULL,
	[shpr_cust_no] [nvarchar](100) NULL,
	[shpr_name] [nvarchar](250) NULL,
	[shpr_company] [nvarchar](250) NULL,
	[shpr_addr1] [nvarchar](250) NULL,
	[shpr_addr2] [nvarchar](250) NULL,
	[shpr_city] [nvarchar](100) NULL,
	[shpr_state] [nvarchar](100) NULL,
	[shpr_zip] [nvarchar](100) NULL,
	[shpr_cntry] [nvarchar](100) NULL,
	[cnsgn_cust_no] [nvarchar](50) NULL,
	[cnsgn_name] [nvarchar](250) NULL,
	[cnsgn_company] [nvarchar](250) NULL,
	[cnsgn_addr1] [nvarchar](250) NULL,
	[cnsgn_addr2] [nvarchar](250) NULL,
	[cnsgn_city] [nvarchar](250) NULL,
	[cnsgn_state] [nvarchar](50) NULL,
	[cnsgn_zip] [nvarchar](50) NULL,
	[cnsgn_cntry] [nvarchar](250) NULL,
	[Col01] [decimal](28, 8) NULL,
	[Col02] [decimal](28, 8) NULL,
	[Col03] [decimal](28, 8) NULL,
	[SvAbbrew] [nvarchar](50) NULL,
	[FuelSur] [decimal](28, 8) NULL,
	[SurDesc1] [nvarchar](100) NULL,
	[SurAmount1] [decimal](28, 8) NULL,
	[SurDesc2] [nvarchar](100) NULL,
	[SurAmount2] [decimal](28, 8) NULL,
	[SurDesc3] [nvarchar](100) NULL,
	[SurAmount3] [decimal](28, 8) NULL,
	[SurDesc4] [nvarchar](100) NULL,
	[SurAmount4] [decimal](28, 8) NULL,
	[SurDesc5] [nvarchar](100) NULL,
	[SurAmount5] [decimal](28, 8) NULL,
	[SurDesc6] [nvarchar](100) NULL,
	[SurAmount6] [decimal](28, 8) NULL,
	[SurDesc7] [nvarchar](100) NULL,
	[SurAmount7] [decimal](28, 8) NULL,
	[SurDesc8] [nvarchar](100) NULL,
	[SurAmount8] [decimal](28, 8) NULL,
	CONSTRAINT [PK_ET2002] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Modified by Kim Thư on 07/05/2019: Bổ sung DescriptionEN và DescriptionVN lưu diễn giải ở OF3025
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ET2002' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'ET2002' AND col.name = 'DescriptionEN') 
	ALTER TABLE ET2002 ADD DescriptionEN NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'ET2002' AND col.name = 'DescriptionVN') 
	ALTER TABLE ET2002 ADD DescriptionVN NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'ET2002' AND col.name = 'settlemt_option_vn') 
	ALTER TABLE ET2002 ADD settlemt_option_vn NVARCHAR(50) NULL
END

-- Gán Default cho Col01, Col02, Col03
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ET2002' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id 
				INNER JOIN sysconstraints const ON const.constid = col.cdefault
				WHERE tab.name = 'ET2002' AND col.name = 'Col01' ) 
		ALTER TABLE ET2002 ADD CONSTRAINT Col01_DF DEFAULT (0) FOR Col01

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id 
				INNER JOIN sysconstraints const ON const.constid = col.cdefault
				WHERE tab.name = 'ET2002' AND col.name = 'Col02' )
		ALTER TABLE ET2002 ADD CONSTRAINT Col02_DF DEFAULT (0) FOR Col02
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id 
				INNER JOIN sysconstraints const ON const.constid = col.cdefault
				WHERE tab.name = 'ET2002' AND col.name = 'Col03' )
		ALTER TABLE ET2002 ADD CONSTRAINT Col03_DF DEFAULT (0) FOR Col03
END
