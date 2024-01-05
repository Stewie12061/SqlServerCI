IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00168]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00168]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load master phiếu in phiếu bán hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao thị Phượng on 08/02/2018
----Edited by: Hoàng Vũ 29/03/2018: Chuyển OKIA từ Sript sang Store để dễ chỉnh sửa
----Edited by : Hoàng Vũ on 27/04/2018, Lấy chương trình khuyến mãi theo ghi chú trong lưới nhập liệu của phiếu
----Edited by : Hoàng Vũ on 11/04/2019, Lấy mẫu của MINHSANG làm mẫu bên NHANNGOC
----Edited by : Hoàng Vũ on 08/05/2019, Lấy Số điện thoại trên phiếu bán hàng, trường hợp nếu rổng thì lấy bên Hội viên
----Edited by : Hoàng Vũ on 09/05/2019, Lấy địa chỉ và tên khác hàng nếu là hội viên trên phiếu bán hàng, trường hợp nếu rổng thì lấy bên Hội viên
----Modify by : Trà Giang on 01/08/2019:Bổ sung thông tin công nợ của khách hàng (NHANNGOC)
----Example: exec POSP00168 @DivisionID=N'NN',@APK='416974E0-5924-4680-98A6-E6C1B03051B0',@UserID=N'ADMIN'

 CREATE PROCEDURE POSP00168 (
		 @DivisionID	VARCHAR(50),
		 @APK NVARCHAR(50),
		 @UserID		NVARCHAR(50)
		)
