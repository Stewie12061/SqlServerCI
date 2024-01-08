---- Create by Tra Giang on 16/08/2018 
---- Nghiệp Vụ: Tiếp phẩm 3 bước ( detail: Bước 2 )
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[NMT2054]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[NMT2054]
(
		 [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
		 [APKMaster] UNIQUEIDENTIFIER NOT NULL,
		 [DivisionID] VARCHAR(50) NOT NULL,		

		 [MealID] VARCHAR(50) NULL,		
		 [DishID] VARCHAR(50) NULL,
		 [MaterialsID] VARCHAR(50) NULL,
		 [Mass] DECIMAL(28,8) NULL,
		 [ProcessingTime] DATETIME NULL,
		 [CookingTime] DATETIME NULL,
		 [DeliveryTime] DATETIME NULL,	
		 [BeginEatTime] DATETIME NULL,
		 [Feel] TINYINT NULL,
		 [StorageConditions] NVARCHAR(50) NULL,		
		   
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
CONSTRAINT [PK_NMT2054] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

 




  