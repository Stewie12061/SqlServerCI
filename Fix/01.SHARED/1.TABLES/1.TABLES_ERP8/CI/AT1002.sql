-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on 19/01/2022 by Nguyễn Văn Tài: [ANGEL] Bổ sung cột City Code để xử lý tăng tự động Sell out.
-- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1002]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[CityID] [nvarchar](50) NOT NULL,
	[CityName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1002] PRIMARY KEY NONCLUSTERED 
(
	[CityID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1002_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1002] ADD  CONSTRAINT [DF_AT1002_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

If Exists (Select * From sysobjects Where name = 'AT1002' and xtype ='U') 
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =  'AT1002' and col.name = 'CityCode')
           Alter Table AT1002 Add CityCode VARCHAR(50) NULL
END

-----------Modify by Hương Nhung - Date 13/12/2023 thêm cột --------------------

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1002' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1002' AND col.name = 'CountryID') -- Mã quốc gia 
   ALTER TABLE AT1002 ADD CountryID  NVARCHAR(100) NULL 

END
