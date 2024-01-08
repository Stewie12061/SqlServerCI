IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2004_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2004_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by: Vo Thanh Huong, date: 04/11/2004
---purpose: In Tinh hinh thuc hien ke hoach san xuat 

/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [02/08/2010]
--- Modified on 09/09/2015 by Tiểu Mai: Bổ sung 10 mã, tên MPT, 10 tham số chi tiết từ đơn hàng sản xuất
--- Modified by Tiểu Mai on 05/01/2016: Bổ sung thông tin quy cách
--- Modified by Tiểu Mai on 03/03/2016: Bổ sung 20 tên thiết lập quy cách hàng hóa
--- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
--- Modified by Bảo Anh on 26/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
--- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
'********************************************/

--exec MP2004 @DivisionID=N'PC',@PlanID=N'KH/01/2016/0001'
--SELECT * FROM MV2016

CREATE PROCEDURE [dbo].[MP2004_QC] @DivisionID nvarchar(50) , 
				@PlanID nvarchar(50)
AS
Declare @Date01 as datetime, 
		@Date02 as datetime, 
		@Date03 as datetime, 
		@Date04 as datetime, 
		@Date05 as datetime, 
		@Date06 as datetime, 
		@Date07 as datetime, 
		@Date08 as datetime, 
		@Date09 as datetime, 
		@Date10 as datetime, 
		@Date11 as datetime, 
		@Date12 as datetime, 
		@Date13 as datetime, 
		@Date14 as datetime, 
		@Date15 as datetime, 
		@Date16 as datetime, 
		@Date17 as datetime, 
		@Date18 as datetime, 
		@Date19 as datetime, 
		@Date20 as datetime, 
		@Date21 as datetime, 
		@Date22 as datetime, 
		@Date23 as datetime, 
		@Date24 as datetime, 
		@Date25 as datetime, 
		@Date26 as datetime, 
		@Date27 as datetime, 
		@Date28 as datetime, 
		@Date29 as datetime, 
		@Date30 as datetime,
		@Date31 as datetime, 
		@Date32 as datetime, 
		@Date33 as datetime, 
		@Date34 as datetime, 
		@Date35 as datetime, 
		@Date36 as datetime, 
		@Date37 as datetime, 
		@Date38 as datetime, 
		@Date39 as datetime, 
		@Date40 as datetime,
		@sSQL nvarchar(MAX),  
		@VoucherNo nvarchar(50), 
		@VoucherDate DATETIME,
		@sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
		@sSQL3 NVARCHAR(MAX)
SET @sSQL = ''
SET @sSQL1 = ''
SET @sSQL2 = ''
SET @sSQL3 = ''

Select @VoucherNo = VoucherNo, @VoucherDate = VoucherDate 
	From MT2001 Where PlanID = @PlanID

Select    @Date01 = Date01,  @Date02 = Date02, @Date03 = Date03, @Date04 = Date04, @Date05 = Date05,
		  @Date06 = Date06,  @Date07 = Date07, @Date08 = Date08, @Date09 = Date09, @Date10 = Date10,
		  @Date11 = Date11,  @Date12 = Date12, @Date13 = Date13, @Date14 = Date14, @Date15 = Date15,
		  @Date16 = Date16,  @Date17 = Date17, @Date18 = Date18, @Date19 = Date19, @Date20 = Date20,
		  @Date21 = Date21,  @Date22 = Date22, @Date23 = Date23, @Date24 = Date24, @Date25 = Date25,
		  @Date26 = Date26,  @Date27 = Date27, @Date28 = Date28, @Date29 = Date29, @Date30 = Date30,
		  @Date31 = Date31,  @Date32 = Date32, @Date33 = Date33, @Date34 = Date34, @Date35 = Date35,
		  @Date36 = Date36,  @Date37 = Date37, @Date38 = Date38, @Date39 = Date39, @Date40 = Date40
From MT2003 Where PlanID = @PlanID

