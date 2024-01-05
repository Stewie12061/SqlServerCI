IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00167]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00167]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- In danh sách phiếu bán hàng (Pos Thương mại)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng on 15/11/2017
----Example: EXEC POSP00167 'MS','MS',0,'1/2011'',''12/2013','2017-02-01','2017-12-01',null,Null,'BH000001',null,null,null,null,null,null, 1,''
----Example: EXEC POSP00167 'MSA','',0,'','2011-02-01','2017-12-01',null,'',null,null,null,null,null,null,1,''
 CREATE PROCEDURE POSP00167 (
		 @DivisionID		VARCHAR(50),
		 @DivisionIDList NVARCHAR(2000),
		 @IsDate		TINYINT, --0:Datetime; 1:Period
		 @PeriodIDList	NVARCHAR(4000),
		 @FromDate		DATETIME,
		 @ToDate		DATETIME,
		 @ShopID		NVARCHAR(50),
		 @VoucherTypeID NVARCHAR(50),
		 @VoucherNo		NVARCHAR(50),
		 @MemberID		NVARCHAR(50),
		 @MemberName	NVARCHAR(250),
		 @CurrencyID	NVARCHAR(250),
		 @Imei01		NVARCHAR(250) =null,
		 @Imei02		NVARCHAR(250) = null,
	     @IsCheckAll		TINYINT, --Không check mà xuất luôn
		 @APKList			NVARCHAR(MAX) ---APK của từng phiếu check
		 )
