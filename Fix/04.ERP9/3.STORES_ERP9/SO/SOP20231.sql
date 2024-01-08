IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20231]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20231]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid Master Form SOF2023 Kế thừa phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 23/03/2017
----Modify by: Thị Phượng, Date: 13/04/2017: as AccountID thành ObjectID
----Edited by: Phan thanh hoàng vũ, Date: 05/05/2017: Bổ sung điều kiện search phân quyền xem
----Modify by Hoàng vũ, Date 25/09/2018: Convert chuyển lấy dữ liệu khách hàng CRM (CRMT10101)-> Khách hàng POS (POST0011)
----Modify by Kiều Nga, Date 07/08/2020: Lấy thêm trường mã số thuế VATNo
----Modify by Trọng Kiên, Date 18/01/2021: Bổ sung điều kiện load gọi từ màn hình hợp đồng cho MaiThu
----Modify by Văn Tài,	  Date 19/06/2021: Bổ sung điều kiện bảng theo dõi mới.
----Modify by Đình Hòa,   Date 07/07/2021 : Kiểm tra số lượng mặt hàng của phiếu báo giá đã được kế thừa hết thì không hiển thị.
----Modify by Văn Tài,    Date 16/07/2021 : Customize [DUCTIN] cách kế thừa dữ liệu báo giá. QuotationStatus.
----Modify by Văn Tài,    Date 19/07/2021 : Bổ sung search mã báo giá.
----Modify by Văn Tài,    Date 21/07/2021 : Customize [DUCTIN] cách kế thừa dữ liệu báo giá. QuotationStatus.
----Modify by Văn Tài,    Date 10/09/2021 : Customize [DUCTIN] Load kế thừa cho trường hợp không có phân quyền dữ liệu.
----Modify by Văn Tài,    Date 22/09/2021 : Bổ sung trường hợp là người tạo.
----Modify by Minh Hiếu   Date 14/01/2022 : Bổ sung load người liên hệ.
----Modify by Hoài Bảo	  Date 12/04/2022 : - Cập nhật điều kiện join với bảng chi tiết phiếu báo giá OT2102, do số lượng dữ liệu bảng OT2102 lớn -> Kế thừa phiếu báo giá load rất chậm.
----Editted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
----										  - Cập nhật kiểm tra điều kiện search theo ngày, theo kỳ
----Editted by: Nhật Quang , Date: 05/10/2022: Bổ sung REPLACE @ConditionQuotationID để sử dụng trong IN ();
----Editted by: Kiều Nga , Date: 21/11/2022: Fix lỗi phiếu đã được kế thừa hết thì không load lên
----Editted by: Hoàng Long , Date: 14/11/2023:Bổ sung điều kiện search Ngày hết hạn lên đơn < Ngày hiện tại => Không show báo giá lên để kế thừa đơn hàng bán
-- <Example>
/*

EXEC SOP20231 'AS' , 'VoucherNo' ,'ObjectID' ,'OpportunityID' ,'EmployeeID' ,0 ,'2017-03-23' ,'2017-03-23','01/2017' , 'NV01' ,N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' ,1 ,20

*/
CREATE PROCEDURE SOP20231 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@VoucherNo nvarchar(50),
		@ObjectID nvarchar(250),
        @OpportunityID nvarchar(max),
		@EmployeeID nvarchar(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@ConditionQuotationID nvarchar(max) = null,
		@ClassifyID nvarchar(max) = null,
		@PageNumber INT,
		@PageSize INT,
		@ProjectID nvarchar(max),
		@FromScreenID VARCHAR(50) = ''
) 
AS 
BEGIN
DECLARE @sSQL VARCHAR (MAX),
		@sSQL1 VARCHAR(MAX) = '',
		@sSQL2 VARCHAR(MAX) = '',
		@sWhere VARCHAR(MAX),
		@OrderBy VARCHAR(500),
        @TotalRow VARCHAR(50),
		@Customerindex INT,
		@sJoin VARCHAR(MAX) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

	SET @Customerindex = (select TOP 1 CustomerName from customerindex)
		
	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' M.QuotationDate DESC, M.QuotationNo '
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	IF @PageNumber = 1 
		SET @TotalRow = 'COUNT(*) OVER ()' 
	ELSE 
		SET @TotalRow = 'NULL'
	
	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+ @DivisionID+''''
	
IF @IsDate = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.QuotationDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.QuotationDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.QuotationDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsDate = 1 AND ISNULL(@Period, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(M.QuotationDate, ''MM/yyyy'')) IN ( ''' + @Period + ''') '
	END
	
	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.QuotationNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.ObjectID,'''') LIKE N''%'+@ObjectID+'%'' '

	IF Isnull(@ProjectID, '') != ''
	    SET @sWhere = @sWhere + 'AND ISNULL(M.OpportunityID,'''') IN (select OpportunityID from OOT2100 where ProjectID IN (N'''+ @ProjectID+ ''') AND DivisionID= '''+@DivisionID+''')'

	IF Isnull(@OpportunityID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') IN (N'''+@OpportunityID+''')'
	
	IF Isnull(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EmployeeID,'''') LIKE N''%'+@EmployeeID+'%''  '

	IF Isnull(@ConditionQuotationID, '') != ''
		BEGIN			
			IF(@Customerindex = 114)
			BEGIN
				SET @sJoin = ' LEFT JOIN CMNT0020 CMNT20 WITH (NOLOCK) ON CMNT20.TableID = ''OT2101'' 
																			AND M.APK = CMNT20.APKMaster 
																			AND CMNT20.FollowerID = '''+@UserID+''' 
							   LEFT JOIN SOT9020 OT90 WITH (NOLOCK) ON OT90.TableID = ''OT2101''
																			AND M.APK = OT90.APKMaster 
																			AND ''' + @UserID + ''' IN (OT90.FollowerID01, OT90.FollowerID02, 
																			OT90.FollowerID03, OT90.FollowerID04, OT90.FollowerID05
																											, OT90.FollowerID06, OT90.FollowerID07, OT90.FollowerID08, OT90.FollowerID09, OT90.FollowerID10
																											, OT90.FollowerID11, OT90.FollowerID12, OT90.FollowerID13, OT90.FollowerID14, OT90.FollowerID15
																											, OT90.FollowerID16, OT90.FollowerID17, OT90.FollowerID18, OT90.FollowerID19, OT90.FollowerID20, OT90.FollowerID21, 
									OT90.FollowerID22, OT90.FollowerID23, OT90.FollowerID24, OT90.FollowerID25, OT90.FollowerID26, 
									OT90.FollowerID27, OT90.FollowerID28, OT90.FollowerID29, OT90.FollowerID30, OT90.FollowerID31, 
									OT90.FollowerID32, OT90.FollowerID33, OT90.FollowerID34, OT90.FollowerID35, OT90.FollowerID36, 
									OT90.FollowerID37, OT90.FollowerID38, OT90.FollowerID39, OT90.FollowerID40, OT90.FollowerID41, 
									OT90.FollowerID42, OT90.FollowerID43, OT90.FollowerID44, OT90.FollowerID45, OT90.FollowerID46, 
									OT90.FollowerID47, OT90.FollowerID48, OT90.FollowerID49, OT90.FollowerID50)

																'
				SET @sJoin = @sJoin +' LEFT JOIN CMNT0030 CMNT30 WITH (NOLOCK) ON M.APK = CMNT30.RelatedToID AND CMNT30.UserID = '''+@UserID+''' '

				SET @sWhere = @sWhere + ' AND (ISNULL(M.CreateUserID,'''') in (N'''+@ConditionQuotationID+''' ) 
												OR CMNT20.APKMaster IS NOT NULL 
												OR OT90.APKMaster IS NOT NULL 
												OR CMNT30.RelatedToID IS NOT NULL
											) '
			END
			ELSE
			BEGIN
				SET @sWhere = @sWhere + ' AND ISNULL(M.CreateUserID,'''') IN (N'''+REPLACE(@ConditionQuotationID,',',''',''')+''' )'
			END
		END
	ELSE
		BEGIN
			SET @sJoin = ' LEFT JOIN CMNT0020 CMNT20 WITH (NOLOCK) ON CMNT20.TableID = ''OT2101'' 
																			AND M.APK = CMNT20.APKMaster 
																			AND CMNT20.FollowerID = '''+@UserID+''' 
							   LEFT JOIN SOT9020 OT90 WITH (NOLOCK) ON OT90.TableID = ''OT2101''
																			AND M.APK = OT90.APKMaster 
																			AND ''' + @UserID + ''' IN (OT90.FollowerID01, OT90.FollowerID02, OT90.FollowerID03, OT90.FollowerID04, OT90.FollowerID05
																											, OT90.FollowerID06, OT90.FollowerID07, OT90.FollowerID08, OT90.FollowerID09, OT90.FollowerID10
																											, OT90.FollowerID11, OT90.FollowerID12, OT90.FollowerID13, OT90.FollowerID14, OT90.FollowerID15
																											, OT90.FollowerID16, OT90.FollowerID17, OT90.FollowerID18, OT90.FollowerID19, OT90.FollowerID20, OT90.FollowerID21, OT90.FollowerID22, OT90.FollowerID23, OT90.FollowerID24, OT90.FollowerID25, OT90.FollowerID26, OT90.FollowerID27, OT90.FollowerID28, OT90.FollowerID29, OT90.FollowerID30, OT90.FollowerID31, OT90.FollowerID32, OT90.FollowerID33, OT90.FollowerID34, OT90.FollowerID35, OT90.FollowerID36, OT90.FollowerID37, OT90.FollowerID38, OT90.FollowerID39, OT90.FollowerID40, OT90.FollowerID41, OT90.FollowerID42, OT90.FollowerID43, OT90.FollowerID44, OT90.FollowerID45, OT90.FollowerID46, OT90.FollowerID47, OT90.FollowerID48, OT90.FollowerID49, OT90.FollowerID50)
																'
				SET @sJoin = @sJoin +' LEFT JOIN CMNT0030 CMNT30 WITH (NOLOCK) ON M.APK = CMNT30.RelatedToID AND CMNT30.UserID = '''+@UserID+''' '

				SET @sWhere = @sWhere + ' AND (CMNT20.APKMaster IS NOT NULL 
												OR OT90.APKMaster IS NOT NULL 
												OR CMNT30.RelatedToID IS NOT NULL
												OR M.EmployeeID = '''+@UserID+'''
											) '
		END

   IF Isnull(@ClassifyID, '') != '' AND @Customerindex = 114
		SET @sWhere = @sWhere + ' AND M.ClassifyID = N'''+@ClassifyID+'''  '

   IF Isnull(@FromScreenID, '') != '' AND @FromScreenID = 'CIF1360'
        SET @sWhere = @sWhere + ' AND A1.InheritVoucherID IS NULL AND (A1.InheritTableID IS NULL OR A1.InheritTableID <> ''OT2101'')'

SET @sSQL = ' SELECT DISTINCT 
					  M.APK
					, M.DivisionID, M.QuotationID, M.TranMonth, M.TranYear
					, M.VoucherTypeID, M.ObjectID, D1.MemberName as AccountName, M.EmployeeID, D2.FullName as EmployeeName, M.CurrencyID, M.ExchangeRate
					, M.QuotationNo, M.QuotationDate, M.RefNo1, M.RefNo2, M.RefNo3
					, M.Attention1, M.Attention2, M.Dear, M.Condition, M.SaleAmount
					, M.PurchaseAmount, M.Disabled, M.Status, M.OrderStatus, M.IsSO, M.Description
					, M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID
					, M.InventoryTypeID, M.EndDate, M.Transport, M.DeliveryAddress, M.PaymentID
					, M.PaymentTermID, M.Ana01ID, M.Ana02ID, M.Ana03ID, M.SalesManID, M.ClassifyID
					, M.ObjectName, M.Ana04ID, M.Address, M.ApportionID, M.IsConfirm
					, M.DescriptionConfirm, M.NumOfValidDays, M.Varchar01, M.Varchar02, M.Varchar03
					, M.Varchar04, M.Varchar05, M.Varchar06, M.Varchar07, M.Varchar08, M.Varchar09
					, M.Varchar10, M.Varchar11, M.Varchar12, M.Varchar13, M.Varchar14, M.Varchar15
					, M.Varchar16, M.Varchar17, M.Varchar18, M.Varchar19, M.Varchar20, M.QuotationStatus
					, M.Ana06ID, M.Ana07ID, M.Ana08ID, M.Ana09ID, M.Ana10ID, M.PriceListID, M.OpportunityID,A.OpportunityName
					, D1.Tel,D1.VATNo
					, M.ContactorID, CR1.ContactName AS ContactorName, CR1.Titlecontact AS DutyID
					into #OT2101
					'
SET @sSQL1 = '
					FROM OT2101 M WITH (NOLOCK)   
					LEFT JOIN (SELECT OT2102.QuotationID, SUM(OT2102.QuoQuantity) AS QuoQuantity FROM OT2101  With (NOLOCK) left join OT2102 With (NOLOCK) ON CONVERT(varchar(50),OT2101.APK) = OT2102.QuotationID  GROUP BY OT2102.QuotationID) M1 on CONVERT(varchar(50),M.APK) = M1.QuotationID
					LEFT JOIN (SELECT OT2002.InheritVoucherID ,SUM(OT2002.OrderQuantity) AS OrderQuantity FROM OT2101  With (NOLOCK) left join OT2002 With (NOLOCK) ON CONVERT(varchar(50),OT2101.APK) = OT2002.InheritVoucherID GROUP BY OT2002.InheritVoucherID) M2 on CONVERT(varchar(50),M.APK) = M2.InheritVoucherID --AND ISNULL(M2.OrderQuantity,0) < M1.QuoQuantity
					LEFT JOIN POST0011 D1 With (NOLOCK) on M.ObjectID = D1.MemberID
					LEFT JOIN AT1103 D2 With (NOLOCK) on M.EmployeeID = D2.EmployeeID
					LEFT JOIN CRMT20501 A With (NOLOCK) on M.OpportunityID = A.OpportunityID
					LEFT JOIN AT1031 A1 WITH (NOLOCK) ON A1.InheritVoucherID = M.APK 
					LEFT JOIN CRMT10001 CR1 WITH (NOLOCK) ON M.ContactorID = CR1.ContactID 
						'+@sJoin

IF (@Customerindex = 114)
BEGIN
	 IF (ISNULL(@ClassifyID, '') = '')
	 BEGIN
		SET @sSQL1 = @sSQL1	+ ' WHERE 
			' + @sWhere + ' 
				AND M.QuotationStatus = 3 AND ISNULL(M2.OrderQuantity,0) < M1.QuoQuantity '
	 END
	 ELSE
	 BEGIN
		SET @sSQL1 = @sSQL1	+ ' WHERE 
			' + @sWhere + ' 
				AND M.Status = 1 AND ISNULL(M2.OrderQuantity,0) < M1.QuoQuantity'
	END
END
ELSE IF (@Customerindex = 162)
BEGIN
	SET @sSQL1 = @sSQL1 + ' WHERE ' + @sWhere + ' AND M.Status = 1 AND ISNULL(M2.OrderQuantity,0) < M1.QuoQuantity AND M.EndDate >= CONVERT(DATE, GETDATE())'
END
ELSE IF (@Customerindex = 117)
BEGIN
	SET @sSQL1 = @sSQL1 + ' WHERE ' + @sWhere + ' AND M.Status = 1'
END
ELSE
BEGIN
		SET @sSQL1 = @sSQL1 + ' WHERE ' + @sWhere + ' AND M.Status = 1 AND ISNULL(M2.OrderQuantity,0) < M1.QuoQuantity '
END

SET @sSQL2 = @sSQL2 + ' 
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #OT2101 M
	ORDER BY '+@OrderBy+' 
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
	'

print @sSQL
print @sSQL1
print @sSQL2

EXEC (@sSQL + @sSQL1 + @sSQL2)

END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO