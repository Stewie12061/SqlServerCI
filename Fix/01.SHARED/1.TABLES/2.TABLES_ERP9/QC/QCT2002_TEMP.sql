---- Create by Le Hoang on 30/03/2021
---- Chi tiết Thông số, ngoại quan đạt được của Thành phẩm, Nguyên vật liệu - Bảng lưu thông số tiêu chuẩn tạm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2002_TEMP]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2002_TEMP](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[StandardID] [varchar](50) NOT NULL,
	[StandardValue] [nvarchar](250) NULL,
	[TableID] [varchar](50) NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2002_TEMP] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

---- [Le Hoang] Bổ sung trường thứ tự [20/01/2021]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2002_TEMP' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Orders')
   ALTER TABLE QCT2002_TEMP ADD Orders INT NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Lý do
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'ReasonID')
   ALTER TABLE QCT2002_TEMP ADD ReasonID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Cách kiểm tra
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Method')
   ALTER TABLE QCT2002_TEMP ADD Method NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Nội dung kiểm tra
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Content')
   ALTER TABLE QCT2002_TEMP ADD Content NVARCHAR(MAX) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Tiêu chuẩn
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Standard')
   ALTER TABLE QCT2002_TEMP ADD Standard NVARCHAR(MAX) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Kết quả kiểm tra
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Result')
   ALTER TABLE QCT2002_TEMP ADD Result NVARCHAR(MAX) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Đánh giá
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'StatusID')
   ALTER TABLE QCT2002_TEMP ADD StatusID INT NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Ghi chú
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'Notes')
   ALTER TABLE QCT2002_TEMP ADD Notes NVARCHAR(MAX) NULL

      -- [Thanh Lượng] Bổ sung cột Số thứ tự bản vẽ
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'OrderDrawing')
   ALTER TABLE QCT2002_TEMP ADD OrderDrawing NVARCHAR(MAX) NULL
     -- [Thanh Lượng] Bổ sung cột Dụng cụ đo
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'SRange06')
   ALTER TABLE QCT2002_TEMP ADD SRange06 NVARCHAR(MAX) NULL
    -- [Thanh Lượng] Bổ sung cột Loại
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'SRange07')
   ALTER TABLE QCT2002_TEMP ADD SRange07 NVARCHAR(MAX) NULL

    -- [Viết Toàn] Bổ sung cột Tần suất đo
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'SRange09')
   ALTER TABLE QCT2002_TEMP ADD SRange09 NVARCHAR(MAX) NULL

   -- [Mai Thư] Bổ sung cột Giá trị kiểm tra
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name = 'QCT2002_TEMP'  and col.name = 'CheckValue')
	ALTER TABLE QCT2002_TEMP ADD CheckValue NVARCHAR(500) NULL

	   -- [Thanh Lượng] Bổ sung cột Giá trị kiểm tra lần 2
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name = 'QCT2002_TEMP'  and col.name = 'CheckValue02')
	ALTER TABLE QCT2002_TEMP ADD CheckValue02 NVARCHAR(500) NULL

	   -- [Thanh Lượng] Bổ sung cột Giá trị kiểm tra lần 3
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name = 'QCT2002_TEMP'  and col.name = 'CheckValue03')
	ALTER TABLE QCT2002_TEMP ADD CheckValue03 NVARCHAR(500) NULL

	   -- [Thanh Lượng] Bổ sung cột Giá trị kiểm tra lần 4
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name = 'QCT2002_TEMP'  and col.name = 'CheckValue04')
	ALTER TABLE QCT2002_TEMP ADD CheckValue04 NVARCHAR(500) NULL

	   -- [Thanh Lượng] Bổ sung cột Giá trị kiểm tra lần 5
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name = 'QCT2002_TEMP'  and col.name = 'CheckValue05')
	ALTER TABLE QCT2002_TEMP ADD CheckValue05 NVARCHAR(500) NULL

	-- [Mai Thư] Bổ sung cột Nội dung kiểm tra
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab--Ghi chú
	ON col.id = tab.id WHERE tab.name = 'QCT2002_TEMP' AND col.name = 'ContentCheck')
	ALTER TABLE QCT2002_TEMP ADD ContentCheck NVARCHAR(MAX) NULL
END


