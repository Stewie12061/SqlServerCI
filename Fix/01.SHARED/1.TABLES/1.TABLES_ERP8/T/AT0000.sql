-- <Summary>
---- Thiết lập hệ thống ASOFT-T
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 24/06/2014 by Lê Thị Hạnh: Thêm mới trường IsCreditLimit cho nghiệp vụ cảnh báo công nợ
---- Modify by Lê Thị Hạnh on 06/10/2014: Bổ sung trường: Tờ khai thuế bảo vệ môi trường
---- Modify by Lê Thị Hạnh on 19/03/2015: Bổ sung IsInsertPayable: Tự động tạo phiếu thu, chi khi duyệt phiếu tạm thu chi
---- Modified on 25/05/2015 by Lê Thị Hạnh: Thiết lập thuế tài nguyên và tiêu thụ đặc biệt
---- Modified on 25/10/2012 by Huỳnh Tấn Phú: Không cho sửa giá khi kế thừa hoá đơn bán hàng
---- Modified on 30/03/2015 by Mai Trí Thiện: Bổ sung phân quyền màn hình vào thiết lập thông tin mail server
---- Modified on 28/02/2014 by Lê Thị Thu Hiền: Bổ sung phân quyền xem dữ liệu IsPermissionView
---- Modified on 28/01/2013 by Lê Thị Thu Hiền: Bổ sung tự động cập nhật giá IsUpDatePrice
---- Modified on 12/10/2013 by Bảo Anh: Chuyển OF0121, OF0122 sang CI
---- Modified on 12/10/2013 by Quốc Tuấn: Add column IsEliminateDebt, chuyển column IsCreditLimit sang 01_AT0000_Addcolumns
---- Modified on 29/08/2012 by Huỳnh Tấn Phú:[IPL] Tự động nhảy số hoá đơn trong phiếu bán hàng,kế toán sẽ không biết phiếu nào đã xuất hoá đơn và phiếu nào chưa , yêu cầu Asoft bỏ tự động đó để bên I.P.L tự đánh số hoá đơn vào
---- Modified on 17/02/2012 by Nguyễn Bình Minh: Bổ sung IsConvertUnit,ContractAnaTypeID,ExpCurExchDiffAccType,InterestExpCurExchDiffAccID,LostExpCurExchDiffAccID,SalesContractAnaTypeID
---- Modified on 23/10/2015 by Tiểu Mai: Bổ sung thêm trường Quản lý quy cách hàng hóa.
---- Modified on 09/11/2015 by Phương Thảo: Bổ sung thiết lập sử dụng thuế nhà thầu (IsWithhodingTax)
---- Modified on 09/12/2015 by Phương Thảo: Bổ sung thiết lập loại mã phân tích phòng ban (DepartmentAnaTypeID)
---- Modified on 23/03/2016 by Tiểu Mai: Bổ sung thiết lập loại mã phân tích tổ nhóm (TeamAnaTypeID)
---- Modified on 31/05/2016 by Bảo Anh: Bổ sung check Mặc định ngày giải trừ theo ngày hạch toán (IsDefaultGiveUpDate)
---- Modified on 09/09/2016 by Phương Thảo: Bổ sung thiết lập: "Không cho phép bỏ giải trừ dữ liệu đã giải trừ trong kỳ khóa sổ" (NotAllowRemoveMatching)
---- Modified on 07/09/2018 by Hồng Thảo; Bổ sung mã phân tích trường (Customize= 91 Blue Sky)
---- Modified on 10/10/2018 by Kim Thư: Bổ sung EInvoicePartner Đối tác hóa đơn điện tử
---- Modified on 15/10/2018 by Kim Thư: Bổ sung IsAutoDownloadEInvoice và EInvoiceFilePath
---- Modified on 19/10/2018 by Kim Thư: Bổ sung PartnerGUID và PartnerToken
---- Modified on 13/03/2019 by Kim Thư: Bổ sung IsSOInheritExVoucher - Check box bắt buộc hóa đơn bán hàng kế thừa phiếu xuất kho
---- Modified on 19/03/2019 by Kim Thư: Bổ sung IsApplyManyBranch - Check phát hành hóa đơn cho chi nhánh chính hay chi nhánh khác ( 32-Phúc Long, 44-Savi)
----											StrConnection3 - Link hủy hóa đơn điện tử
---- Modify on 04/06/2019 by Như Hàn: Bổ sung Mã phân tích ngân sách
---- Modify on 03/07/2019 by Bảo Toàn: Bổ sung Mã phân tích cơ hội
---- Modify on 04/07/2019 by Như Hàn: Bổ sung Mã phân tích tài sản
---- Modify on 13/07/2020 by Văn Tài: Bổ sung các cột Loại chứng từ sinh tự động.


