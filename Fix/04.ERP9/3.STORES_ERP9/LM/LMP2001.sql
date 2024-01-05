IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Edit Form LMF2002 Cập nhật hợp đồng tín dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/06/2017 by Bảo Anh
----Modify by Tiểu Mai on 28/09/2017: Bổ sung 10 MPT nghiệp vụ, 20 tham số
----Modify by Hải Long on 20/10/2017: Bổ sung Load tab Thông tin chung
----Modify by Như Hàn on 14/01/2019: Bổ sung đối tượng (Object) tại tab thông tin chung
-- <Example>
/*  
 EXEC LMP2001 'AS','ABCD',1,1,8,0
 EXEC LMP2001 'AS','ABCD',1,1,8,1
 EXEC LMP2001 'AS','ABCD',1,1,8,2
 EXEC LMP2001 'AS','ABCD',1,1,8,3
*/
----
CREATE PROCEDURE LMP2001 ( 
        @DivisionID VARCHAR(50),
		@VoucherID VARCHAR(50),
		@IsViewDetail TINYINT,	--- 0: màn hình edit, 1: màn hình view
		@PageNumber INT,
        @PageSize INT	,
		@Mode Tinyint -- 0: Master, 1: Thong tin chung, 2: Phi, 3: TSĐB, 
) 
AS

DECLARE @ProjectAnaTypeID varchar(50),
		@ContractAnaTypeID varchar(50),
		@CostAnaTypeID varchar(50),
		@sSQL1 VARCHAR (MAX),
		@sSQL2 VARCHAR (MAX),
		@sSQL3 VARCHAR (MAX),
		@sSQL4 VARCHAR (MAX),		
		@TotalRow VARCHAR(50)

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SELECT	@ProjectAnaTypeID = ISNULL(ProjectAnaTypeID,''),
		@ContractAnaTypeID = ISNULL(ContractAnaTypeID,''),
		@CostAnaTypeID = ISNULL(CostAnaTypeID,'')
FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID



