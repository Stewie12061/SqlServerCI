IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00169]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00169]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Detail phiếu in phiếu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao thị Phượng on 08/02/2018
----Edited by: Hoàng Vũ 29/03/2018: Chuyển OKIA từ Sript sang Store để dễ chỉnh sửa
----Edited by: Hoàng Vũ 22/05/2018: Đối với trường hợp bảng giá trước thuế hoặc sau thuế đều Đơn giá + Tiền thuế=> Không tính toán lại để dảm bảo số lẻ
----Edited by: Hoàng Vũ 22/05/2018: Lấy số series và số bảo hành trường hợp không xuất ngay
----Edited by: Hoàng Vũ 26/07/2018: Dùng trường APKPackageInventoryID để truy ngược lại bảng giá bán theo gói (1 gói sản phẩm có thể khai báo 1 mặt hàng nhiều lần)
----Edited by: Hoàng Vũ 26/09/2018: Fixbug lỗi trường hợp khi lưu không lên giá gói
----Edited by : Hoàng Vũ on 11/04/2019, Lấy mẫu của MINHSANG làm mẫu bên NHANNGOC
----Modify by: Hoàng Vũ 16/04/2019: Lấy các trường bên bảng giá lưu trự qua phiếu bán hàng M.MinPrice, M.Notes01, M.Notes02, M.Notes03 để phục vụ tính điểm, tính hoa hòng theo nhân viên => KHACH HANG NHANNHOC
----Example: exec POSP00169 @DivisionID=N'HCM',@APK='7100FED4-C3EC-483F-AA19-B2D55F089DB1',@UserID=N'ASSUPPORT'

 CREATE PROCEDURE POSP00169 (
		 @DivisionID	VARCHAR(50),
		 @APK NVARCHAR(50),
		 @UserID		NVARCHAR(50)
		)
