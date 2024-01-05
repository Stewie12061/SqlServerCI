IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load Grid danh sách phiếu đề nghị xuất hóa đơn - POSF2030
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng 08/12/2017
----Modify by hoàng vũ on 30/01/2018: sửa cách lấy dữ liệu hóa đơn truy xuất qua bảng AT9000 do 1 phiếu đề nghị bây chờ có thể lập được nhiều phiếu hóa đơn bán hàng), bỏ điều kiện search xuất hóa đơn
----Modify BY Thị Phượng ON 16/01/2018: Sữa bảng lấy dữ liệu từ AT9000 sang POST2030
----Modify by hoàng vũ on 25/01/2019: Bổ sung tên hội viên
----Example EXEC POSP2030 'HCM','','CH-HCM001','',0,'2017-12-08', '2017-12-30', '','','','','','','HOANG',1,25

 CREATE PROCEDURE POSP2030 (
	 @DivisionID	NVARCHAR(Max),			--Biến môi trường
	 @DivisionIDList NVARCHAR(Max),
	 @ShopID		NVARCHAR(Max),				--Biến môi trường
     @ShopIDList	NVARCHAR(Max),
	 @IsDate		TINYINT,					--0:Datetime; 1:Period
     @FromDate		DATETIME,
     @ToDate		DATETIME,
	 @Period		NVARCHAR(Max),
	 @VoucherNo		NVARCHAR(50),
	 @MemberName	NVARCHAR(250),
	 @SuggestUserID	NVARCHAR(250),
	 @Description	NVARCHAR(250),
	 @UserID		NVARCHAR(50),				--Biến môi trường
	 @PageNumber	INT,
     @PageSize		INT						--Biến môi trường
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

	SET @sWhere = ' '
	SET @OrderBy = ' M.VoucherDate DESC, M.VoucherNo'
	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	Else 
		SET @sWhere = @sWhere + ' (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@Period+''')'

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

	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@MemberName, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.VATObjectID,'''') LIKE N''%'+@MemberName+'%'' or ISNULL(M.VATObjectName,'''') LIKE N''%'+@MemberName+'%'' or ISNULL(M.MemberName,'''') LIKE N''%'+@MemberName+'%'')'
		
	IF Isnull(@SuggestUserID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.SuggestUserID,'''') LIKE N''%'+@SuggestUserID+'%'' or ISNULL(P15.FullName,'''') LIKE N''%'+@SuggestUserID+'%'')'

	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Description,'''') LIKE N''%'+@Description+'%'''

   	SET @sSQL ='Select M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
							, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectName
							, M.VATObjectID, M.VATObjectName, P11.Tel, P11.Address, M.SuggestUserID
							, P13.Description as StatusName, M.Status
							, M.Description, P15.FullName SuggestUserName, M.DeleteFlg
							, M.CreateUserID, M.CreateDate
							, M.MemberName
							, M.LastModifyUserID, M.LastModifyDate
							, Case when Isnull(P16.IsTaxIncluded, 0) != 0 Then Isnull(Sum(D.ConvertedAmount) - Sum (D.DiscountAmount),0) 
								Else Isnull(Sum(D.ConvertedAmount) + Sum (D.TaxAmount) - Sum (D.DiscountAmount),0) End as SumAmount
							, Stuff(isnull((	Select  '', '' + x.InVoucherNo From  POST2031 x WITH (NOLOCK)
											Where x.APKMaster = Convert(varchar(50),M.APK) and x.DivisionID= M.DivisionID
											Group By x.InVoucherNo
											FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InVoucherNo
							, Stuff(isnull((	Select  '', '' + y.VoucherNo From  AT9000 y WITH (NOLOCK)
											Where y.InheritVoucherID = Convert(varchar(50),M.APK) 
													and y.DivisionID= M.DivisionID
													and y.TransactionTypeID = ''T04''
													and y.InheritTableID = ''POST2030''
													and y.IsInvoiceSuggest = 1
											Group By y.VoucherNo
											Order by y.VoucherNo
											FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') as InvoiceVoucherNo
							into #TempPOST2030
				FROM POST2030 M WITH (NOLOCK) 
								INNER JOIN POST2031 D WITH (NOLOCK) ON D.APKMaster = M.APK
								Left join POST0011 P11 WITH (NOLOCK) on M.VATObjectID = P11.MemberID
								Left join POST0099 P13 WITH (NOLOCK) on M.Status = P13.ID and P13.CodeMaster =''POS000014''
								Left join AT1103 P15 WITH (NOLOCK) on M.SuggestUserID = P15.EmployeeID
								Left Join POST00161 P16 With (Nolock) on P16.DivisionID = D.DivisionID and P16.APKMaster = D.APKMInherited and P16.APK = D.APKDInherited and P16.DeleteFlg = 0
				WHERE  ' +@sWhere + ' AND M.DeleteFlg = 0 
				Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
								, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectName
								, M.VATObjectID , M.VATObjectName , P11.Tel, P11.Address, M.SuggestUserID
								, P13.Description , M.Status, M.Description, P15.FullName , M.InvoiceVoucherNo, M.DeleteFlg
								, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate, M.MemberName, Isnull(P16.IsTaxIncluded, 0)
				DECLARE @count int
				Select @count = Count(APK) From #TempPOST2030 With (NOLOCK)
							
				SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
								, M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
								, M.TranMonth, M.TranYear, M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectName
								, M.VATObjectID, M.VATObjectName, M.Tel, M.Address, M.SuggestUserID
								, M.StatusName, M.Status, M.InVoucherNo
								, M.Description, M.SuggestUserName, M.InvoiceVoucherNo, M.DeleteFlg
								, M.CreateUserID, M.CreateDate, M.MemberName
								, M.LastModifyUserID, M.LastModifyDate, M.SumAmount
				FROM #TempPOST2030 M WITH (NOLOCK)
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
