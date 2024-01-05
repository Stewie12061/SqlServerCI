---- Create by Thái Đình Ly on 10/24/2019 10:54:11 AM
---- Chi tiết thiết lập dữu liệu mặc định màn hình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT0011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CMNT0011](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[DivisionID] [varchar](25) NULL,
	[Value] [varchar](250) NULL,
	[ColumnID] [varchar](250) NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_ST0081] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



