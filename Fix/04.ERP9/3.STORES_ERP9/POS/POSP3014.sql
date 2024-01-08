IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP3014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Daily Sales Report – POSR3014
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 03/01/2018
----Modify by: Thị Phượng on 03/04/2018: Fix bug cột số tiền (AMOUNT) sai dữ liệu 
----Modify by: Phát Danh on 2018/05/10: Fix bug lấy sai trường Description -> sửa lại lấy Notes
----Modify by: Hoàng Vũ on 2018/05/10: Fix bug Phiếu đặt cọc truy ngược lại bảng giá gói để lấy FreeGift
----Edited by: Hoàng Vũ 30/07/2018: Dùng trường APKPackageInventoryID để truy ngược lại bảng giá bán theo gói (1 gói sản phẩm có thể khai báo 1 mặt hàng nhiều lần)
-- <Example> EXEC POSP3014 'HCM', 'HCM', 'AEONTANPHU', 'CH-HCM001'',''AEONTANPHU', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018','','','', '', 'ASOFTADMIN'

CREATE PROCEDURE POSP3014 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@VoucherNo          VARCHAR(50),
	@DeVoucherNo          VARCHAR(50),
	@ToInventoryID		VARCHAR(MAX),
	@FromInventoryID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sSQL1   NVARCHAR(MAX),
				@sSQL2   NVARCHAR(MAX),
				@sSQL3   NVARCHAR(MAX),
				@sWhere NVARCHAR(MAX),
				@sWhere1 NVARCHAR(MAX),
				@sWhere2 NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''
		SET @sWhere1 = ''
		SET @sWhere2 = ''
	
		--Check Para DivisionIDList null then get DivisionID 
		IF Isnull(@DivisionIDList,'') = ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
		Else 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'

		--Check Para @ShopIDList null then get ShopID 
		IF Isnull(@ShopIDList,'') = ''
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
		Else 
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		--Search theo hội viên  (Dữ liệhội viên nhiều nên dùng control từ hội viên , đến hội viên
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
		IF Isnull(@VoucherNo, '') != ''
		SET @sWhere1 = @sWhere1 + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '

 	    IF Isnull(@DeVoucherNo, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@DeVoucherNo+'%'' '
 	    

		SET @sSQL = N'
		SELECT M.APK,  M.DivisionID, M.VoucherNo, M.VoucherDate, A.BookingAmount  Amount, M.SaleManID EmployeeID, A1.FullName as EmployeeName
		, D.InventoryID, D.InventoryName
		, Case when D.IsPromotePriceTable = 1 and Isnull(OT33.IsGift, 0.0) != 0 then 0.0
			   when D.IsPackage = 1 and isnull(C48.IsGift, 0.0) != 0 then 0.0
			   when D.IsTable = 1and Isnull(OT32.IsGift, 0.0) != 0 then 0.0
			   Else Isnull(D.ActualQuantity, 0.0) end as Quantity
		, Case when D.IsPromotePriceTable = 1 and Isnull(OT33.IsGift, 0.0) != 0  then Isnull(OT33.IsGift, 0.0)
			   when D.IsPackage = 1 and isnull(C48.IsGift, 0.0) != 0 then isnull(C48.IsGift, 0.0)
			   when D.IsTable = 1 and Isnull(OT32.IsGift, 0.0) != 0 then Isnull(OT32.IsGift, 0.0)
			   Else 0.0 end as FreeGift
		, NULL IsDisplay
		, M.ShopID, A2.ShopName, NULL IsDiscount, NULL WarrantyCard
		, M.Description as Notes 
		, D.PackageID
		INTO #TEMPOST3014 
		FROM POST2010 M WITH (NOLOCK) 
		INNER JOIN POST2011 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
		LEFT JOIN (
					SELECT A.APKMInherited, A.DepositVoucherNo, Sum(Amount) as BookingAmount
					FROM POST00802 A With (NOLOCK) Where isnull(A.DeleteFlg,0) = 0 and A.DivisionID IN ('''+ @DivisionID+''')
					Group by A.APKMInherited, A.DepositVoucherNo
					) A On A.APKMInherited = M.APK and A.DepositVoucherNo = M.VoucherNo
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
		LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
		Left JOIN CT0148 C48  WITH (NOLOCK) ON C48.PackagePriceID = D.PackagePriceID and Replace(C48.PackageID,CHAR(13)+CHAR(10),'''') = Replace(D.PackageID,CHAR(13)+CHAR(10),'''') and C48.APK = D.APKPackageInventoryID and D.IsPackage = 1
		Left JOIN OT1302 OT32  WITH (NOLOCK) ON OT32.DivisionID = D.DivisionID and OT32.ID = D.PriceTable and OT32.InventoryID = D.InventoryID and D.IsTable = 1
		Left JOIN OT1302 OT33  WITH (NOLOCK) ON OT33.DivisionID = D.DivisionID and OT33.ID = D.PromotePriceTableID and OT33.InventoryID = D.InventoryID and D.IsPromotePriceTable = 1
		WHERE M.DeleteFlg = 0 '+@sWhere+@sWhere2+''
		SET @sSQL1 =N'
		Union ALL 
		SELECT M.APK, M.DivisionID, M.VoucherNo, M.VoucherDate,  (M.TotalInventoryAmount - isnull(M.BookingAmount,0)) as Amount, M.EmployeeID, M.EmployeeName
		, M.InventoryID, M.InventoryName, SUM(Quantity) AS Quantity , SUM(FreeGift) FreeGift, M.IsDisplay
		, M.ShopID, M.ShopName, M.IsDiscount, M.WarrantyCard, M.Notes, M.PackageID
		FROM (SELECT M.DivisionID, M.APK, M.BookingAmount, Case When M.PVoucherNo is null and M.CVoucherNo is null then M.VoucherNo 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then M.PVoucherNo
												 When M.PVoucherNo is null and M.CVoucherNo is not null then M.CVoucherNo
												 end as VoucherNo, M.VoucherDate
		, Case When M.PVoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * M.TotalInventoryAmount
												 When M.PVoucherNo is null and M.CVoucherNo is not null then M.ChangeAmount
												 end as TotalInventoryAmount, M.SaleManID EmployeeID, A1.FullName as EmployeeName
		, D.InventoryID, D.InventoryName, Case When M.PVoucherNo is null and M.CVoucherNo is null then D.ActualQuantity 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * D.ActualQuantity
												 When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is not null then (-1) * D.ActualQuantity
												 When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is null then D.ActualQuantity
												 end as Quantity, 0.0 as FreeGift, Case WHEN D.IsDisplay = 1 THEN ''Y'' ELSE ''N'' END AS IsDisplay
		, M.ShopID, A2.ShopName, Case WHEN Isnull(M.TotalDiscountRate,0) != 0 THEN ''Y'' ELSE ''N'' END AS IsDiscount, A.WarrantyCard
		, M.Notes 
		, D.PackageID
		FROM POST0016 M WITH (NOLOCK) 
		INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
		LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
		LEFT JOIN (SELECT M.DivisionID, F.InheritVoucherID, F.InheritTransactionID, D.InventoryID, D.WarrantyCard FROM AT2006 M WITH (NOLOCK) 
		INNER JOIN AT2007 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
		INNER JOIN WT0096 F WITH (NOLOCK) ON M.DivisionID = F.DivisionID and  D.InheritVoucherID = F.VoucherID and D.InheritTransactionID = F.TransactionID
		Union ALL 
		SELECT M.DivisionID, D.APKMInherited as InheritVoucherID, D.APKDInherited as InheritTransactionID,  D.InventoryID, D.WarrantyCard FROM POST0027 M WITH (NOLOCK) 
		INNER JOIN POST0028 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
		)A On A.DivisionID = M.DivisionID AND A.InheritVoucherID = D.APKMaster and A.InventoryID = D.InventoryID and A.InheritTransactionID = D.APK
		WHERE isnull(D.IsFreeGift,0) = 0 and M.DeleteFlg = 0 '+@sWhere+@sWhere1+'
		UNION ALL'
		SET @sSQL2 =N'
		SELECT M.DivisionID, M.APK, M.BookingAmount,Case When M.PVoucherNo is null and M.CVoucherNo is null then M.VoucherNo 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then M.PVoucherNo
												 When M.PVoucherNo is null and M.CVoucherNo is not null then M.CVoucherNo
												 end as VoucherNo, M.VoucherDate
		, Case When M.PVoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * M.TotalInventoryAmount
												 When M.PVoucherNo is null and M.CVoucherNo is not null then M.ChangeAmount
												 end as TotalInventoryAmount, M.SaleManID EmployeeID, A1.FullName as EmployeeName
		, D.InventoryID, D.InventoryName, 0.0 as Quantity, Case When M.PVoucherNo is null and M.CVoucherNo is null then D.ActualQuantity 
												 When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * D.ActualQuantity
												 When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is not null then (-1) * D.ActualQuantity
												 When M.PVoucherNo is null and M.CVoucherNo is not null and D.APKDInherited is null then D.ActualQuantity end as FreeGift,
												  Case WHEN D.IsDisplay = 1 THEN ''Y'' ELSE ''N'' END AS IsDisplay
		, M.ShopID, A2.ShopName, Case WHEN Isnull(M.TotalDiscountRate,0) != 0 THEN ''Y'' ELSE ''N'' END AS IsDiscount, A.WarrantyCard
		, M.Notes, D.PackageID
		FROM POST0016 M WITH (NOLOCK) 
		INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.SaleManID
		LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
		LEFT JOIN (SELECT DISTINCT M.DivisionID, F.InheritVoucherID,F.InheritTransactionID, D.InventoryID, D.WarrantyCard FROM AT2006 M WITH (NOLOCK) 
		INNER JOIN AT2007 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
		INNER JOIN WT0096 F WITH (NOLOCK) ON M.DivisionID = F.DivisionID and  D.InheritVoucherID = F.VoucherID and D.InheritTransactionID = F.TransactionID
		Union ALL 
		SELECT DISTINCT M.DivisionID, D.APKMInherited as InheritVoucherID,D.APKDInherited as InheritTransactionID, D.InventoryID, D.WarrantyCard FROM POST0027 M WITH (NOLOCK) 
		INNER JOIN POST0028 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
		)A On A.DivisionID = M.DivisionID AND A.InheritVoucherID = D.APKMaster and A.InventoryID = D.InventoryID and A.InheritTransactionID = D.APK
		WHERE isnull(D.IsFreeGift,0) = 1 and M.DeleteFlg = 0 '+@sWhere+@sWhere1+'
		)M
		GROUP BY M.APK, M.DivisionID, M.VoucherNo, M.VoucherDate, M.TotalInventoryAmount, M.EmployeeID, M.EmployeeName
		, M.InventoryID, M.InventoryName, M.IsDisplay, M.ShopID, M.ShopName, M.IsDiscount, M.WarrantyCard, M.Notes, M.BookingAmount, M.PackageID
		'

		SET @sSQL3 = 'SELECT ROW_NUMBER() OVER (ORDER BY M.ShopID, M.VoucherDate, M.VoucherNo, M.InventoryID ) AS No,
		M.APK, M.DivisionID, A.DivisionName, M.VoucherNo, M.VoucherDate, M.Amount, M.EmployeeID, M.EmployeeName
		, M.InventoryID, M.InventoryName, M.Quantity , M.FreeGift, M.IsDisplay
		, M.ShopID, M.ShopName, M.IsDiscount, M.WarrantyCard, M.Notes, M.PackageID
		FROM #TEMPOST3014 M 
		LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID 
		ORDER BY M.ShopID, M.VoucherDate, M.VoucherNo, M.InventoryID '
		EXEC (@sSQL+ @sSQL1 +@sSQL2+ @sSQL3)
		Print (@sSQL)
		Print (@sSQL1)
		Print (@sSQL2)
		Print (@sSQL3)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
