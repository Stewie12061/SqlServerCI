IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Form kế thừa phiếu xuất hàng (master)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ, Date 19/09/2018
----Created by: Hoàng Vũ, Date 13/02/2019: Xử lý trường hợp cắt dữ liệu phiếu xuất dưới ERP, Bổ sung 4 bảng WT0095_OK, WT0096_OK, AT2006_OK và AT2007_OK lấy dữ liệu số dư của năm 2018 chuyển qua, tương tư cho những lần cắt dữ liệu năm sau
--- Modified by Tấn Lộc on 21/06/2021: Lấy thêm dữ liệu từ đơn hàng bán
--- Modified by Hoài Bảo on 21/06/2021: Bổ sung điều kiện search
-- <Example> EXEC CRMP2093 'HCM', 0, '08/2018', '2018-01-01', '2018-12-31','','', '', '','', '', '','NV01',1,20

CREATE PROCEDURE CRMP2093 ( 
         @DivisionID varchar(50)
	   , @IsDate TINYINT --0:Datetime; 1:Period
	   , @Periods NVARCHAR(MAX)
	   , @FromDate DATETIME
	   , @ToDate DATETIME
	   , @ExportVoucherNo varchar(50)
	   , @SaleVoucherNo varchar(50)
	   , @ObjectID varchar(50)
	   , @Tel varchar(50)
	   , @WarrantyCard varchar(50)
	   , @SerialNo varchar(50)
	   , @FromShopID varchar(50)
	   , @UserID  VARCHAR(50)
	   , @PageNumber INT
	   , @PageSize INT
)
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL VARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@Table1 VARCHAR(50),
		@Table2 VARCHAR(50),
		@Table3 VARCHAR(50),
		@sWhere1 NVARCHAR(MAX),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
	SET @sWhere=''
	SET @sWhere1=''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	SET @OrderBy = 'P27.VoucherDate Desc'
	
	
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + ' AND P27.DivisionID = N'''+ @DivisionID+''''

	IF @IsDate = 0
	BEGIN 
		--SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), P27.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (P27.VoucherDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (P27.VoucherDate <= ''' + @ToDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (P27.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END
	ELSE 
		--SET @sWhere = @sWhere + ' AND (Case When  P27.TranMonth <10 then ''0''+rtrim(ltrim(str(P27.TranMonth)))+''/''+ltrim(Rtrim(str(P27.TranYear))) 
		--							Else rtrim(ltrim(str(P27.TranMonth)))+''/''+ltrim(Rtrim(str(P27.TranYear))) End) IN ('''+@Periods+''')'
		IF(ISNULL(@Periods,'') != '')
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(P27.VoucherDate, ''MM/yyyy'')) IN ( ''' + @Periods + ''') '

	IF  Isnull(@ExportVoucherNo,'') != ''
		SET @sWhere = @sWhere + ' and P27.VoucherNo like N''%'+ @ExportVoucherNo+'%'''

	IF  Isnull(@SaleVoucherNo,'') != ''
		SET @sWhere = @sWhere + ' and (Case when M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end) Like N''%'+ @SaleVoucherNo+'%'''

	IF  Isnull(@ObjectID,'') != ''
		SET @sWhere = @sWhere + ' and ( M.MemberID like N''%'+ @ObjectID+'%''
										Or M.MemberName like N''%'+ @ObjectID+'%'')'
	IF  Isnull(@Tel,'') != ''
		SET @sWhere = @sWhere + ' and Isnull(P11.Phone, P11.Tel) like N''%'+ @Tel+'%'''

	IF  Isnull(@WarrantyCard,'') != ''
		SET @sWhere = @sWhere + ' and P28.WarrantyCard like N''%'+ @WarrantyCard+'%'''

	IF  Isnull(@SerialNo,'') != ''
		SET @sWhere = @sWhere + ' and P28.SerialNo Like N''%'+ @SerialNo+'%'''
	
	IF  Isnull(@FromShopID,'') != ''
		SET @sWhere = @sWhere + ' and M.ShopID Like N''%'+ @FromShopID+'%'''

	-- Xử lý phần search cho phần Đơn hàng bán - Begin
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere1 = @sWhere1 + ' AND O1.DivisionID = N'''+ @DivisionID+''''

	IF @IsDate = 0
	BEGIN
		--SET @sWhere1 = @sWhere1 + ' AND CONVERT(VARCHAR(10), P27.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (O1.OrderDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (O1.OrderDate <= ''' + @ToDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere1 = @sWhere1 + ' AND (O1.OrderDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END	
	ELSE 
		--SET @sWhere1 = @sWhere1 + ' AND (Case When  P27.TranMonth <10 then ''0''+rtrim(ltrim(str(P27.TranMonth)))+''/''+ltrim(Rtrim(str(P27.TranYear))) 
		--							Else rtrim(ltrim(str(P27.TranMonth)))+''/''+ltrim(Rtrim(str(P27.TranYear))) End) IN ('''+@Periods+''')'
		IF(ISNULL(@Periods,'') != '')
			SET @sWhere1 = @sWhere1 + ' AND (SELECT FORMAT(O1.OrderDate, ''MM/yyyy'')) IN ( ''' + @Periods + ''') '

	IF  Isnull(@ExportVoucherNo,'') != ''
		SET @sWhere1 = @sWhere1 + ' and O1.VoucherNo like N''%'+ @ExportVoucherNo+'%'''

	IF  Isnull(@ObjectID,'') != ''
		SET @sWhere1 = @sWhere1 + ' and ( O1.ObjectID like N''%'+ @ObjectID+'%''
										Or A1.ObjectName like N''%'+ @ObjectID+'%'')'
	IF  Isnull(@SaleVoucherNo,'') != ''
		SET @sWhere1 = @sWhere1 + ' and O1.VoucherNo Like N''%'+ @SaleVoucherNo+'%'''

	IF  Isnull(@Tel,'') != ''
		SET @sWhere1 = @sWhere1 + ' and Isnull(A1.Phonenumber, A1.Tel) like N''%'+ @Tel+'%'''

	-- Kết thúc xử lý phần search cho phần Đơn hàng bán - End

	-- Những bảng WT0096_OK, AT2007_OK, AT2006_OK là những bảng customize, xử lý động trường hợp chạy fix không có 3 bảng trên thì lấy bảng chuẩn
		IF(@CustomerName = 87)
			BEGIN
				SET @Table1 = 'WT0096_OK'
				SET @Table2 = 'AT2007_OK'
				SET @Table3 = 'AT2006_OK'
			END
		ELSE
			BEGIN
				SET @Table1 = 'WT0096'
				SET @Table2 = 'AT2007'
				SET @Table3 = 'AT2006'
			END

	SET @sSQL = '	
				Select Distinct P27.APKPOST0016, P27.APKPOST0027, P27.DivisionID, P27.FromShopID
								, P27.ExportVoucherDate, P27.ExportVoucherNo
								, P27.ObjectID, P27.ObjectName, P27.Tel, P27.Description
								, P27.VoucherDate, P27.VoucherNo
				into #TempPOST0027
				From (
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại cửa hàng) => Search phiếu xuất kho tại cửa hàng
						Select M.APK as APKPOST0016, D.APK as APKPOST00161, Cast(P27.APK as Nvarchar(50)) as APKPOST0027, M.DivisionID, M.ShopID as FromShopID
								, P27.VoucherDate as ExportVoucherDate, P27.VoucherNo as ExportVoucherNo
								, M.MemberID as ObjectID, M.MemberName as ObjectName, Isnull(P11.Phone, P11.Tel) as Tel, P27.Description
								, M.VoucherDate, Case when M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end VoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg = 0
										inner join POST0028 P28 With (NOLOCK) on D.APK = P28.APKDInherited and D.APKMaster = P28.APKMInherited
										Inner join POST0027 P27 With (NOLOCK) on P27.APK = P28.APKMaster and P27.DeleteFlg = P28.DeleteFlg and P27.DeleteFlg = 0
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
						Where D.IsWarehouseGeneral = 0 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))
							' + @sWhere+ '
						Union all
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại chi nhánh) => Search phiếu xuất kho tại chi nhánh cửa bảng chính
						Select M.APK as APKPOST0016, D.APK as APKPOST00161, P27.VoucherID as APKPOST0027, M.DivisionID, M.ShopID as FromShopID
								, P27.VoucherDate, P27.VoucherNo
								, M.MemberID as ObjectID, M.MemberName as ObjectName, Isnull(P11.Phone, P11.Tel) as Tel, P27.Description
								, M.VoucherDate, Case when M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end VoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg  and M.DeleteFlg = 0
										inner join WT0096 W96 With (NOLOCK) on M.DivisionID = W96.DivisionID and M.APK = W96.InheritVoucherID and D.APK = W96.InheritTransactionID
										inner join AT2007 P28 With (NOLOCK) on P28.DivisionID = W96.DivisionID and P28.InheritVoucherID = W96.VoucherID and P28.InheritTransactionID = W96.TransactionID
										inner join AT2006 P27 With (NOLOCK) on P27.DivisionID = P28.DivisionID and P27.VoucherID = P28.VoucherID
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
						Where D.IsWarehouseGeneral = 1 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))
							' + @sWhere+ '
						Union all
						--Lấy phiếu bán hàng/đổi hàng (Xuất tại chi nhánh) => Search phiếu xuất kho tại chi nhánh của bảng tạm
						Select M.APK as APKPOST0016, D.APK as APKPOST00161, P27.VoucherID as APKPOST0027, M.DivisionID, M.ShopID as FromShopID
								, P27.VoucherDate, P27.VoucherNo
								, M.MemberID as ObjectID, M.MemberName as ObjectName, Isnull(P11.Phone, P11.Tel) as Tel, P27.Description
								, M.VoucherDate, Case when M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end VoucherNo
						From POST0016 M With (NOLOCK) inner join POST00161 D With (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg  and M.DeleteFlg = 0
										inner join '+@Table1+' W96 With (NOLOCK) on M.DivisionID = W96.DivisionID and M.APK = W96.InheritVoucherID and D.APK = W96.InheritTransactionID
										inner join '+@Table2+' P28 With (NOLOCK) on P28.DivisionID = W96.DivisionID and P28.InheritVoucherID = W96.VoucherID and P28.InheritTransactionID = W96.TransactionID
										inner join '+@Table3+' P27 With (NOLOCK) on P27.DivisionID = P28.DivisionID and P27.VoucherID = P28.VoucherID
										Inner join POST0011 P11 With (NOLOCK) on P11.MemberID = M.MemberID
						Where D.IsWarehouseGeneral = 1 and ((M.PVoucherNo is null and M.CVoucherNo Is null) or (M.CVoucherNo Is not null and D.IsKindVoucherID = 2))
							' + @sWhere+ '

						Union all
						SELECT O1.APK AS APKPOST0016, O2.APK AS APKPOST00161, O1.SOrderID AS APKPOST0027, O1.DivisionID, O1.DivisionID AS FromShopID, O1.OrderDate, O1.VoucherNo, O1.ObjectID, O1.ObjectName,  A1.Tel as Tel, NULL AS Description
						, O1.OrderDate AS ExportVoucherDate, O1.VoucherNo AS ExportVoucherNo
						From OT2001 O1 WITH (NOLOCK)
							LEFT JOIN AT1202 A1 WITH (NOLOCK) ON O1.ObjectID = A1.ObjectID AND O1.DivisionID = A1.DivisionID
							LEFT JOIN OT2002 O2 WITH (NOLOCK) ON O1.SOrderID = O2.SOrderID
							LEFT join AT2007 P28 With (NOLOCK) on P28.DivisionID = O1.DivisionID AND O2.SOrderID = P28.OrderID AND O2.InventoryID = P28.InventoryID
							LEFT join AT2006 P27 With (NOLOCK) on P27.DivisionID = P28.DivisionID and P27.VoucherID = P28.VoucherID AND P27.ObjectID = O1.ObjectID
						WHERE O1.Disabled = 0 '+@sWhere1+'

					  ) P27
				DECLARE @count int
				Select @count = Count(APKPOST0027) From #TempPOST0027 With (NOLOCK)

				SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
								, P27.APKPOST0016, P27.APKPOST0027, P27.DivisionID, P27.FromShopID
								, P27.ExportVoucherDate, P27.ExportVoucherNo
								, P27.ObjectID, P27.ObjectName, P27.Tel, P27.Description
								, P27.VoucherDate, P27.VoucherNo
				FROM #TempPOST0027 P27
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'							
	EXEC (@sSQL)
	PRINT (@sSQL)
	
	





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
