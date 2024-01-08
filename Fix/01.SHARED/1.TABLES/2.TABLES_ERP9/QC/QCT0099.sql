---- Create by Le Hoang on 01/10/2020
---- Bảng dữ liệu ngầm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT0099]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT0099](
	[CodeMaster] [varchar](50) NOT NULL,
	[OrderNo] [varchar](50) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[DescriptionE] [nvarchar](250) NULL,
	[Disabled] [tinyint] DEFAULT 0 NOT NULL,
	[LanguageID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT0099] PRIMARY KEY CLUSTERED 
(
	[CodeMaster] ASC,
	[OrderNo] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--INSERT VNP.dbo.QCT0099(CodeMaster, OrderNo, ID, Description, DescriptionE, Disabled) VALUES
--('QCFVoucherType', 0, '0', N'Phiếu nhập thông số kỹ thuật', N'Phiếu nhập thông số kỹ thuật', 0),
--('QCFVoucherType', 1, '1', N'Phiếu nhập thông số vận hành máy', N'Phiếu nhập thông số vận hành máy', 0),
--('QCFVoucherType', 2, '2', N'Phiếu nhập nguyên vật liệu', N'Phiếu nhập nguyên vật liệu', 0),
--('QCFVoucherType', 3, '3', N'Phiếu ghi nhận số lượng thành phẩm', N'Phiếu ghi nhận số lượng thành phẩm', 0)

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'QCT0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE QCT0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END