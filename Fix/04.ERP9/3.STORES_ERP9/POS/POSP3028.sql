IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Bảng kê phiếu nhập - POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 10/06/2016 by Phan thanh hoang vu: In báo cáo bảng kê phiếu nhập
---- Edit by --- by ---: 
-- <Example> EXEC POSP3028 'HCM', NULL, '50C2101', NULL, NULL, NULL, NULL, NULL, 1, '2018-05-28', '2018-05-28', '05/2018', NULL, NULL

CREATE PROCEDURE POSP3028 (
				@DivisionID AS NVARCHAR(50),
				@DivisionIDList AS NVARCHAR(MAX),
				@ShopID AS NVARCHAR(50),
				@ShopIDList AS NVARCHAR(MAX),
				@FromWareHouseID AS NVARCHAR(50) = NULL,
				@ToWareHouseID AS NVARCHAR(50)=NULL,
				@FromInventoryID AS NVARCHAR(50)=NULL,
				@ToInventoryID AS NVARCHAR(50)=NULL,
				@IsDate TINYINT,  --1: Theo ngày; 0: Theo kỳ
				@FromDate DATETIME, 
				@ToDate DATETIME, 
				@PeriodIDList  NVARCHAR(2000),
				@StatusID NVARCHAR(50)=NULL,
				@UserID NVARCHAR(50),
				@ListInventoryID AS NVARCHAR(MAX)=NULL
)
AS 
	DECLARE @sSQL01 NVARCHAR(MAX),  
			@sSQL02 NVARCHAR(MAX),  
			@sWhere NVARCHAR(MAX),
			@sWhereStatusID NVARCHAR(MAX)
	
	SET @sWhere = ' '
	SET @sWhereStatusID = ' 1 = 1 '
	
	--Search thời gian	
	IF @IsDate = 1	
		SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),M.VoucherDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
	ELSE
		SET @sWhere = @sWhere + N' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

	--Search đơn vị
	IF Isnull(@DivisionIDList,'') != ''
		SET @sWhere = @sWhere + N' AND M.DivisionID IN ('''+@DivisionIDList+''')'
	Else
		SET @sWhere = @sWhere + N' AND M.DivisionID IN ('''+ @DivisionID+''')' 
	
	--Search cửa hàng
	IF Isnull(@ShopIDList,'') != ''
		SET @sWhere = @sWhere + N' And M.ShopID IN ('''+@ShopIDList+''')'
	Else 
		SET @sWhere = @sWhere + N' And M.ShopID IN ('''+@ShopID+''')'
	
	--Search theo kho  (Dữ liệu kho nhiều nên dùng control từ kho , đến kho
	IF Isnull(@FromWareHouseID, '')!= '' and Isnull(@ToWareHouseID, '') = ''
		SET @sWhere = @sWhere + N' AND D.WareHouseID > = N'''+@FromWareHouseID +''''
	ELSE IF Isnull(@FromWareHouseID, '') = '' and Isnull(@ToWareHouseID, '') != ''
		SET @sWhere = @sWhere + N' AND D.WareHouseID < = N'''+@ToWareHouseID +''''
	ELSE IF Isnull(@FromWareHouseID, '') != '' and Isnull(@ToWareHouseID, '') != ''
		SET @sWhere = @sWhere + N' AND D.WareHouseID Between N'''+@FromWareHouseID+''' AND N'''+@ToWareHouseID+''''
			
	--Search vật tư
	IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + N' AND D.InventoryID > = N'''+@FromInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + N' AND D.InventoryID < = N'''+@ToInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + N' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''
	
	--Search loại trang thái
	IF Isnull(@StatusID,'') != ''
		SET @sWhereStatusID = @sWhereStatusID + N' And Cast(M.StatusID as nvarchar(50)) IN ('''+@StatusID+''')'

	IF Isnull(@ListInventoryID,'') <> ''
		SET @sWhere = @sWhere + N' AND D.InventoryID IN ('''+@ListInventoryID+''')'

	--Lấy kết quả
	SET @sSQL01 = N'SELECT	M.DivisionID
						, D.WareHouseID as ImWareHouseID
						, D.WareHouseName as ImWareHouseName
						, Case When Ref04.APK is not null and Ref03.APK is null then Ref04.WareHouseID
							   When Ref04.APK is null and Ref03.APK is not null then Ref03.WareHouseID
							   Else NULL End as ExWareHouseID
						, Case When Ref04.APK is not null and Ref03.APK is null then Ref04.WareHouseName
							   When Ref04.APK is null and Ref03.APK is not null then Ref03.WareHouseName
							   Else NULL End as ExWareHouseName
						, M.ShopID
						, M.VoucherDate
						, M.VoucherNo
						, M.EmployeeID
						, M.EmployeeName
						, Case when Ref01.APK is not null then 0
							   when Ref02.APK is not null then 1
							   when Ref03.APK is not null or Ref04.APK is not null then 2
							   else 3
							   End as StatusID
						, D.InventoryID
						, D.InventoryName
						, M.Description
						, D.ActualQuantity as Quantity
						, D.APKMInherited
						, D.APKDInherited
				into #TEMPPOSPT00151
				FROM POST0015 M WITH (NOLOCK) inner join POST00151 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
											  Left join POST0016 Ref01 WITH (NOLOCK) on Ref01.APK = D.APKMInherited and Ref01.DivisionID = D.DivisionID and Ref01.PVoucherNo is not null
											  Left join POST0016 Ref02 WITH (NOLOCK) on Ref02.APK = D.APKMInherited and Ref02.DivisionID = D.DivisionID and Ref02.CVoucherNo is not null
											 Left join (--Điều chuyển từ ERP -> POS
																Select  M.APK, M.DivisionID, M.WareHouseID2 as WarehouseID, A03.WareHouseName, M.VoucherID, D.TransactionID
																From WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
																			  left join AT1303 A03 on M.WareHouseID2 = A03.WareHouseID
																Where D.InheritVoucherID is null
														) Ref03 on Ref03.DivisionID = D.DivisionID and Ref03.VoucherID = D.APKMInherited and Ref03.TransactionID = D.APKDInherited
															
											  Left join (--Điều chuyển từ POS -> POS
																Select  M.APK, M.DivisionID, M.WarehouseID, A03.WareHouseName, D.APKMInherited , D.APKDInherited
																From POST0027 M inner join POST0028 D on M.DivisionID = D.DivisionID and M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
																				left join AT1303 A03 on M.WareHouseID = A03.WareHouseID
																Where D.APKMInherited is not null
														) Ref04 on Ref04.DivisionID = D.DivisionID and Ref04.APKMInherited = D.APKMaster and Ref04.APKDInherited = D.APK				
				Where M.DeleteFlg =0 ' + @sWhere+''

		SET @sSQL02 = N'Select M.DivisionID
						, A01.DivisionName
						, M.ImWareHouseID
						, M.ImWareHouseName
						, M.ExWareHouseID
						, M.ExWareHouseName
						, M.ShopID
						, P10.ShopName
						, M.VoucherDate
						, M.VoucherNo
						, M.EmployeeID
						, M.EmployeeName
						, D.Description as StatusName
						, M.InventoryID
						, M.InventoryName
						, M.Description
						, M.Quantity
				From #TEMPPOSPT00151 M inner join POST0099 D WITH (NOLOCK) on M.StatusID = D.ID and D.CodeMaster = ''POS000019''
									   inner join POST0010 P10 WITH (NOLOCK) on P10.DivisionID = M.DivisionID and P10.ShopID = M.ShopID
									   inner join AT1101 A01 WITH (NOLOCK) on P10.DivisionID = A01.DivisionID
									   
				Where ' + @sWhereStatusID+'
				'
		
	EXEC(@sSQL01+@sSQL02)
	--PRINT (@sSQL01)
	--PRINT (@sSQL02)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