AS
DECLARE @sSQL NVARCHAR (Max),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
		@TotalRow VARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'x.DivisionID, x.ShopID, x.VoucherDate, x.VoucherNo'

	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),M.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
	IF @IsDate = 1 
				SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' AND M.DivisionID = '''+ @DivisionID+''''		
	
	IF Isnull(@ShopID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID,'''') LIKE N''%'+@ShopID+'%'' '
	
	IF Isnull(@VoucherTypeID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherTypeID,'''') LIKE N''%'+@VoucherTypeID+'%'' '
	
	IF Isnull(@VoucherNo, '')!=''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%''or ISNULL(M.PVoucherNo,'''') LIKE N''%'+@VoucherNo+'%''or ISNULL(M.CVoucherNo,'''') LIKE N''%'+@VoucherNo+'%'')'
	
	IF Isnull(@MemberID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.MemberID,'''') LIKE N''%'+@MemberID+'%'' '

	IF Isnull(@MemberName, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.MemberName,'''') LIKE N''%'+@MemberName+'%'' '
	
	IF Isnull(@CurrencyID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CurrencyID,'''') LIKE N''%'+@CurrencyID+'%'' '

	IF Isnull(@Imei01, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(D.Imei01,'''') LIKE N''%'+@Imei01+'%'' '

	IF Isnull(@Imei02, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(D.Imei02,'''') LIKE N''%'+@Imei02+'%'' '

	IF Isnull(@IsCheckAll, 0) = 0 
		SET  @sWhere = @sWhere +'and M.APK IN ('''+@APKList+''')'
	SET @sSQL = '
		SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, COUNT(*) OVER () AS TotalRow,
				x.APK, x.DivisionID, x.ShopID, x.ShopName, x.VoucherTypeID, x.VoucherNo, x.EVoucherNo2, x.VoucherDate, x.MemberID , x.MemberName,x.TotalAmount
				, Case when IsVoucherTypeID = 1 and ExportStatus = 0 then N''CHUAXUATKHO'' else x.CVoucherNo end as CVoucherNo
				, Case when IsVoucherTypeID = 1 and ExportStatus = 0 then N''CHUAXUATKHO'' else x.PVoucherNo end as PVoucherNo
				, x.PVoucherNo, x.CurrencyName, x.PaymentID, x.TotalDiscountAmount, x.TotalRedureAmount, x.TotalInventoryAmount,
				x.ReceiptStatus, x.ExportStatus, x.SaleManID, x.InventoryID, x.InventoryName, x.UnitID, x.UnitName, x.ActualQuantity, x.UnitPrice, x.Amount, x.DiscountAmount
				, x.TaxAmount, x.InventoryAmount, x.IsInstallmentPrice
		FROM (Select M.APK, M.DivisionID, M.ShopID, Z.ShopName, M.VoucherTypeID, M.TotalAmount,
						Case When M.PVoucherNo is null and M.CVoucherNo is null then M.VoucherNo 
							 When M.PVoucherNo is not null and M.CVoucherNo is null then M.PVoucherNo
							 When M.PVoucherNo is null and M.CVoucherNo is not null then M.CVoucherNo end as VoucherNo,
						Case When M.PVoucherNo is not null and M.CVoucherNo is null then M.VoucherNo
							When M.PVoucherNo is null and M.CVoucherNo is not null then M.VoucherNo Else null end as EVoucherNo2, 
						M.VoucherDate, M.MemberID, M.MemberName, M.CVoucherNo, M.PVoucherNo, M.CurrencyName, 
						P.PaymentID, M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalInventoryAmount, Case When M.PVoucherNo is null  and M.CVoucherNo is null 
						and M.TotalInventoryAmount - M.PaymentObjectAmount01 - M.PaymentObjectAmount02- Sum(Isnull(T.Amount, 0)) > 0 then 1 else 0 end as ReceiptStatus,
						Case when XK.APKMInherited is null then 0 else 1 end as ExportStatus, M.SaleManID
						, D.InventoryID, D.InventoryName, D.UnitID, D.UnitName, D.ActualQuantity, D.UnitPrice, D.Amount, D.DiscountAmount
						, D.TaxAmount, D.InventoryAmount, A99.Description as IsInstallmentPrice
						, Case When M.PVoucherNo is null and M.CVoucherNo is null then 1 
										When M.PVoucherNo is not null and M.CVoucherNo is null then 2
										When M.PVoucherNo is null and M.CVoucherNo is not null then 3 end as IsVoucherTypeID
				FROM POST0016 M  WITH (NOLOCK) left join POST00161 D  WITH (NOLOCK) On M.APK=D.APKMaster and M.DeleteFlg = D.DeleteFlg
								LEFT JOIN POST0010 Z WITH (NOLOCK) ON Z.ShopID = M.ShopID
								Left join POST00802 T WITH (NOLOCK) On T.APKMInherited=M.APK and T.DeleteFlg = M.DeleteFlg
								Left join POST0028 XK WITH (NOLOCK) On XK.APKMInherited=M.APK and XK.DeleteFlg = M.DeleteFlg
								Left join POST0006 P WITH (NOLOCK) On M.APKPaymentID = P.APK
								Left join AT0099 A99 WITH (NOLOCK) On A99.ID = D.IsInstallmentPrice and A99.CodeMaster =''AT00000004''
				WHERE M.DeleteFlg = 0 ' +@sWhere + '
				Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.TotalAmount,
						Case When M.PVoucherNo is null and M.CVoucherNo is null then M.VoucherNo 
							 When M.PVoucherNo is not null and M.CVoucherNo is null then M.PVoucherNo
							 When M.PVoucherNo is null and M.CVoucherNo is not null then M.CVoucherNo end,
						Case When M.PVoucherNo is not null and M.CVoucherNo is null then M.VoucherNo
							When M.PVoucherNo is null and M.CVoucherNo is not null then M.VoucherNo Else null end, 
						M.VoucherDate, M.MemberID, M.CVoucherNo, M.PVoucherNo, M.MemberName, M.CurrencyName, 
						P.PaymentID, M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalInventoryAmount, M.AreaID, M.TableID,
						M.TotalInventoryAmount, M.PaymentObjectAmount01, M.PaymentObjectAmount02, XK.APKMInherited, M.SaleManID
						, D.InventoryID, D.InventoryName, D.UnitID, D.UnitName, D.ActualQuantity, D.UnitPrice, D.Amount, D.DiscountAmount
						, D.TaxAmount, D.InventoryAmount, A99.Description, Z.ShopName)x
				ORDER BY '+@OrderBy+''
EXEC (@sSQL)
Print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
