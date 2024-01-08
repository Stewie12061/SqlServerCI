if exists (select * from sys.objects where [name] = 'SOP20220' and [type] = 'P')
	drop proc SOP20220
go
--  <Summary>
--		Báo giá thiết bị dự án
--  </Summary>
--	<History>
/*
	Ngày tạo: 11/09/2019 
		Người tạo: Bảo Toàn
*/
--	</History>
--	<Example>
/*	
	SOP20220 'DTI', '9b5883af-54aa-48c3-a0c1-99708a391bc6', 'BAOTOAN'
*/
--	</Example>
create proc SOP20220 
@DivisionID varchar(50),
@APKOT2101 varchar(36),
@UserID varchar(50)
as
begin
	--cấu trúc dữ liệu chi tiết phiếu báo giá
	declare @tableData table(
						APK UNIQUEIDENTIFIER default newid(),
						APK_QuotationID UNIQUEIDENTIFIER,
						APK_TransactionID UNIQUEIDENTIFIER,
						Specification NVARCHAR(MAX),
						InventoryID varchar(50),
						Quantity decimal(28,8),						-- Số lượng
						UnitPrice decimal(28,8)						-- Đơn giá					
						)
	--add data 
	insert into @tableData(APK_QuotationID, APK_TransactionID, InventoryID, Specification, Quantity, UnitPrice)
	select QuotationID,TransactionID,InventoryID,Specification,QuoQuantity,UnitPrice
	from OT2102 with (nolock)
	where QuotationID = @APKOT2101

	--table phụ kiện
	declare @tableAccessoryData table(
						APK UNIQUEIDENTIFIER default newid(),
						APK_QuotationID UNIQUEIDENTIFIER,
						APK_TransactionID UNIQUEIDENTIFIER,
						InventoryID varchar(50),
						Quantity decimal(28,8)						-- Số lượng			
						)
	--data face
	insert into @tableAccessoryData(APK_QuotationID, APK_TransactionID, InventoryID, Quantity)
	select  APKOT2101,APKOT2102,InventoryID,Quantity
	from SOT2027 with (nolock)
	where APKOT2101 = @APKOT2101
	--view
	--select * from @tableData

	--data result
	declare @tableResult table(		
						STT int,
						InventoryID varchar(50),
						Specification nvarchar(MAX),				-- Thông tin kỹ thuật
						AccessoryID	varchar(50),					-- Id phụ kiện
						Desciption nvarchar(MAX),					-- Nội dung hiển thị
						OriginName nvarchar(500),						-- Mã phân tích xuất xứ
						Quantity decimal(28,8),						-- Số lượng
						UnitPrice decimal(28,8),					-- Đơn giá
						[Index] int identity(1,1)
						)
	--thêm dữ liệu hiện tại
	insert into @tableResult(STT,InventoryID,Quantity,UnitPrice)
	select ROW_NUMBER() OVER(order by InventoryID), InventoryID,Quantity,UnitPrice 
	from @tableData
	where RIGHT(InventoryID,3) <> '.NC'

	--thêm thông tin kỹ thuật - customeridex = DTI
	insert into @tableResult(InventoryID,Specification)
	select M.InventoryID, ISNULL(M.Specification,R01.Specification)
	from @tableData M 
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
	where RIGHT(M.InventoryID,3) <> '.NC' and ISNULL(M.Specification,R01.Specification) is not null

	--thêm chi phí nhân công - customeridex = DTI
	insert into @tableResult(InventoryID,Quantity,UnitPrice)
	select M.InventoryID,M.Quantity,M.UnitPrice 
	from @tableData M 
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
	where RIGHT(M.InventoryID,3) = '.NC'

	--thêm phụ kiện
	insert into @tableResult(InventoryID,AccessoryID,Quantity)
	select R01.InventoryID, M.InventoryID, M.Quantity
	from @tableAccessoryData M
		inner join OT2102 R01 with (nolock) on M.APK_TransactionID = R01.TransactionID

	--Cập nhật xuất xứ - [Desciption]

	update @tableResult
	set Desciption = R01.InventoryName, OriginName = R02.AnaName
	from @tableResult M 
		left join AT1302 R01 with (nolock) on M.AccessoryID = R01.InventoryID
		left join AT1015 R02 with (nolock) on R01.I03ID = R02.AnaID AND R02.AnaTypeId= 'I03'

	update @tableResult
	set M.Desciption = R01.InventoryName, OriginName = R02.AnaName
	from @tableResult M 
		left join AT1302 R01 with (nolock) on M.InventoryID = R01.InventoryID
		left join AT1015 R02 with (nolock) on R01.I03ID = R02.AnaID AND R02.AnaTypeId= 'I03'
	where M.Desciption is null

	update @tableResult
	set Desciption = [Specification]
	where [Specification] is not null

	select STT, InventoryID, Specification, AccessoryID, Desciption, OriginName, Quantity, UnitPrice,Quantity*UnitPrice as OriginalAmount
	from @tableResult
	order by InventoryID, [Index]


end
