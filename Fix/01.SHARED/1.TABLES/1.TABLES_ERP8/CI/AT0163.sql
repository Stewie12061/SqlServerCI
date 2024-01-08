-- <Summary>
---- 
-- <History>
---- Create on 25/01/2016 by Bảo Anh: Danh mục nhóm thông số máy
---- Modified on 24/01/2021 by Nhựt Trường: Merge code Angel - Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0163]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0163](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[GroupID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT0163] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Merge code Angel - Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).
If Exists (Select * From sysobjects Where name = 'AT0163' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0163'  and col.name = 'DivisionID')
           Alter Table  AT0163 Alter Column DivisionID [nvarchar](50) NOT NULL          
End