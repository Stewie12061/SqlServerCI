IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1363]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1363]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid thông tin hợp đồng (màn hình chọn hợp đồng)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----	
-- <History>
----Created by: Tra Giang  Date: 26/10/2018
----Modify on 28/03/2019 by Tra Giang: Bổ sung covert kiểu ngày tháng 
---- Modified on 03/10/2019 by Trà Giang: Lọc ngày tháng của hợp đồng trong thời gian có hiệu lực.
---- Modified on 12/12/2019 by Học Huy: Sửa điều kiện lọc ngày tháng.
---- Modified on 06/01/2021 by Trọng Kiên: Fix lỗi không kế thừa được hợp đồng khi loại tiền NULL
-- <Example>
---- 
/*-- <Example>
	CIP1363 @DivisionID = 'BS', @UserID = 'ASOFTADMIN',@FromDate = '', @ToDate = '', @ContractID = '', @ObjectID = ''
	CIP1363 @DivisionID, @UserID,@FromDate, @ToDate, @ContractID, @ObjectID
	select * from AT1020
----*/

CREATE PROCEDURE CIP1363
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ContractID VARCHAR(50),
	 @ObjectID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N''
SET @OrderBy = 'M.ContractID'

IF ISNULL(@DivisionID, '') <> ''
	SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

--Search theo ngày
IF ISNULL(@ToDate, '') != ''
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR, M.BeginDate, 112) < =  N''' + CONVERT(VARCHAR, @ToDate, 112) +''''
IF ISNULL(@FromDate, '') != ''
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR, M.EndDate, 112) > = N''' + CONVERT(VARCHAR, @FromDate, 112) +''''

--Search theo mã hợp đồng
IF ISNULL(@ContractID,'') <> '' SET @sWhere = @sWhere + 'AND M.ContractNo  LIKE N''%'+@ContractID+'%'' '	

--Search theo mã đối tượng
IF ISNULL(@ObjectID,'') <> '' SET @sWhere = @sWhere + 'AND M.ObjectID LIKE N''%'+@ObjectID+'%'' '
	
SET @sSQL = @sSQL + N'
	SELECT M.APK, M.DivisionID, M.ContractID, M.ContractNo, M.ContractName, M.ContractType,
		CASE WHEN M.ContractType = 0 THEN N''Mua'' ELSE N''Bán'' END AS ContractTypeName, 
		M.SignDate, M.BeginDate, M.EndDate, 
		M.CurrencyID, C.CurrencyName, M.ExchangeRate, M.Amount, M.ConvertedAmount, M.Description,
		M.ObjectID, AT1202.ObjectName, AT1202.Contactor, AT1202.Address, AT1202.Tel,
		M.Ana01ID, A11.AnaName AS Ana01Name,
		M.Ana02ID, A12.AnaName AS Ana02Name,
		M.Ana03ID, A13.AnaName AS Ana03Name,
		M.Ana04ID, A14.AnaName AS Ana04Name,
		M.Ana05ID, A15.AnaName AS Ana05Name,
		M.Ana06ID, A16.AnaName AS Ana06Name,
		M.Ana07ID, A17.AnaName AS Ana07Name,
		M.Ana08ID, A18.AnaName AS Ana08Name,
		M.Ana09ID, A19.AnaName AS Ana09Name,
		M.Ana10ID, A10.AnaName AS Ana10Name,M.PriceListID
	FROM AT1020 M WITH (NOLOCK)
		LEFT JOIN AT1004 C WITH (NOLOCK) ON M.CurrencyID = C.CurrencyID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = M.ObjectID
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON M.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A12 WITH (NOLOCK) ON M.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON M.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON M.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A15 WITH (NOLOCK) ON M.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
		LEFT JOIN AT1011 A16 WITH (NOLOCK) ON M.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
		LEFT JOIN AT1011 A17 WITH (NOLOCK) ON M.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
		LEFT JOIN AT1011 A18 WITH (NOLOCK) ON M.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
		LEFT JOIN AT1011 A19 WITH (NOLOCK) ON M.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
		LEFT JOIN AT1011 A10 WITH (NOLOCK) ON M.Ana10ID = A10.AnaID AND A10.AnaTypeID = ''A10''
	WHERE '+@sWhere +' 
		AND InheritContractID IS NULL
	ORDER BY '+@OrderBy+' 
	'
EXEC (@sSQL)
PRINT(@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
