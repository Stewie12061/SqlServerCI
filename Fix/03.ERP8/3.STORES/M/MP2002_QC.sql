IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2002_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP2002_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by Tiểu Mai on 11/01/2016
---purpose: Bao cao Tinh hinh thuc hien tien do san xuat theo quy cach hang hoa.
---- Modified by Bảo Anh on 26/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

CREATE  PROCEDURE 	[dbo].[MP2002_QC] @DivisionID nvarchar(50),
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
		@sSQL nvarchar(max),  
		@cur cursor, 
		@Times int, 
		@Orders int, 
		@Dates datetime, 
		@sSQL1 nvarchar(4000), 
		@sSQL2 nvarchar(4000)


Select    @Date01 = Date01,  @Date02 = Date02, @Date03 = Date03, @Date04 = Date04, @Date05 = Date05,
		  @Date06 = Date06,  @Date07 = Date07, @Date08 = Date08, @Date09 = Date09, @Date10 = Date10,
		  @Date11 = Date11,  @Date12 = Date12, @Date13 = Date13, @Date14 = Date14, @Date15 = Date15,
		  @Date16 = Date16,  @Date17 = Date17, @Date18 = Date18, @Date19 = Date19, @Date20 = Date20,
		  @Date21 = Date21,  @Date22 = Date22, @Date23 = Date23, @Date24 = Date24, @Date25 = Date25,
		  @Date26 = Date26,  @Date27 = Date27, @Date28 = Date28, @Date29 = Date29, @Date30 = Date30,
		  @Date31 = Date31,  @Date32 = Date32, @Date33 = Date33, @Date34 = Date34, @Date35 = Date35,
		  @Date36 = Date36,  @Date37 = Date37, @Date38 = Date38, @Date39 = Date39, @Date40 = Date40		
From MT2003 Where PlanID = @PlanID And DivisionID = @DivisionID

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
--print @sSQL
If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'MV2201')
	Drop view MV2201
EXEC('Create view MV2201 ---tao boi MP2002
		 as ' + @sSQL)	
end

Set @sSQL = 'Select Distinct InventoryID,  sum(ActualQuantity) as ActualQuantity, MT2005.DivisionID,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID
		From MT2005 
		Left join MT8899 O99 On O99.DivisionID = MT2005.DivisionID AND O99.VoucherID = MT2005.VoucherID AND O99.TransactionID = MT2005.TransactionID
		Where PlanID = ''' + @PlanID + '''
		AND MT2005.DivisionID = ''' + @DivisionID + '''
		Group by InventoryID, MT2005.DivisionID,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID'

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'MV2202')
	Drop view MV2202