AS

	DECLARE @CustomerName INT
	
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
	
	IF @CustomerName =  79 or @CustomerName =  108 --MINHSANG or NHANHNGOC
	Begin
			Declare @PVoucherNo Int,
			@CVoucherNo Int
			Select @PVoucherNo = (Case when isnull(PVoucherNo, '') != '' then 1 else 0 end)
					, @CVoucherNo = (Case when isnull(CVoucherNo, '') != '' then 1 else 0 end) From POST0016 With (NOLOCK) Where APK = @APK

	
			IF Isnull(@PVoucherNo, 0) = 0 and Isnull(@CVoucherNo, 0) = 0 --Phiếu bán hàng
			Begin
					Select ROW_NUMBER() OVER (ORDER BY M.InventoryID) AS RowNum, M.APKMaster
				, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName, SUm(M.ActualQuantity) AS Sale , M.UnitPrice, M.Amount
				, A.S1, A1.SName as SName1, A.S2, A2.SName as SName2, A.S3, A3.SName as SName3 
				, isnull(sum(D.ShipQuantity),0) as Delivery 
				, Isnull(sum(M.ActualQuantity),0) - isnull(sum(D.ShipQuantity), 0) as NoDelivery
				FROM POST00161 M WITH (NOLOCK)
				LEFT JOIN POST0028 D WITH (NOLOCK) ON D.APKMInherited = M.APKMaster AND D.APKDInherited = M.APK AND D.InventoryID = M.InventoryID and D.DeleteFlg = M.DeleteFlg
				LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = M.InventoryID 
				LEFT JOIN AT1310 A1 WITH (NOLOCK) ON A.S1 = A1.S AND A1.STypeID ='I01'
				LEFT JOIN AT1310 A2 WITH (NOLOCK) ON A.S2 = A2.S AND A2.STypeID ='I02'
				LEFT JOIN AT1310 A3 WITH (NOLOCK) ON A.S3 = A3.S AND A3.STypeID ='I03'
				Where M.DivisionID= @DivisionID AND M.APKMaster = @APK and M.DeleteFlg = 0
				Group by  M.APKMaster, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName,  M.UnitPrice, M.Amount , A.S1, A1.SName, A.S2, A2.SName, A.S3, A3.SName 
			EnD

			IF Isnull(@PVoucherNo, 0) = 1 --Phiếu trả hàng
			Begin
					Select ROW_NUMBER() OVER (ORDER BY M.InventoryID) AS RowNum, M.APKMaster
				, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName, SUm(M.ActualQuantity) AS Sale , M.UnitPrice
				, M.DiscountAmount as DiscountAmount
				, M.Amount - M.DiscountAmount as Amount, C.Notes
				, A.S1, A1.SName as SName1, A.S2, A2.SName as SName2, A.S3, A3.SName as SName3 
				, isnull(sum(D.ActualQuantity),0) as Delivery 
				, Isnull(sum(M.ActualQuantity),0) - isnull(sum(D.ActualQuantity), 0) as NoDelivery
				FROM POST00161 M WITH (NOLOCK)
				LEFT JOIN POST0016 C WITH (NOLOCK) ON C.APK = M.APKMaster AND C.DeleteFlg = M.DeleteFlg
				LEFT JOIN POST00151 D WITH (NOLOCK) ON D.APKMInherited = M.APKMaster AND D.APKDInherited = M.APK AND D.InventoryID = M.InventoryID and D.DeleteFlg = M.DeleteFlg
				LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = M.InventoryID 
				LEFT JOIN AT1310 A1 WITH (NOLOCK) ON A.S1 = A1.S AND A1.STypeID ='I01'
				LEFT JOIN AT1310 A2 WITH (NOLOCK) ON A.S2 = A2.S AND A2.STypeID ='I02'
				LEFT JOIN AT1310 A3 WITH (NOLOCK) ON A.S3 = A3.S AND A3.STypeID ='I03'
				Where M.DivisionID= @DivisionID AND M.APKMaster = @APK and M.DeleteFlg = 0
				Group by  M.APKMaster, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName,  M.UnitPrice, M.DiscountAmount, M.Amount, C.Notes
						, A.S1, A1.SName, A.S2, A2.SName, A.S3, A3.SName
			EnD

			IF Isnull(@CVoucherNo, 0) = 1 --Phiếu đổi hàng
			Begin
					Select ROW_NUMBER() OVER (ORDER BY M.InventoryID) AS RowNum, M.APKMaster, M.InventoryID, M.InventoryName
						, M.UnitID, M.UnitName, M.ActualQuantity AS Sale , M.UnitPrice
						, M.DiscountAmount as DiscountAmount
						, M.Amount - M.DiscountAmount as Amount, C.Notes
						, A.S1, A1.SName as SName1, A.S2, A2.SName as SName2, A.S3, A3.SName as SName3, 0 as Delivery, 0 as NoDelivery, M.IsKindVoucherID
				FROM POST00161 M WITH (NOLOCK)
						LEFT JOIN POST0016 C WITH (NOLOCK) ON C.APK = M.APKMaster AND C.DeleteFlg = M.DeleteFlg
						LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = M.InventoryID 
						LEFT JOIN AT1310 A1 WITH (NOLOCK) ON A.S1 = A1.S AND A1.STypeID ='I01'
						LEFT JOIN AT1310 A2 WITH (NOLOCK) ON A.S2 = A2.S AND A2.STypeID ='I02'
						LEFT JOIN AT1310 A3 WITH (NOLOCK) ON A.S3 = A3.S AND A3.STypeID ='I03'
				Where M.DivisionID= @DivisionID AND M.APKMaster = @APK and M.DeleteFlg = 0 and M.IsKindVoucherID = 2
				Union all
					Select ROW_NUMBER() OVER (ORDER BY M.InventoryID) AS RowNum, M.APKMaster, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName
						, SUm(M.ActualQuantity) AS Sale, M.UnitPrice
						, Sum(Isnull(M.DiscountAmount, 0)) as DiscountAmount
						, Sum(Isnull(M.Amount, 0)) - Sum(Isnull(M.DiscountAmount, 0)) as Amount, C.Notes
						, A.S1, A1.SName as SName1, A.S2, A2.SName as SName2, A.S3, A3.SName as SName3
						, isnull(sum(D.ShipQuantity),0) as Delivery, Isnull(sum(M.ActualQuantity),0) - isnull(sum(D.ShipQuantity), 0) as NoDelivery, M.IsKindVoucherID
				FROM POST00161 M WITH (NOLOCK)
				LEFT JOIN POST0016 C WITH (NOLOCK) ON C.APK = M.APKMaster AND C.DeleteFlg = M.DeleteFlg
				LEFT JOIN POST0028 D WITH (NOLOCK) ON D.APKMInherited = M.APKMaster AND D.APKDInherited = M.APK AND D.InventoryID = M.InventoryID and D.DeleteFlg = M.DeleteFlg
				LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = M.InventoryID 
				LEFT JOIN AT1310 A1 WITH (NOLOCK) ON A.S1 = A1.S AND A1.STypeID ='I01'
				LEFT JOIN AT1310 A2 WITH (NOLOCK) ON A.S2 = A2.S AND A2.STypeID ='I02'
				LEFT JOIN AT1310 A3 WITH (NOLOCK) ON A.S3 = A3.S AND A3.STypeID ='I03'
				Where M.DivisionID= @DivisionID AND M.APKMaster = @APK and M.DeleteFlg = 0 and M.IsKindVoucherID = 1
				Group by  M.APKMaster, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName, M.UnitPrice,C.Notes
						, A.S1, A1.SName, A.S2, A2.SName, A.S3, A3.SName, M.IsKindVoucherID
			EnD
	End

	IF @CustomerName =  87 --OKIA
	Begin
		IF NOT EXISTS (Select Top 1 1 From POST00161 Where APKMaster = @APK and DeleteFlg = 0 and Isnull(IsTaxIncluded, 0) = 1)
		BEGIN
			Select D.APK, D.APKMaster, D.DivisionID, D.ShopID
					, Isnull(D.IsDisplay, 0) as IsDisplay, D.WareHouseID, D.WareHouseName
					, Isnull(D.IsPackage, 0) as IsPackage, D.PackagePriceID, D.PackageID, C47.PackageName
					, D.InventoryID, D.InventoryName, D.IsPromotion
					, D.UnitID, D.UnitName
					, Case when D.IsExportNow = 1 Then SerialNo
						   when D.IsWarehouseGeneral = 0 and D.IsExportNow = 0 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), x.SerialNo)
																									From  POST0028 x WITH (NOLOCK)
																									Where D.DivisionID = x.DivisioNID and D.APKMaster = x.APKMInherited and D.APK = x.APKDInherited and x.DeleteFlg = 0
																									Group By x.SerialNo
																									Order by x.SerialNo
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   when D.IsWarehouseGeneral = 1 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), A27.SerialNo)
																									From WT0096 W96 Inner join AT2007 A27 on W96.VoucherID = A27.InheritVoucherID and W96.TransactionID = A27.InheritTransactionID
																									Where D.DivisionID = W96.DivisioNID and D.APKMaster = W96.InheritVoucherID and D.APK = W96.InheritTransactionID 
																									Group By A27.SerialNo
																									Order by A27.SerialNo
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   End as SerialNo

					, Case when D.IsExportNow = 1 Then WarrantyCard
						   when D.IsWarehouseGeneral = 0 and D.IsExportNow = 0 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), x.WarrantyCard)
																									From  POST0028 x WITH (NOLOCK)
																									Where D.DivisionID = x.DivisioNID and D.APKMaster = x.APKMInherited and D.APK = x.APKDInherited and x.DeleteFlg = 0
																									Group By x.WarrantyCard
																									Order by x.WarrantyCard
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   when D.IsWarehouseGeneral = 1 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), A27.WarrantyCard)
																									From WT0096 W96 Inner join AT2007 A27 on W96.VoucherID = A27.InheritVoucherID and W96.TransactionID = A27.InheritTransactionID
																									Where D.DivisionID = W96.DivisioNID and D.APKMaster = W96.InheritVoucherID and D.APK = W96.InheritTransactionID 
																									Group By A27.WarrantyCard
																									Order by A27.WarrantyCard
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   End as WarrantyCard

					, Case when D.IsPackage = 1 then 1.0 else 0.0 end as PackageQuantity
					, Case when D.IsPackage = 1 then C48.PackagePrice else 0.0 end as PackagePrice
					, Case when D.IsPackage = 1 then C48.PackagePrice else 0.0 end as PackageAmount
					, D.ActualQuantity
					, Case when D.IsPackage = 1 then 0.0 else Case when D.IsPromotePriceTable = 1 then Isnull(O31.UnitPrice, 0) + Isnull(O31.VATAmount, 0)
																   when D.IsTable = 1 then Isnull(O32.UnitPrice, 0) + Isnull(O32.VATAmount, 0)
																   Else Isnull(D.UnitPrice, 0)+Isnull(D.TaxAmount, 0) End
						   end as  UnitPrice
					, Case when D.IsPackage = 1 then 0.0 else Case when D.IsPromotePriceTable = 1 then (Isnull(O31.UnitPrice, 0) + Isnull(O31.VATAmount, 0)) * Isnull(D.ActualQuantity, 0)
																   when D.IsTable = 1 then (Isnull(O32.UnitPrice, 0) + Isnull(O32.VATAmount, 0)) * Isnull(D.ActualQuantity, 0)
																   Else (Isnull(D.UnitPrice, 0)+Isnull(D.TaxAmount, 0)) * Isnull(D.ActualQuantity, 0) End
						   end as  Amount
					, D.OrderPackage
					, D.VATPercent
					, D.DiscountRate
					, Isnull(D.DiscountAmount, 0) as DiscountAmountAVAT
					, Isnull(D.TaxAmount, 0) as RefVATAmount
					, D.*
					
				from POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
						LEFT JOIN CT0147 C47  With (NOLOCK) on D.PackagePriceID = C47.PackagePriceID and D.PackageID = C47.PackageID
						--Lấy bảng giá gói
						LEFT JOIN (
									SELECT M.APKMaster, M.PackagePriceID, M.PackageID, Isnull(M.OrderPackage, 0) as OrderPackage, Sum(C48.UnitPrice + C48.VATAmount) as PackagePrice 
									FROM POST00161 M  With (NOLOCK) INNER JOIN CT0148 C48 With (NOLOCK) on M.PackagePriceID = C48.PackagePriceID and M.PackageID = C48.PackageID 
										  and (Case when Isnull(Cast(M.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(C48.APK as nvarchar(50)) else C48.InventoryID end)
											= (Case when Isnull(Cast(M.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(M.APKPackageInventoryID as nvarchar(50)) Else M.InventoryID end)
									WHERE M.APKMaster = @APK and M.DeleteFlg = 0 and M.IsPackage = 1
									Group by M.APKMaster, M.PackagePriceID, M.PackageID, Isnull(M.OrderPackage, 0)
								  ) C48 ON D.APKMaster = C48.APKMaster and D.PackagePriceID = C48.PackagePriceID and D.PackageID = C48.PackageID and Isnull(D.OrderPackage, 0) = Isnull(C48.OrderPackage, 0)
						--Lấy bảng giá khuyến mãi
						LEFT JOIN OT1302 O31 With (NOLOCK) on O31.DivisionID = D.DivisionID and O31.ID = D.PromotePriceTableID and O31.InventoryID = D.InventoryID and D.IsPromotePriceTable = 1
						--Lấy bảng giá chung
						LEFT JOIN OT1302 O32 With (NOLOCK) on O32.DivisionID = D.DivisionID and O32.ID = D.PriceTable and O32.InventoryID = D.InventoryID and D.IsTable = 1
						--Lấy số series và số bảo hành từ phiếu xuất ERP Xuất chi nhánh hoặc POS xuất sau
						LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID
				Where M.APK = @APK and M.DeleteFlg = 0
				Order by D.OrderNo, D.OrderPackage
		End
		Else
		Begin
			Select D.APK, D.APKMaster, D.DivisionID, D.ShopID, Isnull(D.IsDisplay, 0) as IsDisplay, D.WareHouseID, D.WareHouseName
				, Isnull(D.IsPackage, 0) as IsPackage, D.PackagePriceID, D.PackageID, C47.PackageName, D.InventoryID, D.InventoryName
				, D.IsPromotion, D.UnitID, D.UnitName
				, Case when D.IsExportNow = 1 Then SerialNo
						   when D.IsWarehouseGeneral = 0 and D.IsExportNow = 0 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), x.SerialNo)
																									From  POST0028 x WITH (NOLOCK)
																									Where D.DivisionID = x.DivisioNID and D.APKMaster = x.APKMInherited and D.APK = x.APKDInherited and x.DeleteFlg = 0
																									Group By x.SerialNo
																									Order by x.SerialNo
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   when D.IsWarehouseGeneral = 1 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), A27.SerialNo)
																									From WT0096 W96 Inner join AT2007 A27 on W96.VoucherID = A27.InheritVoucherID and W96.TransactionID = A27.InheritTransactionID
																									Where D.DivisionID = W96.DivisioNID and D.APKMaster = W96.InheritVoucherID and D.APK = W96.InheritTransactionID 
																									Group By A27.SerialNo
																									Order by A27.SerialNo
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   End as SerialNo

					, Case when D.IsExportNow = 1 Then WarrantyCard
						   when D.IsWarehouseGeneral = 0 and D.IsExportNow = 0 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), x.WarrantyCard)
																									From  POST0028 x WITH (NOLOCK)
																									Where D.DivisionID = x.DivisioNID and D.APKMaster = x.APKMInherited and D.APK = x.APKDInherited and x.DeleteFlg = 0
																									Group By x.WarrantyCard
																									Order by x.WarrantyCard
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   when D.IsWarehouseGeneral = 1 Then stuff(isnull((Select  ' ,' + convert(Varchar(50), A27.WarrantyCard)
																									From WT0096 W96 Inner join AT2007 A27 on W96.VoucherID = A27.InheritVoucherID and W96.TransactionID = A27.InheritTransactionID
																									Where D.DivisionID = W96.DivisioNID and D.APKMaster = W96.InheritVoucherID and D.APK = W96.InheritTransactionID 
																									Group By A27.WarrantyCard
																									Order by A27.WarrantyCard
																									FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') 
						   End as WarrantyCard
				, Case when D.IsPackage = 1 then 1.0 else 0.0 end as PackageQuantity
				, Case when D.IsPackage = 1 then C48.PackagePrice else 0.0 end as PackagePrice
				, Case when D.IsPackage = 1 then C48.PackagePrice else 0.0 end as PackageAmount
				, D.ActualQuantity
				, Case when D.IsPackage = 1 then 0.0 else Isnull(D.UnitPrice, 0) end as  UnitPrice
				, Case when D.IsPackage = 1 then 0.0 else Isnull(D.UnitPrice, 0) * Isnull(D.ActualQuantity, 0) end as  Amount
				, Isnull(D.DiscountAmount, 0) as DiscountAmountAVAT
				--, D.BeforeVATUnitPrice * D.ActualQuantity
				--			- D.BeforeVATDiscountAmount 
				--			- Case when Isnull(M.TotalAmount, 0) ! = 0 
				--				   then (M.TotalDiscountAmount + M.TotalRedureAmount) * (D.BeforeVATUnitPrice * D.ActualQuantity- D.BeforeVATDiscountAmount )/M.TotalAmount
				--				   else 0 end as RefBeforeAmount 
				, Isnull(D.TaxAmount, 0)  as RefVATAmount
				, D.OrderPackage, D.OrderNo 
			from POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
					left join CT0147 C47  With (NOLOCK) on D.PackagePriceID = C47.PackagePriceID and D.PackageID = C47.PackageID
					LEFT JOIN (
									SELECT M.APKMaster, M.PackagePriceID, M.PackageID, Isnull(M.OrderPackage, 0) as OrderPackage, Sum(C48.UnitPrice) as PackagePrice 
									FROM POST00161 M  With (NOLOCK) INNER JOIN CT0148 C48 With (NOLOCK) on M.PackagePriceID = C48.PackagePriceID and M.PackageID = C48.PackageID 
										  and (Case when Isnull(Cast(M.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(C48.APK as nvarchar(50)) else C48.InventoryID end)
											= (Case when Isnull(Cast(M.APKPackageInventoryID as nvarchar(50)), '') != '' then  Cast(M.APKPackageInventoryID as nvarchar(50)) Else M.InventoryID end)
									WHERE M.APKMaster = @APK and M.DeleteFlg = 0 and M.IsPackage = 1
									Group by M.APKMaster, M.PackagePriceID, M.PackageID, M.OrderPackage
							  ) C48 ON D.APKMaster = C48.APKMaster and D.PackagePriceID = C48.PackagePriceID and D.PackageID = C48.PackageID and Isnull(D.OrderPackage, 0) = Isnull(C48.OrderPackage, 0)
					LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID
			Where M.APK = @APK and M.DeleteFlg = 0
			Order by D.OrderNo, D.OrderPackage
		End
	End



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