-- <Example>
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0000](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DefDivisionID] [nvarchar](3) NOT NULL,
	[DefTranMonth] [int] NULL,
	[DefTranYear] [int] NULL,
	[DefLoginDate] [datetime] NULL,
	[ScheduleDays] [int] NULL,
	[StartHour] [int] NULL,
	[StartMinute] [int] NULL,
	[EndHour] [int] NULL,
	[EndMinute] [int] NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[CashAccountID] [nvarchar](50) NULL,
	[ReceivedAccountID] [nvarchar](50) NULL,
	[PayableAccountID] [nvarchar](50) NULL,
	[TurnOverAccountID] [nvarchar](50) NULL,
	[PrimeCostAccountID] [nvarchar](50) NULL,
	[VATInAccountID] [nvarchar](50) NULL,
	[VATOutAccountID] [nvarchar](50) NULL,
	[DifferenceAccountID] [nvarchar](50) NULL,
	[LossExchangeAccID] [nvarchar](50) NOT NULL,
	[InterestExchangeAccID] [nvarchar](50) NOT NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[IsNegativeStock] [tinyint] NOT NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[IsDiscount] [tinyint] NOT NULL,
	[IsAsoftM] [tinyint] NOT NULL,
	[IsAsoftHRM] [tinyint] NOT NULL,
	[IsAsoftOP] [tinyint] NOT NULL,
	[PreCostAccountID] [nvarchar](50) NULL,
	[IsCommission] [tinyint] NULL,
	[CommissionAccountID] [nvarchar](50) NULL,
	[IsNegativeCash] [tinyint] NULL,
	[IsLockSalePrice] [tinyint] NULL,
	[IsAutoSourceNo] [tinyint] NOT NULL,
	[IsTestSalePrice] [tinyint] NULL,
	[IsConsecutiveExchange] [tinyint] NOT NULL,
	[IsNotDebit] [tinyint] NULL,
	[ImportExcel] [tinyint] NULL,
	[IsBarcode] [tinyint] NULL,
	[IsPrintedInvoice] [tinyint] NULL,
	[Image01ID] [image] NULL,
	[Image02ID] [image] NULL,
	CONSTRAINT [PK_AT0000] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON

)) ON [PRIMARY]
END
---- Add giá trị default
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_StartHour]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_StartHour]  DEFAULT ((8)) FOR [StartHour]
END
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_StartMinute]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_StartMinute]  DEFAULT ((0)) FOR [StartMinute]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_EndHour]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_EndHour]  DEFAULT ((17)) FOR [EndHour]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_EndMinute]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_EndMinute]  DEFAULT ((0)) FOR [EndMinute]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_LossExchangeAccID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_LossExchangeAccID]  DEFAULT ((635)) FOR [LossExchangeAccID]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_InterestExchangeAccID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_InterestExchangeAccID]  DEFAULT ((515)) FOR [InterestExchangeAccID]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_IsNegativeStock]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_IsNegativeStock]  DEFAULT ((0)) FOR [IsNegativeStock]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0000__IsDiscou__697D6489]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF__AT0000__IsDiscou__697D6489]  DEFAULT ((0)) FOR [IsDiscount]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0000__IsAsoftM__3668A02E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF__AT0000__IsAsoftM__3668A02E]  DEFAULT ((0)) FOR [IsAsoftM]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0000__IsAsoftH__375CC467]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF__AT0000__IsAsoftH__375CC467]  DEFAULT ((0)) FOR [IsAsoftHRM]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0000__IsAsoftO__3850E8A0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF__AT0000__IsAsoftO__3850E8A0]  DEFAULT ((0)) FOR [IsAsoftOP]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__AT0000__IsAutoSo__092A807F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF__AT0000__IsAutoSo__092A807F]  DEFAULT ((0)) FOR [IsAutoSourceNo]
END
IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0000_IsConsecutiveExchange]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0000] ADD  CONSTRAINT [DF_AT0000_IsConsecutiveExchange]  DEFAULT ((0)) FOR [IsConsecutiveExchange]
END
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsCreditLimit')
		ALTER TABLE AT0000 ADD IsCreditLimit TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='ITypeID')
		ALTER TABLE AT0000 ADD ITypeID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsEnvironmentTax')
		ALTER TABLE AT0000 ADD IsEnvironmentTax TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='ETaxDebitAccountID')
		ALTER TABLE AT0000 ADD ETaxDebitAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='ETaxCreditAccountID')
		ALTER TABLE AT0000 ADD ETaxCreditAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsInsertPayable')
		ALTER TABLE AT0000 ADD IsInsertPayable TINYINT DEFAULT 1 NOT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsNRT')
		ALTER TABLE AT0000 ADD IsNRT TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsSET')
		ALTER TABLE AT0000 ADD IsSET TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='NRTDebitAccountID')
		ALTER TABLE AT0000 ADD NRTDebitAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='NRTCreditAccountID')
		ALTER TABLE AT0000 ADD NRTCreditAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='InSETDebitAccountID')
		ALTER TABLE AT0000 ADD InSETDebitAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='InSETCreditAccountID')
		ALTER TABLE AT0000 ADD InSETCreditAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='OSETDebitAccountID')
		ALTER TABLE AT0000 ADD OSETDebitAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='OSETCreditAccountID')
		ALTER TABLE AT0000 ADD OSETCreditAccountID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsNoEditPrice')
		ALTER TABLE AT0000 ADD IsNoEditPrice TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='MailSetting')
		ALTER TABLE AT0000 ADD MailSetting NVARCHAR(2000) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsPermissionView')
		ALTER TABLE AT0000 ADD IsPermissionView TINYINT Default(0) NOT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsUpDatePrice')
		ALTER TABLE AT0000 ADD IsUpDatePrice TINYINT NULL
	END
