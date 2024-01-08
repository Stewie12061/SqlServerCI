---- Create by Hồng Thảo on 6/1/2020
---- Lưu thông tin theo dõi biểu phí của bé trong năm 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2013]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2013]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [SchoolYearID] VARCHAR(50)  NULL,
  [StudentID] VARCHAR(50)  NULL,
  [FeeID]    VARCHAR(50)  NULL,                 ---Biểu phí
  [FromDate] DATETIME NULL,		                ---Ngày bắt đầu năm học 			
  [ToDate] DATETIME NULL,					    ---Ngày kết thúc năm học 
  [InheritTable] VARCHAR(50),                   --- Lưu tên bảng kế thừa (PTTTV, thay đổi biểu phí, thiết lập đóng đầu năm) 
  [InheritAPK] VARCHAR(50),                     --- Lưu vết kế thừa APK 
  [DeleteFlg] TINYINT DEFAULT (0) NULL,          
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT2013] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


 





