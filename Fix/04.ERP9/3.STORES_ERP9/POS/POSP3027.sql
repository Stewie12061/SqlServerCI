IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- In báo cáo [Báo cáo lịch trình giao hàng và thu tiền] => Customize OKIA
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ on 04/05/2018
----Created by: Hoàng vũ on 21/06/2018: Lấy shopID = shopID + ShopName
----Edited by: Hoàng vũ on 21/03/2019: Không lấy những phiếu xuất ngay khi bán hàng, chỉ lấy những phiếu xuất sau hoặc xuất tại chi nhanh
----Edited by: Hoàng vũ on 07/06/2019: Đối với nhân ngọc lấy dữ liệu chi tiết (Đối với OKIA lấy tổng hợp)
----Edited by: Hoàng vũ on 20/06/2019: Chỉnh sửa lấy chi tiết cho báo cáo của nhân ngọc
----Edited by: Hồng Thắm on 10/10/2023: lấy dữ liệu chi tiết cho khách hàng Thanh Liêm 
----Example: 
/*
	exec sp_executesql N'POSP3027 @DivisionID=N''NN'',@DivisionIDList=''NN'',@ShopID=N''CH01'',@ShopIDList=''CH01'',@IsPeriod=0,@FromDate=N''2019-06-20 00:00:00'',
	@ToDate=N''2019-06-20 00:00:00'',@PeriodIDList=null,@FromEmployeeID=''TUANTV'',@ToEmployeeID=''TUANTV'',@StatusID=null,@UserID=N''SUPPORT''',N'@CreateUserID nvarchar(7),
	@LastModifyUserID nvarchar(7),@DivisionID nvarchar(2)',@CreateUserID=N'SUPPORT',@LastModifyUserID=N'SUPPORT',@DivisionID=N'NN'
*/
 CREATE PROCEDURE POSP3027 (
		  @DivisionID AS NVARCHAR(4000),
		  @DivisionIDList AS NVARCHAR(4000),
		  @ShopID AS NVARCHAR(4000),
		  @ShopIDList AS NVARCHAR(4000),
		  @IsPeriod AS TINYINT,   --1: Theo ngày; 0: Theo kỳ
		  @FromDate AS DATETIME,
		  @ToDate AS DATETIME,
		  @PeriodIDList	AS NVARCHAR(2000),
		  @FromEmployeeID AS NVARCHAR(50) ='',
		  @ToEmployeeID AS NVARCHAR(50)='',
		  @StatusID AS NVARCHAR(50),
		  @UserID AS NVARCHAR(50),
		  @ListEmployeeID AS NVARCHAR(MAX)=''
		)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (Max),
		@sSQL1 NVARCHAR (Max),
		@sSQL2 NVARCHAR (Max),
		@sSQL3 NVARCHAR (Max),
		@sSQL4 NVARCHAR (Max),
		@OrderBy NVARCHAR(500),
		@sWhere NVARCHAR(MAX),
		@sWhere_StatusID NVARCHAR(MAX)
	
	SET @sWhere = ''
	SET @sWhere_StatusID = '1 = 1'
	
	IF @IsPeriod = 0	
			SET @sWhere = @sWhere + ' CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	ELSE
			SET @sWhere = @sWhere + ' (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND Isnull(P16.DivisionID, '''') in ('''+ @DivisionIDList+''')'		
	Else
		SET @sWhere = @sWhere + ' AND Isnull(P16.DivisionID, '''') in ('''+ @DivisionID+''')'		

	IF Isnull(@ShopIDList, '')!=''
		SET @sWhere = @sWhere + ' AND Isnull(P16.ShopID, '''') in ('''+ @ShopIDList+''')'		
	Else
		SET @sWhere = @sWhere + ' AND Isnull(P16.ShopID, '''') in ('''+ @ShopID+''')'		

	--Search theo nhân viên
	IF Isnull(@FromEmployeeID, '')!= '' and Isnull(@ToEmployeeID, '') = ''
		SET @sWhere = @sWhere + ' AND Isnull(M.DeliveryEmployeeID, '''') > = N'''+@FromEmployeeID +''''
	ELSE IF Isnull(@FromEmployeeID, '') = '' and Isnull(@ToEmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.DeliveryEmployeeID, '''') < = N'''+@ToEmployeeID +''''
	ELSE IF Isnull(@FromEmployeeID, '') != '' and Isnull(@ToEmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND Isnull(M.DeliveryEmployeeID, '''') Between N'''+@FromEmployeeID+''' AND N'''+@ToEmployeeID+''''
		
	IF Isnull(@StatusID, '')!=''
		SET @sWhere_StatusID = @sWhere_StatusID + ' AND Isnull(M.StatusID, '''') = N'''+ @StatusID+''''		

	IF Isnull(@ListEmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND  M.DeliveryEmployeeID IN (N'''+@ListEmployeeID+''')'
	
	Declare @CustomizeIndex int
	SET @CustomizeIndex = (Select Top 1 CustomerName from CustomerIndex)

	IF @CustomizeIndex = 87  or @CustomizeIndex = 163
	Begin
			SET @sSQL1 = '
			SELECT DISTINCT M.DivisionID, M.VoucherID, M.VoucherNo, M.VoucherDate, M.TranMonth, M.TranYear, P16.ShopID, P16.MemberID, P16.MemberName, P16.Amount
							, stuff(isnull((Select  '' ,'' + (x.InventoryID +'' : '' + convert(Varchar(50),cast (x.ActualQuantity as int)))
											From  AT2007 x WITH (NOLOCK)
											Where x.DivisionID = M.DivisionID and x.VoucherID = M.VoucherID and x.InheritVoucherID = P16.VoucherID
											Group By InventoryID, ActualQuantity
											Order by x.InventoryID
											FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InventoryID
							, Isnull(M.IsInTime, 0) as IsInTime, Isnull(M.IsOutTime, 0) as IsOutTime, Isnull(M.IsPayment, 0) as IsPayment
							, Isnull(M.IsTransferMoney, 0) as IsTransferMoney, Isnull(M.IsReceiptMoney, 0) as IsReceiptMoney, 1 as IsERP
							, M.DeliveryEmployeeID, M.DeliveryStatus
							, P16.VoucherNo_Sales, P16.PVoucherNo, P16.CVoucherNo
							, M.WareHouseID, A13.Address as FromAddress
							, M.RDAddress, M.OutTime, M.InTime, M.CashierTime, M.TransferMoneyTime, M.PaymentTime
							, Case  when M.IsTransferMoney = 1 or M.IsReceiptMoney = 1 then 4
									when M.IsPayment = 1 then 3
									when M.IsInTime = 1 then 2
									when M.IsOutTime = 1 then 1
									Else 0
								End as StatusID
							, Case when M.IsTransferMoney = 1 then M.TransferMoneyTime
									when M.IsReceiptMoney = 1 then M.CashierTime
									when M.IsPayment = 1 then M.PaymentTime
									when M.IsInTime = 1 then M.InTime
									when M.IsOutTime = 1 then M.OutTime
								End as StatusTime
			INTO #TempAT2006'
			SET @sSQL2 = '
			FROM AT2006 M WITH (NOLOCK) INNER JOIN AT2007 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID AND M.KindVoucherID = 2
										LEFT JOIN AT1303 A13 WITH (NOLOCK) ON M.WareHouseID = A13.WareHouseID
										INNER JOIN (
													SELECT Distinct M.ShopID, M.DivisionID, cast (M.APK as Varchar(50)) as APKMaster, M.MemberID, P11.MemberName
															, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount
																			when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount end), 0) 
																- Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(Sum(ERP.OriginalAmount), 0) as Amount
															, F.VoucherID
															, M.VoucherNo as VoucherNo_Sales, M.PVoucherNo, M.CVoucherNo
													FROM POST0016 M WITH (NOLOCK) INNER JOIN POST00161 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
																					INNER JOIN WT0096 F WITH (NOLOCK) ON M.DivisionID = F.DivisionID 
																														and F.InheritVoucherID = D.APKMaster and F.InheritTransactionID = Cast(D.APK as Varchar(50))
																					LEFT JOIN POST0011 P11 WITH (NOLOCK) ON M.MemberID = P11.MemberID
																					Left join (
																								Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
																								from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
																								Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
																								Group by D.APKMInherited
																							) THU on M.APK = THU.APKBanDoi
																					--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
																					Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1 
													WHERE M.DeleteFlg = 0 and isnull(D.IsWarehouseGeneral, 0) =1
													Group by M.APK, M.DivisionID, M.ShopID, M.MemberID, P11.MemberName, M.BookingAmount, M.TotalInventoryAmount
															, M.PvoucherNo, M.CVoucherNo, THU.ThuTien,  M.ChangeAmount, F.VoucherID
															, M.VoucherNo
												)P16 On M.DivisionID = P16.DivisionID  and D.InheritVoucherID = P16.VoucherID       
			WHERE '+@sWhere+''
			SET @sSQL3='	
		
			UNION ALL
			SELECT DISTINCT M.DivisionID, Cast (M.APK as Varchar(50)) VoucherID, M.VoucherNo, M.VoucherDate, M.TranMonth, M.TranYear, P16.ShopID, P16.MemberID, P16.MemberName, P16.Amount
							, stuff(isnull((Select  '' ,'' + (x.InventoryID +'' : '' + convert(Varchar(50),cast (x.ShipQuantity as int)))
											From  POST0028 x WITH (NOLOCK)
											Where x.DivisionID = M.DivisionID and x.APKMaster = M.APK and x.APKMInherited = P16.APKMaster
											Group By InventoryID, ShipQuantity
											Order by x.InventoryID
											FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InventoryID
							, Isnull(M.IsInTime, 0) as IsInTime, Isnull(M.IsOutTime, 0) as IsOutTime, Isnull(M.IsPayment, 0) as IsPayment
							, Isnull(M.IsTransferMoney, 0) as IsTransferMoney, Isnull(M.IsReceiptMoney, 0) as IsReceiptMoney, 0 as IsERP
							, M.DeliveryEmployeeID, M.DeliveryStatus
							, P16.VoucherNo_Sales, P16.PVoucherNo, P16.CVoucherNo
							, M.WareHouseID, A13.Address as FromAddress
							, P16.DeliveryAddress as RDAddress, M.OutTime, M.InTime, M.CashierTime, M.TransferMoneyTime, M.PaymentTime
							, Case  when M.IsReceiptMoney = 1 then 4
									when M.IsPayment = 1 then 3
									when M.IsInTime = 1 then 2
									when M.IsOutTime = 1 then 1
									Else 0
								End as StatusID
							,  Case when M.IsReceiptMoney = 1 then M.CashierTime
									when M.IsTransferMoney = 1 then M.TransferMoneyTime
									when M.IsPayment = 1 then M.PaymentTime
									when M.IsInTime = 1 then M.InTime
									when M.IsOutTime = 1 then M.OutTime
								End as StatusTime'
			SET @sSQL4 = '
			FROM POST0027 M WITH (NOLOCK) INNER JOIN POST0028 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster
											Inner join POST00161 P61  WITH (NOLOCK) ON D.DivisionID = P61.DivisionID and D.APKMInherited = P61.APKmaster and D.APKDInherited = P61.APK and P61.DeleteFlg = 0 and Isnull(P61.IsExportNow, 0) = 0
											LEFT JOIN AT1303 A13 WITH (NOLOCK) ON M.WareHouseID = A13.WareHouseID
											INNER JOIN (
															SELECT M.ShopID, M.DivisionID, cast (M.APK as Varchar(50)) as APKMaster, D.APK as TransactionID, M.MemberID, P11.MemberName
																, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount
																				when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount end), 0) 
																	- Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(Sum(ERP.OriginalAmount), 0) as Amount
																, M.VoucherNo as VoucherNo_Sales, M.PVoucherNo, M.CVoucherNo, M.DeliveryAddress
															FROM POST0016 M WITH (NOLOCK) 
																		INNER JOIN POST00161 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
																		LEFT JOIN POST0011 P11 WITH (NOLOCK) ON M.MemberID = P11.MemberID
																		Left join (
																					Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
																					from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
																					Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
																					Group by D.APKMInherited
																			) THU on M.APK = THU.APKBanDoi
																		--Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
																		Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1
															WHERE M.DeleteFlg = 0
															Group by M.ShopID, M.DivisionID, M.APK, M.MemberID, P11.MemberName, M.TotalInventoryAmount, M.BookingAmount
																	, D.APK, M.PvoucherNo, M.CVoucherNo, THU.ThuTien,  M.ChangeAmount
																	, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, M.DeliveryAddress
														)P16 On M.DivisionID = P16.DivisionID  and D.APKMInherited = P16.APKMaster 
			Where '+@sWhere+'
			'
			SET @sSQL = '
			SELECT 	M.VoucherID as APK 
				--Nhân viên giao hàng 
					, M.DeliveryEmployeeID
					, A03.FullName as DeliveryEmployeeName
				--Đơn hàng giao khách--Ngày/tháng/Năm
					, M.VoucherNo as VoucherNo_Export, M.VoucherNo_Sales, ''[''+Isnull(M.ShopID, '''') + ''-'' + Isnull(P10.ShopName, '''')+'']'' as ShopID, M.VoucherDate as VoucherDate_Export

				--Địa chỉ, thời điểm xuất phát /Thời gian--Địa chỉ, thời điểm đến/Thời gian
					, M.FromAddress, M.OutTime as Time_FromAddress, RDAddress as ToAddress, M.InTime as Time_ToAddress

				--Tiền mặt thu từ khách
					, Case when M.IsPayment = 1 then M.Amount else NULL end as CustomerReceived
					, Case when M.IsPayment = 1 then M.PaymentTime else NULL end as Time_CustomerReceived

				--Số tiền Nộp tài khoản công ty
					, Case when M.IsTransferMoney = 1 then M.Amount else NULL end as CompanyPay
					, Case when M.IsTransferMoney = 1 then M.TransferMoneyTime else NULL end as Time_CompanyPay
				
				--Số tiền Nộp BM/ Trưởng BP Giao hàng 
					, Case when M.IsReceiptMoney = 1 and Isnull(M.IsTransferMoney, 0) = 0 then M.Amount else NULL end as DepartmentPay
					, Case when M.IsReceiptMoney = 1 and Isnull(M.IsTransferMoney, 0) = 0 then M.CashierTime else NULL end as Time_DepartmentPay

				--Lấy ghi chú	
					, A07.Notes_CheckIn as Notes_ToAddress
				--Lấy ghi chú	
					, A07.Notes_TransferMoney as Notes_CompanyPay

				--Tình trạng
					, D.Description as StatusName, M.StatusTime
			FROM #TempAT2006 M left join POST0099 D WITH (NOLOCK) on M.StatusID = D.ID and D.CodeMaster = ''POS000018''
								Left join AT1103 A03 WITH (NOLOCK) on M.DeliveryEmployeeID = A03.EmployeeID
								Left join APT0007 A07 WITH (NOLOCK) on M.VoucherID = A07.APKMInherited
								Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID 
			Where '+@sWhere_StatusID+'
			Order by M.VoucherDate, M.DeliveryEmployeeID'
		EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4 + @sSQL)
	End

	IF @CustomizeIndex = 108
	Begin
		SET @sSQL1 = '
		SELECT DISTINCT M.DivisionID, Cast (M.APK as Varchar(50)) VoucherID, M.VoucherNo, M.VoucherDate, XX.XXCreateDate, M.TranMonth, M.TranYear, P16.ShopID, P16.MemberID, P11.MemberName, P16.Amount
							, stuff(isnull((Select  '' ,'' + (x.InventoryID +'' : '' + convert(Varchar(50),cast (x.ShipQuantity as int)))
											From  POST0028 x WITH (NOLOCK)
											Where x.DivisionID = M.DivisionID and x.APKMaster = M.APK and x.APKMInherited = P16.APKMaster
											Group By InventoryID, ShipQuantity
											Order by x.InventoryID
											FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InventoryID
							, Isnull(M.IsInTime, 0) as IsInTime, Isnull(M.IsOutTime, 0) as IsOutTime, Isnull(M.IsPayment, 0) as IsPayment
							, Isnull(M.IsTransferMoney, 0) as IsTransferMoney, Isnull(M.IsReceiptMoney, 0) as IsReceiptMoney, 0 as IsERP
							, M.DeliveryEmployeeID, M.DeliveryStatus
							, P16.VoucherNo_Sales, P16.PVoucherNo, P16.CVoucherNo
							, M.WareHouseID
							, A13.Address as FromAddress
							, P16.DeliveryAddress as RDAddress, M.OutTime, M.InTime, M.CashierTime, M.TransferMoneyTime, M.PaymentTime, XX.XXPaymentAmount, XX.XXPaymentTime, XX.YYTransferMoneyAmount, XX.YYTransferMoneyTime
							, Case  when Isnull(M.IsPayment, 0) = 1 and Isnull(IsTransferMoney, 0) = 1 then 4												--Hoàn tất
									when Isnull(M.IsPayment, 0) = 1 or Isnull(IsTransferMoney, 0) = 1 or Isnull(XX.RefVoucherID, '''') != '''' then 3		--Đã nhận tiền
									when Isnull(M.IsOutTime, 0) = 0 and Isnull(M.IsInTime, 0) = 0 then 0													--Chưa giao hàng
									when Isnull(M.IsOutTime, 0) = 1 and Isnull(M.IsInTime, 0) = 0 then 1													--Đang giao hàng
									when Isnull(M.IsInTime, 0) = 1 then 2																					--Đã giao hàng
									Else -1																													--Không xác định
									End as StatusID
							--Do phiếu xuất có chi tiết thu/nộp tiền nhiều lần nên thơi gian cho trạng thái phiếu xuất chỉ xác định được khi trường hợp [Đã giao hàng]
							, Case  when Isnull(M.IsPayment, 0) = 1 and Isnull(IsTransferMoney, 0) = 1 then NULL											--Hoàn tất
									when Isnull(M.IsPayment, 0) = 1 or Isnull(IsTransferMoney, 0) = 1 or Isnull(XX.RefVoucherID, '''') != '''' then NULL	--Đã nhận tiền
									when Isnull(M.IsOutTime, 0) = 0 and Isnull(M.IsInTime, 0) = 0 then NULL													--Chưa giao hàng
									when Isnull(M.IsOutTime, 0) = 1 and Isnull(M.IsInTime, 0) = 0 then NULL													--Đang giao hàng
									when Isnull(M.IsInTime, 0) = 1 then Convert(varchar(50), M.InTime, 103) + '' '' + Convert(varchar(50), M.InTime, 108)	--Đã giao hàng
									Else NULL																												--Không xác định
									End as StatusTime
			Into #TempAT2006
					'
		SET @sSQL2 = '
			FROM POST0027 M WITH (NOLOCK) INNER JOIN POST0028 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster
										  INNER JOIN (
														  SELECT M.DivisionID, M.ShopID, cast (M.APK as Varchar(50)) as APKMaster, D.APK, M.MemberID
																, M.VoucherNo as VoucherNo_Sales, M.PVoucherNo, M.CVoucherNo, M.DeliveryAddress, 0.0 as Amount
														  FROM POST0016 M WITH (NOLOCK) INNER JOIN POST00161 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
														  WHERE M.DeleteFlg = 0 and Isnull(D.IsExportNow, 0) = 0															
													 )P16 On D.DivisionID = P16.DivisionID and D.APKMInherited = P16.APKmaster and D.APKDInherited = P16.APK
										  LEFT JOIN ( --Đã thu tiền khách hàng --Nộp tiền công ty
														Select M.DivisionID, M.RefVoucherID, M.IsERP, M.TypeID
															   , Case when M.TypeID = 1 then M.ConvertedAmount else NULL end as XXPaymentAmount
															   , Case when M.TypeID = 1 then Convert(varchar(50), CreateDate, 103) + '' '' + Convert(varchar(50), CreateDate, 108) else NULL end as XXPaymentTime
															   , Case when M.TypeID = 0 then M.ConvertedAmount else NULL end as YYTransferMoneyAmount
															   , Case when M.TypeID = 0 then Convert(varchar(50), CreateDate, 103) + '' '' + Convert(varchar(50), CreateDate, 108) else NULL end as YYTransferMoneyTime
															   , M.CreateDate as XXCreateDate
														From APT0014 M
													) XX on M.DivisionID = XX.DivisionID and M.APK = XX.RefVoucherID
										  LEFT JOIN AT1303 A13 WITH (NOLOCK) ON M.WareHouseID = A13.WareHouseID
										  LEFT JOIN POST0011 P11 WITH (NOLOCK) ON P16.MemberID = P11.MemberID
			Where '+@sWhere+'
			'
		SET @sSQL3=''
		SET @sSQL4 = ''
		SET @sSQL = '
		SELECT 	M.VoucherID as APK 
			--Nhân viên giao hàng 
				, M.DeliveryEmployeeID
				, A03.FullName as DeliveryEmployeeName
			--Đơn hàng giao khách--Ngày/tháng/Năm
				, M.VoucherNo as VoucherNo_Export, M.VoucherNo_Sales, ''[''+Isnull(M.ShopID, '''') + ''-'' + Isnull(P10.ShopName, '''')+'']'' as ShopID, M.VoucherDate as VoucherDate_Export

			--Địa chỉ, thời điểm xuất phát /Thời gian--Địa chỉ, thời điểm đến/Thời gian
				, M.FromAddress, M.OutTime as Time_FromAddress, RDAddress as ToAddress, M.InTime as Time_ToAddress

			--Tiền mặt thu từ khách
				, Case when M.IsPayment = 1 or M.XXPaymentAmount != 0 then M.XXPaymentAmount else NULL end as CustomerReceived
				, Case when M.IsPayment = 1 or Isnull(M.XXPaymentTime, '''') != '''' then Cast(M.XXPaymentTime as varchar(50)) else NULL end as Time_CustomerReceived

			--Số tiền Nộp tài khoản công ty
				, Case when M.IsTransferMoney = 1 or M.YYTransferMoneyAmount != 0 then M.YYTransferMoneyAmount else NULL end as CompanyPay
				, Case when M.IsTransferMoney = 1 or Isnull(M.YYTransferMoneyTime, '''') != '''' then Cast(M.YYTransferMoneyTime as varchar(50)) else NULL end as Time_CompanyPay
				
			--Số tiền Nộp BM/ Trưởng BP Giao hàng 
				, Case when M.IsReceiptMoney = 1 and Isnull(M.IsTransferMoney, 0) = 0 then M.Amount else NULL end as DepartmentPay
				, Case when M.IsReceiptMoney = 1 and Isnull(M.IsTransferMoney, 0) = 0 then M.CashierTime else NULL end as Time_DepartmentPay

			--Lấy ghi chú	
				, A07.Notes_CheckIn as Notes_ToAddress
			--Lấy ghi chú	
				, A07.Notes_TransferMoney as Notes_CompanyPay
			--Tình trạng
				, M.StatusID, D.Description as StatusName, M.StatusTime
		FROM #TempAT2006 M left join POST0099 D WITH (NOLOCK) on M.StatusID = D.ID and D.CodeMaster = ''POS000018''
						   Left join AT1103 A03 WITH (NOLOCK) on M.DeliveryEmployeeID = A03.EmployeeID
						   Left join APT0007 A07 WITH (NOLOCK) on M.VoucherID = A07.APKMInherited
						   Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID 
		Where '+@sWhere_StatusID+'
		Order by M.VoucherDate, M.XXCreateDate, M.DeliveryEmployeeID'
		EXEC (@sSQL1+@sSQL2+@sSQL3+@sSQL4 + @sSQL)
	End

	Print @sSQL1
	Print @sSQL2
	Print @sSQL3
	Print @sSQL4
	Print @sSQL
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