If Exists (Select * From sysobjects Where name = 'AT0000' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT0000'  and col.name = 'CheckSerialInvoiceNo')
    Alter Table  AT0000 Add CheckSerialInvoiceNo tinyint Null Default(0)
           
    ---------------- Bổ sung cho Sinolife
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'AT0000'  and col.name = 'LevelCounts')
    Alter Table  AT0000 Add LevelCounts int Null Default(3)
    -------------------------------------------------------------------------
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsCreditLimit')
	ALTER TABLE AT0000 ADD IsCreditLimit TINYINT NULL
	-------------------------------------------------------------------------
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsEliminateDebt')
	ALTER TABLE AT0000 ADD IsEliminateDebt TINYINT NULL
End
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsAutoSerialInvoiceNo')
		ALTER TABLE AT0000 ADD IsAutoSerialInvoiceNo TINYINT DEFAULT(1) NULL
	END
IF(ISNULL(COL_LENGTH('AT0000', 'IsConvertUnit'), 0) <= 0)
BEGIN
	ALTER TABLE AT0000 ADD IsConvertUnit TINYINT
	EXEC('UPDATE AT0000 SET IsConvertUnit = 0 WHERE IsConvertUnit IS NULL')
END
IF(ISNULL(COL_LENGTH('AT0000', 'ContractAnaTypeID'), 0) <= 0)
BEGIN
	ALTER TABLE AT0000 ADD ContractAnaTypeID NVARCHAR(50) NULL DEFAULT('A03')
	EXEC ('
		UPDATE AT0000
		SET ContractAnaTypeID = ''A01''
		WHERE ContractAnaTypeID IS NULL
		')
END
IF(ISNULL(COL_LENGTH('AT0000', 'ExpCurExchDiffAccType'), 0) <= 0)
	ALTER TABLE AT0000 ADD ExpCurExchDiffAccType TINYINT NOT NULL DEFAULT(0)
IF(ISNULL(COL_LENGTH('AT0000', 'InterestExpCurExchDiffAccID'), 0) <= 0)
	ALTER TABLE AT0000 ADD InterestExpCurExchDiffAccID NVARCHAR(50) NOT NULL DEFAULT('')
IF(ISNULL(COL_LENGTH('AT0000', 'LostExpCurExchDiffAccID'), 0) <= 0)
	ALTER TABLE AT0000 ADD LostExpCurExchDiffAccID NVARCHAR(50) NOT NULL DEFAULT('')


--- Thiet lap thue nha thau
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsWithhodingTax')
        ALTER TABLE AT0000 ADD IsWithhodingTax TINYINT NULL
    END

--- Mã phân tích phòng ban
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'DepartmentAnaTypeID')
        ALTER TABLE AT0000 ADD DepartmentAnaTypeID NVARCHAR(50) NULL
    END




