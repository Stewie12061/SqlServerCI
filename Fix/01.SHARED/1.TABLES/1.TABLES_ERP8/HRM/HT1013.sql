-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Tr?m
---- Modified by Tiểu Mai on 23/02/2017: Sửa lại đoạn add default
---- Modified by Văn Tài  on 10/09/2020: Bổ sung trường thiếu từ 8.3.7 DA sang.
---- Modified by Huỳnh Thử  on 08/01/2021: Bổ sung trường ProbationaryType 8.3.7 DA sang.
---- Modified on ... by ...
---- <Example>


GO

/****** Object:  Table [dbo].[HT1013]    Script Date: 07/22/2010 15:39:06 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1013]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1013](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[AbsentTypeID] [nvarchar](50) NOT NULL,
	[AbsentName] [nvarchar](250) NULL,
	[UnitID] [nvarchar](50) NULL,
	[IsMonth] [tinyint] NULL,
	[ConvertUnit] [decimal](28, 8) NULL,
	[TypeID] [nvarchar](50) NULL,
	[IsTransfer] [tinyint] NULL,
	[ParentID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[IsSystem] [tinyint] NOT NULL,
	[Disabled] [tinyint] NOT NULL,
	[MaxValue] [decimal](28, 8) NULL,
	[Orders] [tinyint] NULL,
	[Caption] [nvarchar](250) NULL,
 CONSTRAINT [PK_HT1013] PRIMARY KEY NONCLUSTERED 
(
	[AbsentTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[HT1013]    Script Date: 07/22/2010 15:39:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

------ Add giá tr? defauult
--IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1013_IsSystem]') AND type = 'D')
--BEGIN
--ALTER TABLE [dbo].[HT1013] ADD  CONSTRAINT [DF_HT1013_IsSystem]  DEFAULT ((0)) FOR [IsSystem]
--END
--IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1013_Disabled]') AND type = 'D')
--BEGIN
--ALTER TABLE [dbo].[HT1013] ADD  CONSTRAINT [DF_HT1013_Disabled]  DEFAULT ((0)) FOR [Disabled]
--END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT1013' and xtype ='U') 
Begin      
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT1013'  and col.name = 'IsCondition')
       Alter Table  HT1013 Add IsCondition tinyint Null Default(0)       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT1013'  and col.name = 'ConditionCode')
       Alter Table  HT1013 Add ConditionCode nvarchar(4000) Null
END

--- Modified by Ti?u Mai on 17/11/2016: Bổ sung checkbox Công phép thường niên
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT1013'  and col.name = 'IsAnnualLeave')
Alter Table  HT1013 Add IsAnnualLeave TINYINT DEFAULT(0) NULL

---- Add giá trị default
Declare @DefaultName varchar(200), @DefaultText varchar(200), @AllowNull varchar(50), @SQL varchar(500)
If Exists (Select * From sysobjects Where name = 'HT1013' and xtype ='U') 
Begin
	Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
	From syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'HT1013'  and col.name = 'IsSystem'
	If @AllowNull Is Not Null        
	Begin 
		Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
		on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
		inner join sysobjects tab on col.id = tab.id  
		where tab.name = 'HT1013'  and col.name = 'IsSystem'  
		--drop constraint 
		if @DefaultName Is Not Null 
			Execute ('Alter Table HT1013 Drop Constraint ' + @DefaultName)
		--change column type
		Set @SQL = 'Alter Table HT1013  Alter Column IsSystem tinyint '  + @AllowNull 
		Execute(@SQL) 
		--restore constraint 
		if @DefaultName Is Not Null 
			Execute( 'Alter Table HT1013  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For IsSystem')
	End
END

If Exists (Select * From sysobjects Where name = 'HT1013' and xtype ='U') 
Begin
	Select @AllowNull = Case When col.isnullable  = 1 Then 'NULL' Else 'NOT NULL' End 
	From syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'HT1013'  and col.name = 'Disabled'
	If @AllowNull Is Not Null        
	Begin 
		Select @DefaultName = def.name, @DefaultText = cmm.text from sysobjects def inner join syscomments cmm 
		on def.id = cmm.id inner join syscolumns col on col.cdefault = def.id 
		inner join sysobjects tab on col.id = tab.id  
		where tab.name = 'HT1013'  and col.name = 'Disabled'  
		--drop constraint 
		if @DefaultName Is Not Null 
			Execute ('Alter Table HT1013 Drop Constraint ' + @DefaultName)
		--change column type
		Set @SQL = 'Alter Table HT1013  Alter Column Disabled tinyint '  + @AllowNull 
		Execute(@SQL) 
		--restore constraint 
		if @DefaultName Is Not Null 
			Execute( 'Alter Table HT1013  Add Constraint ' + @DefaultName   + ' Default (' + @DefaultText + ') For Disabled')
	End
End

--- Modified by Văn Tài on 24/07/2020
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT1013'  and col.name = 'IsDTVS')
Alter Table  HT1013 Add IsDTVS TINYINT DEFAULT(0) NULL

--- Modified by Văn Tài on 24/07/2020
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT1013'  and col.name = 'IsRegime')
Alter Table  HT1013 Add IsRegime TINYINT DEFAULT(0) NULL

--- Modified by Văn Tài on 10/09/2020
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT1013'  and col.name = 'IsOTLeave')
Alter Table  HT1013 Add IsOTLeave TINYINT DEFAULT(0) NULL

-- Bổ sung thêm trường ProbationaryType Loại công thử việc
If Exists (Select * From sysobjects Where name = 'HT1013' and xtype ='U') 
Begin      
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT1013'  and col.name = 'ProbationaryTypeID')
       Alter Table HT1013 Add ProbationaryTypeID varchar(50)       
END