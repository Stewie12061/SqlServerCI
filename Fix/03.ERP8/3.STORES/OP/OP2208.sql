IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2208]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP2208]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







---Created by:Nguyen Thi Thuy Tuyen, date:07/11/2006
---purpose: Ke thua tu yeu cau mua hang  cho don hang mua.
---Last EDit ThuyTuyen 01/06/2006
/********************************************
'* Edited by: [GS] [Tố Oanh] [02/08/2010]
'********************************************/
---Last Edit Mai Duyen 04/03/2014 : Sua lai khai bao chieu dai cua @lstROrderID 
--- Modified by Tiểu Mai on 19/11/2015: Bổ sung thông tin quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
--- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
--- Modified by Trà Giang on 23/05/2019: Thêm trường tên quy cách 
--- Modified by Trà Giang on 09/07/2019: Thêm trường DataType, ConversionFactor, Operator
--- Modified on 28/02/2020 by Tuấn Anh : Bổ sung điều kiện OT3102.Finish => Check dòng hoàn tất
--- Modified on 05/03/2020 by Văn Minh : Fix lỗi OT3102.Finish cound not be bound.
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
CREATE PROCEDURE [dbo].[OP2208]  @DivisionID nvarchar(50),
				@lstROrderID nvarchar(2000)
AS
Declare @sSQL  nvarchar(max),
		@sSQL1  nvarchar(max),
		@sSQL2  nvarchar(max)

Set  @lstROrderID = 	Replace(@lstROrderID, ',', ''',''')
--- Print @lstROrderID

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sSQL = '
	Select OT3101.DivisionID, TranMonth, TranYear,
	OT3102.ROrderID, OT3101.OrderStatus, OT3102.TransactionID,
	OT3102.InventoryID, OrderQuantity,  ----OT3001.OrderQuantity as ActualQuantity, 
	case when OT3102.Finish = 1 then NULL else isnull(OT3102.OrderQuantity,0) - isnull(ActualQuantity, 0) end as EndQuantity,
	case when OT3102.Finish = 1 then NULL else isnull(OT3102.ConvertedQuantity,0) - isnull(ActualCQuantity, 0) end as EndCQuantity,
	O89.S01ID, O89.S02ID, O89.S03ID, O89.S04ID, O89.S05ID, O89.S06ID, O89.S07ID, O89.S08ID, O89.S09ID, O89.S10ID,
	O89.S11ID, O89.S12ID, O89.S13ID, O89.S14ID, O89.S15ID, O89.S16ID, O89.S17ID, O89.S18ID, O89.S19ID, O89.S20ID,AT1309.DataType,AT1309.ConversionFactor, AT1309.Operator

