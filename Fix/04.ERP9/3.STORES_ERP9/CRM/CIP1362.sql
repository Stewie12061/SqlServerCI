IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1362]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1362]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Xuất excel hợp đồng.  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Tra Giang, Date: 06/07/2019
----Updated by: Anh Đô, Date: 26/12/2022: Select thêm cột VATGroupName
----Updated by: Anh Đô, Date: 30/12/2022: Bổ sung sắp xếp tăng dần theo StepID cho trường hợp Mode != 0 và 1
----Updated by: Anh Đô, Date: 16/02/2023: Bổ sung lấy tổng giá trị các mặt hàng; Select thêm các cột cho vấn đề [Issue: 2023/01/IS/0074]
-- <Example>
---- 
/*-- <Example>
	CIP1362 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',  @ContractID = '6DD70E52-F3A5-475E-A813-71B03D1B64AD'',''6515773C-21BD-481E-BE88-C85DB080C302', @Mode = 1

----*/

CREATE PROCEDURE CIP1362
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ContractID VARCHAR(max),
	 @Mode INT -- 0: master, 1: detail 
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N''

IF @Mode = 0 
BEGIN 
	SET @sSQL = N'
				SELECT A120.ContractID, A120.VoucherTypeID, A120.ContractNo, A120.SignDate, A120.CurrencyID, AT1004.CurrencyName, A120.ContractName,
				case when A120.ContractType = 0 then N''Mua'' else N''Bán'' end as ContractType,
				A120.InheritContractID,A120.IsAppendixContract, A120.VoucherTypeID as VoucherType,
				A120.ObjectID,AT1202.ObjectName,AT1202.Address,AT1202.Tel,AT1202.Contactor,A120.Amount, 
				A120.ConRef01, A120.ConRef02, A120.ConRef03, A120.ConRef04, A120.ConRef05, A120.ConRef06, A120.ConRef07, A120.ConRef08, A120.ConRef09, A120.ConRef10,
				A120.ConRef11, A120.ConRef12, A120.ConRef13, A120.ConRef14, A120.ConRef15, A120.ConRef16, A120.ConRef17, A120.ConRef18, A120.ConRef19, A120.ConRef20,
				A120.Description, A120.ConvertedAmount, A120.ExchangeRate, A120.EndDate, A120.BeginDate, A120.PriceID, A120.DayUnit,
				A120.ConRefName01,A120.ConRefName02,A120.ConRefName03,A120.ConRefName04,A120.ConRefName05,
				A120.ConRefName06,A120.ConRefName07,A120.ConRefName08,A120.ConRefName09,A120.ConRefName10,
				A120.ConRefName11,A120.ConRefName12,A120.ConRefName13,A120.ConRefName14,A120.ConRefName15,
				A120.ConRefName16,A120.ConRefName17,A120.ConRefName18,A120.ConRefName19,A120.ConRefName20,
				A120.Ana01ID,A11.AnaName as Ana01Name,A120.Ana02ID,A12.AnaName as Ana02Name,A120.Ana03ID,A13.AnaName  as Ana03Name,
				A120.Ana04ID,A14.AnaName as Ana04Name,A120.Ana05ID,A15.AnaName as Ana05Name,
				A120.Ana06ID,A16.AnaName as Ana06Name,A120.Ana07ID,A17.AnaName  as Ana07Name,A120.Ana08ID,A18.AnaName  as Ana08Name,
				A120.Ana09ID,A19.AnaName as Ana09Name,A120.Ana10ID,A10.AnaName  as Ana10Name,
				(CASE WHEN EXISTS(SELECT TOP 1 1 FROM AT1020 AT20 WITH (NOLOCK) WHERE AT20.InheritContractID = A120.ContractID AND IsAppendixContract = 1) 
				THEN 1 ELSE 0 END) AS IsHaveAppendixContract 
				, A20.VoucherTypeName
				, A120.VATConvertedAmount
				FROM AT1020 A120 WITH (NOLOCK)
				LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.CurrencyID = A120.CurrencyID 
				LEFT JOIN AT1202 WITH (NOLOCK) ON A120.ObjectID = AT1202.ObjectID 
				LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A120.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
				LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A120.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A120.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A120.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A120.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A120.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A120.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A120.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
				LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A120.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
				LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A120.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
				LEFT JOIN AT1007 A20 WITH (NOLOCK) ON A20.VoucherTypeID = A120.VoucherTypeID AND A20.DivisionID IN (A120.DivisionID, ''@@@'')
				WHERE A120.DivisionID = ''' + @DivisionID + '''
				AND A120.ContractID IN (''' + @ContractID + ''')'
