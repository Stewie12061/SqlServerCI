IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2094]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2094]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form kế thừa phiếu xuất hàng (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ, Date 19/09/2018
----Created by: Hoàng Vũ, Date 13/02/2019: Xử lý trường hợp cắt dữ liệu phiếu xuất dưới ERP, Bổ sung 4 bảng WT0095_OK, WT0096_OK, AT2006_OK và AT2007_OK lấy dữ liệu số dư của năm 2018 chuyển qua, tương tư cho những lần cắt dữ liệu năm sau
-- <Example> EXEC CRMP2094 'HCM', 'DF71DD05-85AE-44B2-868F-9F5055F7049C'',''3CF76E4B-9354-4B7A-8696-81739CF8C38C'  ,'NV01',1,20

CREATE PROCEDURE CRMP2094 ( 
         @DivisionID varchar(50)
	   , @APKList nvarchar(Max)
	   , @UserID  VARCHAR(50)
	   , @PageNumber INT
	   , @PageSize INT
)
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
	SET @OrderBy = 'P28.APKPOST0027'
	
	SET @sSQL01 = '	
				Select Distinct P28.APKPOST00161, P28.APKPOST0027, P28.APKPOST0028, P28.DivisionID, P28.InventoryID, P28.InventoryName, P28.UnitID, P28.ActualQuantity, P28.WarrantyCard, P28.SerialNo
				, P28.ExportVoucherNo
				into #TempPOST0028
				From (
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại cửa hàng) => Search phiếu xuất kho tại cửa hàng
						Select Cast(D.APK as Nvarchar(50)) as APKPOST00161, Cast(P27.APK as Nvarchar(50)) as APKPOST0027, Cast(P28.APK as Nvarchar(50)) as APKPOST0028, M.DivisionID
								, P28.InventoryID, A02.InventoryName, P28.UnitID, P28.ShipQuantity as ActualQuantity, P28.WarrantyCard, P28.SerialNo, P27.VoucherNo as ExportVoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg = 0
										inner join POST0028 P28 With (NOLOCK) on D.APK = P28.APKDInherited and D.APKMaster = P28.APKMInherited
										Inner join POST0027 P27 With (NOLOCK) on P27.APK = P28.APKMaster and P27.DeleteFlg = P28.DeleteFlg and P27.DeleteFlg = 0
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
										Inner join AT1302 A02 With (NOLOCK) on A02.InventoryID = P28.InventoryID
						Where D.IsWarehouseGeneral = 0 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))
						Union all
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại chi nhánh) => Search phiếu xuất kho tại chi nhánh bảng chính
						Select Cast(D.APK as Nvarchar(50)) as APKPOST00161, Cast(P27.VoucherID as Nvarchar(50)) as APKPOST0027, Cast(P28.TransactionID as Nvarchar(50)) as APKPOST0028, M.DivisionID
								, P28.InventoryID, A02.InventoryName, P28.UnitID, P28.ActualQuantity, P28.WarrantyCard, P28.SerialNo, P27.VoucherNo as ExportVoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg  and M.DeleteFlg = 0
										inner join WT0096 W96 With (NOLOCK) on M.DivisionID = W96.DivisionID and M.APK = W96.InheritVoucherID and D.APK = W96.InheritTransactionID
										inner join AT2007 P28 With (NOLOCK) on P28.DivisionID = W96.DivisionID and P28.InheritVoucherID = W96.VoucherID and P28.InheritTransactionID = W96.TransactionID
										inner join AT2006 P27 With (NOLOCK) on P27.DivisionID = P28.DivisionID and P27.VoucherID = P28.VoucherID
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
										Inner join AT1302 A02 With (NOLOCK) on A02.InventoryID = P28.InventoryID
						Where D.IsWarehouseGeneral = 1 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))
						Union all'
	SET @sSQL02 = '	
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại chi nhánh) => Search phiếu xuất kho tại chi nhánh bảng tạm số dư
						Select Cast(D.APK as Nvarchar(50)) as APKPOST00161, Cast(P27.VoucherID as Nvarchar(50)) as APKPOST0027, Cast(P28.TransactionID as Nvarchar(50)) as APKPOST0028, M.DivisionID
								, P28.InventoryID, A02.InventoryName, P28.UnitID, P28.ActualQuantity, P28.WarrantyCard, P28.SerialNo, P27.VoucherNo as ExportVoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg  and M.DeleteFlg = 0
										inner join WT0096_OK W96 With (NOLOCK) on M.DivisionID = W96.DivisionID and M.APK = W96.InheritVoucherID and D.APK = W96.InheritTransactionID
										inner join AT2007_OK P28 With (NOLOCK) on P28.DivisionID = W96.DivisionID and P28.InheritVoucherID = W96.VoucherID and P28.InheritTransactionID = W96.TransactionID
										inner join AT2006_OK P27 With (NOLOCK) on P27.DivisionID = P28.DivisionID and P27.VoucherID = P28.VoucherID
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
										Inner join AT1302 A02 With (NOLOCK) on A02.InventoryID = P28.InventoryID
						Where D.IsWarehouseGeneral = 1 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))

						Union all
						SELECT O2.APK AS APKPOST00161, O1.SOrderID AS APKPOST0027, O1.SOrderID AS APKPOST0028, O1.DivisionID, O2.InventoryID, O3.InventoryName, O2.UnitID, O2.OrderQuantity AS ActualQuantity
						, NULL AS WarrantyCard, NULL AS SerialNo,  O1.VoucherNo AS ExportVoucherNo
						From OT2001 O1 WITH (NOLOCK)
							LEFT JOIN OT2002 O2 WITH (NOLOCK) ON Convert(varchar(50), O1.APK) = O2.SOrderID
							LEFT JOIN AT1302 O3 WITH (NOLOCK) ON O3.InventoryID = O2.InventoryID

					  ) P28
				Where P28.DivisionID = N'''+ @DivisionID+''' AND Cast(P28.APKPOST0027 as varchar(50)) in ('''+ @APKList+''')
				DECLARE @count int
				Select @count = Count(APKPOST0028) From #TempPOST0028 With (NOLOCK)

				SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
						, P28.APKPOST00161, P28.APKPOST0027, P28.APKPOST0028, P28.DivisionID, P28.ExportVoucherNo
						, P28.InventoryID, P28.InventoryName, P28.UnitID, P28.ActualQuantity, P28.WarrantyCard, P28.SerialNo, Isnull(C91.NumberOfWarranty, 0) as NumberOfWarranty
				FROM #TempPOST0028 P28 Left join (
													Select DivisionID, Cast(APKMInherited as Nvarchar(50)) as APKPOST0027, Cast(APKDInherited as Nvarchar(50)) as APKPOST0028, Count(APKDInherited) as NumberOfWarranty
													From CRMT2091 With (NOLOCK)
													Where DeleteFlg = 0
													Group by DivisionID, APKMInherited, APKDInherited
												 ) C91 on P28.DivisionID = C91.DivisionID and P28.APKPOST0027 = C91.APKPOST0027 and P28.APKPOST0028 = C91.APKPOST0028
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'							
	EXEC (@sSQL01+@sSQL02)
	PRINT (@sSQL01)
	PRINT (@sSQL02)
	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