AS

	DECLARE @CustomerName INT
	
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
	
	IF @CustomerName =  79 or @CustomerName =  108  --MINHSANG or NHANGOC
	Begin
			Declare @PVoucherNo Int,
			@CVoucherNo Int
			Select @PVoucherNo = (Case when isnull(PVoucherNo, '') != '' then 1 else 0 end)
				 , @CVoucherNo = (Case when isnull(CVoucherNo, '') != '' then 1 else 0 end) From POST0016 With (NOLOCK) Where APK = @APK

			IF Isnull(@PVoucherNo, 0) = 0 and Isnull(@CVoucherNo, 0) = 0 --Phiếu bán hàng
			Begin
				SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherNo, M.VoucherDate, M.MemberID
					--, M.MemberName
					, Case when Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) != '' then Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) else isnull(M.MemberName,'') end  as MemberName
					--, M.Address
					, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(M.Address,'') end  as Address
					, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(M.Phone,'') + ' - ' + isnull(M.Tel,'') end  as Phone
					,  M.TeL, M.TotalAmount, M.TotalDiscountAmount, M.TotalRedureAmount, M.VATAmount
					, M.TotalInventoryAmount - Isnull(M.TotalGiftVoucherAmount, 0) as TotalInventoryAmount, M.InstallmentAmount,  M.ReceiptAmount - Isnull(M.TotalGiftVoucherAmount, 0) as ReceiptAmount
					,  Case When (InstallmentAmount > 0 and  M.Change <= 0) then M.Change*(-1)
							WHEN (InstallmentAmount > 0 and  M.Change >= 0) then 0.0 else M.ReceiptAmount - Isnull(M.TotalGiftVoucherAmount, 0) - M.PaymentAmount  END AS DepositAmount
					, M.PaymentAmount, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver 
					, M.SaleManID, M.SalenanName, M.EmployeeID, M.EmployeeName,M.DebitAmount
				From (
						SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherNo, M.VoucherDate, M.MemberID, M.MemberName, M.TotalAmount, D.Address
								, isnull(D.Phone,'') as Phone,   isnull(D.Tel,'') Tel, M.TotalInventoryAmount, M.TotalDiscountAmount, M.TotalRedureAmount, M.Change
								, Case When (A.PaymentID01 = 'TRAGOP') THEN  M.PaymentObjectAmount01 
										When (A.PaymentID02 = 'TRAGOP') THEN  M.PaymentObjectAmount02
										ELSE 0.0  end AS InstallmentAmount
								, Case When (A.PaymentID01 = 'TRAGOP') and M.Change <= 0 THEN (M.TotalInventoryAmount - M.PaymentObjectAmount01 ) 
										When (A.PaymentID02 = 'TRAGOP') and M.Change <= 0 THEN  (M.TotalInventoryAmount - M.PaymentObjectAmount02)  
										ELSE M.TotalInventoryAmount end AS ReceiptAmount, isnull(F.PaymentAmount,0) PaymentAmount
								, M.TotalTaxAmount as VATAmount, M.TotalGiftVoucherAmount
								, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
								, M.SaleManID, A03.FullName as SalenanName, M.EmployeeID, M.EmployeeName, SUM(G.DebitAmount) + ISNULL(D.BeginPeriodDebt,0) as DebitAmount
						FROM POST0016 M WITH (NOLOCK) LEFT JOIN (
																	Select F.DivisionID, F.APKMInherited, Sum(F.PaymentAmount) as PaymentAmount
																	FROM (
																			SELECT F.DivisionID, F.APKMInherited, Case WHEN (isnull(A.PaymentID01,'') = 'TRAGOP') and  SUM(F.Amount)> 0 And SUM(F.Amount)- isnull(M.PaymentObjectAmount01,0)  >=0 THEN  SUM(F.Amount)- isnull(M.PaymentObjectAmount01,0) 
																														When (isnull(A.PaymentID01,'') = 'TRAGOP') and  SUM(F.Amount)> 0 And SUM(F.Amount)- isnull(M.PaymentObjectAmount01,0)  >=0  THEN  SUM(F.Amount) - isnull(M.PaymentObjectAmount02,0)
																														ELSE  SUM(F.Amount) end AS PaymentAmount 
																			FROM POST00802 F WITH (NOLOCK) Inner JOIN POST00801  M WITH (NOLOCK) ON M.APK = F.APKMaster
																											LEFT JOIN POST0006 A WITH (NOLOCK) ON A.APK = M.APKPaymentID
																			WHERE isnull(F.DeleteFlg,0) = 0 
																			Group By F.APKMInherited, F.DivisionID,A.PaymentID01,A.PaymentID02, M.PaymentObjectAmount01, M.PaymentObjectAmount02
																		)F
																	Group By F.APKMInherited, F.DivisionID
																	)F ON F.APKMInherited = Cast(M.APK as Varchar(50))and F.DivisionID = M.DivisionID
														LEFT JOIN POST0011 D WITH (NOLOCK) ON D.MemberID = M.MemberID
														LEFT JOIN POST0006 A WITH (NOLOCK) ON A.APK = M.APKPaymentID
														LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = M.SaleManID
							LEFT JOIN 
							(
							Select M.DivisionID, M.MemberID, M.MemberName
								, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount - Isnull(M.TotalGiftVoucherAmount, 0)
									when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
									end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(ERP.OriginalAmount, 0)   as DebitAmount
							From POST0016 M  WITH (NOLOCK) Left join (
														Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
														from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
														Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
														Group by D.APKMInherited
													  ) THU on M.APK = THU.APKBanDoi
											--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
											Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1 										
								Where M.DeleteFlg = 0 and ((M.CVoucherNo is null and M.PVoucherNo is null) or M.CVoucherNo is not null)   AND M.DivisionID IN (@DivisionID)
								Group by M.DivisionID, M.MemberID, M.MemberName
								, M.TotalInventoryAmount, PromoteChangeAmount
								, M.ChangeAmount, M.Description, M.SaleManID,  M.PvoucherNo, M.CVoucherNo, Isnull(M.TotalGiftVoucherAmount, 0)
								, Isnull(M.BookingAmount, 0), Isnull(THU.ThuTien, 0), Isnull(ERP.OriginalAmount, 0)
						) G ON M.DivisionID = G.DivisionID and M.MemberID = G.MemberID
					GROUP BY M.APK, M.DivisionID, M.ShopID, M.VoucherNo, M.VoucherDate, M.MemberID, M.MemberName, M.TotalAmount, D.Address
								, isnull(D.Phone,'') ,   isnull(D.Tel,'') , M.TotalInventoryAmount, M.TotalDiscountAmount, M.TotalRedureAmount, M.Change
								, Case When (A.PaymentID01 = 'TRAGOP') THEN  M.PaymentObjectAmount01 
										When (A.PaymentID02 = 'TRAGOP') THEN  M.PaymentObjectAmount02
										ELSE 0.0  end 
								, Case When (A.PaymentID01 = 'TRAGOP') and M.Change <= 0 THEN (M.TotalInventoryAmount - M.PaymentObjectAmount01 ) 
										When (A.PaymentID02 = 'TRAGOP') and M.Change <= 0 THEN  (M.TotalInventoryAmount - M.PaymentObjectAmount02)  
										ELSE M.TotalInventoryAmount end, isnull(F.PaymentAmount,0) 
								, M.TotalTaxAmount , M.TotalGiftVoucherAmount
								, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
								, M.SaleManID, A03.FullName, M.EmployeeID, M.EmployeeName,ISNULL(D.BeginPeriodDebt,0)
					)M
				WHERE M.DivisionID = @DivisionID and  M.APK = @APK
			EnD

			IF Isnull(@PVoucherNo, 0) = 1 --Phiếu trả hàng
			Begin
				SELECT M.APK, M.DivisionID, M.ShopID, M.PVoucherNo as VoucherNo, M.VoucherDate, M.MemberID
						--, D.MemberName
						, Case when Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) != '' then Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) else isnull(D.MemberName,'') end  as MemberName
						--, D.Address
						, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(D.Address,'') end as Address
						, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(D.Phone,'') + ' - ' + isnull(D.Tel,'') end as Phone, D.Tel
						, M.TotalAmount, M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalTaxAmount as VATAmount, M.TotalInventoryAmount
						, SaleManID, A03.FullName as SalenanName, M.EmployeeID, M.EmployeeName, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
				From POST0016 M WITH (NOLOCK) LEFT JOIN POST0011 D WITH (NOLOCK) ON D.MemberID = M.MemberID
											  LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = M.SaleManID
				WHERE M.DivisionID = @DivisionID and  M.APK = @APK
			EnD

			IF Isnull(@CVoucherNo, 0) = 1 --Phiếu đổi hàng
			Begin
				SELECT M.APK, M.DivisionID, M.ShopID, M.CVoucherNo as VoucherNo, M.VoucherDate, M.MemberID
						--, P11.MemberName
						, Case when Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) != '' then Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) else isnull(P11.MemberName,'') end  as MemberName
						--, P11.Address
						, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(P11.Address,'') end as Address
						, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(P11.Phone,'') + ' - ' + isnull(P11.Tel,'') end as Phone, P11.Tel
						, SaleManID, A03.FullName as SalenanName, M.EmployeeID, M.EmployeeName
						, Case when D.IsKindVoucherID = 1 then Sum(Isnull(D.InventoryAmount, 0)) else 0 end as ImTotalAmount
						, Case when D.IsKindVoucherID = 1 then Sum(Isnull(D.DiscountAllocation, 0)) else 0 end as ImTotalDiscountAmount
						, Case when D.IsKindVoucherID = 1 then Sum(Isnull(D.RedureAllocation, 0)) else 0 end as ImTotalRedureAmount
						, Case when D.IsKindVoucherID = 1 then Sum(Isnull(D.TaxAmount, 0)) else 0 end as ImTotalTaxAmount
						, Case when D.IsKindVoucherID = 1 then case when D.IsTaxIncluded = 1 then Sum(Isnull(D.InventoryAmount, 0))
																								   - Sum(Isnull(D.DiscountAllocation, 0))
																								   - Sum(Isnull(D.RedureAllocation, 0))
																								   - Isnull(M.TotalGiftVoucherAmount, 0) 
																								   else Sum(Isnull(D.InventoryAmount, 0))
																								   - Sum(Isnull(D.DiscountAllocation, 0))
																								   - Sum(Isnull(D.RedureAllocation, 0))		
																								   + Sum(Isnull(D.TaxAmount, 0)) 											
																								   - Isnull(M.TotalGiftVoucherAmount, 0) end
															    else 0 end as ImTotalInventoryAmount
						, M.TotalAmount as ExTotalAmount
						, M.TotalDiscountAmount as ExTotalDiscountAmount
						, M.TotalRedureAmount as ExTotalRedureAmount
						, M.TotalTaxAmount as ExTotalTaxAmount
						, M.TotalInventoryAmount as ExTotalInventoryAmount
						, M.ChangeAmount, M.TotalGiftVoucherAmount, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
				From POST0016 M WITH (NOLOCK) LEFT JOIN POST0011 P11 WITH (NOLOCK) ON P11.MemberID = M.MemberID
											  LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = M.SaleManID
											  Left join POST00161 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				WHERE M.DivisionID = @DivisionID and  Cast(M.APK as varchar(50)) = @APK
				and D.IsKindVoucherID = 1
				Group by M.APK, M.DivisionID, M.ShopID, M.CVoucherNo, M.VoucherDate, M.MemberID
						--, P11.MemberName
						, Case when Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) != '' then Isnull(M.DeliveryContact, Isnull(M.DeliveryReceiver, '')) else isnull(P11.MemberName,'') end
						--, P11.Address
						, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(P11.Address,'') end
						, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(P11.Phone,'') + ' - ' + isnull(P11.Tel,'') end, P11.Tel
						, SaleManID, A03.FullName, M.EmployeeID, M.EmployeeName
						, M.TotalAmount
						, M.TotalDiscountAmount
						, M.TotalRedureAmount
						, M.TotalTaxAmount
						, M.TotalInventoryAmount
						, M.ChangeAmount, D.IsKindVoucherID, M.TotalGiftVoucherAmount, Isnull(M.TotalGiftVoucherAmount, 0), M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver,D.IsTaxIncluded
			EnD
	End

	IF @CustomerName =  87 --OKIA
	Begin
			Select M.MemberName
				, Isnull(P11.Phone, P11.Tel) as Tel
				, M.VoucherDate
				, P11.CompanyName
				, Case  when isnull(M.PVoucherNo, '') !='' then  isnull(M.PVoucherNo, '') 
						when isnull(M.CVoucherNo, '') !='' then  isnull(M.CVoucherNo, '') 
						when isnull(M.PVoucherNo, '') ='' and isnull(M.CVoucherNo, '') ='' then  isnull(M.VoucherNo, '')
						end as VoucherNo
				, Isnull(P11.CompanyAddress, P11.Address) as CompanyAddress
				, P11.Email, P11.Identify, M.DeliveryReceiver, M.DeliveryMobile, M.DeliveryAddress
				, A03.FullName as SaleManName, M.SaleManID
				, Case when Isnull(P06.PaymentID01, '') != '' and Isnull(P06.PaymentID02, '') != '' then A51.PaymentName+', '+ A52.PaymentName
					   when Isnull(P06.PaymentID01, '') != '' and Isnull(P06.PaymentID02, '') = '' then A51.PaymentName
					   when Isnull(P06.PaymentID01, '') = '' and Isnull(P06.PaymentID02, '') != '' then A52.PaymentName
					   else NULL end as PaymentName
				, Stuff(isnull((	Select  ', ' + x.Notes From  
																(	Select Distinct APKMaster, DivisionID, Notes 
																	From POST00161 WITH (NOLOCK)
																	Where APKMaster = @APK and DeleteFlg = 0
																) x
											Where x.APKMaster = Convert(varchar(50),M.APK) and x.DivisionID= M.DivisionID
											FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 2, '') as PromotionProgram
				, P20.VoucherNo as VoucherNoSO
				, P20.VoucherDate as VoucherDateSO
				, P20.ShopName as ShopNameSO
				, M.Notes
				, P10.ShopName
				, M.BookingAmount
				, M.APK, M.DivisionID, M.ShopID, P20.ShopID as ShopIDSO
				, Case  when isnull(M.PVoucherNo, '') !='' then  N'Phiếu trả hàng'
						when isnull(M.CVoucherNo, '') !='' then  N'Phiếu đổi hàng'
						when isnull(M.PVoucherNo, '') ='' and isnull(M.CVoucherNo, '') ='' then  N'Phiếu bán hàng' 
						end as VoucherTypeID
				, M.MemberID, M.DeliveryContact, M.Description, P06.PaymentID, M.EmployeeID, M.EmployeeName
				, M.TotalDiscountAmount, M.TotalRedureAmount
			From POST0016 M WITH (NOLOCK) Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
						 Left join POST0011 P11 WITH (NOLOCK) on M.MemberID = P11.MemberID
						 Left join AT1103 A03 WITH (NOLOCK) on M.SaleManID = A03.EmployeeID
						 Left join POST0006 P06 WITH (NOLOCK) on M.APKPaymentID = P06.APK
						 Left join AT1205 A51 WITH (NOLOCK) on P06.PaymentID01 = A51.PaymentID
						 Left join AT1205 A52 WITH (NOLOCK) on P06.PaymentID02 = A52.PaymentID
						 Left join (Select Distinct D.DivisionID, D.APKMaster, D.DeleteFlg, P20.VoucherNo, P20.VoucherDate, P101.ShopName, P20.ShopID
									From POST00161 D WITH (NOLOCK) inner join POST2010 P20 WITH (NOLOCK) on D.APKMInherited = P20.APK and P20.DeleteFlg = 0
													 Left join POST0010 P101 WITH (NOLOCK) on P20.DivisionID = P101.DivisionID and P20.ShopID = P101.ShopID
									Where D.DeleteFlg = 0
									) P20 on P20.APKMaster = M.APK and P20.DeleteFlg = M.DeleteFlg
						 Left join (
									   Select Distinct PromoteID, FromDate, Todate, Description 
									   From AT1328 WITH (NOLOCK)
									   Where DivisionID in (@DivisionID, '@@@')
										 and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
										 and convert(varchar(10), ToDate, 111)
								    ) AT28 on P10.PromoteID = AT28.PromoteID
			Where M.APK = @APK and M.DeleteFlg = 0
			Group by   
				  M.MemberName
				, Isnull(P11.Phone, P11.Tel)
				, M.VoucherDate
				, P11.CompanyName
				, Case when isnull(M.PVoucherNo, '') !='' then  isnull(M.PVoucherNo, '') 
				  when isnull(M.CVoucherNo, '') !='' then  isnull(M.CVoucherNo, '') 
				  when isnull(M.PVoucherNo, '') ='' and isnull(M.CVoucherNo, '') ='' then  isnull(M.VoucherNo, '')
				  end
				, Isnull(P11.CompanyAddress, P11.Address)
				, P11.Email
				, P11.Identify
				, M.DeliveryReceiver
				, M.DeliveryMobile
				, M.DeliveryAddress
				, A03.FullName
				, M.SaleManID
				, Case when Isnull(P06.PaymentID01, '') != '' and Isnull(P06.PaymentID02, '') != '' then A51.PaymentName+', '+ A52.PaymentName
					when Isnull(P06.PaymentID01, '') != '' and Isnull(P06.PaymentID02, '') = '' then A51.PaymentName
					when Isnull(P06.PaymentID01, '') = '' and Isnull(P06.PaymentID02, '') != '' then A52.PaymentName
					else NULL end
				, P20.VoucherNo
				, P20.VoucherDate
				, P20.ShopName
				, M.Notes
				, P10.ShopName
				, M.BookingAmount
				, M.APK, M.DivisionID, M.ShopID, P20.ShopID
				, Case when isnull(M.PVoucherNo, '') !='' then  N'Phiếu trả hàng' 
					when isnull(M.CVoucherNo, '') !='' then  N'Phiếu đổi hàng' 
					when isnull(M.PVoucherNo, '') ='' and isnull(M.CVoucherNo, '') ='' then  N'Phiếu bán hàng' 
					end
				, M.MemberID, M.DeliveryContact, M.Description, P06.PaymentID, M.EmployeeID, M.EmployeeName, M.TotalDiscountAmount, M.TotalRedureAmount
	End