END 
ELSE
IF @Mode = 1
BEGIN
		SET @sSQL = @sSQL + N'
		SELECT
			ROW_NUMBER() OVER (ORDER BY A31.InventoryID) AS Row	
			,A31.TransactionID
			,A31.InventoryID
			,A32.InventoryName
			,A31.UnitID
			,A34.UnitName
			,A31.OrderQuantity
			,A31.SalePrice
			,ISNULL(A31.OriginalAmount,0) as OriginalAmount
			,ISNULL(A31.ConvertedAmount,0) as ConvertedAmount
			,ISNULL(A31.VATOriginalAmount,0) as VATOriginalAmount
			,ISNULL(A31.OriginalAmount,0) + ISNULL(A31.VATOriginalAmount,0) as TotalAmount
			,ISNULL(A31.ConvertedAmount, 0) + ISNULL(A31.VATConvertedAmount, 0) - ISNULL(A31.DiscountAmount, 0) * A12.ExchangeRate AS TotalConvertedAmount
			,ISNULL(A31.VATConvertedAmount,0) as VATConvertedAmount
			,A31.VATGroupID
			,A31.VATPercent
			,A31.Notes
			,A31.InheritTableID
			,A31.InheritVoucherID
			,A31.InheritTransactionID
			,A10.VATGroupName 
			,ISNULL(A31.DiscountPercent, 0) AS DiscountPercent
			,ISNULL(A31.DiscountAmount, 0) * A12.ExchangeRate AS DiscountConvertedAmount
		FROM AT1031 A31 WITH (NOLOCK) 
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A31.InventoryID = A32.InventoryID
		LEFT JOIN AT1304 A34 WITH (NOLOCK) ON  A31.UnitID = A34.UnitID
		LEFT JOIN AT1010 A10 WITH (NOLOCK) ON A10.VATGroupID = A31.VATGroupID AND A10.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1020 A12 WITH (NOLOCK) ON A12.ContractID = A31.ContractID
		WHERE A31.DivisionID = '''+ @DivisionID +''' and A31.ContractID IN (''' + @ContractID + ''')
		'
END
ELSE IF @Mode = 2
	BEGIN
	
	SET @sSQL = @sSQL + N'
		SELECT
			ROW_NUMBER() OVER(ORDER BY ContractID) AS Row
			,APK
			,DivisionID
			,ContractDetailID
			,ContractID
			,StepID
			,StepName
			,StepDays
			, PaymentPercent
			,PaymentAmount
			,StepStatus
			,CompleteDate
			,PaymentDate
			,CorrectDate
			,PaymentStatus
			,Notes
			,Paymented
			,PaymentVATAmount
		FROM AT1021 WITH (NOLOCK)
		WHERE DivisionID = '''+ @DivisionID +''' and ContractID in (''' + @ContractID + ''')
		ORDER BY AT1021.StepID
		'
	END
ELSE IF @Mode = 3
BEGIN
		SET @sSQL = @sSQL + N'
		SELECT
			A31.ContractID
			,SUM(ISNULL(A31.OriginalAmount, 0) + ISNULL(A31.VATOriginalAmount, 0) - ISNULL(A31.DiscountAmount, 0)) AS TSumOriginalAmount
			,SUM(ISNULL(A31.ConvertedAmount, 0) + ISNULL(A31.VATConvertedAmount, 0) - ISNULL(A31.DiscountAmount, 0) * A12.ExchangeRate) AS TSumConvertedAmount
			,SUM(ISNULL(A31.OriginalAmount, 0)) AS TOriginalAmount
			,SUM(ISNULL(A31.ConvertedAmount, 0)) AS TConvertedAmount
			,SUM(ISNULL(A31.DiscountAmount, 0)) AS TOriginalDiscountAmount
			,SUM(ISNULL(A31.DiscountAmount, 0) * A12.ExchangeRate) AS TConvertedDiscountAmount
			,SUM(ISNULL(A31.VATOriginalAmount, 0)) AS TVATOriginalAmount
			,SUM(ISNULL(A31.VATConvertedAmount, 0)) AS TVATConvertedAmount
		FROM AT1031 A31 WITH (NOLOCK) 
		LEFT JOIN AT1020 A12 WITH (NOLOCK) ON A12.ContractID = A31.ContractID
		WHERE A31.DivisionID = '''+ @DivisionID +''' and A31.ContractID IN (''' + @ContractID + ''')
		GROUP BY A31.ContractID
		'
END
	
		

PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