--- Dữ liệu master
IF(@Mode = 0)
BEGIN
	SET @sSQL1 = '      
	SELECT		T01.APK, T01.DivisionID, T01.VoucherID, T01.VoucherTypeID, T01.VoucherNo, 
				T01.VoucherDate, T01.TranMonth, T01.TranYear, T01.LimitVoucherID, T01.CreditFormID, 
				ISNULL(T17.BankAccountNo,T16.BankAccountNo) As BankAccountID, T01.FromDate, T01.ToDate, T01.CurrencyID, T04.CurrencyName, T01.ExchangeRate, 
				T01.OriginalAmount, T01.ConvertedAmount, T01.ProjectID, T01.PurchaseContractID, 
				T01.Status, T01.Description, T01.RelatedToTypeID, T01.CreateUserID, T01.CreateDate, 
				T01.LastModifyUserID, T01.LastModifyDate, T01.Parameter01, T01.Parameter02, T01.Parameter03, 
				T01.Parameter04, T01.Parameter05, T01.Parameter06, T01.Parameter07, T01.Parameter08, 
				T01.Parameter09, T01.Parameter10, T01.Parameter11, T01.Parameter12, T01.Parameter13, 
				T01.Parameter14, T01.Parameter15, T01.Parameter16, T01.Parameter17, T01.Parameter18, 
				T01.Parameter19, T01.Parameter20, T01.ContractOfGuaranteeID, ISNULL(T01.BankID,T10.BankID) As BankID, T10.VoucherNo as LimitVoucherNo, 
				T00.CreditFormName, ISNULL(T17.BankName,T16.BankName) As BankName, A01.AnaName as ProjectName, 
				A02.AnaName as PurchaseContractName, T99.Description as StatusName,
				T03.FullName as CreateUserName, T031.FullName as LastModifyUserName,  T51.VoucherNo AS ContractOfGuaranteeNo	
	FROM		LMT2001 T01 WITH (NOLOCK)
	LEFT JOIN	LMT2051	T51 WITH (NOLOCK) ON T01.DivisionID = T51.DivisionID AND T01.ContractOfGuaranteeID = T51.VoucherID	
	LEFT JOIN	LMT1010 T10 WITH (NOLOCK) ON T01.DivisionID = T10.DivisionID AND T01.LimitVoucherID = T10.VoucherID
	LEFT JOIN	LMT1001 T00 WITH (NOLOCK) ON T01.CreditFormID = T00.CreditFormID
	LEFT JOIN	(SELECT DISTINCT BankID, BankName,BankAccountNo, BankAccountID From AT1016 WITH (NOLOCK) Where DivisionID in (''@@@'',''' + @DivisionID + ''') And Disabled = 0) T16 ON T10.BankID = T16.BankID AND T01.BankAccountID = T16.BankAccountID
	LEFT JOIN	AT1011 A01 WITH (NOLOCK) ON T01.ProjectID = A01.AnaID And A01.AnaTypeID = ''' + @ProjectAnaTypeID + '''
	LEFT JOIN	AT1011 A02 WITH (NOLOCK) ON T01.PurchaseContractID = A02.AnaID And A02.AnaTypeID = ''' + @ContractAnaTypeID + '''
	LEFT JOIN	LMT0099 T99 WITH (NOLOCK) ON T01.Status = T99.OrderNo AND CodeMaster = ''LMT00000003''
	LEFT JOIN	AT1103 T03 WITH (NOLOCK) ON T01.CreateUserID = T03.EmployeeID
	LEFT JOIN	AT1103 T031 WITH (NOLOCK) ON T01.LastModifyUserID = T031.EmployeeID
	LEFT JOIN	(SELECT DISTINCT BankID, BankName,BankAccountNo, BankAccountID From AT1016 WITH (NOLOCK) Where DivisionID in (''@@@'',''' + @DivisionID + ''') And Disabled = 0 AND ISNULL(BankID,'''') <>'''') T17 ON T01.BankID = T17.BankID AND T01.BankAccountID = T17.BankAccountID
	LEFT JOIN	AT1004 T04 WITH (NOLOCK) ON T01.CurrencyID = T04.CurrencyID
	WHERE		T01.DivisionID = ''' + @DivisionID + '''
	AND			T01.VoucherID = ''' + @VoucherID + ''''
END
ELSE
--- Thông tin chung
IF(@Mode = 1)
BEGIN
	SET @sSQL1 = '
	SELECT		'+CASE WHEN @IsViewDetail = 1 THEN 'ROW_NUMBER() OVER (ORDER BY T04.Orders) AS RowNum, '+@TotalRow+' AS TotalRow,' ELSE '' END +'
				T04.*, 
				A11.AnaName as Ana01Name, A12.AnaName as Ana02Name, A13.AnaName as Ana03Name, A14.AnaName as Ana04Name, A15.AnaName as Ana05Name,
				A16.AnaName as Ana06Name, A17.AnaName as Ana07Name, A18.AnaName as Ana08Name, A19.AnaName as Ana09Name, A20.AnaName as Ana10Name
				, T12.ObjectName 
	FROM		LMT2004 T04 WITH (NOLOCK)
	LEFT JOIN	AT1011 A11 WITH (NOLOCK) ON A11.AnaID  = T04.Ana01ID AND A11.AnaTypeID = ''A01''
	LEFT JOIN	AT1011 A12 WITH (NOLOCK) ON A12.AnaID  = T04.Ana02ID AND A12.AnaTypeID = ''A02''
	LEFT JOIN	AT1011 A13 WITH (NOLOCK) ON A13.AnaID  = T04.Ana03ID AND A13.AnaTypeID = ''A03''
	LEFT JOIN	AT1011 A14 WITH (NOLOCK) ON A14.AnaID  = T04.Ana04ID AND A14.AnaTypeID = ''A04''
	LEFT JOIN	AT1011 A15 WITH (NOLOCK) ON A15.AnaID  = T04.Ana05ID AND A15.AnaTypeID = ''A05''
	LEFT JOIN	AT1011 A16 WITH (NOLOCK) ON A16.AnaID  = T04.Ana06ID AND A16.AnaTypeID = ''A06''
	LEFT JOIN	AT1011 A17 WITH (NOLOCK) ON A17.AnaID  = T04.Ana07ID AND A17.AnaTypeID = ''A07''
	LEFT JOIN	AT1011 A18 WITH (NOLOCK) ON A18.AnaID  = T04.Ana08ID AND A18.AnaTypeID = ''A08''
	LEFT JOIN	AT1011 A19 WITH (NOLOCK) ON A19.AnaID  = T04.Ana09ID AND A19.AnaTypeID = ''A09''
	LEFT JOIN	AT1011 A20 WITH (NOLOCK) ON A20.AnaID  = T04.Ana10ID AND A20.AnaTypeID = ''A10''
	LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T04.ObjectID = T12.ObjectID
	WHERE		T04.DivisionID = ''' + @DivisionID + '''
	AND			T04.VoucherID = ''' + @VoucherID + '''
	ORDER BY	T04.Orders'
END
ELSE
--- Lưới phí ngân hàng
IF(@Mode = 2)
BEGIN
	SET @sSQL1 = '
	SELECT		'+CASE WHEN @IsViewDetail = 1 THEN 'ROW_NUMBER() OVER (ORDER BY T02.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
				T02.*, A01.AnaName as CostTypeName,
				A11.AnaName as Ana01Name, A12.AnaName as Ana02Name, A13.AnaName as Ana03Name, A14.AnaName as Ana04Name, A15.AnaName as Ana05Name,
				A16.AnaName as Ana06Name, A17.AnaName as Ana07Name, A18.AnaName as Ana08Name, A19.AnaName as Ana09Name, A20.AnaName as Ana10Name
	FROM		LMT2002 T02 WITH (NOLOCK)
	LEFT JOIN	AT1011 A01 WITH (NOLOCK) ON T02.CostTypeID = A01.AnaID And A01.AnaTypeID = ''' + @CostAnaTypeID + '''
	LEFT JOIN	AT1011 A11 WITH (NOLOCK) ON A11.AnaID  = T02.Ana01ID AND A11.AnaTypeID = ''A01''
	LEFT JOIN	AT1011 A12 WITH (NOLOCK) ON A12.AnaID  = T02.Ana02ID AND A12.AnaTypeID = ''A02''
	LEFT JOIN	AT1011 A13 WITH (NOLOCK) ON A13.AnaID  = T02.Ana03ID AND A13.AnaTypeID = ''A03''
	LEFT JOIN	AT1011 A14 WITH (NOLOCK) ON A14.AnaID  = T02.Ana04ID AND A14.AnaTypeID = ''A04''
	LEFT JOIN	AT1011 A15 WITH (NOLOCK) ON A15.AnaID  = T02.Ana05ID AND A15.AnaTypeID = ''A05''
	LEFT JOIN	AT1011 A16 WITH (NOLOCK) ON A16.AnaID  = T02.Ana06ID AND A16.AnaTypeID = ''A06''
	LEFT JOIN	AT1011 A17 WITH (NOLOCK) ON A17.AnaID  = T02.Ana07ID AND A17.AnaTypeID = ''A07''
	LEFT JOIN	AT1011 A18 WITH (NOLOCK) ON A18.AnaID  = T02.Ana08ID AND A18.AnaTypeID = ''A08''
	LEFT JOIN	AT1011 A19 WITH (NOLOCK) ON A19.AnaID  = T02.Ana09ID AND A19.AnaTypeID = ''A09''
	LEFT JOIN	AT1011 A20 WITH (NOLOCK) ON A20.AnaID  = T02.Ana10ID AND A20.AnaTypeID = ''A10''
	WHERE		T02.DivisionID = ''' + @DivisionID + '''
	AND			T02.VoucherID = ''' + @VoucherID + '''
	ORDER BY	T02.Orders'
	IF @IsViewDetail = 1
	BEGIN
		SET @sSQL1 = @sSQL1+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

END
ELSE
--- Lưới TSĐB
IF(@Mode = 3)
BEGIN
	SET @sSQL1 = '
	SELECT		'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T03.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END+'
				T03.*, V03.AssetName, T99.[Description] as SourceName, V03.AccountingValue, V03.LoanLimitRate, V03.LoanLimitAmount,
				V03.LoanLimitAmount - ISNULL(TB.ConvertedAmount, 0) AS RemainAmount,
				A11.AnaName as Ana01Name, A12.AnaName as Ana02Name, A13.AnaName as Ana03Name, A14.AnaName as Ana04Name, A15.AnaName as Ana05Name,
				A16.AnaName as Ana06Name, A17.AnaName as Ana07Name, A18.AnaName as Ana08Name, A19.AnaName as Ana09Name, A20.AnaName as Ana10Name
	FROM		LMT2003 T03 WITH (NOLOCK)
	LEFT JOIN	LMT1020 V03 ON T03.SourceID = V03.SourceID And T03.AssetID = V03.AssetID
	LEFT JOIN	LMT0099 T99 ON T03.SourceID = T99.ID And T99.CodeMaster = ''LMT00000004''
	LEFT JOIN	AT1011 A11 WITH (NOLOCK) ON A11.AnaID  = T03.Ana01ID AND A11.AnaTypeID = ''A01''
	LEFT JOIN	AT1011 A12 WITH (NOLOCK) ON A12.AnaID  = T03.Ana02ID AND A12.AnaTypeID = ''A02''
	LEFT JOIN	AT1011 A13 WITH (NOLOCK) ON A13.AnaID  = T03.Ana03ID AND A13.AnaTypeID = ''A03''
	LEFT JOIN	AT1011 A14 WITH (NOLOCK) ON A14.AnaID  = T03.Ana04ID AND A14.AnaTypeID = ''A04''
	LEFT JOIN	AT1011 A15 WITH (NOLOCK) ON A15.AnaID  = T03.Ana05ID AND A15.AnaTypeID = ''A05''
	LEFT JOIN	AT1011 A16 WITH (NOLOCK) ON A16.AnaID  = T03.Ana06ID AND A16.AnaTypeID = ''A06''
	LEFT JOIN	AT1011 A17 WITH (NOLOCK) ON A17.AnaID  = T03.Ana07ID AND A17.AnaTypeID = ''A07''
	LEFT JOIN	AT1011 A18 WITH (NOLOCK) ON A18.AnaID  = T03.Ana08ID AND A18.AnaTypeID = ''A08''
	LEFT JOIN	AT1011 A19 WITH (NOLOCK) ON A19.AnaID  = T03.Ana09ID AND A19.AnaTypeID = ''A09''
	LEFT JOIN	AT1011 A20 WITH (NOLOCK) ON A20.AnaID  = T03.Ana10ID AND A20.AnaTypeID = ''A10''
	LEFT JOIN
	(
		SELECT LMT2003.DivisionID, LMT2003.AssetID, SUM(LMT2003.ConvertedAmount - ISNULL(LMT2061.UnwindAmount, 0)) AS ConvertedAmount 
		FROM LMT2003 WITH (NOLOCK)
		LEFT JOIN LMT2061 WITH (NOLOCK) ON LMT2003.DivisionID = LMT2061.DivisionID AND LMT2003.TransactionID = LMT2061.LoanTransactionID AND LMT2003.VoucherID = LMT2061.LoanVoucherID
		GROUP BY LMT2003.DivisionID, LMT2003.AssetID
	) TB ON TB.DivisionID = V03.DivisionID AND TB.AssetID = V03.AssetID
	WHERE		T03.DivisionID = ''' + @DivisionID + '''
	AND			T03.VoucherID = ''' + @VoucherID + '''
	ORDER BY	T03.Orders'
	
	IF @IsViewDetail = 1
	BEGIN
		SET @sSQL1 = @sSQL1+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
END
PRINT @sSQL1
EXEC (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

