---- Create by Như Hàn on 03/04/2019 
---- Thông tin chi tiết dữ liệu duyệt (số tiền, ghi chú,...) sử dụng cho trường hợp duyệt nhiều detail

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT9004]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT9004]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	  [APKDetail] UNIQUEIDENTIFIER NOT NULL,
	  [APK9001] UNIQUEIDENTIFIER NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ApprovePersonID] VARCHAR(50) NOT NULL,
      [Level] INT NOT NULL,
      [Note] NVARCHAR(250) NULL,
	  [ApprovalOAmount] DECIMAL (28,8) NULL,
	  [ApprovalCAmount] DECIMAL (28,8) NULL,
	  [ApprovalDate] DATETIME NULL,
	  [Status] INT NOT NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT9004] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
