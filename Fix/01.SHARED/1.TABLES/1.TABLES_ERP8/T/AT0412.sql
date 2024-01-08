---- Create by Kiều Nga on 28/04/2021 
---- Khai báo phân bổ chi phí khác

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0412]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0412]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [Type] VARCHAR(50) NOT NULL,  -- Loại
  [ApportionID] VARCHAR(50) NOT NULL, -- Mã số
  [ApportionName] NVARCHAR(MAX) NULL, -- Tên gọi
  [EmployeeID] VARCHAR(50) NULL, -- Nhân viên
  [DepartmentID] VARCHAR(50) NULL, -- Phòng ban
  [ApportionDate] DATETIME NULL, -- Ngày
  [BeginMonth] INT NULL, 
  [BeginYear] INT NULL,
  [ConvertedAmount] DECIMAL (28, 8) NULL, -- Số tiền
  [DepValue] DECIMAL (28, 8) NULL, -- Số tiền đã trả
  [ResidualValue] DECIMAL (28, 8) NULL, -- Số tiền còn lại
  [Periods] INT NULL, -- Số kỳ phân bổ
  [DepMonths] INT NULL, -- Số kỳ đã phân bổ
  [ResidualMonths] INT NULL, -- Số kỳ còn lại
  [Description] NVARCHAR(MAX) NULL, -- Diễn giải
  [Amount] DECIMAL (28, 8) NULL, -- Số tiền thực đóng/tháng , số tiền nộp/tháng
  [IsRegistration] TINYINT NULL, -- Đăng ký
  [AmountAllocation] DECIMAL (28, 8) NULL, -- Số tiền phân bổ/tháng
  [AmountPay] DECIMAL (28, 8) NULL, -- Số tiền xin trả hàng tháng
  [LendingRate] DECIMAL (28, 8) NULL, -- Lãi suất vay
  [InterestPay] DECIMAL (28, 8) NULL, -- Lãi trả hàng tháng
  [StatusApportion] TINYINT NULL DEFAULT(1), -- Trạng thái phân bổ
  [BeginPeriod]  VARCHAR(50) NULL, -- Kỳ bắt đầu phân bổ
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_AT0412] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
