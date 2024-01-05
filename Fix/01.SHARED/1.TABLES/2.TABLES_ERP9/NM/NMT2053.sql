---- Create by Tra Giang on 16/08/2018 
---- Nghiệp Vụ: Tiếp phẩm 3 bước ( detail: Bước 1B )
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2053]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT2053]
(
		 [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
		 [APKMaster] UNIQUEIDENTIFIER NOT NULL,
		 [DivisionID] VARCHAR(50) NOT NULL,

		 [VoucherDate] DATETIME NOT NULL,
		 [MaterialsID] VARCHAR(50) NULL,
		 [ActualQuantity] DECIMAL(28,8) NULL,
		 [SupplierID] VARCHAR(50) NULL,	
		 [Address] NVARCHAR(250) NULL,
		 [BrandName] NVARCHAR(50) NULL,			
		 [PackagingType] NVARCHAR(50) NULL,		
		 [ExpiryDate] DATETIME NULL,
		 [VoucherNo] VARCHAR(50) NOT NULL,
		 [StorageConditions] NVARCHAR(250) NULL,
		 [Notes] NVARCHAR(250) NULL,	
		  
		 [InheritAPK] UNIQUEIDENTIFIER NULL,
		 [InheritAPKMaster] UNIQUEIDENTIFIER NULL,
		 [InheritTableID] VARCHAR(50) NULL,  
		 [TranMonth] INT NOT NULL,
         [TranYear] INT NOT NULL,
		 [DeleteFlg] TINYINT NOT NULL Default 0,
		 [CreateUserID] VARCHAR(50) NULL,
         [CreateDate] DATETIME NULL,
		 [LastModifyUserID] VARCHAR(50) NULL,
		 [LastModifyDate] DATETIME NULL

CONSTRAINT [PK_NMT2053] PRIMARY KEY CLUSTERED
(
  [APK] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END





  