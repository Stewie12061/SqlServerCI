-- <Summary>
---- Bảng số dư phép đầu kỳ
-- <History>
---- Create on 30/11/2016 by Hải Long
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1420]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1420](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
	[EmployeeID] VARCHAR(50) NOT NULL,
	[FirstLoaDays] DECIMAL(28,8) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL
	CONSTRAINT [PK_HT1420] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

	) ON [PRIMARY]
	

--- Modified on 05/01/2019 by Bảo Anh: Bổ sung số dư phép bù đầu kỳ (dùng cho QL phép nghỉ bù của NEWTOYO)
If Exists (Select * From sysobjects Where name = 'HT1420' and xtype ='U') 
Begin      
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT1420'  and col.name = 'FirstOTLeaveDays')
       Alter Table HT1420 Add FirstOTLeaveDays DECIMAL(28,8) NULL
END