--------------------------- UPDATE ------------------------------------------------------
IF(ISNULL(COL_LENGTH('AT0000', 'SalesContractAnaTypeID'), 0) <= 0)
BEGIN
	ALTER TABLE AT0000 ADD SalesContractAnaTypeID NVARCHAR(50) NULL DEFAULT('A03')
	EXEC ('
		UPDATE AT0000
		SET SalesContractAnaTypeID = ContractAnaTypeID
		WHERE SalesContractAnaTypeID IS NULL
		')
END


---- Add columns by Tieu Mai on 23/10/2015	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsSpecificate')
		ALTER TABLE AT0000 ADD IsSpecificate TINYINT DEFAULT(0) NOT NULL
	END	
	
--- Mã phân tích tổ nhóm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'TeamAnaTypeID')
        ALTER TABLE AT0000 ADD TeamAnaTypeID NVARCHAR(50) NULL
    END

--- Modify on 31/05/2016 by Bảo Anh: Bổ sung check Mặc định ngày giải trừ theo ngày hạch toán
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsDefaultGiveUpDate')
        ALTER TABLE AT0000 ADD IsDefaultGiveUpDate TINYINT DEFAULT(1) NULL
    END

---- Modified on 09/09/2016 by Phương Thảo: Bổ sung thiết lập: "Không cho phép bỏ giải trừ dữ liệu đã giải trừ trong kỳ khóa sổ" (NotAllowRemoveMatching)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'NotAllowRemoveMatching')
        ALTER TABLE AT0000 ADD NotAllowRemoveMatching TINYINT NULL
    END
    
--- Modify on 21/06/2017 by Bảo Anh: Bổ sung Mã phân tích dự án, doanh thu, chi phí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'ProjectAnaTypeID')
        ALTER TABLE AT0000 ADD ProjectAnaTypeID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SalesAnaTypeID')
        ALTER TABLE AT0000 ADD SalesAnaTypeID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'CostAnaTypeID')
        ALTER TABLE AT0000 ADD CostAnaTypeID VARCHAR(50) NULL
    END
        
---- Modified on 16/08/2017 by Hải Long: Bổ sung các trường của hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsEInvoice')
        ALTER TABLE AT0000 ADD IsEInvoice TINYINT DEFAULT(0) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'UserName')
        ALTER TABLE AT0000 ADD UserName NVARCHAR(250) NULL 
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'Password')
        ALTER TABLE AT0000 ADD Password NVARCHAR(100) NULL 
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'StrConnection1')
        ALTER TABLE AT0000 ADD StrConnection1 NVARCHAR(2000) NULL       
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'StrConnection2')
        ALTER TABLE AT0000 ADD StrConnection2 NVARCHAR(2000) NULL       
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'Account')
        ALTER TABLE AT0000 ADD Account NVARCHAR(250) NULL 
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'ACPass')
        ALTER TABLE AT0000 ADD ACPass NVARCHAR(100) NULL                                 
    END
    