From OT3102 WITH (NOLOCK) inner join OT3101 WITH (NOLOCK) on OT3102.ROrderID = OT3101.ROrderID
	LEFT JOIN OT8899 O89 WITH (NOLOCK) ON O89.DivisionID = OT3102.DivisionID AND O89.VoucherID = OT3102.ROrderID AND O89.TransactionID = OT3102.TransactionID AND O89.TableID = ''OT3102''
	LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = OT3102.InventoryID and AT1309.DivisionID  =  OT3102.DivisionID
	left join 	(Select OT3001.DivisionID, OT3002.ROrderID, isnull (OT3002.RefTransactionID,'''' ) as RefTransactionID,
			OT3002.InventoryID, sum(OT3002.OrderQuantity) As ActualQuantity, Sum(Isnull(ConvertedQuantity,0)) As ActualCQuantity,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		From OT3002 WITH (NOLOCK) 
		inner join OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID
		LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT3002.DivisionID AND O99.VoucherID = OT3002.POrderID AND O99.TransactionID = OT3002.TransactionID AND O99.TableID = ''OT3002''
		Where isnull (OT3002.RefTransactionID,'''' ) <> '' ''
		AND ISNULL(OT3002.Finish,0) = 0
		Group by OT3001.DivisionID, OT3002.ROrderID, InventoryID,OT3002.RefTransactionID,
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID) as G  --- (co nghia la Nhan hang)
					on 	OT3101.DivisionID = G.DivisionID and
						----OT3102.ROrderID = G.ROrderID and
						OT3102.InventoryID = G.InventoryID and
						OT3102.TransactionID = isnull(G.RefTransactionID,'''') AND
						ISNULL(O89.S01ID,'''') = Isnull(G.S01ID,'''') AND 
						ISNULL(O89.S02ID,'''') = Isnull(G.S02ID,'''') AND
						ISNULL(O89.S03ID,'''') = Isnull(G.S03ID,'''') AND
						ISNULL(O89.S04ID,'''') = Isnull(G.S04ID,'''') AND
						ISNULL(O89.S05ID,'''') = Isnull(G.S05ID,'''') AND 
						ISNULL(O89.S06ID,'''') = Isnull(G.S06ID,'''') AND
						ISNULL(O89.S07ID,'''') = Isnull(G.S07ID,'''') AND
						ISNULL(O89.S08ID,'''') = Isnull(G.S08ID,'''') AND
						ISNULL(O89.S09ID,'''') = Isnull(G.S09ID,'''') AND
						ISNULL(O89.S10ID,'''') = Isnull(G.S10ID,'''') AND
						ISNULL(O89.S11ID,'''') = Isnull(G.S11ID,'''') AND 
						ISNULL(O89.S12ID,'''') = Isnull(G.S12ID,'''') AND
						ISNULL(O89.S13ID,'''') = Isnull(G.S13ID,'''') AND
						ISNULL(O89.S14ID,'''') = Isnull(G.S14ID,'''') AND
						ISNULL(O89.S15ID,'''') = Isnull(G.S15ID,'''') AND
						ISNULL(O89.S16ID,'''') = Isnull(G.S16ID,'''') AND
						ISNULL(O89.S17ID,'''') = Isnull(G.S17ID,'''') AND
						ISNULL(O89.S18ID,'''') = Isnull(G.S18ID,'''') AND
						ISNULL(O89.S19ID,'''') = Isnull(G.S19ID,'''') AND
						ISNULL(O89.S20ID,'''') = Isnull(G.S20ID,'''')
			'
		--PRINT @sSQL
	If not exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'OV29051')
	EXEC('Create view OV29051 ----tao boi OP2208
			as ' + @sSQL)
	Else	
	EXEC('Alter view OV29051 ----tao boi OP2208
			as ' + @sSQL)
			
	BEGIN				
	Set @sSQL1 ='
	Select Distinct OT3102.DivisionID, 
		OT3102.ROrderID, 
		OT3102.TransactionID, 
		OT3102.InventoryID, 
		case when isnull(OT3102.InventoryCommonName,'''') = ''''  then AT1302.InventoryName else OT3102.InventoryCommonName end as 
		InventoryName, 			
		Isnull(OT3102.UnitID,AT1302.UnitID) as  UnitID,
		OV29051.EndQuantity as OrderQuantity, 
		RequestPrice, 
		ConvertedAmount, 
		OriginalAmount, 
		VATConvertedAmount, 
		VATOriginalAmount, 
		OT3102.VATPercent, 
		DiscountConvertedAmount,  
		DiscountOriginalAmount,
		OT3102.Ana01ID,
		OT3102.Ana02ID,
		OT3102.Ana03ID,
		OT3102.Ana04ID,
		OT3102.Ana05ID,
		OT3102.Ana06ID,
		OT3102.Ana07ID,
		OT3102.Ana08ID,
		OT3102.Ana09ID,
		OT3102.Ana10ID,
		OT3102.DiscountPercent,
		OT3102.Orders, 				
		OT3102.Notes,
		OT3102.Notes01,
		OT3102.Notes02,
		OT3101.ConTractNo,OV29051.EndCQuantity as ConvertedQuantity, OT3102.ConvertedSalePrice,
		OT3102.Parameter01, OT3102.Parameter02, OT3102.Parameter03, OT3102.Parameter04, OT3102.Parameter05,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
		AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
		AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
		AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
		AT1309.DataType	,AT1309.ConversionFactor, AT1309.Operator	
			From OT3102 WITH (NOLOCK) 
			left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3102.DivisionID) AND AT1302.InventoryID= OT3102.InventoryID
	        Left Join OT3101 WITH (NOLOCK) on OT3101.ROrderID  =  OT3102.ROrderID	AND OT3101.DivisionID  =  OT3102.DivisionID
	        Left join OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT3102.DivisionID AND O99.VoucherID = OT3102.ROrderID AND O99.TransactionID = OT3102.TransactionID AND O99.TableID = ''OT3102''
			LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = OT3102.InventoryID and AT1309.DivisionID  =  OT3102.DivisionID
			Inner Join OV29051 on	OV29051.ROrderID  =  OT3102.ROrderID  AND OV29051.DivisionID  =  OT3102.DivisionID
									and OT3102.TransactionID = OV29051.TransactionID AND OT3102.DivisionID = OV29051.DivisionID AND
									ISNULL(O99.S01ID,'''') = ISNULL(OV29051.S01ID,'''') AND 
									ISNULL(O99.S02ID,'''') = ISNULL(OV29051.S02ID,'''') AND
									ISNULL(O99.S03ID,'''') = ISNULL(OV29051.S03ID,'''') AND
									ISNULL(O99.S04ID,'''') = ISNULL(OV29051.S04ID,'''') AND
									ISNULL(O99.S05ID,'''') = ISNULL(OV29051.S05ID,'''') AND 
									ISNULL(O99.S06ID,'''') = ISNULL(OV29051.S06ID,'''') AND
									ISNULL(O99.S07ID,'''') = ISNULL(OV29051.S07ID,'''') AND
									ISNULL(O99.S08ID,'''') = ISNULL(OV29051.S08ID,'''') AND
									ISNULL(O99.S09ID,'''') = ISNULL(OV29051.S09ID,'''') AND
									ISNULL(O99.S10ID,'''') = ISNULL(OV29051.S10ID,'''') AND
									ISNULL(O99.S11ID,'''') = ISNULL(OV29051.S11ID,'''') AND 
									ISNULL(O99.S12ID,'''') = ISNULL(OV29051.S12ID,'''') AND
									ISNULL(O99.S13ID,'''') = ISNULL(OV29051.S13ID,'''') AND
									ISNULL(O99.S14ID,'''') = ISNULL(OV29051.S14ID,'''') AND
									ISNULL(O99.S15ID,'''') = ISNULL(OV29051.S15ID,'''') AND
									ISNULL(O99.S16ID,'''') = ISNULL(OV29051.S16ID,'''') AND
									ISNULL(O99.S17ID,'''') = ISNULL(OV29051.S17ID,'''') AND
									ISNULL(O99.S18ID,'''') = ISNULL(OV29051.S18ID,'''') AND
									ISNULL(O99.S19ID,'''') = ISNULL(OV29051.S19ID,'''') AND
									ISNULL(O99.S20ID,'''') = ISNULL(OV29051.S20ID,'''')'
	SET @sSQL2 ='
		LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = O99.S01ID AND AT01.StandardTypeID = ''S01''
		LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = O99.S02ID AND AT02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = O99.S03ID AND AT03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = O99.S04ID AND AT04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = O99.S05ID AND AT05.StandardTypeID = ''S05''
		LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = O99.S06ID AND AT06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = O99.S07ID AND AT07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = O99.S08ID AND AT08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = O99.S09ID AND AT09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = O99.S10ID AND AT10.StandardTypeID = ''S10''
		LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = O99.S11ID AND AT11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = O99.S12ID AND AT12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = O99.S13ID AND AT13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = O99.S15ID AND AT14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = O99.S15ID AND AT15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = O99.S16ID AND AT16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = O99.S17ID AND AT17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = O99.S18ID AND AT18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = O99.S19ID AND AT19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20''
Where OT3101.DivisionID = ''' + @DivisionID + ''' and OT3102.ROrderID in (''' + @lstROrderID + ''')
AND ISNULL(OT3102.Finish,0) = 0
 and OV29051.EndQuantity > 0
'
	END
END
ELSE
	BEGIN
	Set @sSQL1 ='Select Distinct OT3102.DivisionID, 
		OT3102.ROrderID, 
		OT3102.TransactionID, 
		OT3102.InventoryID, 
		case when isnull(OT3102.InventoryCommonName,'''') = ''''  then AT1302.InventoryName else OT3102.InventoryCommonName end as 
		InventoryName, 			
		Isnull(OT3102.UnitID,AT1302.UnitID) as  UnitID,
		OV2905.EndQuantity as OrderQuantity, 
		RequestPrice, 
		ConvertedAmount, 
		OriginalAmount, 
		VATConvertedAmount, 
		VATOriginalAmount, 
		OT3102.VATPercent, 
		DiscountConvertedAmount,  
		DiscountOriginalAmount,
		OT3102.Ana01ID,
		OT3102.Ana02ID,
		OT3102.Ana03ID,
		OT3102.Ana04ID,
		OT3102.Ana05ID,
		OT3102.Ana06ID,
		OT3102.Ana07ID,
		OT3102.Ana08ID,
		OT3102.Ana09ID,
		OT3102.Ana10ID,
		OT3102.DiscountPercent,
		OT3102.Orders, 				
		OT3102.Notes,
		OT3102.Notes01,
		OT3102.Notes02,
		OT3101.ConTractNo,OV2905.EndCQuantity as ConvertedQuantity, OT3102.ConvertedSalePrice,
		OT3102.Parameter01, OT3102.Parameter02, OT3102.Parameter03, OT3102.Parameter04, OT3102.Parameter05,
		'''' as S01ID, '''' as S02ID, '''' as S03ID, '''' as S04ID, '''' as S05ID, '''' as S06ID, '''' as S07ID, '''' as S08ID, '''' as S09ID, '''' as S10ID,
		'''' as S11ID, '''' as S12ID, '''' as S13ID, '''' as S14ID, '''' as S15ID, '''' as S16ID, '''' as S17ID, '''' as S18ID, '''' as S19ID, '''' as S20ID,
		'''' as S01Name, '''' as S02Name, '''' as S03Name, '''' as S04Name, '''' as S05Name,
		'''' as S06Name, '''' as S07Name, '''' as S08Name, '''' as S09Name, '''' as S10Name,
		'''' as S11Name, '''' as S12Name, '''' as S13Name, '''' as S14Name, '''' as S15Name,
		'''' as S16Name, '''' as S17Name, '''' as S18Name, '''' as S19Name, '''' as S20Name,
		AT1309.DataType,AT1309.ConversionFactor, AT1309.Operator
From OT3102 WITH (NOLOCK) 
left join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3102.DivisionID) AND AT1302.InventoryID= OT3102.InventoryID
Left Join OT3101 WITH (NOLOCK) on OT3101.ROrderID  =  OT3102.ROrderID	AND OT3101.DivisionID  =  OT3102.DivisionID
LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = OT3102.InventoryID and AT1309.DivisionID  =  OT3102.DivisionID
Inner Join OV2905 on OV2905.ROrderID  =  OT3102.ROrderID  AND OV2905.DivisionID  =  OT3102.DivisionID
				and OT3102.TransactionID =OV2905.TransactionID AND OT3102.DivisionID =OV2905.DivisionID
Where OT3101.DivisionID = ''' + @DivisionID + ''' and OT3102.ROrderID in (''' + @lstROrderID + ''')
AND ISNULL(OT3102.Finish,0) = 0
 and OV2905.EndQuantity > 0
'
	SET @sSQL2 =N''
	END
	
	--print @sSQL1
	--print @sSQL2
	If not exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'OV2208')
	EXEC('Create view OV2208 ----tao boi OP2208
			as ' + @sSQL1 + @sSQL2)
	Else	
	EXEC('Alter view OV2208 ----tao boi OP2208
			as ' + @sSQL1 + @sSQL2)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
