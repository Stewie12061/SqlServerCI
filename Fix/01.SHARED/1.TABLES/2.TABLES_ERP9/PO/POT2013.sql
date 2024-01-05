---- Create by Tieumai on 6/22/2018 2:46:29 PM
---- Cập nhật Leadtime_MOQ (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT2013]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT2013]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [LeadTimeID] NVARCHAR(50) NOT NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [InventoryTypeID] NVARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_POT2013] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [LeadTimeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
If Exists (Select * From sysobjects Where name = 'POT2013' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2013'  and col.name = 'Priority1')
           Alter Table  POT2013 Add Priority1 NVARCHAR(250) NULL
		   
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2013'  and col.name = 'Priority2')
           Alter Table  POT2013 Add Priority2 NVARCHAR(250) NULL
		   
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2013'  and col.name = 'Priority3')
           Alter Table  POT2013 Add Priority3 NVARCHAR(250) NULL
End 