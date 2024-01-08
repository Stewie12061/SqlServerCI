IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3008_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3008_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Nhập xuất tồn theo kho (tất cả các kho)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/06/2006 by Nguyen Quoc Huy
---- 
---- Modified on 12/06/2012 by Lê Thị Thu Hiền : Bổ sung MinQuantity, MaxQuantity
---- Modified on 10/09/2012 by Bao Anh : Customize cho 2T (tồn kho theo quy cách), gọi AP3888
---- Modified on 10/09/2012 by Bao Anh : Bổ sung Varchar01 --> Varchar02
---- Modified on 17/06/2014 by Thanh Sơn : Bổ sung TimeOfUse
---- Modified on 08/07/2014 by Bảo Anh : Trả dữ liệu trực tiếp, không tạo view AV3008
---- Modified on 14/05/2015 by Bảo Anh: cải thiện tốc độ (dùng bảng tạm thay view, sửa câu tạo bảng tạm ##AV3088, tính TimeOfUse từ AT2007)
---- Modified on 11/09/2015 by Thanh Thịnh: Chỉ hiện những người có trường Thủ Kho ở AT1303 là khác 1 (Figla)
---- Modified on 14/10/2015 by Tieu Mai: Fix đúp dòng khi xem báo cáo theo ngày.
---- Modified on 15/11/2015 by Bảo Anh: Đưa phần tính TimeOfUse vào customize cho Viện Gút, lấy các trường Notes01 -> 03 từ AT1302 để fix lỗi 1 mặt hàng lên nhiều dòng
---- Modified on 07/01/2016 by Tieu Mai: Bổ sung in báo cáo theo quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 04/02/2016 by Kim Vu: Bo sung in báo cáo loại trừ kho không chọn in trong thiết lập in
---- Modified by Phương Thảo on 27/05/2016: Bổ sung WITH(NOLOCK)
---- Modified by Tiểu Mai on 08/08/2017: Bổ sung group by theo kho cho ANGEL
---- Modified by Phương Thảo on 16/11/2017:  Chỉnh sửa cách lấy dữ liệu nhập xuất trong kỳ khi group theo kho: Lấy luôn dữ liệu VCNB
---- Modified on 22/01/2018 by Bảo Anh: Không trừ VCNB khi tính giá trị nhập xuất trong kỳ
---- Modified on 07/05/2018 by Bảo Anh: Bổ sung I06ID -> I10ID
---- Modified on 04/01/2019 by Kim Thư: Bổ sung biến @IsExceptReturn - option load hàng bị trả lại
---- Modified on 20/06/2019 by Kim Thư: Không loại trừ phiếu nhập đầu kỳ trả lại và ko áp giá xuất kho
---- Modified on 08/07/2019 by Kim Thư: Không loại trừ phiếu nhập đầu kỳ trả lại HOẶC ko áp giá xuất kho
---- Modified on 19/01/2022 by Nhật Thanh: Bổ sung điều kiện division dùng chung khi join bảng
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- <Example>
---- EXEC AP3008 'MK',1,1,2016, 2016, '', '', '', '', 0, 1, '', '', ''

CREATE PROCEDURE AP3008_AG
(
    @DivisionID AS nvarchar(50), 
    @FromMonth AS int, 
    @ToMonth AS int, 
    @FromYear AS int, 
    @ToYear AS int, 
    @FromDate AS datetime, 
    @ToDate AS datetime, 
    @FromInventoryID AS nvarchar(50), 
    @ToInventoryID AS nvarchar(50), 
    @IsDate AS tinyint, 
    @IsGroupID AS tinyint, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    @GroupID1 AS nvarchar(50), 
    @GroupID2 AS nvarchar(50), --- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@LstWareHouseID as nvarchar(1000),--- Danh sach cac kho loại trừ khong in
	@IsExceptReturn AS TINYINT
)
AS
DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP3009 @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @IsDate, @IsGroupID, @GroupID1, @GroupID2, @LstWareHouseID
ELSE
BEGIN
	IF @CustomerName = 15 --- Customize 2T
		EXEC AP3888 @DivisionID, @FromMonth, @ToMonth, @FromYear, @ToYear, @FromDate, @ToDate, @FromInventoryID, @ToInventoryID, @IsDate, @IsGroupID, @GroupID1, @GroupID2
	ELSE
	BEGIN
		DECLARE 
			@sSQL1 AS nvarchar(4000), 
			@sSQL2 AS nvarchar(4000), 
			@sSQL3 AS nvarchar(4000), 
			@sSQL4 AS nvarchar(4000), 
			@GroupField1 AS nvarchar(20), 
			@GroupField2 AS nvarchar(20), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@3MonthPrevious INT,
			@YearPrevious INT		
			

		SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
		SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

		--- Xóa các bảng tạm nếu đã tồn tại
		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.##AV7016')) 
			DROP TABLE ##AV7016

		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.##AV3088')) 
			DROP TABLE ##AV3088

		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.##AV3098')) 
			DROP TABLE ##AV3098
		
		IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.##AV3008')) 
			DROP TABLE ##AV3008

		IF @IsDate = 0 --theo ky
		BEGIN
			IF @ToMonth > 3	BEGIN SET @3MonthPrevious = @ToMonth - 3 SET @YearPrevious = @ToYear END
			ELSE BEGIN SET @3MonthPrevious = 9 + @ToMonth SET @YearPrevious = @ToYear - 1 END
			SET @sSQL1 = 
			N' 
				SELECT AT2008.WareHouseID, AT1303.WareHouseName,
				AT2008.InventoryID, 
				AT1302.InventoryName, 
				AT1302.UnitID, 
				AT1302.VATPercent, 
				AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
				AT1302.S1, AT1302.S2, AT1302.S3,
				AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302.I06ID, AT1302.I07ID, AT1302.I08ID, AT1302.I09ID, AT1302.I10ID,
				AT1302.InventoryTypeID, AT1302.Specification, 
				AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
				AT1302.Varchar01,AT1302.Varchar02,AT1302.Varchar03,AT1302.Varchar04,AT1302.Varchar05,
				AT1304.UnitName, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + '
					THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @ToMonthYearText + '
					THEN ISNULL(EndQuantity, 0) ELSE 0 END) AS EndQuantity, 
				--SUM(ISNULL(DebitQuantity, 0) - ISNULL(InDebitQuantity, 0)) AS DebitQuantity, 
				--SUM(ISNULL(CreditQuantity, 0) - ISNULL(InCreditQuantity, 0)) AS CreditQuantity, 
				SUM(ISNULL(DebitQuantity, 0)) AS DebitQuantity, 
				SUM(ISNULL(CreditQuantity, 0)) AS CreditQuantity, 
				SUM(ISNULL(DebitQuantity, 0)) AS DebitQuantityGroupWH,
				SUM(ISNULL(CreditQuantity, 0)) AS CreditQuantityGroupWH,
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @FromMonthYearText + '
					THEN ISNULL(BeginAmount, 0) ELSE 0 END) AS BeginAmount, 
				SUM(CASE WHEN TranMonth + TranYear * 100 = ' + @ToMonthYearText + '
					THEN ISNULL(EndAmount, 0) ELSE 0 END) AS EndAmount, 
				--SUM(ISNULL(DebitAmount, 0) - ISNULL(InDebitAmount, 0)) AS DebitAmount, 
				--SUM(ISNULL(CreditAmount, 0) - ISNULL(InCreditAmount, 0)) AS CreditAmount,
				SUM(ISNULL(DebitAmount, 0)) AS DebitAmount, 
				SUM(ISNULL(CreditAmount, 0)) AS CreditAmount, 
				SUM(ISNULL(DebitAmount, 0) ) AS DebitAmountGroupWH,
				SUM(ISNULL(CreditAmount, 0) ) AS CreditAmountGroupWH,
				SUM(ISNULL(InDebitAmount, 0)) AS InDebitAmount, 
				SUM(ISNULL(InCreditAmount, 0)) AS InCreditAmount, 
				SUM(ISNULL(InDebitQuantity, 0)) AS InDebitQuantity, 
				SUM(ISNULL(InCreditQuantity, 0)) AS InCreditQuantity, 
				AT2008.DivisionID
			'
			SET @sSQL2 = N' INTO ##AV3098
				FROM AT2008 WITH(NOLOCK)
				INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.InventoryID = AT2008.InventoryID AND AT1302.DivisionID in (''@@@'',AT2008.DivisionID)
				INNER JOIN AT1304 WITH(NOLOCK) ON AT1304.UnitID = AT1302.UnitID AND AT1304.DivisionID in (''@@@'',AT2008.DivisionID)
				INNER JOIN AT1303 WITH(NOLOCK) ON AT1303.DivisionID in (''@@@'',''' + @DivisionID + ''') AND AT1303.WareHouseID = AT2008.WareHouseID
				LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AT2008.InventoryID AND AT1309.UnitID = AT1302.UnitID AND AT1309.DivisionID = AT2008.DivisionID 

				WHERE AT1303.IsTemp = 0 
				'+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AT1303.FullName,'''') <> ''1'' ' ELSE'' END  +'
				AND AT2008.DivisionID LIKE ''' + @DivisionID + '''
				AND AT2008.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
				AND AT2008.TranMonth + AT2008.TranYear * 100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + '
				AND AT2008.WareHouseID not in (''' + Isnull(@LstWareHouseID,'') + ''')

				GROUP BY AT2008.WareHouseID, AT1303.WareHouseName, AT2008.InventoryID, InventoryName, AT1302.UnitID, AT1304.UnitName, AT1302.VATPercent, 
				AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
				AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302.I06ID, AT1302.I07ID, AT1302.I08ID, AT1302.I09ID, AT1302.I10ID, 
				AT1302.InventoryTypeID, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
				AT1302.Varchar01,AT1302.Varchar02,AT1302.Varchar03,AT1302.Varchar04,AT1302.Varchar05, 
				AT2008.DivisionID
			'
		END
		ELSE -- theo ngayW
		BEGIN
			IF Month(@ToDate) > 3 BEGIN SET @3MonthPrevious = Month(@ToDate) - 3  SET @YearPrevious = YEAR(@ToDate) END
			ELSE BEGIN SET @3MonthPrevious = 9 + Month(@ToDate) SET @YearPrevious = Month(@ToDate) - 1 END
			SET @sSQL1 = N'
				SELECT V7.WareHouseID, V7.WareHouseName,
				InventoryID, InventoryName, UnitID, 
				S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
				UnitName, VATPercent, InventoryTypeID, Specification, 
				V7.D02Notes01 as Notes01, V7.D02Notes02 as Notes02, V7.D02Notes03 as Notes03, 
				V7.Varchar01,V7.Varchar02,V7.Varchar03,V7.Varchar04,V7.Varchar05,
				SUM(SignQuantity) AS BeginQuantity, 
				SUM(SignAmount) AS BeginAmount, 
				DivisionID
			'
			SET @sSQL2 = ' INTO ##AV7016
				FROM AV7000 V7		
				WHERE DivisionID LIKE ''' + @DivisionID + '''
				'+CASE WHEN  @CustomerName = 49 THEN 'AND ISNULL(V7.WHFullName,'''') <> ''1'' ' ELSE ''END  +'
				AND (VoucherDate < ''' + @FromDateText + ''' OR D_C = ''BD'')
				AND InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
				AND V7.WareHouseID not in (''' + Isnull(@LstWareHouseID,'') + ''')
				GROUP BY V7.WareHouseID, V7.WareHouseName, InventoryID, InventoryName, UnitID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID,  I06ID, I07ID, I08ID, I09ID, I10ID,
				UnitName, VATPercent, InventoryTypeID, Specification, 
				V7.D02Notes01, V7.D02Notes02, V7.D02Notes03, 
				V7.Varchar01,V7.Varchar02,V7.Varchar03,V7.Varchar04,V7.Varchar05,
				V7.DivisionID
			'
			print @sSQL1
			print @sSQL2
			EXEC(@sSQL1 + @sSQL2)
		
		/*
				IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV7016')
					EXEC(' CREATE VIEW AV7016 AS ' + @sSQL1 + @sSQL2)
				ELSE
					EXEC(' ALTER VIEW AV7016 AS ' + @sSQL1 + @sSQL2)
		*/
			SET @sSQL1 = N'
				SELECT WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, 
				S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID, VATPercent, InventoryTypeID, Specification, 
				Notes01, Notes02, Notes03, 
				Varchar01,Varchar02,Varchar03,Varchar04,Varchar05,
				UnitName, 
				BeginQuantity, 
				BeginAmount, 
				0 AS DebitQuantity, 
				0 AS CreditQuantity, 
				0 AS DebitAmount, 
				0 AS CreditAmount, 
				0 AS DebitQuantityGroupWH, 
				0 AS CreditQuantityGroupWH, 
				0 AS DebitAmountGroupWH, 
				0 AS CreditAmountGroupWH, 
				0 AS EndQuantity, 
				0 AS EndAmount, AV7016.DivisionID
			'
			SET @sSQL2 = N' INTO ##AV3088
				FROM ##AV7016 AV7016
			'
			SET @sSQL3 = N'
				UNION ALL

				SELECT AV7000.WareHouseID, AV7000.WareHouseName,
				AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, 
				AV7000.S1, AV7000.S2, AV7000.S3,
				AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000.I06ID, AV7000.I07ID, AV7000.I08ID, AV7000.I09ID, AV7000.I10ID,
				AV7000.VATPercent, AV7000.InventoryTypeID, AV7000.Specification, 
				AV7000.D02Notes01 as Notes01, AV7000.D02Notes02 as Notes02, AV7000.D02Notes03 as Notes03,
				AV7000.Varchar01,AV7000.Varchar02,AV7000.Varchar03,AV7000.Varchar04,AV7000.Varchar05, 
				AV7000.UnitName, 
				0 AS BeginQuantity, 
				0 AS BeginAmount, 
				--SUM(CASE WHEN D_C = ''D'' THEN CASE WHEN KindVoucherID = 3 THEN 0 ELSE ISNULL(AV7000.ActualQuantity, 0) END ELSE 0 END) AS DebitQuantity, 
				--SUM(CASE WHEN D_C = ''C'' THEN CASE WHEN KindVoucherID = 3 THEN 0 ELSE ISNULL(AV7000.ActualQuantity, 0) END ELSE 0 END) AS CreditQuantity, 
				--SUM(CASE WHEN D_C = ''D'' THEN CASE WHEN KindVoucherID = 3 THEN 0 ELSE ISNULL(AV7000.ConvertedAmount, 0) END ELSE 0 END) AS DebitAmount, 
				--SUM(CASE WHEN D_C = ''C'' THEN CASE WHEN KindVoucherID = 3 THEN 0 ELSE ISNULL(AV7000.ConvertedAmount, 0) END ELSE 0 END) AS CreditAmount, 
				SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
				SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
				SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
				SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount,		
				SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS DebitQuantityGroupWH, 
				SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ActualQuantity, 0) ELSE 0 END) AS CreditQuantityGroupWH, 
				SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS DebitAmountGroupWH, 
				SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7000.ConvertedAmount, 0) ELSE 0 END) AS CreditAmountGroupWH, 
				0 AS EndQuantity, 
				0 AS EndAmount, AV7000.DivisionID 
			'
			SET @sSQL4 =N'
				FROM AV7000 AV7000 
				WHERE AV7000.IsTemp = 0 	
				'+CASE WHEN @CustomerName = 49 THEN 'AND ISNULL(AV7000.WHFullName,'''') <> ''1'' ' ELSE '' END  +'	
				AND AV7000.D_C IN (''D'', ''C'') 
				AND AV7000.DivisionID LIKE ''' + @DivisionID + ''' 
				AND AV7000.InventoryID BETWEEN ''' + @FromInventoryID + ''' AND ''' + @ToInventoryID + '''
				AND AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
				AND AV7000.WareHouseID not in (''' + Isnull(@LstWareHouseID,'') + ''')
				GROUP BY AV7000.WareHouseID, AV7000.WareHouseName, AV7000.InventoryID, AV7000.InventoryName, AV7000.UnitID, AV7000.UnitName, ---AV7016.BeginQuantity, AV7016.BeginAmount, 
				AV7000.S1, AV7000.S2, AV7000.S3, AV7000.I01ID, AV7000.I02ID, AV7000.I03ID, AV7000.I04ID, AV7000.I05ID, AV7000.I06ID, AV7000.I07ID, AV7000.I08ID, AV7000.I09ID, AV7000.I10ID, 
				AV7000.VATPercent, AV7000.InventoryTypeID, AV7000.Specification, 
				AV7000.D02Notes01, AV7000.D02Notes02, AV7000.D02Notes03,
				AV7000.Varchar01,AV7000.Varchar02,AV7000.Varchar03,AV7000.Varchar04,AV7000.Varchar05, 
				AV7000.DivisionID 
			'
			EXEC(@sSQL1 + @sSQL2 + @sSQL3 + @sSQL4)
		--print @sSQL1
		--print @sSQL2
		--print @sSQL3
		--print @sSQL4

		/*
				IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3088')
					EXEC(' CREATE VIEW AV3088 AS ' + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4) ---TAO BOI AP3008
				ELSE
					EXEC(' ALTER VIEW AV3088 AS ' + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4) ---TAO BOI AP3008
		*/
			SET @sSQL1 = N'
				SELECT AV3088.WareHouseID, AV3088.WareHouseName, AV3088.InventoryID, 
				InventoryName, 
				AV3088.UnitID, 
				UnitName, AV3088.VATPercent, AV3088.InventoryTypeID, Specification, 
				AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
				AV3088.Varchar01,AV3088.Varchar02,AV3088.Varchar03,AV3088.Varchar04,AV3088.Varchar05, 
				AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, 
				S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
				SUM(BeginQuantity) AS BeginQuantity, 
				SUM(BeginAmount) AS BeginAmount, 
				DebitQuantity, 
				CreditQuantity, 
				DebitAmount, 
				CreditAmount, 
				DebitQuantityGroupWH, 
				CreditQuantityGroupWH, 
				DebitAmountGroupWH, 
				CreditAmountGroupWH,
				0 AS InDebitAmount, 0 AS InCreditAmount, 0 AS InDebitQuantity, 
				0 AS InCreditQuantity, 
				SUM(BeginQuantity) + DebitQuantityGroupWH - CreditQuantityGroupWH AS EndQuantity, 
				SUM(BeginAmount) + DebitAmountGroupWH - CreditAmountGroupWH AS EndAmount, AV3088.DivisionID 
			'
			SET @sSQL2 = N'INTO ##AV3098
				FROM ##AV3088 AV3088 
				LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AV3088.InventoryID AND AT1309.UnitID = AV3088.UnitID AND AT1309.DivisionID = AV3088.DivisionID

				GROUP BY AV3088.WareHouseID, AV3088.WareHouseName, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
				AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, 
				AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, 
				DebitQuantity, DebitAmount, CreditQuantity, CreditAmount, 
				DebitQuantityGroupWH, DebitAmountGroupWH, CreditQuantityGroupWH, CreditAmountGroupWH, 
				AV3088.VATPercent, AV3088.InventoryTypeID, Specification, 
				AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, 
				AV3088.Varchar01,AV3088.Varchar02,AV3088.Varchar03,AV3088.Varchar04,AV3088.Varchar05, 
				AV3088.DivisionID 
			'
		END --- theo ngay -------------------------------------------------------
		EXEC(@sSQL1 + @sSQL2)
		print @sSQL1
		print @sSQL2
/*
		IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3098')
			EXEC(' CREATE VIEW AV3098 AS ' + @sSQL1 + @sSQL2)
		ELSE
			EXEC(' ALTER VIEW AV3098 AS ' + @sSQL1 + @sSQL2)
*/		    
		SET @GroupField1 = 
		(
			SELECT CASE @GroupID1
				WHEN 'CI1' THEN 'S1'
				WHEN 'CI2' THEN 'S2'
				WHEN 'CI3' THEN 'S3'
				WHEN 'I01' THEN 'I01ID'
				WHEN 'I02' THEN 'I02ID'
				WHEN 'I03' THEN 'I03ID'
				WHEN 'I04' THEN 'I04ID'
				WHEN 'I05' THEN 'I05ID'
				WHEN 'I06' THEN 'I06ID'
				WHEN 'I07' THEN 'I07ID'
				WHEN 'I08' THEN 'I08ID'
				WHEN 'I09' THEN 'I09ID'
				WHEN 'I10' THEN 'I10ID'
			END
		)
		SET @GroupField2 = @GroupField1

		SET @GroupField2 = 
		(
			SELECT CASE @GroupID2
				WHEN 'CI1' THEN 'S1'
				WHEN 'CI2' THEN 'S2'
				WHEN 'CI3' THEN 'S3'
				WHEN 'I01' THEN 'I01ID'
				WHEN 'I02' THEN 'I02ID'
				WHEN 'I03' THEN 'I03ID'
				WHEN 'I04' THEN 'I04ID'
				WHEN 'I05' THEN 'I05ID'
				WHEN 'I06' THEN 'I06ID'
				WHEN 'I07' THEN 'I07ID'
				WHEN 'I08' THEN 'I08ID'
				WHEN 'I09' THEN 'I09ID'
				WHEN 'I10' THEN 'I10ID' 
			END
		)

		SET @GroupField1 = ISNULL(@GroupField1, '')
		SET @GroupField2 = ISNULL(@GroupField2, '')
		        
		IF ((@IsGroupID >= 2) AND (@GroupField1 <> '') AND (@GroupField2 <> ''))
		BEGIN
			SET @sSQL1 = N'
				SELECT AV3098.WareHouseID, AV3098.WareHouseName,
				V1.ID AS GroupID1, V2.ID AS GroupID2, 
				V1.SName AS GroupName1, V2.SName AS GroupName2, 
				AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID,
				AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, VATPercent, AV3098.InventoryTypeID, AV3098.Specification, 
				AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
				AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				SUM(AV3098.BeginQuantity) AS BeginQuantity, SUM(AV3098.EndQuantity) AS EndQuantity, 
				CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
				ELSE ISNULL(SUM(AV3098.EndQuantity), 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
				SUM(AV3098.DebitQuantityGroupWH) as DebitQuantityGroupWH, SUM(AV3098.CreditQuantityGroupWH) as CreditQuantityGroupWH, 
				SUM(AV3098.BeginAmount) as BeginAmount, SUM(AV3098.EndAmount) as EndAmount, 
				SUM(AV3098.DebitAmountGroupWH) as DebitAmountGroupWH, SUM(AV3098.CreditAmountGroupWH) as CreditAmountGroupWH, 
				SUM(AV3098.InDebitAmount) as InDebitAmount, SUM(AV3098.InCreditAmount) as InCreditAmount, SUM(AV3098.InDebitQuantity) as InDebitQuantity, 
				SUM(AV3098.InCreditQuantity) as InCreditQuantity, AV3098.DivisionID,
				AT1314.MinQuantity, AT1314.MaxQuantity,
				SUM(AV3098.DebitQuantity) as DebitQuantity, SUM(AV3098.CreditQuantity) as CreditQuantity, 
				SUM(AV3098.DebitAmount) as DebitAmount, SUM(AV3098.CreditAmount) as CreditAmount
			'
		
			IF @CustomerName = 23 --- Customize Viện Gút
				SET @sSQL1 = @sSQL1 + N',		
					CASE WHEN (	SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
								Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID 
								WHERE InventoryID = AV3098.InventoryID
								AND KindVoucherID IN (2,4,6)
								AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
								AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+') = 0 THEN 0
					ELSE SUM(AV3098.EndQuantity)/
								((SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
								Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID 
								WHERE InventoryID = AV3098.InventoryID
								AND KindVoucherID IN (2,4,6)
								AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
								AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+')/3)
					END TimeOfUse
				'

			SET @sSQL2 = N'
				INTO ##AV3008		
				FROM ##AV3098 AV3098
				LEFT JOIN AV1310 V1 ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID = AV3098.DivisionID
				LEFT JOIN AV1310 V2 ON V2.ID = AV3098.' + @GroupField2 + ' AND V2.TypeID =''' + @GroupID2 + ''' AND V2.DivisionID = AV3098.DivisionID
				LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
							FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
					ON		AT1314.DivisionID = AV3098.DivisionID AND AT1314.InventoryID = AV3098.InventoryID
				WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
				AND AV3098.DivisionID = ''' + @DivisionID + '''
				GROUP BY AV3098.WareHouseID, AV3098.WareHouseName, V1.ID, V2.ID, 
				V1.SName, V2.SName, 
				AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID, 
				AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, VATPercent, AV3098.InventoryTypeID, AV3098.Specification, 
				AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
				AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				AV3098.DivisionID,  AT1314.MinQuantity, AT1314.MaxQuantity
				ORDER BY AV3098.WareHouseID, AV3098.InventoryID
			'
		END 
		ELSE IF ((@IsGroupID >= 1) AND ((@GroupField1 <> '') OR (@GroupField2 <> '')))
		BEGIN        
			IF(@GroupField1 = '') SET @GroupField1 = @GroupField2
			SET @sSQL1 = N'
				SELECT AV3098.WareHouseID, AV3098.WareHouseName,
				V1.ID AS GroupID1, '''' AS GroupID2, 
				V1.SName AS GroupName1, '''' AS GroupName2, 
				AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID, 
				AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, AV3098.InventoryTypeID, AV3098.Specification, 
				AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
				AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				AV3098.BeginQuantity, AV3098.EndQuantity, 
				CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
				ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
				AV3098.DebitQuantityGroupWH, AV3098.CreditQuantityGroupWH, AV3098.BeginAmount, AV3098.EndAmount, 
				AV3098.DebitAmountGroupWH, AV3098.CreditAmountGroupWH, 
				AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
				AV3098.InCreditQuantity, AV3098.DivisionID,
				AT1314.MinQuantity, AT1314.MaxQuantity,
				AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.DebitAmount, AV3098.CreditAmount
			'
		
			IF @CustomerName = 23 --- Customize Viện Gút
			SET @sSQL1 = @sSQL1 + N',
				CASE WHEN (	SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
							Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID 
							WHERE InventoryID = AV3098.InventoryID
							AND KindVoucherID IN (2,4,6)
							AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
							AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+') = 0 THEN 0
				ELSE AV3098.EndQuantity/
							((SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
							Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID
							WHERE InventoryID = AV3098.InventoryID
							AND KindVoucherID IN (2,4,6)
							AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
							AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+')/3)
				END TimeOfUse'
		
			SET @sSQL2 = N'
				INTO ##AV3008		
				FROM ##AV3098 AV3098 
				LEFT JOIN AV1310 V1 ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID = AV3098.DivisionID
				LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
							FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
					ON		AT1314.DivisionID = AV3098.DivisionID AND AT1314.InventoryID = AV3098.InventoryID
				WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
				AND AV3098.DivisionID = ''' + @DivisionID + '''
				ORDER BY AV3098.WareHouseID, AV3098.InventoryID
			'
		END     
		ELSE
		BEGIN
			SET @sSQL1 = N'
				SELECT AV3098.WareHouseID, AV3098.WareHouseName, '''' AS GroupID1, '''' AS GroupID2, '''' AS GroupName1, '''' AS GroupName2, 
				AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I06ID, I07ID, I08ID, I09ID, I10ID, 
				AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, AV3098.InventoryTypeID, Specification, 
				AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, 
				AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
				AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, 
				AV3098.BeginQuantity, AV3098.EndQuantity, 
				CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL
				ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
				AV3098.DebitQuantityGroupWH, AV3098.CreditQuantityGroupWH, AV3098.BeginAmount, AV3098.EndAmount, 
				AV3098.DebitAmountGroupWH, AV3098.CreditAmountGroupWH, 
				AV3098.InDebitAmount, AV3098.InCreditAmount, AV3098.InDebitQuantity, 
				AV3098.InCreditQuantity, AV3098.DivisionID,
				AT1314.MinQuantity, AT1314.MaxQuantity,
				AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.DebitAmount, AV3098.CreditAmount
			'
		
			IF @CustomerName = 23 --- Customize Viện Gút
			SET @sSQL1 = @sSQL1 + N', 
				CASE WHEN (	SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
							Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID
							WHERE InventoryID = AV3098.InventoryID
							AND KindVoucherID IN (2,4,6)
							AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
							AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+') = 0 THEN 0
				ELSE AV3098.EndQuantity/
							((SELECT SUM(ActualQuantity) FROM AT2007 WITH(NOLOCK)
							Inner join AT2006 WITH(NOLOCK) On AT2007.DivisionID = AT2006.DivisionID And AT2007.VoucherID = AT2006.VoucherID
							WHERE InventoryID = AV3098.InventoryID
							AND KindVoucherID IN (2,4,6)
							AND AT2007.TranMonth + AT2007.TranYear * 100 > '+STR(@3MonthPrevious + @YearPrevious * 100)+'
							AND AT2007.TranMonth + AT2007.TranYear * 100 <= '+STR(@ToMonth + @ToYear * 100)+')/3)
				END TimeOfUse
			'
			
			SET @sSQL2 = N'		
				INTO ##AV3008		
				FROM ##AV3098 AV3098 
				LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
							FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID  ) AT1314
					ON		AT1314.DivisionID = AV3098.DivisionID AND AT1314.InventoryID = AV3098.InventoryID
				WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
				CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
				AND AV3098.DivisionID = ''' + @DivisionID + '''
				ORDER BY AV3098.WareHouseID, AV3098.InventoryID
			'
		END
		
		--PRINT @sSQL1 
		--PRINT @sSQL2 
		EXEC(@sSQL1 + @sSQL2)
		--SELECT * FROM ##AV3008
		
		IF @IsExceptReturn = 1
		BEGIN
			IF @IsDate = 0
				SET @sSQL1 = N'
				-- Số lượng hàng trả lại đầu kỳ
				SELECT A06.DivisionID, A06.WarehouseID, A07.InventoryID, ISNULL(SUM(A07.ActualQuantity),0) AS ActualQuantity, ISNULL(SUM(A07.ConvertedAmount),0) AS ConvertedAmount 
				INTO #BEGINRETURN
				FROM AT2006 A06 INNER JOIN AT2007 A07 ON A06.VoucherID = A07.VoucherID 
				WHERE A06.DivisionID = '''+@DivisionID+''' AND A07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' AND (A06.IsReturn=1 OR A06.IsNotUpdatePrice=1)
				AND A06.TranMonth + A06.TranYear * 100 < '+@FromMonthYearText +' AND A06.KindVoucherID IN (1,3,5,7)
				GROUP BY A06.DivisionID, A06.WarehouseID, A07.InventoryID

				-- Số lượng hàng trả lại trong kỳ
				SELECT A06.DivisionID, A06.WarehouseID, A06.WarehouseID2, A06.KindVoucherID, A07.InventoryID, ISNULL(SUM(A07.ActualQuantity),0) AS ActualQuantity, ISNULL(SUM(A07.ConvertedAmount),0) AS ConvertedAmount 
				INTO #ENDRETURN
				FROM AT2006 A06 INNER JOIN AT2007 A07 ON A06.VoucherID = A07.VoucherID 
				WHERE A06.DivisionID = '''+@DivisionID+''' AND A07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' AND (A06.IsReturn=1 OR A06.IsNotUpdatePrice=1)
				AND A06.TranMonth + A06.TranYear * 100 BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' AND A06.KindVoucherID IN (1,3,5,7)
				GROUP BY A06.DivisionID, A06.WarehouseID, A06.WarehouseID2, A06.KindVoucherID, A07.InventoryID
				'
			ELSE
				SET @sSQL1 = N'
				-- Số lượng hàng trả lại đầu kỳ
				SELECT A06.DivisionID, A06.WarehouseID, A07.InventoryID, ISNULL(SUM(A07.ActualQuantity),0) AS ActualQuantity, ISNULL(SUM(A07.ConvertedAmount),0) AS ConvertedAmount 
				INTO #BEGINRETURN
				FROM AT2006 A06 INNER JOIN AT2007 A07 ON A06.VoucherID = A07.VoucherID 
				WHERE A06.DivisionID = '''+@DivisionID+''' AND A07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' AND (A06.IsReturn=1 OR A06.IsNotUpdatePrice=1)
				AND A06.VoucherDate < ''' + @FromDateText + ''' AND A06.KindVoucherID IN (1,3,5,7)
				GROUP BY A06.DivisionID, A06.WarehouseID, A07.InventoryID

				-- Số lượng hàng trả lại trong kỳ
				SELECT A06.DivisionID, A06.WarehouseID, A06.WarehouseID2, A06.KindVoucherID, A07.InventoryID, ISNULL(SUM(A07.ActualQuantity),0) AS ActualQuantity, ISNULL(SUM(A07.ConvertedAmount),0) AS ConvertedAmount 
				INTO #ENDRETURN
				FROM AT2006 A06 INNER JOIN AT2007 A07 ON A06.VoucherID = A07.VoucherID 
				WHERE A06.DivisionID = '''+@DivisionID+''' AND A07.InventoryID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+''' AND (A06.IsReturn=1 OR A06.IsNotUpdatePrice=1)
				AND A06.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' AND A06.KindVoucherID IN (1,3,5,7)
				GROUP BY A06.DivisionID, A06.WarehouseID, A06.WarehouseID2, A06.KindVoucherID, A07.InventoryID
				'
			SET @sSQL2 = N'
			SELECT A1.WarehouseID, A1.WarehouseName, A1.GroupID1, A1.GroupID2, A1.GroupName1, A1.GroupName2, A1.InventoryID, A1.S1, A1.S2, A1.S3, A1.I01ID, A1.I02ID, A1.I03ID,
			A1.I04ID, A1.I05ID, A1.I06ID, A1.I07ID, A1.I08ID, A1.I09ID, A1.I10ID, A1.InventoryName, A1.UnitID, A1.UnitName, A1.VATPercent, A1.InventoryTypeID, A1.Specification,
			A1.Notes01, A1.Notes02, A1.Notes03, A1.Varchar01, A1.Varchar02, A1.Varchar03, A1.Varchar04, A1.Varchar05, A1.ConversionUnitID, A1.ConversionFactor, A1.Operator,
			ISNULL(A1.BeginQuantity,0) AS BeginQuantity, 
			CASE WHEN ISNULL(A1.DebitQuantity,0) = 0 AND ISNULL(A1.CreditQuantity,0) = 0 THEN ISNULL(A1.BeginQuantity,0)
				 ELSE ISNULL(A1.EndQuantity-ISNULL(SUM(A3.ActualQuantity),0)-ISNULL(SUM(A4.ActualQuantity),0),0) END AS EndQuantity,
			ISNULL(A1.ConversionQuantity-ISNULL(SUM(A3.ActualQuantity),0)-ISNULL(SUM(A4.ActualQuantity),0),0) AS ConversionQuantity, 
			ISNULL(A1.DebitQuantityGroupWH-ISNULL(SUM(A3.ActualQuantity),0)-ISNULL(SUM(A4.ActualQuantity),0),0) AS DebitQuantityGroupWH, 
			ISNULL(A1.CreditQuantityGroupWH-ISNULL(SUM(A5.ActualQuantity),0),0) AS CreditQuantityGroupWH,
			ISNULL(A1.BeginAmount,0) AS BeginAmount, 
			CASE WHEN ISNULL(A1.DebitAmount,0)=0 AND ISNULL(A1.CreditAmount,0)=0 THEN ISNULL(A1.BeginAmount,0)
				ELSE ISNULL(A1.EndAmount-ISNULL(SUM(A3.ConvertedAmount),0)-ISNULL(SUM(A4.ConvertedAmount),0),0) END AS EndAmount,
			ISNULL(A1.DebitAmountGroupWH-ISNULL(SUM(A3.ConvertedAmount),0)-ISNULL(SUM(A4.ConvertedAmount),0),0) AS DebitAmountGroupWH, 
			ISNULL(A1.CreditAmountGroupWH-ISNULL(SUM(A5.ConvertedAmount),0),0) AS CreditAmountGroupWH, 
			ISNULL(A1.InDebitAmount-ISNULL(SUM(A4.ConvertedAmount),0),0) AS InDebitAmount, 
			ISNULL(A1.InCreditAmount-ISNULL(SUM(A5.ConvertedAmount),0),0) AS InCreditAmount,
			ISNULL(A1.IndebitQuantity-ISNULL(SUM(A4.ActualQuantity),0),0) AS IndebitQuantity, 
			ISNULL(A1.InCreditQuantity-ISNULL(SUM(A5.ActualQuantity),0),0) AS InCreditQuantity,
			A1.DivisionID, A1.MinQuantity, A1.MaxQuantity, 
			ISNULL(A1.DebitQuantity-ISNULL(SUM(A3.ActualQuantity),0)-ISNULL(SUM(A4.ActualQuantity),0),0) AS DebitQuantity,
			ISNULL(A1.CreditQuantity-ISNULL(SUM(A5.ActualQuantity),0),0) AS CreditQuantity,
			ISNULL(A1.DebitAmount-ISNULL(SUM(A3.ConvertedAmount),0)-ISNULL(SUM(A4.ConvertedAmount),0),0) AS DebitAmount, 
			ISNULL(A1.CreditAmount-ISNULL(SUM(A5.ConvertedAmount),0),0) AS CreditAmount
			'
			SET @sSQL3 = N'FROM ##AV3008 A1 --LEFT JOIN #BEGINRETURN A2 ON A1.WarehouseID = ISNULL(A2.WareHouseID,'''') AND A1.InventoryID = ISNULL(A2.InventoryID,'''')
			LEFT JOIN #ENDRETURN A3 ON A1.WarehouseID = ISNULL(A3.WareHouseID,'''') AND A1.InventoryID = ISNULL(A3.InventoryID,'''') AND A3.KindVoucherID = 1
			LEFT JOIN #ENDRETURN A4 ON A1.WarehouseID = ISNULL(A4.WareHouseID,'''') AND A1.InventoryID = ISNULL(A4.InventoryID,'''') AND A4.KindVoucherID IN  (''3'',''5'',''7'')
			--LEFT JOIN #ENDRETURN A4-1 ON A1.WarehouseID = ISNULL(A4-1.WareHouseID,'''') AND A1.InventoryID = ISNULL(A4-1.InventoryID,'''') AND A4-1.KindVoucherID = 5
			--LEFT JOIN #ENDRETURN A4-2 ON A1.WarehouseID = ISNULL(A4-2.WareHouseID,'''') AND A1.InventoryID = ISNULL(A4-2.InventoryID,'''') AND A4-2.KindVoucherID = 7
			LEFT JOIN #ENDRETURN A5 ON A1.WarehouseID = ISNULL(A5.WareHouseID2,'''') AND A1.InventoryID = ISNULL(A5.InventoryID,'''') AND A5.KindVoucherID = 3
			GROUP BY A1.WarehouseID, A1.WarehouseName, A1.GroupID1, A1.GroupID2, A1.GroupName1, A1.GroupName2, A1.InventoryID, A1.S1, A1.S2, A1.S3, A1.I01ID, A1.I02ID, A1.I03ID,
			A1.I04ID, A1.I05ID, A1.I06ID, A1.I07ID, A1.I08ID, A1.I09ID, A1.I10ID, A1.InventoryName, A1.UnitID, A1.UnitName, A1.VATPercent, A1.InventoryTypeID, A1.Specification,
			A1.Notes01, A1.Notes02, A1.Notes03, A1.Varchar01, A1.Varchar02, A1.Varchar03, A1.Varchar04, A1.Varchar05, A1.ConversionUnitID, A1.ConversionFactor, A1.Operator,
			A1.DivisionID, A1.MinQuantity, A1.MaxQuantity, A1.BeginQuantity, A1.EndQuantity, A1.ConversionQuantity, A1.DebitQuantityGroupWH, A1.CreditQuantityGroupWH,
			A1.BeginAmount, A1.EndAmount, A1.DebitAmountGroupWH, A1.CreditAmountGroupWH, A1.InDebitAmount, A1.InCreditAmount, A1.IndebitQuantity, A1.InCreditQuantity,
			A1.DebitQuantity, A1.CreditQuantity, A1.DebitAmount, A1.CreditAmount
			Order by InventoryID
			'
			--SELECT @sSQL1
			--SELECT @sSQL2
			EXEC (@sSQL1 + @sSQL2 + @sSQL3)
		END
		ELSE
			SELECT * FROM ##AV3008 Order by InventoryID
		
	END
	
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
