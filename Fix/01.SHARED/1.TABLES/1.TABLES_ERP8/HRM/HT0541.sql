---- Create by Phạm Lê Hoàng on 11/03/2021 
---- Hệ số tính lương theo công đoạn (MAITHU)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0541]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT0541]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [PhaseID] VARCHAR(50) NOT NULL,
  [EmployeeID] VARCHAR(50) NOT NULL,
  [InventoryID] VARCHAR(50) NULL,
  [Coefficient] DECIMAL(28,8) NOT NULL,
  [Notes] NVARCHAR(MAX) NULL,
  [EffectiveDate] DATETIME NULL,--sử dụng cho nếu có ngày hiệu lực từ ngày
  [IsUsed] TINYINT NULL DEFAULT 0,--sử dụng kiểm tra còn hiệu lực hay không nếu bộ [DivisionID, PhaseID, EmployeeID, InventoryID] trùng nhau
  [Disabled] TINYINT NOT NULL DEFAULT 0,
  [IsCommon] TINYINT NOT NULL DEFAULT 0,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
CONSTRAINT [PK_HT0541] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