EXEC('Create view MV2202 ---tao boi MP2002
		as ' + @sSQL) 

Set @sSQL = 'Select Distinct T00.InventoryID,  VoucherDate as Dates, V00.ActualQuantity, sum(T00.ActualQuantity) as Quantity, T00.DivisionID,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID
		From MT2005  	T00 inner join MT2004 T01 on T00.VoucherID = T01.VoucherID and T00.DivisionId = T01.DivisionId
		Left join MT8899 O99 On O99.DivisionID = T00.DivisionID AND O99.VoucherID = T00.VoucherID AND O99.TransactionID = T00.TransactionID
		inner join MV2202 V00 on V00.InventoryID = T00.InventoryID	and V00.DivisionId = T00.DivisionID AND
								Isnull(O99.S01ID,'''') = Isnull(V00.S01ID,'''') AND
								Isnull(O99.S02ID,'''') = Isnull(V00.S02ID,'''') AND
								Isnull(O99.S03ID,'''') = Isnull(V00.S03ID,'''') AND
								Isnull(O99.S04ID,'''') = Isnull(V00.S04ID,'''') AND
								Isnull(O99.S05ID,'''') = Isnull(V00.S05ID,'''') AND
								Isnull(O99.S06ID,'''') = Isnull(V00.S06ID,'''') AND
								Isnull(O99.S07ID,'''') = Isnull(V00.S07ID,'''') AND
								Isnull(O99.S08ID,'''') = Isnull(V00.S08ID,'''') AND
								Isnull(O99.S09ID,'''') = Isnull(V00.S09ID,'''') AND
								Isnull(O99.S10ID,'''') = Isnull(V00.S10ID,'''') AND
								Isnull(O99.S11ID,'''') = Isnull(V00.S11ID,'''') AND
								Isnull(O99.S12ID,'''') = Isnull(V00.S12ID,'''') AND
								Isnull(O99.S13ID,'''') = Isnull(V00.S13ID,'''') AND
								Isnull(O99.S14ID,'''') = Isnull(V00.S14ID,'''') AND
								Isnull(O99.S15ID,'''') = Isnull(V00.S15ID,'''') AND
								Isnull(O99.S16ID,'''') = Isnull(V00.S16ID,'''') AND
								Isnull(O99.S17ID,'''') = Isnull(V00.S17ID,'''') AND
								Isnull(O99.S18ID,'''') = Isnull(V00.S18ID,'''') AND
								Isnull(O99.S19ID,'''') = Isnull(V00.S19ID,'''') AND
								Isnull(O99.S20ID,'''') = Isnull(V00.S20ID,'''')			
		Where T00.PlanID = ''' + @PlanID + '''
		AND T00.DivisionID = ''' + @DivisionID + '''
		Group by T00.InventoryID, VoucherDate, V00.ActualQuantity, T00.DivisionID,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID'

If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2203')
	Drop view MV2203
EXEC('Create view MV2203 ---tao boi MP2002
		as ' + @sSQL) 

---Tat ca ngay  trong ke hoach san xuat va thuc te thuc hien
Set @sSQL = 'Select Dates, Times,DivisionID From MV2201 Union
		Select Distinct Dates, 41 as Times, DivisionID From MV2203 Where Dates not in (Select Dates From MV2201 WHERE MV2201.DivisionID ='''+ @DivisionID + ''' )'

If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2204')
	Drop view MV2204
Exec('Create view MV2204  ---tao boi MP2002
		as ' + @sSQL) 
--//

Select @Orders = 1, 
		@sSQL1 = 'Select MT2002.DivisionID, InventoryID, sum(PlanQuantity) as PlanQuantity,
				O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
				O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID, ', 
				
		@sSQL2 = 'Select DivisionID, InventoryID,
				S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
				S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID, ',  
				
		@sSQL = 'Select V00.DivisionID, case when isnull(V00.InventoryID, '''') = '''' then V01.InventoryID else V00.InventoryID end as InventoryID, 
				InventoryName, UnitName, V00.PlanQuantity, V02.ActualQuantity,
				V00.S01ID,V00.S02ID,V00.S03ID,V00.S04ID,V00.S05ID,V00.S06ID,V00.S07ID,V00.S08ID,V00.S09ID,V00.S10ID,
				V00.S11ID,V00.S12ID,V00.S13ID,V00.S14ID,V00.S15ID,V00.S16ID,V00.S17ID,V00.S18ID,V00.S19ID,V00.S20ID, ' 
Set @cur = Cursor scroll keyset for
		Select Dates, Times 	From MV2204  		Order by Dates
Open @cur
Fetch next from @cur into @Dates, @Times

While @@Fetch_Status = 0
Begin
	Set @sSQL1 = @sSQL1 + 'sum(' + case when  @Times < 10 	then 'isnull(Quantity0' + cast(@Times as nvarchar(2)) + ', 0)'
				  when @Times < 41  	then 'isnull(Quantity' + cast(@Times as nvarchar(2)) 	+ ', 0)' 
				   else '0' end + ') as Quantity' + case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ', '	
	Set @sSQL2 = @sSQL2 + 'sum(case when Dates = ''' + convert(nvarchar(20), @Dates, 120) + 
			''' then isnull(Quantity, 0) else 0 end) as AQuantity' +  case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ', '	
	Set @sSQL = @sSQL +  'Quantity' + case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ' =  
					case when Quantity' +  case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ' = 0 then 
					NULL else Quantity' +  case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ' end, 
				AQuantity' + case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10))  +' = case when AQuantity' + 
					  case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10))  + ' = 0
					then NULL else AQuantity' +  case when @Orders <  10 then  '0' else '' end + cast(@Orders as nvarchar(10)) + ' end, '

	Set @Orders = @Orders + 1
	Fetch next from @cur into @Dates, @Times
End

Set @sSQL1 = left(@sSQL1, len(@sSQL1) - 1) + ' From MT2002
											Left join MT8899 O99 On O99.DivisionID = MT2002.DivisionID AND O99.VoucherID = MT2002.PlanID AND O99.TransactionID = MT2002.PlanDetailID
											 Where PlanID = ''' + @PlanID + ''' And MT2002.DivisionID = ''' + @DivisionID + ''' Group by MT2002.DivisionID, InventoryID,
											O99.S01ID,O99.S02ID,O99.S03ID,O99.S04ID,O99.S05ID,O99.S06ID,O99.S07ID,O99.S08ID,O99.S09ID,O99.S10ID,
											O99.S11ID,O99.S12ID,O99.S13ID,O99.S14ID,O99.S15ID,O99.S16ID,O99.S17ID,O99.S18ID,O99.S19ID,O99.S20ID '

Set @sSQL2 = left(@sSQL2, len(@sSQL2) - 1) + ' From MV2203 Group by DivisionID, InventoryID,
												S01ID,S02ID,S03ID,S04ID,S05ID,S06ID,S07ID,S08ID,S09ID,S10ID,
												S11ID,S12ID,S13ID,S14ID,S15ID,S16ID,S17ID,S18ID,S19ID,S20ID'

Set @sSQL = left(@sSQL, len(@sSQL) - 1) + ' From MV2205 V00 full join MV2206 V01 on V00.InventoryID = V01.InventoryID and V00.DivisionID = V01.DivisionID AND
												Isnull(V01.S01ID,'''') = Isnull(V00.S01ID,'''') AND
												Isnull(V01.S02ID,'''') = Isnull(V00.S02ID,'''') AND
												Isnull(V01.S03ID,'''') = Isnull(V00.S03ID,'''') AND
												Isnull(V01.S04ID,'''') = Isnull(V00.S04ID,'''') AND
												Isnull(V01.S05ID,'''') = Isnull(V00.S05ID,'''') AND
												Isnull(V01.S06ID,'''') = Isnull(V00.S06ID,'''') AND
												Isnull(V01.S07ID,'''') = Isnull(V00.S07ID,'''') AND
												Isnull(V01.S08ID,'''') = Isnull(V00.S08ID,'''') AND
												Isnull(V01.S09ID,'''') = Isnull(V00.S09ID,'''') AND
												Isnull(V01.S10ID,'''') = Isnull(V00.S10ID,'''') AND
												Isnull(V01.S11ID,'''') = Isnull(V00.S11ID,'''') AND
												Isnull(V01.S12ID,'''') = Isnull(V00.S12ID,'''') AND
												Isnull(V01.S13ID,'''') = Isnull(V00.S13ID,'''') AND
												Isnull(V01.S14ID,'''') = Isnull(V00.S14ID,'''') AND
												Isnull(V01.S15ID,'''') = Isnull(V00.S15ID,'''') AND
												Isnull(V01.S16ID,'''') = Isnull(V00.S16ID,'''') AND
												Isnull(V01.S17ID,'''') = Isnull(V00.S17ID,'''') AND
												Isnull(V01.S18ID,'''') = Isnull(V00.S18ID,'''') AND
												Isnull(V01.S19ID,'''') = Isnull(V00.S19ID,'''') AND
												Isnull(V01.S20ID,'''') = Isnull(V00.S20ID,'''')
		full join MV2202 V02 on case when isnull( V00.InventoryID, '''') = '''' then V01.InventoryID else V00.InventoryID end = V02.InventoryID
			And case when isnull( V00.InventoryID, '''') = '''' then V01.DivisionID else V00.DivisionID end = V02.DivisionID AND
												Isnull(V02.S01ID,'''') = Isnull(V00.S01ID,'''') AND
												Isnull(V02.S02ID,'''') = Isnull(V00.S02ID,'''') AND
												Isnull(V02.S03ID,'''') = Isnull(V00.S03ID,'''') AND
												Isnull(V02.S04ID,'''') = Isnull(V00.S04ID,'''') AND
												Isnull(V02.S05ID,'''') = Isnull(V00.S05ID,'''') AND
												Isnull(V02.S06ID,'''') = Isnull(V00.S06ID,'''') AND
												Isnull(V02.S07ID,'''') = Isnull(V00.S07ID,'''') AND
												Isnull(V02.S08ID,'''') = Isnull(V00.S08ID,'''') AND
												Isnull(V02.S09ID,'''') = Isnull(V00.S09ID,'''') AND
												Isnull(V02.S10ID,'''') = Isnull(V00.S10ID,'''') AND
												Isnull(V02.S11ID,'''') = Isnull(V00.S11ID,'''') AND
												Isnull(V02.S12ID,'''') = Isnull(V00.S12ID,'''') AND
												Isnull(V02.S13ID,'''') = Isnull(V00.S13ID,'''') AND
												Isnull(V02.S14ID,'''') = Isnull(V00.S14ID,'''') AND
												Isnull(V02.S15ID,'''') = Isnull(V00.S15ID,'''') AND
												Isnull(V02.S16ID,'''') = Isnull(V00.S16ID,'''') AND
												Isnull(V02.S17ID,'''') = Isnull(V00.S17ID,'''') AND
												Isnull(V02.S18ID,'''') = Isnull(V00.S18ID,'''') AND
												Isnull(V02.S19ID,'''') = Isnull(V00.S19ID,'''') AND
												Isnull(V02.S20ID,'''') = Isnull(V00.S20ID,'''')
		inner join AT1302 A00 on case when isnull(V00.InventoryID, '''') = '''' then V01.InventoryID else V00.InventoryID end = A00.InventoryID
								 AND A00.DivisionID IN (case when isnull(V00.DivisionID, '''') = '''' then V01.DivisionID else V00.DivisionID end,''@@@'')
		inner join AT1304 A01 on A01.UnitID = A00.UnitID'


If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2205')
	Drop view MV2205
Exec('Create view MV2205  ---tao boi MP2002
		as ' + @sSQL1) 

If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2206')
	Drop view MV2206
Exec('Create view MV2206  ---tao boi MP2002
		as ' + @sSQL2) 

--print @sSQL
If  exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name ='MV2207')
	Drop view MV2207
Exec('Create view MV2207  ---tao boi MP2002
		as ' + @sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO





