IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20222]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20222]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--  <Summary>
--		Bảng báo giá nhân công
--  </Summary>
--	<History>
/*
	Ngày tạo: 05/03/2020
		Người tạo: Kiều Nga
*/
--	</History>
--	<Example>
/*	
	SOP20222 'DTI', '9b5883af-54aa-48c3-a0c1-99708a391bc6', 'BAOTOAN'
*/
--	</Example>
create proc SOP20222 
@DivisionID varchar(50),
@APKOT2101 varchar(36),
@UserID varchar(50) 
as
begin
	SET NOCOUNT ON

	Declare @sign_NC varchar(10) = '.NC'
			, @lv1 varchar(10) = 'LV1'
			, @lv2 varchar(10) = 'LV2'
			, @lv3 varchar(10) = 'LV3'
			, @InventoryVirual_lv1 varchar(10) = 'ZZZZZZZZZZ'
			, @InventoryVirual_lv2 varchar(10) = 'ZZZZZZZZZY'
			, @AutoIndex01 decimal(5,2) = 0.01
			, @AutoIndex02 decimal(5,2) = 0.10
			, @Caption_Total nvarchar(500) = N'TỔNG'
			, @ClassifyID nvarchar(max) 
			, @ClassifyID_ISSALE nvarchar(max)  = 'SALE'
	Declare	@len_Sign_NC int = LEN(@sign_NC)
	Declare @AmountTotal decimal(28,8) --[TỔNG TIỀN]
			, @ReduceCost decimal(28,8) --[TIỀN GIẢM TRỪ]
	--cấu trúc dữ liệu chi tiết phiếu báo giá
	declare @tableData table(
						APK UNIQUEIDENTIFIER default newid(),
						APK_QuotationID UNIQUEIDENTIFIER,
						APK_TransactionID UNIQUEIDENTIFIER,
						Specification NVARCHAR(MAX),
						InventoryID varchar(50),
						UnitID varchar(50),
						Quantity decimal(28,8),						-- Số lượng
						UnitPrice decimal(28,8),						-- Đơn giá					
						InheritTransactionID varchar(50), 
						OrderIndex decimal(20,5)
						)
	--add data 
	insert into @tableData(APK_QuotationID, APK_TransactionID, InventoryID,UnitID, Specification, Quantity, UnitPrice,InheritTransactionID, OrderIndex)
	select QuotationID,TransactionID,InventoryID,UnitID,Specification,QuoQuantity
	, Case when Coefficient > 0 then UnitPrice * Coefficient else UnitPrice end UnitPrice
	,InheritTransactionID,CAST(Orders+0.00000 as decimal(20,5))
	from OT2102 with (nolock)
	where QuotationID = @APKOT2101

	--[TÍNH TỔNG GIÁ TRỊ PHIẾU]
	SET @AmountTotal = (select SUM(ISNULL(Quantity,0)*ISNULL(UnitPrice,0)) from @tableData)
	--[TIỀN GIẢM TRỪ]
	SET @ReduceCost = (select DiscountAmount from SOT2062 with (nolock) where APK_OT2101 = @APKOT2101)
	--select * from @tableData
	--data result
	declare @tableResult table(		
						STTCaption varchar(50),						--Hiển thị số thứ tự
						InventoryID varchar(50),
						Specification nvarchar(MAX),				-- Thông tin kỹ thuật
						AccessoryID	varchar(50),					-- Id phụ kiện
						UnitID varchar(50),
						Desciption nvarchar(MAX),					-- Nội dung hiển thị
						OriginName nvarchar(500),						-- Mã phân tích xuất xứ
						Quantity decimal(28,8),						-- Số lượng
						UnitPrice decimal(28,8),
						QuantityLabor decimal(28,8),	
						UnitPriceLabor decimal(28,8),
						OriginalAmount decimal(28,8),				-- Thành tiền
						[Index] int identity(1,1),
						LevelOrder1 varchar(10),
						LevelOrder2 varchar(10),
						LevelDesciption nvarchar(MAX),
						TypeOrder varchar(10),
						InheritTransactionID varchar(50),
						OrderIndex decimal(20,5)
						)
	--thêm dữ liệu hiện tại

	insert into @tableResult(InventoryID,UnitID,Quantity,UnitPrice, TypeOrder,InheritTransactionID, OrderIndex)
	select InventoryID,UnitID,Quantity,UnitPrice,@lv3, InheritTransactionID,OrderIndex
	from @tableData
	where RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC

	--thêm chi phí nhân công - customeridex = DTI
	--insert into @tableResult(InventoryID,UnitID,Quantity,UnitPrice, OrderIndex)
	update @tableResult
	set QuantityLabor = M.Quantity, UnitPriceLabor = M.UnitPrice
	from @tableData M 
		inner join @tableResult M1 on M1.InventoryID = LEFT(M.InventoryID, LEN(M.InventoryID) - LEN(@sign_NC))
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID 
	where RIGHT(M.InventoryID,@len_Sign_NC) = @sign_NC	

	--thêm thông tin kỹ thuật - customeridex = DTI
	insert into @tableResult(InventoryID,Specification, InheritTransactionID,OrderIndex)
	select M.InventoryID, ISNULL(M.Specification,R01.Specification), InheritTransactionID,CAST( OrderIndex as decimal)
	from @tableData M 
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
	where RIGHT(M.InventoryID,@len_Sign_NC) <> @sign_NC 
		AND ISNULL(M.Specification,R01.Specification) IS NOT NULL

	

	--[CẬP NHẬT MÃ PHÂN TÍCH (LEVEL CHI TIẾT)]	
	--[XỬ LÝ ĐẶC THÙ CHO BÁO GIÁ SALE]
	SELECT @ClassifyID = ClassifyID FROM OT2101 WITH(NOLOCK) WHERE APK = @APKOT2101
	IF ISNULL(@ClassifyID, '') = @ClassifyID_ISSALE
	BEGIN
		update @tableResult
		set M.Desciption = R01.InventoryName
			,OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
			, LevelOrder1 = R02_I01.AnaID
			, LevelOrder2 = R02_I02.AnaID
			--, M.levelDesciption = (case
			--					when R02_I02.AnaID is not null then R02_I02.AnaName
			--					when R02_I01.AnaID is not null then R02_I01.AnaName						
			--				end)
		from @tableResult M 
			left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
			INNER JOIN OT2102 R01_R with (nolock) on M.InheritTransactionID = R01_R.TransactionID
			LEFT JOIN OT3102 R02 with (nolock) on R01_R.InheritTransactionID = R02.TransactionID
			left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A09') R02_I01 on R02.Ana09ID = R02_I01.AnaID 
			left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A10') R02_I02 on R02.Ana10ID = R02_I02.AnaID 
			left join (select AnaID, AnaName from AT1015 with (nolock) where AnaTypeId= 'I03') R02_I03  on R02.I03ID = R02_I03.AnaID
		WHERE RIGHT(M.InventoryID,@len_Sign_NC) <> @sign_NC
	END
	ELSE 
	BEGIN
		update @tableResult
		set M.Desciption = R01.InventoryName
			,OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
			, LevelOrder1 = R02_I01.AnaID
			, LevelOrder2 = R02_I02.AnaID
			--, M.levelDesciption = (case
			--					when R02_I02.AnaID is not null then R02_I02.AnaName
			--					when R02_I01.AnaID is not null then R02_I01.AnaName						
			--				end)
		from @tableResult M 
			left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
			LEFT JOIN OT3102 R02 with (nolock) on M.InheritTransactionID = R02.TransactionID
			left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A09') R02_I01 on R02.Ana09ID = R02_I01.AnaID 
			left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A10') R02_I02 on R02.Ana10ID = R02_I02.AnaID 
			left join (select AnaID, AnaName from AT1015 with (nolock) where AnaTypeId= 'I03') R02_I03  on R02.I03ID = R02_I03.AnaID
		WHERE RIGHT(M.InventoryID,@len_Sign_NC) <> @sign_NC
	END

	--[SET UP INDEX ROW THEO PARTITION]
	select ROW_NUMBER() over(partition by LevelOrder1,LevelOrder2 order by LevelOrder1,LevelOrder2, InventoryID, [Index]) STT
			,LevelOrder1,LevelOrder2, InventoryID, [Index]
			into #tbl_index
	from @tableResult
	where Specification IS NULL

	update @tableResult
	set STTCaption = STT
	from @tableResult M
			inner join #tbl_index R01 on  M.[Index] = R01.[Index]

	--Cập nhật xuất xứ - [Desciption]
	update @tableResult
	set M.Desciption = R01.InventoryName
		, OriginName = CASE WHEN TypeOrder = @lv3 THEN R02_I03.AnaName ELSE ''  END
	from @tableResult M 
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
		left join AT1015 R02_I03 with (nolock) on R01.I03ID = R02_I03.AnaID AND R02_I03.AnaTypeId= 'I03'
	where M.[Specification] IS NULL 

	--[CẬP NHẬT MÃ PHÂN TÍCH CHO MÃ NHÂN CÔNG (NẾU CHƯA CÓ)]
	update @tableResult
	set LevelOrder1 = R01.LevelOrder1, LevelOrder2 = R01.LevelOrder2
	from @tableResult M
		inner join (select InventoryID,LevelOrder1, LevelOrder2 
					from @tableResult
					where RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC AND ISNULL(Specification,'') = '') R01 on LEFT(M.InventoryID, LEN(M.InventoryID) - @len_Sign_NC) = R01.InventoryID
	where RIGHT(M.InventoryID,@len_Sign_NC) = @sign_NC 
	
	--[DỮ LIỆU CẤP 1]
	select CHAR(64 + (ROW_NUMBER() OVER (ORDER BY LevelOrder1,LevelDesciption))) STT
			,LevelOrder1,LevelDesciption, CAST(NULL AS decimal(28,8)) as OriginalAmount 
			, @InventoryVirual_lv1 InventoryID
			, @lv1 TypeOrder
			, CAST(00.00000 as decimal(10,5))  as OrderIndex
			into #tbl_LevelOrder1
	from @tableResult
	where LevelOrder1 is not null 
		AND RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC		
	group by LevelOrder1,LevelDesciption	

	--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
	insert into @tableResult(STTCaption,LevelOrder1,Desciption,OriginalAmount,TypeOrder)
	select STT,LevelOrder1, R02_I01.AnaName,OriginalAmount, TypeOrder
	from #tbl_LevelOrder1 M
	left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A09') R02_I01 on M.LevelOrder1 = R02_I01.AnaID 

	--[DỮ LIỆU CẤP 1]-- cập nhật tổng tiền
	update #tbl_LevelOrder1
	set OriginalAmount = R01.OriginalAmount, OrderIndex = R02.OrderIndex + @AutoIndex01
	from #tbl_LevelOrder1 M
		inner join (select LevelOrder1, sum(Quantity*UnitPrice) OriginalAmount
					from @tableResult
					group by LevelOrder1
					) R01 on M.LevelOrder1 = R01.LevelOrder1
		inner join (select LevelOrder1, Max(OrderIndex) OrderIndex
					from @tableResult
					group by LevelOrder1
					) R02 on M.LevelOrder1 = R02.LevelOrder1

	
	--[DỮ LIỆU CẤP 2]
	select dbo.ToRoman(ROW_NUMBER() OVER (partition by LevelOrder1 ORDER BY LevelOrder1,LevelOrder2,LevelDesciption)) STT
			, LevelOrder1,LevelOrder2,LevelDesciption, CAST(NULL AS decimal(28,8)) as OriginalAmount 
			, @InventoryVirual_lv2 InventoryID
			, @lv2 TypeOrder
			, CAST(00.00000 as decimal(10,5))  as OrderIndex
			into #tbl_LevelOrder2
	from @tableResult
	where LevelOrder1 is not null 
			and LevelOrder2 is not null 
			and RIGHT(InventoryID,@len_Sign_NC) <> @sign_NC
	group by LevelOrder1,LevelOrder2,LevelDesciption

	
	--[BỔ SUNG DÒNG DỮ LIỆU TỔNG]
	insert into @tableResult(STTCaption,LevelOrder1,LevelOrder2,Desciption,OriginalAmount,TypeOrder)
	select STT,LevelOrder1,LevelOrder2,R02_I01.AnaName,OriginalAmount, TypeOrder
	from #tbl_LevelOrder2 M
		left join (select AnaID, AnaName from AT1011 with (nolock) where AnaTypeId= 'A10') R02_I01 on M.LevelOrder2 = R02_I01.AnaID 

	--[DỮ LIỆU CẤP 2]-- cập nhật tổng tiền
	update #tbl_LevelOrder2
	set OriginalAmount = R01.OriginalAmount, OrderIndex = R02.OrderIndex + @AutoIndex02
	from #tbl_LevelOrder2 M
		inner join (select LevelOrder1,LevelOrder2, sum(Quantity*UnitPrice) OriginalAmount
					from @tableResult
					group by LevelOrder1,LevelOrder2
					) R01 on M.LevelOrder1 = R01.LevelOrder1 and  M.LevelOrder2 = R01.LevelOrder2
		inner join (select LevelOrder1,LevelOrder2, max(OrderIndex) OrderIndex
					from @tableResult
					group by LevelOrder1,LevelOrder2
					) R02 on M.LevelOrder1 = R02.LevelOrder1 and  M.LevelOrder2 = R02.LevelOrder2
	
	
	--[BỔ SUNG DỮ LIỆU VÀO BẢNG LƯU KẾT QUẢ]	
	insert into @tableResult(STTCaption,LevelOrder1,LevelOrder2,InventoryID,Desciption,OriginalAmount,TypeOrder, OrderIndex)
	select STT,LevelOrder1,InventoryID,InventoryID,LevelDesciption,OriginalAmount, TypeOrder, OrderIndex
	from #tbl_LevelOrder1

	insert into @tableResult(STTCaption,LevelOrder1,LevelOrder2,InventoryID,Desciption,OriginalAmount,TypeOrder, OrderIndex)
	select STT,LevelOrder1,LevelOrder2,InventoryID,LevelDesciption,OriginalAmount, TypeOrder, OrderIndex
	from #tbl_LevelOrder2



	select LevelOrder1,LevelOrder2 ,OrderIndex,InventoryID,[Index]
	,TypeOrder
	, STTCaption	
	, CASE 
		WHEN Specification IS NOT NULL THEN ''
		WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN ''
		ELSE InventoryID
		END InventoryIDCaption
	, R01.UnitName as UnitID, Specification, AccessoryID
	, CASE 
		WHEN InventoryID IN (@InventoryVirual_lv1,@InventoryVirual_lv2) THEN @Caption_Total + ' ' + STTCaption
		WHEN Specification IS NULL THEN Desciption		
		ELSE Specification
		END AS Desciption
	, OriginName, Quantity, UnitPrice
	, CASE
		WHEN TypeOrder NOT IN (@lv1,@lv2) THEN Quantity*UnitPrice 
		WHEN TypeOrder IS NULL AND RIGHT(InventoryID,@len_Sign_NC) = @sign_NC	 THEN Quantity*UnitPrice 
		ELSE OriginalAmount
	  END	as OriginalAmount
	, QuantityLabor 
	, UnitPriceLabor
	, QuantityLabor*UnitPriceLabor as AmountLabor
	, ISNULL(Quantity*UnitPrice,0)  + ISNULL(QuantityLabor*UnitPriceLabor,0) AS Amount
	from @tableResult M	
		LEFT JOIN AT1304 R01 ON M.UnitID = R01.UnitID
	--WHERE InventoryID IS NOT NULL
	--order by TypeOrder,OrderIndex,InventoryID,[Index]
	order by LevelOrder1,LevelOrder2,OrderIndex,InventoryID,[Index]

	SELECT @AmountTotal AmountTotal, ISNULL(@ReduceCost,0) DiscountAmount
	, (ISNULL(@AmountTotal,0) - ISNULL(@ReduceCost,0)) as PacketTotal, 0 VAT10
end



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
