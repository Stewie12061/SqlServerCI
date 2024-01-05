---- Create by Cao Thị Phượng on 9/11/2017 3:10:35 PM
---- Dữ liệu Master cấp duyệt của loại phiếu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1201]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [Level] INT NOT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CIT1201] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Add Column DutyID(Chức vụ duyệt)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT1201' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CIT1201' AND col.name = 'DutyID') 
   ALTER TABLE CIT1201 ADD DutyID NVARCHAR(50) NULL 
END

/*===============================================END DutyID===============================================*/ 