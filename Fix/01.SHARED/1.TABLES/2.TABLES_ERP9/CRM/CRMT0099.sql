
---- Create by Cao Thị Phượng on 2/10/2017 1:21:57 PM
---- Modify by Lê Hoàng on 24/11/2020 4:33:00 PM : cập nhật cho phép NULL trường DescriptionE
---- Dữ liệu code master

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT0099]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT0099]
(
  [CodeMaster] VARCHAR(50) NOT NULL,
  [OrderNo] INT NOT NULL,
  [ID] VARCHAR(50) NOT NULL,
  [Description] NVARCHAR(250) NOT NULL,
  [DescriptionE] NVARCHAR(250) NOT NULL,
  [Disabled] TINYINT DEFAULT (0) NOT NULL
CONSTRAINT [PK_CRMT0099] PRIMARY KEY CLUSTERED
(
  [CodeMaster],
  [ID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--Thị Phượng bổ sung để lấy ngôn ngữ lịch sử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT0099' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT0099' AND col.name = 'LanguageID') 
   ALTER TABLE CRMT0099 ADD LanguageID VARCHAR(50) NULL 
END
--Lê Hoàng cập nhật cho phép NULL trường DescriptionE
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT0099' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT0099' AND col.name = 'DescriptionE') 
   ALTER TABLE CRMT0099 ALTER COLUMN DescriptionE NVARCHAR(250) NULL
END
-- Tấn Đạt: Bổ sung dữ liệu Phân loại yêu cầu, phân loại bug
DECLARE @CodeMaster VARCHAR(50), @OrderNo INT, @ID VARCHAR(50), @Description NVARCHAR(250), @DescriptionE NVARCHAR(250), @Disabled TINYINT, @LanguageID VARCHAR(50) = NULL
----------Phân loại Yêu cầu
SET @CodeMaster = 'CRMT00000025' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Hỗ trợ' 
SET @DescriptionE = N'Support' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Lỗi/Vấn đề' 
SET @DescriptionE = N'Bug/Issue' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Phàn nàn' 
SET @DescriptionE = N'Complain' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Chức năng mới' 
SET @DescriptionE = N'New function' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Báo giá' 
SET @DescriptionE = N'Quotation' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 3  
SET @ID = '6' 
SET @Description = N'Đối tác' 
SET @DescriptionE = N'Partner' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 4  
SET @ID = '7' 
SET @Description = N'Nhu cầu SME' 
SET @DescriptionE = N'Demand SME' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 5  
SET @ID = '8' 
SET @Description = N'Nhu cầu ERP' 
SET @DescriptionE = N'Demand ERP' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------Phân loại Bug
SET @CodeMaster = 'CRMT00000026' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Dùng chung' 
SET @DescriptionE = N'Is common' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Vấn đề lặp lại' 
SET @DescriptionE = N'Repeat Problem' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Dừng chương trình' 
SET @DescriptionE = N'Stop program' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'CRMT0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE CRMT0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END