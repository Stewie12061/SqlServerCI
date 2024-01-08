---- Create by Cao Thị Phượng on 10/10/2017 2:50:00 PM
---- Phòng ban và các dự án liên quan

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2101]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2101]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [RelatedToID] VARCHAR(50) NOT NULL,
  [DepartmentID] VARCHAR(50) NOT NULL,
  [RelatedToTypeID] INT NOT NULL
CONSTRAINT [PK_OOT2101] PRIMARY KEY CLUSTERED
(
  [RelatedToID],
  [DepartmentID],
  [RelatedToTypeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 01/10/2019 - Vĩnh Tâm: Bổ sung cột APKMaster --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OOT2101' AND col.name = 'APKMaster')
BEGIN
	ALTER TABLE OOT2101 ADD APKMaster UNIQUEIDENTIFIER NULL
END