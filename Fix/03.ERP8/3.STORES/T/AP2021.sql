IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tieu Mai, on 09/11/2015
---- Purpose: Chi tiet nhap xuat vat tu theo quy cách hàng (theo DVT quy doi).
---- Modified by Kim Vu on 18/03/2016: Bo sung loc bao cao theo danh sach kho duoc chon( Sửa cách truyền WarehousID)
---- Modified by Tiểu Mai on 24/05/2016: Bổ sung 20 trường thiết lập tên quy cách
---- Modified by Bảo Thy on 27/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 31/05/2016: Fix bug không lên dữ liệu đầu kỳ khi không có phát sinh
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP2021]
       @DivisionID nvarchar(50) ,
       @WareHouseID AS xml,
       @FromInventoryID AS nvarchar(50) ,
       @ToInventoryID AS nvarchar(50) ,
       @FromMonth AS int ,
       @FromYear AS int ,
       @ToMonth AS int ,
       @ToYear AS int ,
       @FromDate AS datetime ,
       @ToDate AS datetime ,
       @IsDate AS tinyint ,
       @IsInner AS tinyint,
	   @IsAll AS tinyint
AS
		DECLARE
				@sSQlSelect AS nvarchar(4000) ,
				@sSQlSelect1 AS nvarchar(4000) ,
				@sSQlFrom AS nvarchar(4000) ,
				@sSQlWhere AS nvarchar(4000) ,
				@sSQlUnionSelect AS nvarchar(4000) ,
				@sSQlUnionSelect1 AS nvarchar(4000) ,
				@sSQlUnionSelect2 AS nvarchar(4000) ,
				@sSQlUnionFrom AS nvarchar(4000) ,
				@sSQlUnionWhere AS nvarchar(4000) ,
				@WareHouseName AS nvarchar(4000) ,
				@WareHouseName1 AS nvarchar(4000) ,
				@WareHouseID2 AS nvarchar(4000) ,
				@WareHouseID1 AS nvarchar(4000) ,
				@KindVoucherListIm AS nvarchar(4000) ,
				@KindVoucherListEx1 AS nvarchar(4000) ,
				@KindVoucherListEx2 AS nvarchar(4000),
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20)

    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'				

		-- Xu li du lieu xml
		IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[TBL_WareHouseIDAP2021]') AND TYPE IN (N'U'))
		BEGIN
			CREATE TABLE TBL_WareHouseIDAP2021 (WareHouseID VARCHAR(50))
		END

		-- Xoa du lieu hien tai
		DELETE TBL_WareHouseIDAP2021

		INSERT INTO TBL_WareHouseIDAP2021
		SELECT X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID
		FROM @WareHouseID.nodes('//Data') AS X (Data)

		IF((select count(*) from TBL_WareHouseIDAP2021) = 1)
		begin
			SELECT  @WareHouseName1 = WareHouseName
			FROM    AT1303 WITH (NOLOCK)
			WHERE   WareHouseID in (select WareHouseID from TBL_WareHouseIDAP2021) AND DivisionID IN (@DivisionID, '@@@')
		end  
		    
		EXEC AP7019 @DivisionID , @WareHouseID , @FromInventoryID , @ToInventoryID , @FromMonth , @FromYear , @ToMonth , @ToYear , @FromDate , @ToDate , @IsDate, @IsAll


		IF @IsInner = 0
		   BEGIN
				 SET @KindVoucherListEx1 = '(2,4,8,10,14,20) '
				 SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
				 SET @KindVoucherListIm = '(1,5,7,9,15,17) '
		   END
		ELSE
		   BEGIN
				 SET @KindVoucherListEx1 = '(2,4,3,8,10,14,20)'
				 SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
				 SET @KindVoucherListIm = '(1,3,5,7,9,15,17) '
		   END

		IF @IsAll = 1
		   BEGIN
				 SET @WareHouseID2 = '''%'''
				 SET @WareHouseID1 = '''%'''
				 SET @WareHouseName = 'WFML000110'

		   END
		ELSE
		   BEGIN
			--Set @WareHouseID2 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end'
				 SET @WareHouseID2 = ' AT2006.WareHouseID '
				 SET @WareHouseID1 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '
				 SET @WareHouseName = +'"' + @WareHouseName1 + '"'

		   END

		IF @IsDate = 0
		   BEGIN
				SET @sSQlSelect = N'
			--- Phan Nhap kho
			SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
					N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
					AT2007.VoucherID,
					AT2007.TransactionID,
					AT2007.Orders,
					VoucherDate,
					VoucherNo,	
					VoucherDate AS ImVoucherDate,
					VoucherNo AS ImVoucherNo,		
					SourceNo AS ImSourceNo,
					LimitDate AS ImLimitDate,	
 					AT2006.WareHouseID AS ImWareHouseID,		
					AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
					AT2007.ActualQuantity AS ImQuantity,
					AT2007.UnitPrice AS ImUnitPrice ,
					AT2007.ConvertedAmount AS ImConvertedAmount,
					AT2007.OriginalAmount AS ImOriginalAmount,
					AT2007.ConvertedQuantity AS ImConvertedQuantity,
					Null AS ExVoucherDate,
					Null AS ExVoucherNo,		
					Null AS ExSourceNo,
					Null AS ExLimitDate,	
 					Null AS ExWareHouseID,		
					Null AS ExRefNo01 , Null AS ExRefNo02 , 
					0 AS ExQuantity,
					Null AS ExUnitPrice ,
					0 AS ExConvertedAmount,
					0 AS ExOriginalAmount,
					0 AS ExConvertedQuantity,
					VoucherTypeID,
					AT2006.Description,
					AT2007.Notes,
					AT2007.InventoryID,	
					AT1302.InventoryName,
					AT2007.UnitID,		
					isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
					isnull(AV7019.BeginQuantity,0) AS BeginQuantity,
					isnull(AV7019.BeginAmount,0) AS BeginAmount,
					isnull(AV7019.BeginConvertedQuantity,0) AS BeginConvertedQuantity,
					(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
					AT2007.DebitAccountID, AT2007.CreditAccountID,
					At2006.ObjectID,
					AT1202.ObjectName,
					AT1302.Notes01,
					AT1302.Notes02,
					AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
					AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
					(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
					A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
					A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
					AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
					O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
					O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID  '
				
			SET @sSQlFrom = ' 
				FROM AT1302 WITH (NOLOCK)	
				LEFT JOIN AT2007  WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
				INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND At2006.DivisionID = AT2007.DivisionID
				LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID
				LEFT JOIN AV7019 on AV7019.InventoryID = AT2007.InventoryID AND AV7019.DivisionID = AT2007.DivisionID AND
									Isnull(AV7019.S01ID,'''') = Isnull(O99.S01ID,'''') AND
									Isnull(AV7019.S02ID,'''') = Isnull(O99.S02ID,'''') AND
									Isnull(AV7019.S03ID,'''') = Isnull(O99.S03ID,'''') AND
									Isnull(AV7019.S04ID,'''') = Isnull(O99.S04ID,'''') AND
									Isnull(AV7019.S05ID,'''') = Isnull(O99.S05ID,'''') AND
									Isnull(AV7019.S06ID,'''') = Isnull(O99.S06ID,'''') AND
									Isnull(AV7019.S07ID,'''') = Isnull(O99.S07ID,'''') AND
									Isnull(AV7019.S08ID,'''') = Isnull(O99.S08ID,'''') AND
									Isnull(AV7019.S09ID,'''') = Isnull(O99.S09ID,'''') AND
									Isnull(AV7019.S10ID,'''') = Isnull(O99.S10ID,'''') AND
									Isnull(AV7019.S11ID,'''') = Isnull(O99.S11ID,'''') AND
									Isnull(AV7019.S12ID,'''') = Isnull(O99.S12ID,'''') AND
									Isnull(AV7019.S13ID,'''') = Isnull(O99.S13ID,'''') AND
									Isnull(AV7019.S14ID,'''') = Isnull(O99.S14ID,'''') AND
									Isnull(AV7019.S15ID,'''') = Isnull(O99.S15ID,'''') AND
									Isnull(AV7019.S16ID,'''') = Isnull(O99.S16ID,'''') AND
									Isnull(AV7019.S17ID,'''') = Isnull(O99.S17ID,'''') AND
									Isnull(AV7019.S18ID,'''') = Isnull(O99.S18ID,'''') AND
									Isnull(AV7019.S19ID,'''') = Isnull(O99.S19ID,'''') AND
									Isnull(AV7019.S20ID,'''') = Isnull(O99.S20ID,'''')
				INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
				LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
				LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
				LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''	
				'
				
			SET @sSQlWhere = ' 
				WHERE	AT2007.DivisionID = N''' + @DivisionID + '''  ' +
						(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
						AT2006.TranMonth + 100*AT2006.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' AND
						KindVoucherID in ' + @KindVoucherListIm + ' AND
						(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
						AT2006.WareHouseID in (Select WareHouseID from TBL_WareHouseIDAP2021)'

			SET @sSQlUnionSelect = ' 
				UNION
			--- Phan Xuat kho
				SELECT  ' + @WareHouseID1 + ' AS WareHouseID,
						N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
						AT2007.VoucherID,
						AT2007.TransactionID,
						AT2007.Orders,
						VoucherDate,
						VoucherNo,	
						Null AS ImVoucherDate,
						Null AS ImVoucherNo,		
						Null AS ImSourceNo,
						Null AS ImLimitDate,	
 						Null AS ExWareHouseID,	
						Null AS ImRefNo01 , Null AS ImRefNo02 , 
						0 AS ImQuantity,
						Null AS ImUnitPrice ,
						0 AS ImConvertedAmount,
						0 AS ImOriginalAmount,
						0 AS ImConvertedQuantity,
						VoucherDate AS ExVoucherDate,
						VoucherNo AS ExVoucherNo,		
						SourceNo AS ExSourceNo,
						LimitDate AS ExLimitDate,	
 						(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
						AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
						AT2007.ActualQuantity AS ExQuantity,
						AT2007.UnitPrice AS ExUnitPrice ,
						AT2007.ConvertedAmount AS ExConvertedAmount,
						AT2007.OriginalAmount AS ExOriginalAmount,
						AT2007.ConvertedQuantity AS ExConvertedQuantity,
						VoucherTypeID,
						AT2006.Description,
						AT2007.Notes,
						AT2007.InventoryID,	
						AT1302.InventoryName,
						AT2007.UnitID,		 							
						isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
						isnull(AV7019.BeginQuantity,0) AS BeginQuantity,
						isnull(AV7019.BeginAmount,0) AS BeginAmount,
						isnull(AV7019.BeginConvertedQuantity,0) AS BeginConvertedQuantity,
						2 AS ImExOrders,
						AT2007.DebitAccountID, AT2007.CreditAccountID,
						At2006.ObjectID,
						AT1202.ObjectName,
						AT1302.Notes01,
						AT1302.Notes02,
						AT1302.Notes03,AT2007.DivisionID, AT2007.ConvertedUnitID,
						AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
						(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
						A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
						A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
						AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
						O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
						O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID '	
							
				SET @sSQlUnionFrom = ' 
					FROM AT1302 WITH (NOLOCK) 	
					LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
					INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
					LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID
					LEFT JOIN AV7019 on AV7019.InventoryID = AT2007.InventoryID AND AV7019.DivisionID = AT2007.DivisionID AND
									Isnull(AV7019.S01ID,'''') = Isnull(O99.S01ID,'''') AND
									Isnull(AV7019.S02ID,'''') = Isnull(O99.S02ID,'''') AND
									Isnull(AV7019.S03ID,'''') = Isnull(O99.S03ID,'''') AND
									Isnull(AV7019.S04ID,'''') = Isnull(O99.S04ID,'''') AND
									Isnull(AV7019.S05ID,'''') = Isnull(O99.S05ID,'''') AND
									Isnull(AV7019.S06ID,'''') = Isnull(O99.S06ID,'''') AND
									Isnull(AV7019.S07ID,'''') = Isnull(O99.S07ID,'''') AND
									Isnull(AV7019.S08ID,'''') = Isnull(O99.S08ID,'''') AND
									Isnull(AV7019.S09ID,'''') = Isnull(O99.S09ID,'''') AND
									Isnull(AV7019.S10ID,'''') = Isnull(O99.S10ID,'''') AND
									Isnull(AV7019.S11ID,'''') = Isnull(O99.S11ID,'''') AND
									Isnull(AV7019.S12ID,'''') = Isnull(O99.S12ID,'''') AND
									Isnull(AV7019.S13ID,'''') = Isnull(O99.S13ID,'''') AND
									Isnull(AV7019.S14ID,'''') = Isnull(O99.S14ID,'''') AND
									Isnull(AV7019.S15ID,'''') = Isnull(O99.S15ID,'''') AND
									Isnull(AV7019.S16ID,'''') = Isnull(O99.S16ID,'''') AND
									Isnull(AV7019.S17ID,'''') = Isnull(O99.S17ID,'''') AND
									Isnull(AV7019.S18ID,'''') = Isnull(O99.S18ID,'''') AND
									Isnull(AV7019.S19ID,'''') = Isnull(O99.S19ID,'''') AND
									Isnull(AV7019.S20ID,'''') = Isnull(O99.S20ID,'''')
					INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = ( CASE WHEN KindVoucherID = 3 Then AT2006.WareHouseID2  Else AT2006.WareHouseID end)
					LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
					LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
					'

				SET @sSQlUnionWhere = ' 
					WHERE	AT2007.DivisionID = N''' + @DivisionID + '''  ' +
							(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
							AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
							AT2006.TranMonth + 100*AT2006.TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' AND
							(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
							( (KindVoucherID in ' + @KindVoucherListEx2 + '  AND 
							AT2006.WareHouseID in (Select WareHouseID from TBL_WareHouseIDAP2021)) or  ( KindVoucherID = 3 AND WareHouseID2 in (Select WareHouseID from TBL_WareHouseIDAP2021))) '
			   END
			ELSE
			   BEGIN
					SET @sSQlSelect = N'
				--- Phan Nhap kho
				SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
						N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
						AT2007.VoucherID,
						AT2007.TransactionID,
						AT2007.Orders,
						VoucherDate,
						VoucherNo,	
						VoucherDate AS ImVoucherDate,
						VoucherNo AS ImVoucherNo,		
						SourceNo AS ImSourceNo,
						LimitDate AS ImLimitDate,	
 						AT2006.WareHouseID AS ImWareHouseID,		
						AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
						AT2007.ActualQuantity AS ImQuantity,
						AT2007.UnitPrice AS ImUnitPrice ,
						AT2007.ConvertedAmount AS ImConvertedAmount,
						AT2007.OriginalAmount AS ImOriginalAmount,
						AT2007.ConvertedQuantity AS ImConvertedQuantity,
						Null AS ExVoucherDate,
						Null AS ExVoucherNo,		
						Null AS ExSourceNo,
						Null AS ExLimitDate,	
 						Null AS ExWareHouseID,		
						Null AS ExRefNo01 , Null AS ExRefNo02 , 
						0 AS ExQuantity,
						Null AS ExUnitPrice ,
						0 AS ExConvertedAmount,
						0 AS ExOriginalAmount,
						0 AS ExConvertedQuantity,
						VoucherTypeID,
						AT2006.Description,
						AT2007.Notes,
						AT2007.InventoryID,	
						AT1302.InventoryName,
						AT2007.UnitID,		
						isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
						isnull(AV7019.BeginQuantity,0) AS BeginQuantity,
						isnull(AV7019.BeginAmount,0) AS BeginAmount,
						isnull(AV7019.BeginConvertedQuantity,0) AS BeginConvertedQuantity,
						(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
						AT2007.DebitAccountID, AT2007.CreditAccountID,
						At2006.ObjectID,
						AT1202.ObjectName,
						AT1302.Notes01,
						AT1302.Notes02,
						AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
						AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
						(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
						A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
						A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
						AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
						O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
						O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID  '
				
				SET @sSQlFrom = ' 
					FROM AT1302 WITH (NOLOCK)	
					LEFT JOIN AT2007  WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
					INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND At2006.DivisionID = AT2007.DivisionID
					LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID
					LEFT JOIN AV7019 on AV7019.InventoryID = AT2007.InventoryID AND AV7019.DivisionID = AT2007.DivisionID AND
										Isnull(AV7019.S01ID,'''') = Isnull(O99.S01ID,'''') AND
										Isnull(AV7019.S02ID,'''') = Isnull(O99.S02ID,'''') AND
										Isnull(AV7019.S03ID,'''') = Isnull(O99.S03ID,'''') AND
										Isnull(AV7019.S04ID,'''') = Isnull(O99.S04ID,'''') AND
										Isnull(AV7019.S05ID,'''') = Isnull(O99.S05ID,'''') AND
										Isnull(AV7019.S06ID,'''') = Isnull(O99.S06ID,'''') AND
										Isnull(AV7019.S07ID,'''') = Isnull(O99.S07ID,'''') AND
										Isnull(AV7019.S08ID,'''') = Isnull(O99.S08ID,'''') AND
										Isnull(AV7019.S09ID,'''') = Isnull(O99.S09ID,'''') AND
										Isnull(AV7019.S10ID,'''') = Isnull(O99.S10ID,'''') AND
										Isnull(AV7019.S11ID,'''') = Isnull(O99.S11ID,'''') AND
										Isnull(AV7019.S12ID,'''') = Isnull(O99.S12ID,'''') AND
										Isnull(AV7019.S13ID,'''') = Isnull(O99.S13ID,'''') AND
										Isnull(AV7019.S14ID,'''') = Isnull(O99.S14ID,'''') AND
										Isnull(AV7019.S15ID,'''') = Isnull(O99.S15ID,'''') AND
										Isnull(AV7019.S16ID,'''') = Isnull(O99.S16ID,'''') AND
										Isnull(AV7019.S17ID,'''') = Isnull(O99.S17ID,'''') AND
										Isnull(AV7019.S18ID,'''') = Isnull(O99.S18ID,'''') AND
										Isnull(AV7019.S19ID,'''') = Isnull(O99.S19ID,'''') AND
										Isnull(AV7019.S20ID,'''') = Isnull(O99.S20ID,'''')
					INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2006.WareHouseID
					LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
					LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
					LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
					LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
					LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
					LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
					LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
					LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
					LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
					LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
					LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''	
					'
				
				SET @sSQlWhere = ' 
					WHERE	AT2007.DivisionID = N''' + @DivisionID + '''  ' +
							(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
							(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) Between ''' + CONVERT(varchar(10) , @FromDate , 101) + ''' AND ''' + CONVERT(varchar(10) , @ToDate , 101) + ''' ) AND
							KindVoucherID in ' + @KindVoucherListIm + ' AND
							(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
							AT2006.WareHouseID IN (Select WareHouseID from TBL_WareHouseIDAP2021)'

				SET @sSQlUnionSelect = ' 
					UNION
				--- Phan Xuat kho
					SELECT  ' + @WareHouseID1 + ' AS WareHouseID,
							N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
							AT2007.VoucherID,
							AT2007.TransactionID,
							AT2007.Orders,
							VoucherDate,
							VoucherNo,	
							Null AS ImVoucherDate,
							Null AS ImVoucherNo,		
							Null AS ImSourceNo,
							Null AS ImLimitDate,	
 							Null AS ExWareHouseID,	
							Null AS ImRefNo01 , Null AS ImRefNo02 , 
							0 AS ImQuantity,
							Null AS ImUnitPrice ,
							0 AS ImConvertedAmount,
							0 AS ImOriginalAmount,
							0 AS ImConvertedQuantity,
							VoucherDate AS ExVoucherDate,
							VoucherNo AS ExVoucherNo,		
							SourceNo AS ExSourceNo,
							LimitDate AS ExLimitDate,	
 							(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
							AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
							AT2007.ActualQuantity AS ExQuantity,
							AT2007.UnitPrice AS ExUnitPrice ,
							AT2007.ConvertedAmount AS ExConvertedAmount,
							AT2007.OriginalAmount AS ExOriginalAmount,
							AT2007.ConvertedQuantity AS ExConvertedQuantity,
							VoucherTypeID,
							AT2006.Description,
							AT2007.Notes,
							AT2007.InventoryID,	
							AT1302.InventoryName,
							AT2007.UnitID,
							isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
							isnull(AV7019.BeginQuantity,0) AS BeginQuantity,
							isnull(AV7019.BeginAmount,0) AS BeginAmount,
							isnull(AV7019.BeginConvertedQuantity,0) AS BeginConvertedQuantity,
							2 AS ImExOrders,
							AT2007.DebitAccountID, AT2007.CreditAccountID,
							At2006.ObjectID,
							AT1202.ObjectName,
							AT1302.Notes01,
							AT1302.Notes02,
							AT1302.Notes03,AT2007.DivisionID, AT2007.ConvertedUnitID,
							AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
							(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
							A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
							A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
							AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
							O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
							O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID '	
							
					SET @sSQlUnionFrom = ' 
						FROM AT1302 WITH (NOLOCK) 	
						LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.DivisionID IN (AT2007.DivisionID,''@@@'') AND AT1302.InventoryID = AT2007.InventoryID
						INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
						LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = AT2007.DivisionID AND O99.VoucherID = AT2007.VoucherID AND O99.TransactionID = AT2007.TransactionID
						LEFT JOIN AV7019 on AV7019.InventoryID = AT2007.InventoryID AND AV7019.DivisionID = AT2007.DivisionID AND
										Isnull(AV7019.S01ID,'''') = Isnull(O99.S01ID,'''') AND
										Isnull(AV7019.S02ID,'''') = Isnull(O99.S02ID,'''') AND
										Isnull(AV7019.S03ID,'''') = Isnull(O99.S03ID,'''') AND
										Isnull(AV7019.S04ID,'''') = Isnull(O99.S04ID,'''') AND
										Isnull(AV7019.S05ID,'''') = Isnull(O99.S05ID,'''') AND
										Isnull(AV7019.S06ID,'''') = Isnull(O99.S06ID,'''') AND
										Isnull(AV7019.S07ID,'''') = Isnull(O99.S07ID,'''') AND
										Isnull(AV7019.S08ID,'''') = Isnull(O99.S08ID,'''') AND
										Isnull(AV7019.S09ID,'''') = Isnull(O99.S09ID,'''') AND
										Isnull(AV7019.S10ID,'''') = Isnull(O99.S10ID,'''') AND
										Isnull(AV7019.S11ID,'''') = Isnull(O99.S11ID,'''') AND
										Isnull(AV7019.S12ID,'''') = Isnull(O99.S12ID,'''') AND
										Isnull(AV7019.S13ID,'''') = Isnull(O99.S13ID,'''') AND
										Isnull(AV7019.S14ID,'''') = Isnull(O99.S14ID,'''') AND
										Isnull(AV7019.S15ID,'''') = Isnull(O99.S15ID,'''') AND
										Isnull(AV7019.S16ID,'''') = Isnull(O99.S16ID,'''') AND
										Isnull(AV7019.S17ID,'''') = Isnull(O99.S17ID,'''') AND
										Isnull(AV7019.S18ID,'''') = Isnull(O99.S18ID,'''') AND
										Isnull(AV7019.S19ID,'''') = Isnull(O99.S19ID,'''') AND
										Isnull(AV7019.S20ID,'''') = Isnull(O99.S20ID,'''')
						INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = ( CASE WHEN KindVoucherID = 3 Then AT2006.WareHouseID2  Else AT2006.WareHouseID end)
						LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT2006.ObjectID
						LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
						LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
						LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
						LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
						LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
						LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
						LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
						LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
						LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
						LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
						'

					SET @sSQlUnionWhere = ' 
						WHERE	AT2007.DivisionID = N''' + @DivisionID + '''  ' +
								(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
								AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
								(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) Between ''' + CONVERT(varchar(10) , @FromDate , 101) + ''' AND ''' + CONVERT(varchar(10) , @ToDate , 101) + ''' ) AND
								(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
								( (KindVoucherID in ' + @KindVoucherListEx2 + '  AND 
								AT2006.WareHouseID IN (Select WareHouseID from TBL_WareHouseIDAP2021)) or  (KindVoucherID = 3 AND WareHouseID2 IN (Select WareHouseID from TBL_WareHouseIDAP2021))) '
				   END	 


				 --PRINT 'aa' + @sSQLSelect + @sSQlFrom + @sSQlWhere
				 --PRINT @sSQlUnionSelect + @sSQlUnionFrom + @sSQlUnionWhere

		--Edit by Nguyen Quoc Huy

		--print @sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere
		
		print @sSQLSelect
		print @sSQlFrom
		print @sSQlWhere
		print @sSQlUnionSelect
		print @sSQlUnionFrom
		print @sSQlUnionWhere
		

		IF NOT EXISTS ( SELECT 1 FROM SysObjects WITH (NOLOCK) WHERE Xtype = 'V' AND Name = 'AV2021' )
		   BEGIN
				 EXEC ( 'CREATE VIEW AV2021--CREATED BY AP2021
							AS '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
		   END
		ELSE
		   BEGIN
				 EXEC ( 'ALTER VIEW AV2021 --CREATED BY AP2021
							as '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
		   END
		 
		--- Lay du su va phat sinh
		SET @sSQLSelect = N' 
			SELECT	AV2021.WareHouseID, AV2021.WareHouseName, AV2021.VoucherID, AV2021.TransactionID, AV2021.Orders,
					DATEADD(d, 0, DATEDIFF(d, 0, AV2021.VoucherDate)) AS VoucherDate, AV2021.VoucherNo, AV2021.ImVoucherDate, AV2021.ImVoucherNo, AV2021.ImSourceNo,
					AV2021.ImLimitDate, AV2021.ImWareHouseID, 
					AV2021.ImRefNo01, AV2021.ImRefNo02,
					AV2021.ImQuantity, AV2021.ImUnitPrice, AV2021.ImConvertedAmount,
					AV2021.ImOriginalAmount, AV2021.ImConvertedQuantity,  
					AV2021.ExVoucherDate, AV2021.ExVoucherNo, AV2021.ExSourceNo,
					AV2021.ExLimitDate, AV2021.ExWareHouseID, 
					AV2021.ExRefNo01, AV2021.ExRefNo02,
					AV2021.ExQuantity, AV2021.ExUnitPrice, AV2021.ExConvertedAmount,
					AV2021.ExOriginalAmount, AV2021.ExConvertedQuantity, AV2021.VoucherTypeID, AV2021.Description,
					AV2021.Notes, AV2021.InventoryID, AV2021.InventoryName, AV2021.UnitID,  AT1304.UnitName, AV2021.ConversionFactor,
					AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
					AV2021.BeginQuantity, AV2021.BeginAmount, AV2021.BeginConvertedQuantity, AV2021.ImExOrders, AV2021.DebitAccountID, AV2021.CreditAccountID,
					AV2021.ObjectID, AV2021.ObjectName, AV2021.Notes01, AV2021.Notes02, AV2021.Notes03, AV2021.DivisionID,
					AV2021.Ana01ID, AV2021.Ana02ID, AV2021.Ana03ID, AV2021.Ana04ID, AV2021.Ana05ID, AV2021.Ana06ID, AV2021.Ana07ID, AV2021.Ana08ID, AV2021.Ana09ID, AV2021.Ana10ID ,
					AV2021.Ana01Name, AV2021.Ana02Name, AV2021.Ana03Name, AV2021.Ana04Name, AV2021.Ana05Name, AV2021.Ana06Name, AV2021.Ana07Name, AV2021.Ana08Name, AV2021.Ana09Name, AV2021.Ana10Name ,
					AV2021.InvoiceNo, AV2021.ConvertedUnitID,
					AV2021.Parameter01,AV2021.Parameter02,AV2021.Parameter03,AV2021.Parameter04,AV2021.Parameter05,
					AV2021.S01ID,AV2021.S02ID,AV2021.S03ID,AV2021.S04ID,AV2021.S05ID,AV2021.S06ID,AV2021.S07ID,AV2021.S08ID,AV2021.S09ID,AV2021.S10ID,
					AV2021.S11ID,AV2021.S12ID,AV2021.S13ID,AV2021.S14ID,AV2021.S15ID,AV2021.S16ID,AV2021.S17ID,AV2021.S18ID,AV2021.S19ID,AV2021.S20ID,
					A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
					A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
					A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
					A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
					A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
					a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
					a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20 
					'
				
			SET @sSQlSelect1 = N'		
			FROM	AV2021
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = AV2021.DivisionID
			LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV2021.UnitID
			LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV2021.InventoryID AND AT1309.UnitID = AV2021.UnitID
			LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV2021.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
			LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV2021.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
			LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV2021.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
			LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV2021.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
			LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV2021.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
			LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV2021.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
			LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV2021.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
			LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV2021.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
			LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV2021.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
			LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV2021.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
			LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV2021.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
			LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV2021.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
			LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV2021.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
			LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV2021.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
			LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV2021.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
			LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV2021.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
			LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV2021.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
			LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV2021.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
			LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV2021.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
			LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV2021.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
			WHERE	AV2021.BeginQuantity <> 0 or AV2021.BeginAmount <> 0 or AV2021.ImQuantity <> 0 or
					AV2021.ImConvertedAmount <> 0 or AV2021.ExQuantity <> 0 or AV2021.ExConvertedAmount <> 0 
			'
		SET @sSQlUnionSelect = N' 
			UNION ALL
			SELECT  AV7019.WareHouseID  AS WareHouseID, AV7019.WareHouseName AS WareHouseName, Null AS VoucherID, Null AS TransactionID, 
					Null AS Orders,null AS VoucherDate, null AS VoucherNo, null AS ImVoucherDate, null AS ImVoucherNo, 
					null AS ImSourceNo,null AS ImLimitDate, null AS ImWareHouseID,
    				Null AS ImRefNo01, Null AS  ImRefNo02,

					0 AS ImQuantity, 0 AS ImUnitPrice, 0 AS ImConvertedAmount,
					0 AS ImOriginalAmount, 0 AS ImConvertedQuantity,   0 AS ExVoucherDate, null AS ExVoucherNo, 
					null AS ExSourceNo, null AS ExLimitDate, null AS ExWareHouseID, 
					Null AS ExRefNo01, Null AS  ExRefNo02,
					0 AS ExQuantity, 0 AS ExUnitPrice, 
					0 AS ExConvertedAmount,0 AS ExOriginalAmount, 0 AS ExConvertedQuantity, 
        			null AS VoucherTypeID, null AS Description,null AS Notes, 
					AV7019.InventoryID, AV7019.InventoryName, AV7019.UnitID, AT1304.UnitName, 1 AS ConversionFactor,
					AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
					AV7019.BeginQuantity, AV7019.BeginAmount, AV7019.BeginConvertedQuantity, 0 AS ImExOrders,NULL AS DebitAccountID, NULL AS CreditAccountID,
					null AS ObjectID,  null AS ObjectName,null AS Notes01, Null AS Notes02, Null AS Notes03, AV7019.DivisionID,
					NULL AS Ana01ID, NULL AS Ana02ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID,
					NULL as Ana01Name, NULL as Ana02Name, NULL as Ana03Name, NULL as Ana04Name, NULL as Ana05Name, NULL as Ana06Name, NULL as Ana07Name, NULL as Ana08Name, NULL as Ana09Name, NULL as Ana10Name , 
					NULL AS InvoiceNo, NULL AS ConvertedUnitID,
					NULL as Parameter01,NULL as Parameter02,NULL as Parameter03,NULL as Parameter04,NULL as Parameter05,
					AV7019.S01ID,AV7019.S02ID,AV7019.S03ID,AV7019.S04ID,AV7019.S05ID,AV7019.S06ID,AV7019.S07ID,AV7019.S08ID,AV7019.S09ID,AV7019.S10ID,
					AV7019.S11ID,AV7019.S12ID,AV7019.S13ID,AV7019.S14ID,AV7019.S15ID,AV7019.S16ID,AV7019.S17ID,AV7019.S18ID,AV7019.S19ID,AV7019.S20ID,
					A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
					A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
					A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
					A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
					A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
					a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
					a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20
					'
					
			SET @sSQlUnionSelect1 = N'		
			FROM	AV7019 
			FULL JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = AV7019.DivisionID
			INNER JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV7019.UnitID
			LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV7019.InventoryID AND AT1309.UnitID = AV7019.UnitID
			LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV7019.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
			LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV7019.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
			LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV7019.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
			LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV7019.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
			LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV7019.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
			LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV7019.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
			LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV7019.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
			LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV7019.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
			LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV7019.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
			LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV7019.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
			LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV7019.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
			LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV7019.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
			LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV7019.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
			LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV7019.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
			LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV7019.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
			LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV7019.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
			LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV7019.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
			LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV7019.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
			LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV7019.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
			LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV7019.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
			'
			SET @sSQlUnionSelect2 = '
			LEFT JOIN AV2021 ON AV7019.DivisionID = AV2021.DivisionID AND AV2021.InventoryID = AV7019.InventoryID AND 
										Isnull(AV7019.S01ID,'''') = Isnull(AV2021.S01ID,'''') AND
										Isnull(AV7019.S02ID,'''') = Isnull(AV2021.S02ID,'''') AND
										Isnull(AV7019.S03ID,'''') = Isnull(AV2021.S03ID,'''') AND
										Isnull(AV7019.S04ID,'''') = Isnull(AV2021.S04ID,'''') AND
										Isnull(AV7019.S05ID,'''') = Isnull(AV2021.S05ID,'''') AND
										Isnull(AV7019.S06ID,'''') = Isnull(AV2021.S06ID,'''') AND
										Isnull(AV7019.S07ID,'''') = Isnull(AV2021.S07ID,'''') AND
										Isnull(AV7019.S08ID,'''') = Isnull(AV2021.S08ID,'''') AND
										Isnull(AV7019.S09ID,'''') = Isnull(AV2021.S09ID,'''') AND
										Isnull(AV7019.S10ID,'''') = Isnull(AV2021.S10ID,'''') AND
										Isnull(AV7019.S11ID,'''') = Isnull(AV2021.S11ID,'''') AND
										Isnull(AV7019.S12ID,'''') = Isnull(AV2021.S12ID,'''') AND
										Isnull(AV7019.S13ID,'''') = Isnull(AV2021.S13ID,'''') AND
										Isnull(AV7019.S14ID,'''') = Isnull(AV2021.S14ID,'''') AND
										Isnull(AV7019.S15ID,'''') = Isnull(AV2021.S15ID,'''') AND
										Isnull(AV7019.S16ID,'''') = Isnull(AV2021.S16ID,'''') AND
										Isnull(AV7019.S17ID,'''') = Isnull(AV2021.S17ID,'''') AND
										Isnull(AV7019.S18ID,'''') = Isnull(AV2021.S18ID,'''') AND
										Isnull(AV7019.S19ID,'''') = Isnull(AV2021.S19ID,'''') AND
										Isnull(AV7019.S20ID,'''') = Isnull(AV2021.S20ID,'''')
			WHERE AV2021.DivisionID IS NULL  AND (AV7019.BeginQuantity<>0 or AV7019.BeginAmount<>0)
		 '

		 --PRINT @sSQlSelect
		 --PRINT @sSQlSelect1
		 --PRINT @sSQlUnionSelect
		 --PRINT @sSQlUnionSelect1                  
		 --PRINT @sSQlUnionSelect2   
		 
		EXEC (@sSQLSelect + @sSQLSelect1 + @sSQlUnionSelect + @sSQlUnionSelect1 + @sSQlUnionSelect2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
