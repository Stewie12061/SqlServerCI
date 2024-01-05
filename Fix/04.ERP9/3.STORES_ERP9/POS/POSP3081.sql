IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- In phiếu xuất kho/In phiếu giao hàng POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Hoàng Vũ, Date 08-05-2019: Chuyển từ Script sql thường sang Store
-- <Example>
---- exec  POSP3081 @APK = '3E888F62-A5A8-4223-908C-07A11F396DE3'

CREATE PROCEDURE POSP3081 
(
	@DivisionID			NVARCHAR(50) = NULL,
	@APK				NVARCHAR(50),
	@UserID				NVARCHAR(50) = NULL
)
AS
BEGIN
       -- Nếu kế thừa YCDV
       DECLARE @IsServiceRequest INT = 0
	   IF EXISTS (select top 1 1 from POST2050  WITH (NOLOCK) left join POST0028 WITH (NOLOCK) ON POST2050.APK = POST0028.APKMInherited where POST0028.APKMaster = @APK)
	      SET @IsServiceRequest = 1

	   Select Distinct M.APK, M.VoucherNo, M.VoucherDate
			, Day(M.VoucherDate) as TranDay
			, Month(M.VoucherDate) as TranMonth
			, Year(M.VoucherDate) as TranYear
			, CASE WHEN @IsServiceRequest =1 then K.MemberID else Isnull(M.MemberID, T.MemberID) end as MemberID
			, CASE WHEN @IsServiceRequest =1 then k.MemberName else Isnull(M.MemberName, T.MemberName) end as MemberName
			, CASE WHEN @IsServiceRequest =1 then K.Address else T.Address end as Address
			, CASE WHEN @IsServiceRequest =1 then K.Tel else T.Tel end as Tel
			, CASE WHEN @IsServiceRequest =1 then K.Amount else T.TotalInventoryAmount end as TotalInventoryAmount
			, T.PaymentObjectAmount01, T.PaymentObjectAmount02, T.ReceivedMoney
			, CASE WHEN @IsServiceRequest =1 then K.Amount else T.ReceivableAmount end as ReceivableAmount
		From POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Left join 
									(
										SELECT cast (M.APK as Varchar(50)) as APKPOST0016, M.DivisionID,  M.ShopID, M.MemberID
												, Case when Isnull(P11.IsMemberID, 0) = 1 then Isnull(M.DeliveryContact, M.DeliveryReceiver)
													   Else 
															Case when Isnull(M.DeliveryContact, '') != '' or Isnull(M.DeliveryReceiver, '') != '' then Isnull(M.DeliveryContact, M.DeliveryReceiver) else P11.MemberName end 
													   End as MemberName
												--, P11.MemberName	   
												, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(P11.Address,'') end as Address
												--, P11.Address
												, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(P11.Phone,'') + ' - ' + isnull(P11.Tel,'') end as Tel
												--,  P11.Tel
												, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount - Isnull(M.TotalGiftVoucherAmount, 0)
															when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
															end), 0) as TotalInventoryAmount 
												, M.PaymentObjectAmount01 , M.PaymentObjectAmount02
												, Isnull(THU.ThuTien, 0) as ReceivedMoney
												, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount - Isnull(M.TotalGiftVoucherAmount, 0)
															when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
															end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(Sum(ERP.OriginalAmount), 0) as ReceivableAmount
												, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
										FROM POST0016 M WITH (NOLOCK) INNER JOIN POST00161 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
																		LEFT JOIN POST0011 P11 WITH (NOLOCK) ON M.MemberID = P11.MemberID
																		Left join (
																					Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
																					from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
																					Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
																					Group by D.APKMInherited
																				) THU on M.APK = THU.APKBanDoi
																		--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
																		Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1
										WHERE M.DeleteFlg = 0 and isnull(D.IsWarehouseGeneral, 0) =0 
										Group by M.ShopID, M.DivisionID, M.APK, M.MemberID
												, Case when Isnull(P11.IsMemberID, 0) = 1 then Isnull(M.DeliveryContact, M.DeliveryReceiver)
													   Else 
															Case when Isnull(M.DeliveryContact, '') != '' or Isnull(M.DeliveryReceiver, '') != '' then Isnull(M.DeliveryContact, M.DeliveryReceiver) else P11.MemberName end 
													   End
												--, P11.MemberName
												, M.TotalInventoryAmount, M.BookingAmount, D.APK, M.PvoucherNo
												, M.CVoucherNo, THU.ThuTien,  M.ChangeAmount, Isnull(M.TotalGiftVoucherAmount, 0)
												, Case when Isnull(M.DeliveryAddress, '') != '' then Isnull(M.DeliveryAddress, '') else isnull(P11.Address,'') end
												--, P11.Address
												, Case when Isnull(M.DeliveryMobile, '') != '' then Isnull(M.DeliveryMobile, '') else isnull(P11.Phone,'') + ' - ' + isnull(P11.Tel,'') end
												--, P11.Tel
												, M.PaymentObjectAmount01 , M.PaymentObjectAmount02, Isnull(THU.ThuTien, 0)
												, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
									) T on T.APKPOST0016 = D.APKMInherited
									Left join 
									(
									  		select P50.APK,P50.MemberID,A02.MemberName AS MemberName ,A02.Address,ISNULL(A02.Tel,P50.Tel) as Tel,SUM(CASE WHEN P51.IsWarranty = 1 THEN 0 ELSE ISNULL(P51.Amount,0) END) AS Amount
											from POST2050 P50 WITH (NOLOCK)
											LEFT JOIN POST2051 P51 WITH (NOLOCK) ON P50.APK = P51.APKMaster
											LEFT JOIN POST0011 A02 WITH (NOLOCK) ON P50.MemberID = A02.MemberID
											group by P50.APK,P50.MemberID,A02.MemberName,A02.Address,A02.Tel,P50.Tel
									) K on K.APK = D.APKMInherited
									
		Where M.APK = @APK
END	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