--- Modify on 14/09/2017 by Tiểu Mai: Bổ sung Mã phân tích lưu chuyển tiền tệ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'CaseFlowAnaTypeID')
        ALTER TABLE AT0000 ADD CaseFlowAnaTypeID NVARCHAR(50) NULL
    END

--- Modified by Bảo Thy on 02/01/2018: bổ sung thông tin token (hóa đơn điện tử)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsUseToken') 
   ALTER TABLE AT0000 ADD IsUseToken TINYINT DEFAULT(0) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SerialToken') 
   ALTER TABLE AT0000 ADD SerialToken NVARCHAR(250) NULL 
END

---- Modified on 24/04/2018 by Minh Tâm: Bổ sung check Quản lý mặt hàng theo số seri

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsAutoSeri')
		ALTER TABLE AT0000 ADD IsAutoSeri TINYINT NOT NULL DEFAULT(0)
	END


	--- Modify on 07/09/2018 by Hồng Thảo: Bổ sung Mã phân trường (Customize= 91 Blue Sky)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SchoolAnaTypeID')
        ALTER TABLE AT0000 
		DROP COLUMN SchoolAnaTypeID
    END

---- Modified on 10/10/2018 by Kim Thư: Bổ sung EInvoicePartner Đối tác hóa đơn điện tử

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='EInvoicePartner')
	ALTER TABLE AT0000 ADD EInvoicePartner VARCHAR(200) NULL 
END

---- Modified on 15/10/2018 by Kim Thư: Bổ sung IsAutoDownloadEInvoice và EInvoiceFilePath
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsAutoDownloadEInvoice')
	ALTER TABLE AT0000 ADD IsAutoDownloadEInvoice TINYINT NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='EInvoiceFilePath')
	ALTER TABLE AT0000 ADD EInvoiceFilePath VARCHAR(4000) NULL 
END

---- Modified on 19/10/2018 by Kim Thư: Bổ sung PartnerGUID và PartnerToken
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='PartnerGUID')
	ALTER TABLE AT0000 ADD PartnerGUID NVARCHAR(4000) NULL 

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='PartnerToken')
	ALTER TABLE AT0000 ADD PartnerToken NVARCHAR(4000) NULL 
END

----Modified by hồng Thảo on 31/10/2018: Bổ sung Mã phân tích ô vựa, Mã phân tích loại phí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'PortionAnaTypeID')
        ALTER TABLE AT0000 ADD PortionAnaTypeID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'ReceiptTypeID')
        ALTER TABLE AT0000 ADD ReceiptTypeID VARCHAR(50) NULL
    END

----Modified by Hồng Thảo on 17/01/2019: Bổ sung loại chứng từ hóa đơn bán hàng, loại chứng từ bút toán tổng hợp

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SaleVoucherTypeID')
        ALTER TABLE AT0000 ADD SaleVoucherTypeID VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'EntryVoucherTypeID')
        ALTER TABLE AT0000 ADD EntryVoucherTypeID VARCHAR(50) NULL
    END

---- Modified on 13/03/2019 by Kim Thư: Bổ sung IsSOInheritExVoucher - Check box bắt buộc hóa đơn bán hàng kế thừa phiếu xuất kho
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsSOInheritExVoucher')
	ALTER TABLE AT0000 ADD IsSOInheritExVoucher TINYINT DEFAULT(0)
END

---- Modified on 19/03/2019 by Kim Thư: Bổ sung IsApplyManyBranch - Check phát hành hóa đơn cho chi nhánh chính hay chi nhánh khác ( 32-Phúc Long)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='IsApplyManyBranch')
	ALTER TABLE AT0000 ADD IsApplyManyBranch TINYINT DEFAULT(0)
