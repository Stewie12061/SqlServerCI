---- Create by Văn Tài	on 06/05/2022

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90201]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,	--- APK CRMT9020
  [Steps]	TINYINT NULL,				--- Bước gửi duyệt.
  [Orders]	TINYINT NULL,				--- Bước / Thứ tự.
  [RelatedToID] VARCHAR(50) NULL,		--- Mã văn bản liên quan.
  [EmployeeID] DATETIME NULL,			--- Mã người ký/duyệt.
  [DepartmentID] VARCHAR(50) NULL,		--- Mã phòng ban (lịch sử xử lý văn bản của người đó đang ở phòng ban nào).
  [Email] VARCHAR(50) NULL,				
  [UseESign] TINYINT NULL,				--- Sử dụng chữ ký số.
  [SignedStatus] TINYINT NULL,			--- Trạng thái ký số.
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate]	DATETIME NULL
CONSTRAINT [PK_CRMT90201] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 29/12/2020 - Tấn Lộc: Bổ sung cột --------------------
--IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
--	   ON col.id = tab.id WHERE tab.name = 'CRMT90201' AND col.name = 'UnitID')
--BEGIN
--	ALTER TABLE CRMT2104 ADD UnitID NVARCHAR(250) NULL
--END