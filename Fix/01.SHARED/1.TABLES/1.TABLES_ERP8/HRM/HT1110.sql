---- Create by Nguyễn Hoàng Bảo Thy on 9/14/2017 4:27:08 PM
---- Kế hoạch sản xuất theo máy (master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1110]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1110]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [MachineID] VARCHAR(50) NOT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastmodifyDate] DATETIME NULL,
  [LastmodifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_HT1110] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
If Exists (Select * From sysobjects Where name = 'HT1110' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1110'  and col.name = 'ShiftID')
           Alter Table HT1110 ADD  [ShiftID] VARCHAR(50) NULL
End
