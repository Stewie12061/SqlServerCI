---- Create by Cao Thị Phượng on 12/8/2017 7:08:30 PM
---- Phiêu đề nghị chi (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST2020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST2020]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [ShopID] VARCHAR(50) NOT NULL,
  [ObjectID] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NULL,
  [VoucherDate] DATETIME NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [Description] NVARCHAR(250) NULL,
  [MemberID] VARCHAR(50) NOT NULL,
  [SuggestType] TINYINT DEFAULT (0) NULL, --0: Phiếu đề nghị chi đặt cọc; 1: Phiếu đề nghị chi trả hàng; 2:Phiếu đề nghị chi đổi hàng
  [IsConfirm] TINYINT DEFAULT (0) NULL,   --0: Chưa duyệt phiếu; 1: Duyệt phiếu
  [ConfirmUserID] VARCHAR(50) NULL,
  [ConfirmDate] DATETIME NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [RelatedToTypeID] INT DEFAULT (49) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_POST2020] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END