Set @sSQL =  case when isnull(@Date01, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date01, 120) + ''' as Dates, 1 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date02, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date02, 120) + ''' as Dates, 2 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date03, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date03, 120) + ''' as Dates, 3 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date04, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date04, 120) + ''' as Dates, 4 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date05, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date05, 120) + ''' as Dates, 5 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date06, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date06, 120) + ''' as Dates, 6 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date07, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date07, 120) + ''' as Dates, 7 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date08, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date08, 120) + ''' as Dates, 8 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date09, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date09, 120) + ''' as Dates, 9 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date10, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date10, 120) + ''' as Dates, 10 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date11, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date11, 120) + ''' as Dates, 11 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date12, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date12, 120) + ''' as Dates, 12 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date13, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date13, 120) + ''' as Dates, 13 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date14, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date14, 120) + ''' as Dates, 14 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date15, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date15, 120) + ''' as Dates, 15 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date16, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date16, 120) + ''' as Dates, 16 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date17, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date17, 120) + ''' as Dates, 17 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date18, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date18, 120) + ''' as Dates, 18 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date19, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date19, 120) + ''' as Dates, 19 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date20, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date20, 120) + ''' as Dates, 20 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date21, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date21, 120) + ''' as Dates, 21 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date22, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date22, 120) + ''' as Dates, 22 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date23, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date23, 120) + ''' as Dates, 23 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date24, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date24, 120) + ''' as Dates, 24 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date25, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date25, 120) + ''' as Dates, 25 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date26, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date26, 120) + ''' as Dates, 26 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date27, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date27, 120) + ''' as Dates, 27 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date28, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date28, 120) + ''' as Dates, 28 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date29, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date29, 120) + ''' as Dates, 29 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date30, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date30, 120) + ''' as Dates, 30 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date31, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date31, 120) + ''' as Dates, 31 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date32, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date32, 120) + ''' as Dates, 32 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date33, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date33, 120) + ''' as Dates, 33 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date34, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date34, 120) + ''' as Dates, 34 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date35, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date35, 120) + ''' as Dates, 35 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date36, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date36, 120) + ''' as Dates, 36 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date37, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date37, 120) + ''' as Dates, 37 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date38, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date38, 120) + ''' as Dates, 38 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date39, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date39, 120) + ''' as Dates, 39 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end +
			 case when isnull(@Date40, '') = '' then '' else ' Select ''' + convert(nvarchar(20), @Date40, 120) + ''' as Dates, 40 as Times, ''' + @DivisionID + ''' as DivisionID Union ' end 
if len(@sSQL) > 0
begin
Set @sSQL = left(@sSQL, len(@sSQL) - 5)
--PRINT @sSQL
If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'MV2011')
	Drop view MV2011
EXEC('Create view MV2011 ---tao boi MP2004
		 as ' + @sSQL)	

Set @sSQL = 'Select  V00.Dates, V00.Times, T00.InventoryID, A00.InventoryName, A01.UnitName, sum(T00.PlanQuantity) as PlanQuantity, 
			T00.DivisionID,
			sum(case when Times = 1 then T00.Quantity01 
			when Times = 2 then T00.Quantity02 
			when Times = 3 then T00.Quantity03 
			when Times = 4 then T00.Quantity04 
			when Times = 5 then T00.Quantity05 
			when Times = 6 then T00.Quantity06 
			when Times = 7 then T00.Quantity07 
			when Times = 8 then T00.Quantity08 
			when Times = 9 then T00.Quantity09 
			when Times = 10 then T00.Quantity10 
			when Times = 11 then T00.Quantity11 
			when Times = 12 then T00.Quantity12 
			when Times = 13 then T00.Quantity13 
			when Times = 14 then T00.Quantity14 
			when Times = 15 then T00.Quantity15 
			when Times = 16 then T00.Quantity16 
			when Times = 17 then T00.Quantity17 
			when Times = 18 then T00.Quantity18 
			when Times = 19 then T00.Quantity19 
			when Times = 20 then T00.Quantity20 
			when Times = 21 then T00.Quantity21 
			when Times = 22 then T00.Quantity22 
			when Times = 23 then T00.Quantity23 
			when Times = 24 then T00.Quantity24 
			when Times = 25 then T00.Quantity25 
			when Times = 26 then T00.Quantity26 
			when Times = 27 then T00.Quantity27 
			when Times = 28 then T00.Quantity28 
			when Times = 29 then T00.Quantity29 
			when Times = 30 then T00.Quantity30  
			when Times = 31 then T00.Quantity31 
			when Times = 32 then T00.Quantity32 
			when Times = 33 then T00.Quantity33 
			when Times = 34 then T00.Quantity34 
			when Times = 35 then T00.Quantity35 
			when Times = 36 then T00.Quantity36 
			when Times = 37 then T00.Quantity37 
			when Times = 38 then T00.Quantity38 
			when Times = 39 then T00.Quantity39 
			when Times = 40 then T00.Quantity40  end) as Quantity,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
			O02.Ana01ID, O02.Ana02ID, O02.Ana03ID, O02.Ana04ID, O02.Ana05ID,
			O02.Ana06ID, O02.Ana07ID, O02.Ana08ID, O02.Ana09ID, O02.Ana10ID,
			A21.StandardName AS S01Name, A02.StandardName AS S02Name, A03.StandardName AS S03Name, A04.StandardName AS S04Name, A05.StandardName AS S05Name,
			A06.StandardName AS S06Name, A07.StandardName AS S07Name, A08.StandardName AS S08Name, A09.StandardName AS S09Name, A22.StandardName AS S10Name,
			A11.StandardName AS S11Name, A12.StandardName AS S12Name, A13.StandardName AS S13Name, A14.StandardName AS S14Name, A15.StandardName AS S15Name,
			A16.StandardName AS S16Name, A17.StandardName AS S17Name, A18.StandardName AS SName18, A19.StandardName AS S19Name, A20.StandardName AS S20Name,
			A1.AnaName as Ana01Name,
			A2.AnaName as Ana02Name,
			A3.AnaName as Ana03Name,
			A4.AnaName as Ana04Name,
			A5.AnaName as Ana05Name,
			A6.AnaName as Ana06Name,
			A7.AnaName as Ana07Name,
			A8.AnaName as Ana08Name,
			A9.AnaName as Ana09Name,
			A10.AnaName as Ana10Name
		'
SET @sSQL1 = 'From MT2002 T00 WITH (NOLOCK) cross join MV2011 V00 
				inner join AT1302 A00 WITH (NOLOCK) on A00.InventoryID = T00.InventoryID AND A00.DivisionID IN (T00.DivisionID,''@@@'')
				inner join AT1304 A01 WITH (NOLOCK) on A00.UnitID = A01.UnitID AND A00.DivisionID IN (A01.DivisionID,''@@@'')
				LEFT JOIN OT2002 O02 WITH (NOLOCK)  ON O02.DivisionID    = T00.DivisionID AND O02.LinkNo = T00.LinkNo  AND T00.InventoryID = O02.InventoryID
				LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T00.DivisionID AND O99.VoucherID = T00.PlanID AND O99.TransactionID = T00.PlanDetailID
				left join AT1011 A1 WITH (NOLOCK) on A1.AnaTypeID = ''A01'' and A1.AnaID = O02.Ana01ID
				left join AT1011 A2 WITH (NOLOCK) on A2.AnaTypeID = ''A02'' and A2.AnaID = O02.Ana02ID
				left join AT1011 A3 WITH (NOLOCK) on A3.AnaTypeID = ''A03'' and A3.AnaID = O02.Ana03ID
				left join AT1011 A4 WITH (NOLOCK) on A4.AnaTypeID = ''A04'' and A4.AnaID = O02.Ana04ID
				left join AT1011 A5 WITH (NOLOCK) on A5.AnaTypeID = ''A05'' and A5.AnaID = O02.Ana05ID
				left join AT1011 A6 WITH (NOLOCK) on A6.AnaTypeID = ''A06'' and A6.AnaID = O02.Ana06ID
				left join AT1011 A7 WITH (NOLOCK) on A7.AnaTypeID = ''A07'' and A7.AnaID = O02.Ana07ID
				left join AT1011 A8 WITH (NOLOCK) on A8.AnaTypeID = ''A08'' and A8.AnaID = O02.Ana08ID
				left join AT1011 A9 WITH (NOLOCK) on A9.AnaTypeID = ''A09'' and A9.AnaID = O02.Ana09ID
				left join AT1011 A10 WITH (NOLOCK) on A10.AnaTypeID = ''A10'' and A10.AnaID = O02.Ana10ID
						
		'

SET @sSQL2 ='
		LEFT JOIN AT0128 A21 WITH (NOLOCK) ON A21.StandardID = O99.S01ID AND A21.StandardTypeID = ''S01''
		LEFT JOIN AT0128 A02 WITH (NOLOCK) ON A02.StandardID = O99.S02ID AND A02.StandardTypeID = ''S02''
		LEFT JOIN AT0128 A03 WITH (NOLOCK) ON A03.StandardID = O99.S03ID AND A03.StandardTypeID = ''S03''
		LEFT JOIN AT0128 A04 WITH (NOLOCK) ON A04.StandardID = O99.S04ID AND A04.StandardTypeID = ''S04''
		LEFT JOIN AT0128 A05 WITH (NOLOCK) ON A05.StandardID = O99.S05ID AND A05.StandardTypeID = ''S05''
		LEFT JOIN AT0128 A06 WITH (NOLOCK) ON A06.StandardID = O99.S06ID AND A06.StandardTypeID = ''S06''
		LEFT JOIN AT0128 A07 WITH (NOLOCK) ON A07.StandardID = O99.S07ID AND A07.StandardTypeID = ''S07''
		LEFT JOIN AT0128 A08 WITH (NOLOCK) ON A08.StandardID = O99.S08ID AND A08.StandardTypeID = ''S08''
		LEFT JOIN AT0128 A09 WITH (NOLOCK) ON A09.StandardID = O99.S09ID AND A09.StandardTypeID = ''S09''
		LEFT JOIN AT0128 A22 WITH (NOLOCK) ON A22.StandardID = O99.S10ID AND A22.StandardTypeID = ''S10''
		LEFT JOIN AT0128 A11 WITH (NOLOCK) ON A11.StandardID = O99.S11ID AND A11.StandardTypeID = ''S11''
		LEFT JOIN AT0128 A12 WITH (NOLOCK) ON A12.StandardID = O99.S12ID AND A12.StandardTypeID = ''S12''
		LEFT JOIN AT0128 A13 WITH (NOLOCK) ON A13.StandardID = O99.S13ID AND A13.StandardTypeID = ''S13''
		LEFT JOIN AT0128 A14 WITH (NOLOCK) ON A14.StandardID = O99.S14ID AND A14.StandardTypeID = ''S14''
		LEFT JOIN AT0128 A15 WITH (NOLOCK) ON A15.StandardID = O99.S15ID AND A15.StandardTypeID = ''S15''
		LEFT JOIN AT0128 A16 WITH (NOLOCK) ON A16.StandardID = O99.S16ID AND A16.StandardTypeID = ''S16''
		LEFT JOIN AT0128 A17 WITH (NOLOCK) ON A17.StandardID = O99.S17ID AND A17.StandardTypeID = ''S17''
		LEFT JOIN AT0128 A18 WITH (NOLOCK) ON A18.StandardID = O99.S18ID AND A18.StandardTypeID = ''S18''
		LEFT JOIN AT0128 A19 WITH (NOLOCK) ON A19.StandardID = O99.S19ID AND A19.StandardTypeID = ''S19''
		LEFT JOIN AT0128 A20 WITH (NOLOCK) ON A20.StandardID = O99.S20ID AND A20.StandardTypeID = ''S20''
		Where T00.PlanID = ''' + @PlanID + '''		
        Group by V00.Dates, V00.Times, T00. InventoryID, A00.InventoryName, A01.UnitName, T00.DivisionID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID, O02.Ana01ID, O02.Ana02ID, O02.Ana03ID, O02.Ana04ID, O02.Ana05ID, O02.Ana06ID, O02.Ana07ID, O02.Ana08ID, O02.Ana09ID, O02.Ana10ID,
			A1.AnaName, A2.AnaName, A3.AnaName, A4.AnaName, A5.AnaName, A6.AnaName, A7.AnaName, A8.AnaName, A9.AnaName, A10.AnaName,
			A21.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, A05.StandardName,
			A06.StandardName, A07.StandardName, A08.StandardName, A09.StandardName, A22.StandardName,
			A11.StandardName, A12.StandardName, A13.StandardName, A14.StandardName, A15.StandardName,
			A16.StandardName, A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName'

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
If exists (Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'MV2012')
	Drop view MV2012
EXEC('Create view MV2012 ---tao boi MP2004
		as ' + @sSQL+@sSQL1+@sSQL2)

Set @sSQL = 'Select InventoryID,  sum(ActualQuantity) as ActualQuantity, MT2005.DivisionID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		From MT2005 WITH (NOLOCK)
		LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = MT2005.DivisionID AND O99.VoucherID = MT2005.VoucherID AND O99.TransactionID = MT2005.TransactionID
		Where PlanID = ''' + @PlanID + '''
		And MT2005.DivisionID = ''' + @DivisionID + '''
		Group by InventoryID, MT2005.DivisionID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID'

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'MV2013')
	Drop view MV2013
EXEC('Create view MV2013 ---tao boi MP2004
		as ' + @sSQL)

Set @sSQL = '
Select T00.InventoryID, InventoryName, A01.UnitName, VoucherDate as Dates, V00.ActualQuantity, sum(T00.ActualQuantity) as Quantity,
		T00.DivisionID,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		From MT2005  T00 WITH (NOLOCK)   inner join MT2004 T01 WITH (NOLOCK) on T00.VoucherID = T01.VoucherID and T00.DivisionID = T01.DivisionID
			LEFT JOIN MT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T00.DivisionID AND O99.VoucherID = T00.VoucherID AND O99.TransactionID = T00.TransactionID
			inner join MV2013 V00 on T00.InventoryID = V00.InventoryID and T00.DivisionID = V00.DivisionID and 
										ISNULL(O99.S01ID,'''') = ISNULL(V00.S01ID,'''') AND
										ISNULL(O99.S02ID,'''') = ISNULL(V00.S02ID,'''') AND
										ISNULL(O99.S03ID,'''') = ISNULL(V00.S03ID,'''') AND
										ISNULL(O99.S04ID,'''') = ISNULL(V00.S04ID,'''') AND
										ISNULL(O99.S05ID,'''') = ISNULL(V00.S05ID,'''') AND
										ISNULL(O99.S06ID,'''') = ISNULL(V00.S06ID,'''') AND
										ISNULL(O99.S07ID,'''') = ISNULL(V00.S07ID,'''') AND
										ISNULL(O99.S08ID,'''') = ISNULL(V00.S08ID,'''') AND
										ISNULL(O99.S09ID,'''') = ISNULL(V00.S09ID,'''') AND
										ISNULL(O99.S10ID,'''') = ISNULL(V00.S10ID,'''') AND
										ISNULL(O99.S11ID,'''') = ISNULL(V00.S11ID,'''') AND
										ISNULL(O99.S12ID,'''') = ISNULL(V00.S12ID,'''') AND
										ISNULL(O99.S13ID,'''') = ISNULL(V00.S13ID,'''') AND
										ISNULL(O99.S14ID,'''') = ISNULL(V00.S14ID,'''') AND
										ISNULL(O99.S15ID,'''') = ISNULL(V00.S15ID,'''') AND
										ISNULL(O99.S16ID,'''') = ISNULL(V00.S16ID,'''') AND
										ISNULL(O99.S17ID,'''') = ISNULL(V00.S17ID,'''') AND
										ISNULL(O99.S18ID,'''') = ISNULL(V00.S18ID,'''') AND
										ISNULL(O99.S19ID,'''') = ISNULL(V00.S19ID,'''') AND
										ISNULL(O99.S20ID,'''') = ISNULL(V00.S20ID,'''')  
			inner join AT1302 A00 WITH (NOLOCK) on T00.InventoryID = A00.InventoryID AND A00.DivisionID IN (T00.DivisionID,''@@@'')
			inner join AT1304 A01 WITH (NOLOCK) on A00.UnitID = A01.UnitID AND A00.DivisionID IN (A01.DivisionID,''@@@'')
		Where PlanID = ''' + @PlanID + '''
		AND T00.DivisionID = ''' + @DivisionID + '''
		Group by T00.InventoryID, InventoryName,  A01.UnitName, Voucherdate , V00.ActualQuantity, T00.DivisionID,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID'

If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2014')
	Drop view MV2014
EXEC('Create view MV2014 ---tao boi MP2004
		as ' + @sSQL) 

---Tat ca ngay  trong ke hoach san xuat va thuc te thuc hien
Set @sSQL = 'Select Dates, MV2011.DivisionID From MV2011 Union
		Select Distinct Dates, MV2014.DivisionID From MV2014'

If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2015')
	Drop view MV2015
EXEC('Create view MV2015  ---tao boi MP2004
		as ' + @sSQL) 
--//

Set @sSQL = 'Select ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, 
		V00.InventoryID,  V00.InventoryName, V00.UnitName, Dates, 
		1 as Types, ''MFML000254'' as TypeName, PlanQuantity, V01.ActualQuantity, Quantity, V00.DivisionID,
		V00.S01ID, V00.S02ID, V00.S03ID, V00.S04ID, V00.S05ID, V00.S06ID, V00.S07ID, V00.S08ID, V00.S09ID, V00.S10ID, 
		V00.S11ID, V00.S12ID, V00.S13ID, V00.S14ID, V00.S15ID, V00.S16ID, V00.S17ID, V00.S18ID, V00.S19ID, V00.S20ID,
		V00.S01Name, V00.S02Name, V00.S03Name, V00.S04Name, V00.S05Name,
		V00.S06Name, V00.S07Name, V00.S08Name, V00.S09Name, V00.S10Name,
		V00.S11Name, V00.S12Name, V00.S13Name, V00.S14Name, V00.S15Name,
		V00.S16Name, V00.S17Name, V00.SName18, V00.S19Name, V00.S20Name,
		Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,
		Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
		Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name, Ana10Name  
	From MV2012 V00 left join MV2013 V01 on V00.InventoryID = V01.inventoryID 	and 
										ISNULL(V01.S01ID,'''') = ISNULL(V00.S01ID,'''') AND
										ISNULL(V01.S02ID,'''') = ISNULL(V00.S02ID,'''') AND
										ISNULL(V01.S03ID,'''') = ISNULL(V00.S03ID,'''') AND
										ISNULL(V01.S04ID,'''') = ISNULL(V00.S04ID,'''') AND
										ISNULL(V01.S05ID,'''') = ISNULL(V00.S05ID,'''') AND
										ISNULL(V01.S06ID,'''') = ISNULL(V00.S06ID,'''') AND
										ISNULL(V01.S07ID,'''') = ISNULL(V00.S07ID,'''') AND
										ISNULL(V01.S08ID,'''') = ISNULL(V00.S08ID,'''') AND
										ISNULL(V01.S09ID,'''') = ISNULL(V00.S09ID,'''') AND
										ISNULL(V01.S10ID,'''') = ISNULL(V00.S10ID,'''') AND
										ISNULL(V01.S11ID,'''') = ISNULL(V00.S11ID,'''') AND
										ISNULL(V01.S12ID,'''') = ISNULL(V00.S12ID,'''') AND
										ISNULL(V01.S13ID,'''') = ISNULL(V00.S13ID,'''') AND
										ISNULL(V01.S14ID,'''') = ISNULL(V00.S14ID,'''') AND
										ISNULL(V01.S15ID,'''') = ISNULL(V00.S15ID,'''') AND
										ISNULL(V01.S16ID,'''') = ISNULL(V00.S16ID,'''') AND
										ISNULL(V01.S17ID,'''') = ISNULL(V00.S17ID,'''') AND
										ISNULL(V01.S18ID,'''') = ISNULL(V00.S18ID,'''') AND
										ISNULL(V01.S19ID,'''') = ISNULL(V00.S19ID,'''') AND
										ISNULL(V01.S20ID,'''') = ISNULL(V00.S20ID,'''')		'	

SET @sSQL1 = '
Union 
Select Distinct ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, 
		V00.InventoryID, V00.InventoryName, V00.UnitName, V00.Dates, 
		1 as Types,''MFML000254'' as TypeName, V01.PlanQuantity as PlanQuantity, ActualQuantity,  0 as Quantity, V00.DivisionID,
		V01.S01ID, V01.S02ID, V01.S03ID, V01.S04ID, V01.S05ID, V01.S06ID, V01.S07ID, V01.S08ID, V01.S09ID, V01.S10ID, 
		V01.S11ID, V01.S12ID, V01.S13ID, V01.S14ID, V01.S15ID, V01.S16ID, V01.S17ID, V01.S18ID, V01.S19ID, V01.S20ID,
		V01.S01Name, V01.S02Name, V01.S03Name, V01.S04Name, V01.S05Name,
		V01.S06Name, V01.S07Name, V01.S08Name, V01.S09Name, V01.S10Name,
		V01.S11Name, V01.S12Name, V01.S13Name, V01.S14Name, V01.S15Name,
		V01.S16Name, V01.S17Name, V01.SName18, V01.S19Name, V01.S20Name,
		V01.Ana01ID, V01.Ana02ID, V01.Ana03ID, V01.Ana04ID, V01.Ana05ID,
		V01.Ana06ID, V01.Ana07ID, V01.Ana08ID, V01.Ana09ID, V01.Ana10ID,
		V01.Ana01Name,V01.Ana02Name,V01.Ana03Name,V01.Ana04Name,V01.Ana05Name,V01.Ana06Name,V01.Ana07Name,V01.Ana08Name,V01.Ana09Name, V01.Ana10Name
	From MV2014 V00 left join (Select Distinct InventoryID, PlanQuantity, S01ID,S02ID, S03ID, S04ID, S05ID,S06ID, S07ID, S08ID, S09ID, S10ID,
												S11ID,S12ID, S13ID, S14ID, S15ID,S16ID, S17ID, S18ID, S19ID, S20ID,
												S01Name, S02Name, S03Name, S04Name, S05Name,
												S06Name, S07Name, S08Name, S09Name, S10Name,
												S11Name, S12Name, S13Name, S14Name, S15Name,
												S16Name, S17Name, SName18, S19Name, S20Name,
												Ana01ID,Ana02ID, Ana03ID,Ana04ID, Ana05ID,
												Ana06ID,Ana07ID,Ana08ID, Ana09ID, Ana10ID,
												Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name, Ana10Name From MV2012) V01 
		on V00.InventoryID = V01.InventoryID and 
										ISNULL(V01.S01ID,'''') = ISNULL(V00.S01ID,'''') AND
										ISNULL(V01.S02ID,'''') = ISNULL(V00.S02ID,'''') AND
										ISNULL(V01.S03ID,'''') = ISNULL(V00.S03ID,'''') AND
										ISNULL(V01.S04ID,'''') = ISNULL(V00.S04ID,'''') AND
										ISNULL(V01.S05ID,'''') = ISNULL(V00.S05ID,'''') AND
										ISNULL(V01.S06ID,'''') = ISNULL(V00.S06ID,'''') AND
										ISNULL(V01.S07ID,'''') = ISNULL(V00.S07ID,'''') AND
										ISNULL(V01.S08ID,'''') = ISNULL(V00.S08ID,'''') AND
										ISNULL(V01.S09ID,'''') = ISNULL(V00.S09ID,'''') AND
										ISNULL(V01.S10ID,'''') = ISNULL(V00.S10ID,'''') AND
										ISNULL(V01.S11ID,'''') = ISNULL(V00.S11ID,'''') AND
										ISNULL(V01.S12ID,'''') = ISNULL(V00.S12ID,'''') AND
										ISNULL(V01.S13ID,'''') = ISNULL(V00.S13ID,'''') AND
										ISNULL(V01.S14ID,'''') = ISNULL(V00.S14ID,'''') AND
										ISNULL(V01.S15ID,'''') = ISNULL(V00.S15ID,'''') AND
										ISNULL(V01.S16ID,'''') = ISNULL(V00.S16ID,'''') AND
										ISNULL(V01.S17ID,'''') = ISNULL(V00.S17ID,'''') AND
										ISNULL(V01.S18ID,'''') = ISNULL(V00.S18ID,'''') AND
										ISNULL(V01.S19ID,'''') = ISNULL(V00.S19ID,'''') AND
										ISNULL(V01.S20ID,'''') = ISNULL(V00.S20ID,'''')
	Where V00.Dates not in (Select Distinct Dates From MV2011) '

SET @sSQL2 = '
Union
Select ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate, 
		 V00.InventoryID,  V00.InventoryName, V00.UnitName,  Dates, 
		2 as Types, ''MFML000255'' as TypeName, V01.PlanQuantity, ActualQuantity, Quantity , V00.DivisionID,
		V01.S01ID, V01.S02ID, V01.S03ID, V01.S04ID, V01.S05ID, V01.S06ID, V01.S07ID, V01.S08ID, V01.S09ID, V01.S10ID, 
		V01.S11ID, V01.S12ID, V01.S13ID, V01.S14ID, V01.S15ID, V01.S16ID, V01.S17ID, V01.S18ID, V01.S19ID, V01.S20ID,
		V01.S01Name, V01.S02Name, V01.S03Name, V01.S04Name, V01.S05Name,
		V01.S06Name, V01.S07Name, V01.S08Name, V01.S09Name, V01.S10Name,
		V01.S11Name, V01.S12Name, V01.S13Name, V01.S14Name, V01.S15Name,
		V01.S16Name, V01.S17Name, V01.SName18, V01.S19Name, V01.S20Name,
		V01.Ana01ID, V01.Ana02ID, V01.Ana03ID, V01.Ana04ID, V01.Ana05ID,
		V01.Ana06ID, V01.Ana07ID, V01.Ana08ID, V01.Ana09ID, V01.Ana10ID,
		V01.Ana01Name,V01.Ana02Name,V01.Ana03Name,V01.Ana04Name,V01.Ana05Name,V01.Ana06Name,V01.Ana07Name,V01.Ana08Name,V01.Ana09Name, V01.Ana10Name
	From MV2014 V00 inner join
	(Select Distinct InventoryID, PlanQuantity, S01ID,S02ID, S03ID, S04ID, S05ID,S06ID, S07ID, S08ID, S09ID, S10ID,
					S11ID,S12ID, S13ID, S14ID, S15ID,S16ID, S17ID, S18ID, S19ID, S20ID,
					S01Name, S02Name, S03Name, S04Name, S05Name,
					S06Name, S07Name, S08Name, S09Name, S10Name,
					S11Name, S12Name, S13Name, S14Name, S15Name,
					S16Name, S17Name, SName18, S19Name, S20Name,
					Ana01ID,Ana02ID, Ana03ID,Ana04ID, Ana05ID,
					Ana06ID,Ana07ID,Ana08ID, Ana09ID, Ana10ID,
					Ana01Name,Ana02Name,Ana03Name,Ana04Name,Ana05Name,Ana06Name,Ana07Name,Ana08Name,Ana09Name, Ana10Name From MV2012) V01 
		on V00.InventoryID = V01.InventoryID	and 
										ISNULL(V01.S01ID,'''') = ISNULL(V00.S01ID,'''') AND
										ISNULL(V01.S02ID,'''') = ISNULL(V00.S02ID,'''') AND
										ISNULL(V01.S03ID,'''') = ISNULL(V00.S03ID,'''') AND
										ISNULL(V01.S04ID,'''') = ISNULL(V00.S04ID,'''') AND
										ISNULL(V01.S05ID,'''') = ISNULL(V00.S05ID,'''') AND
										ISNULL(V01.S06ID,'''') = ISNULL(V00.S06ID,'''') AND
										ISNULL(V01.S07ID,'''') = ISNULL(V00.S07ID,'''') AND
										ISNULL(V01.S08ID,'''') = ISNULL(V00.S08ID,'''') AND
										ISNULL(V01.S09ID,'''') = ISNULL(V00.S09ID,'''') AND
										ISNULL(V01.S10ID,'''') = ISNULL(V00.S10ID,'''') AND
										ISNULL(V01.S11ID,'''') = ISNULL(V00.S11ID,'''') AND
										ISNULL(V01.S12ID,'''') = ISNULL(V00.S12ID,'''') AND
										ISNULL(V01.S13ID,'''') = ISNULL(V00.S13ID,'''') AND
										ISNULL(V01.S14ID,'''') = ISNULL(V00.S14ID,'''') AND
										ISNULL(V01.S15ID,'''') = ISNULL(V00.S15ID,'''') AND
										ISNULL(V01.S16ID,'''') = ISNULL(V00.S16ID,'''') AND
										ISNULL(V01.S17ID,'''') = ISNULL(V00.S17ID,'''') AND
										ISNULL(V01.S18ID,'''') = ISNULL(V00.S18ID,'''') AND
										ISNULL(V01.S19ID,'''') = ISNULL(V00.S19ID,'''') AND
										ISNULL(V01.S20ID,'''') = ISNULL(V00.S20ID,'''')	'

SET @sSQL3 = '
Union 
Select Distinct ''' + @VoucherNo + ''' as VoucherNo, ''' + convert(nvarchar(10), @VoucherDate, 103) + ''' as VoucherDate,
		V00.InventoryID,  V00.InventoryName, V00.UnitName,  V00.Dates,  
		2 as Types, ''MFML000255'' as TypeName, PlanQuantity, V01.ActualQuantity, 0 as Quantity, V00.DivisionID,
		V00.S01ID, V00.S02ID, V00.S03ID, V00.S04ID, V00.S05ID, V00.S06ID, V00.S07ID, V00.S08ID, V00.S09ID, V00.S10ID, 
		V00.S11ID, V00.S12ID, V00.S13ID, V00.S14ID, V00.S15ID, V00.S16ID, V00.S17ID, V00.S18ID, V00.S19ID, V00.S20ID,
		V00.S01Name, V00.S02Name, V00.S03Name, V00.S04Name, V00.S05Name,
		V00.S06Name, V00.S07Name, V00.S08Name, V00.S09Name, V00.S10Name,
		V00.S11Name, V00.S12Name, V00.S13Name, V00.S14Name, V00.S15Name,
		V00.S16Name, V00.S17Name, V00.SName18, V00.S19Name, V00.S20Name,
		V00.Ana01ID, V00.Ana02ID, V00.Ana03ID, V00.Ana04ID, V00.Ana05ID,
		V00.Ana06ID, V00.Ana07ID, V00.Ana08ID, V00.Ana09ID, V00.Ana10ID,
		V00.Ana01Name,V00.Ana02Name,V00.Ana03Name,V00.Ana04Name,V00.Ana05Name,V00.Ana06Name,V00.Ana07Name,V00.Ana08Name,V00.Ana09Name, V00.Ana10Name
	From MV2012 V00 left join MV2013 V01 on V00.InventoryID = V01.InventoryID and 
										ISNULL(V01.S01ID,'''') = ISNULL(V00.S01ID,'''') AND
										ISNULL(V01.S02ID,'''') = ISNULL(V00.S02ID,'''') AND
										ISNULL(V01.S03ID,'''') = ISNULL(V00.S03ID,'''') AND
										ISNULL(V01.S04ID,'''') = ISNULL(V00.S04ID,'''') AND
										ISNULL(V01.S05ID,'''') = ISNULL(V00.S05ID,'''') AND
										ISNULL(V01.S06ID,'''') = ISNULL(V00.S06ID,'''') AND
										ISNULL(V01.S07ID,'''') = ISNULL(V00.S07ID,'''') AND
										ISNULL(V01.S08ID,'''') = ISNULL(V00.S08ID,'''') AND
										ISNULL(V01.S09ID,'''') = ISNULL(V00.S09ID,'''') AND
										ISNULL(V01.S10ID,'''') = ISNULL(V00.S10ID,'''') AND
										ISNULL(V01.S11ID,'''') = ISNULL(V00.S11ID,'''') AND
										ISNULL(V01.S12ID,'''') = ISNULL(V00.S12ID,'''') AND
										ISNULL(V01.S13ID,'''') = ISNULL(V00.S13ID,'''') AND
										ISNULL(V01.S14ID,'''') = ISNULL(V00.S14ID,'''') AND
										ISNULL(V01.S15ID,'''') = ISNULL(V00.S15ID,'''') AND
										ISNULL(V01.S16ID,'''') = ISNULL(V00.S16ID,'''') AND
										ISNULL(V01.S17ID,'''') = ISNULL(V00.S17ID,'''') AND
										ISNULL(V01.S18ID,'''') = ISNULL(V00.S18ID,'''') AND
										ISNULL(V01.S19ID,'''') = ISNULL(V00.S19ID,'''') AND
										ISNULL(V01.S20ID,'''') = ISNULL(V00.S20ID,'''')
	Where Dates not in (Select Distinct Dates From MV2014) '

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3
If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2016_1')
	Drop view MV2016_1
EXEC('Create view MV2016_1 ---tao boi MP2004
		as ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3) 

SET @sSQL = '
			SELECT MV2016_1.*,
				a.S01 as UserName01, a.S02 as UserName02, a.S03 as UserName03, a.S04 as UserName04, a.S05 as UserName05, 
				a.S06 as UserName06, a.S07 as UserName07, a.S08 as UserName08, a.S09 as UserName09, a.S10 as UserName10,
				a.S11 as UserName11, a.S12 as UserName12, a.S13 as UserName13, a.S14 as UserName14, a.S15 as UserName15, 
				a.S16 as UserName16, a.S17 as UserName17, a.S18 as UserName18, a.S19 as UserName19, a.S20 as UserName20
			FROM MV2016_1
			LEFT JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = MV2016_1.DivisionID
	
			'
--PRINT @sSQL			
If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2016')
	Drop view MV2016
EXEC('Create view MV2016 ---tao boi MP2004
		as ' + @sSQL)


END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