END

---- Modified on 19/03/2019 by Kim Thư: Bổ sung StrConnection3 - Link hủy hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT0000' AND col.name='StrConnection3')
	ALTER TABLE AT0000 ADD StrConnection3 VARCHAR(2000) NULL
END


--- Modify on 04/06/2019 by Như Hàn: Bổ sung Mã phân tích ngân sách
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'BudgetAnaTypeID')
        ALTER TABLE AT0000 ADD BudgetAnaTypeID VARCHAR(50) NULL
    END

--- Modify on 03/07/2019 by Bảo Toàn: Bổ sung Mã phân tích cơ hội
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'OpportunityAnaTypeID')
        ALTER TABLE AT0000 ADD OpportunityAnaTypeID VARCHAR(50) NULL
    END

--- Modify on 11/06/2019 by Như Hàn: Bổ sung Mã phân tích tài sản
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'AssetAnaTypeID')
        ALTER TABLE AT0000 ADD AssetAnaTypeID VARCHAR(50) NULL
    END
----Modified by Tuấn Anh on 23/07/2019: Bổ sung column thời hạn mật khẩu người dùng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'PasswordTerm')
        ALTER TABLE AT0000 ADD PasswordTerm INT NULL
    END

	----Modified by Văn Tài on 01/07/2020: Bổ sung column chứng từ sinh tự động
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherTempCollect')
        ALTER TABLE AT0000 ADD VoucherTempCollect VARCHAR(50) NULL

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherTempPayment')
        ALTER TABLE AT0000 ADD VoucherTempPayment VARCHAR(50) NULL
		
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherTempCollectBank')
        ALTER TABLE AT0000 ADD VoucherTempCollectBank VARCHAR(50) NULL
		
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherTempPaymentBank')
        ALTER TABLE AT0000 ADD VoucherTempPaymentBank VARCHAR(50) NULL
		
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherAccountingEntry')
        ALTER TABLE AT0000 ADD VoucherAccountingEntry VARCHAR(50) NULL
    END

	
-------------------- 24/11/2021 - Kiều Nga: Bổ sung cột InventoryGroupAnaTypeID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'InventoryGroupAnaTypeID')
BEGIN
	ALTER TABLE AT0000 ADD InventoryGroupAnaTypeID VARCHAR(25) NULL
END

--- Modify on 14/12/2021 by Nhật Thanh: Bổ sung trường IsConfirmPurchasePL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsConfirmPurchasePL')
        ALTER TABLE AT0000 ADD IsConfirmPurchasePL TINYINT NULL
    END   
    
--- Modify on 14/12/2021 by Nhật Thanh: Bổ sung trường IsConfirmPaymentRequest (Duyệt đề nghị thanh toán - tạm chi)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsConfirmPaymentRequest')
        ALTER TABLE AT0000 ADD IsConfirmPaymentRequest TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'AreaAnaTypeID')
        ALTER TABLE AT0000 ADD AreaAnaTypeID VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SaleAnaTypeID')
        ALTER TABLE AT0000 ADD SaleAnaTypeID VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'CustomerAnaTypeID')
        ALTER TABLE AT0000 ADD CustomerAnaTypeID VARCHAR(50) NULL
    END 

--- Modify on 14/04/2022 by Kiều Nga : Bổ sung mặc định chứng từ hợp đồng thuê đất
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherMemorandum')
        ALTER TABLE AT0000 ADD VoucherMemorandum VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherLandLeaseContract')
        ALTER TABLE AT0000 ADD VoucherLandLeaseContract VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherOriginalcontract')
        ALTER TABLE AT0000 ADD VoucherOriginalcontract VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherBrokerageContract')
        ALTER TABLE AT0000 ADD VoucherBrokerageContract VARCHAR(50) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'VoucherTransferLiquidate')
        ALTER TABLE AT0000 ADD VoucherTransferLiquidate VARCHAR(50) NULL
END 