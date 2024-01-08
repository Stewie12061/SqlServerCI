---- Create by Nguyễn Văn Tài on 4/5/2023 9:31:22 AM
---- Bảng thiết lập quy định chênh lệch dữ liệu chấm công cho phép theo ca.

DROP TABLE IF EXISTS HT2418

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT2418]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT2418]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [ShiftID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(250) NULL,
  [DifferenceMinutesIn] DECIMAL(28,8) NULL,
  [DifferenceMinutesOut] DECIMAL(28,8) NULL,
  [RangeMinutesFinish] DECIMAL(28,8) NULL,
  [IsDisabled] TINYINT DEFAULT (0) NULL
CONSTRAINT [PK_HT2418] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

DELETE FROM HT2418

Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA1',
	N'Ca làm việc giờ hành chính không tăng ca',
	30,
	30,
	660,
	0
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA2',
	N'Ca 8:00 - 17:00',
	30,
	30,
	660,
	0
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA3',
	N'Ca 7:00 - 17:00 có tăng ca',
	30,
	30,
	660,
	0
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA4',
	N'Bộ phận bảo vệ 06:00-14:00',
	30,
	30,
	660,
	1
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA5',
	N'Bộ phận bảo vệ 14:00 - 22:00',
	30,
	30,
	660,
	1
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA6',
	N'Bộ phận bảo vệ 22:00-06:00',
	30,
	30,
	660,
	1
)
Insert INTO HT2418
VALUES(
	NEWID(),
	N'HIP',
	N'CA7',
	N'Ca làm việc giờ hành chính có tăng ca',
	30,
	30,
	660,
	0
)