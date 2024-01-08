IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1361]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1361]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Form deatail: xem hợp đồng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by: Tra Giang, Date: 10/04/2019
----Modify by: Kiều Nga, Date: 26/03/2021 : Bổ sung load giá trị đã thanh toán từ phiếu thu
----Modify by: Hoài Bảo, Date: 22/09/2022 : Bổ sung load giá trị PaymentVATAmount, DiscountPercent, DiscountAmount
-- <Example>
---- 
/*-- <Example>
	CIP1361 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @ContractID = '3FFB7CE3-D2EA-40E4-9B66-DDE4F6B76FB6', @Mode = 1
	
----*/

CREATE PROCEDURE CIP1361
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ContractID VARCHAR(max),
	 @Mode INT
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
    
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @Mode = 0 
BEGIN 
	SET @OrderBy = 'A31.ContractID'
	SET @sSQL = @sSQL + N'
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
			A31.DivisionID,A31.ContractID,A31.TransactionID,A31.InventoryID,A32.InventoryName,A31.UnitID,A34.UnitName,A31.OrderQuantity,A31.SalePrice,
				ISNULL(A31.OriginalAmount,0) AS OriginalAmount,
				ISNULL(A31.ConvertedAmount,0) AS ConvertedAmount,
				ISNULL(A31.VATOriginalAmount,0) AS VATOriginalAmount,
				ISNULL(A31.OriginalAmount,0) + ISNULL(A31.VATOriginalAmount,0) AS TotalAmount,
				ISNULL(A31.VATConvertedAmount,0) AS VATConvertedAmount,
				ISNULL(A31.DiscountPercent,0) AS DiscountPercent,
				ISNULL(A31.DiscountAmount,0) AS DiscountAmount,
			A31.VATGroupID,A31.VATPercent,A31.Notes,A31.InheritTableID,A31.InheritVoucherID,A31.InheritTransactionID
			,A31.Ana01ID, T01.AnaName As Ana01Name, A31.Ana02ID, T02.AnaName As Ana02Name
			,A31.Ana04ID, A31.Ana05ID, A31.Ana06ID, A31.Ana07ID,T04.AnaName As Ana04Name, T05.AnaName As Ana05Name
			,T06.AnaName As Ana06Name, T07.AnaName As Ana07Name
		FROM AT1031 A31 WITH (NOLOCK) 
		LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A31.InventoryID = A32.InventoryID
		LEFT JOIN AT1304 A34 WITH (NOLOCK) ON  A31.UnitID = A34.UnitID
		LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = A31.Ana01ID AND T01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = A31.Ana02ID AND T02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = A31.Ana04ID AND T04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = A31.Ana05ID AND T05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = A31.Ana06ID AND T06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = A31.Ana07ID AND T07.AnaTypeID = ''A07''
		WHERE A31.DivisionID = '''+ @DivisionID +''' and A31.ContractID = ''' + @ContractID + '''
		ORDER BY '+@OrderBy+' 
			
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END
ELSE 
BEGIN
	SET @OrderBy = 'AT1021.StepID'
	SET @sSQL = @sSQL + N'
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		 AT1021.APK, AT1021.DivisionID, AT1021.ContractDetailID,AT1021.ContractID,AT1021.FromDate,AT1021.ToDate,AT1021.StepID,AT1021.StepName,AT1021.StepDays, AT1021.PaymentPercent
		 ,AT1021.PaymentAmount,AT1021.PaymentVATAmount,AT1021.StepStatus,AT1021.CompleteDate,AT1021.PaymentDate,AT1021.CorrectDate,AT1021.Notes
		 ,CASE WHEN ISNULL(A.ContractDetailID,'''') <>'''' THEN 1 ELSE 0 END AS PaymentStatus,ISNULL(A.ConvertedAmount,0) as Paymented
		FROM AT1021 WITH (NOLOCK)
		LEFT JOIN (
				  SELECT ContractDetailID,SUM(ISNULL(ConvertedAmount,0)) as ConvertedAmount  FROM AT9000
				  WHERE ContractDetailID IS NOT NULL
				  GROUP BY ContractDetailID
		) A ON A.ContractDetailID = AT1021.ContractDetailID
		WHERE AT1021.DivisionID = '''+ @DivisionID +''' and AT1021.ContractID = ''' + @ContractID + '''
		ORDER BY '+@OrderBy+' 
			
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
