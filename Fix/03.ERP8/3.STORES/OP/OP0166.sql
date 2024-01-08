IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0166]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0166]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by : Hai Long, date: 20/08/2016
---purpose: Truy vấn đơn hàng bán đã phân bổ, chưa phân bổ (Khách hàng: ABA)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 06/07/2017: Cộng thêm các tham số vào thành tiền
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[OP0166]  
(  
       @DivisionID nvarchar(50),  
       @TranMonth AS int,  
       @TranYear AS int,  
	   @Mode As Tinyint --1: Đã phân bổ, 0: Chưa phân bổ
)         
AS  
SET NOCOUNT ON  

IF (@Mode = 1)
BEGIN
	SELECT  OT2001.DivisionID,
			OT2001.VoucherTypeID, 
			OT2001.VoucherNo,
			OT2001.OrderDate, 
			OT2001.ContractNo, 
			OT2001.ContractDate,
			OT2001.CurrencyID,
			OT2001.ExchangeRate,  
			OT2001.ObjectID,  
			AT1202.ObjectName, 
			OT2001.DeliveryAddress, 
			OT2001.ClassifyID, 
			ClassifyName,
			OT2001.EmployeeID,
			AT1103.FullName,
			Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0) +
			(CASE WHEN ISNUMERIC(OT2002.nvarchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar04) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar05) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar06) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar07) END)*OT2001.ExchangeRate) AS ConvertedAmount,
			Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
			ISNULL(VAToriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0) +
			CASE WHEN ISNUMERIC(OT2002.nvarchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar04) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar05) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar06) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar07) END) AS OriginalAmount,
			OT2001.Notes,  
			OT2001.ShipDate,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) AS KmNumber,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar11) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar11) END) AS Varchar11,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar12) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar12) END) AS Varchar12,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar13) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar13) END) AS Varchar13,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar14) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar14) END) AS Varchar14,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar15) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar15) END) AS Varchar15,
			OT2002.Ana01ID
		
	FROM OT2001  WITH (NOLOCK)
	LEFT JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SorderID = OT2002.SorderID 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = OT2001.ObjectID 
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN OT1001 WITH (NOLOCK) ON OT2001.DivisionID = OT1001.DivisionID AND OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.TypeID = 'SO'
	WHERE	OT2001.DivisionID = @DivisionID 
			AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear
			AND OT2001.IsConfirm = 1
			AND OT2001.OrderType = 0  
			AND OT2001.IsAllocation = 1
	GROUP BY 
	OT2001.DivisionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, OT2001.ContractNo, OT2001.ContractDate, OT2001.CurrencyID, OT2001.ExchangeRate, OT2001.ObjectID, AT1202.ObjectName,
	OT2001.DeliveryAddress, OT2001.ClassifyID, ClassifyName, OT2001.EmployeeID, AT1103.FullName, OT2001.Notes, OT2001.ShipDate, OT2002.Ana01ID
	ORDER BY OrderDate, VoucherNo	
END
ELSE
BEGIN
	SELECT  OT2001.DivisionID,
			OT2001.VoucherTypeID, 
			OT2001.VoucherNo,
			OT2001.OrderDate, 
			OT2001.ContractNo, 
			OT2001.ContractDate,
			OT2001.CurrencyID,
			OT2001.ExchangeRate,  
			OT2001.ObjectID,  
			AT1202.ObjectName, 
			OT2001.DeliveryAddress, 
			OT2001.ClassifyID, 
			ClassifyName,
			OT2001.EmployeeID,
			AT1103.FullName,
			Sum(ISNULL(ConvertedAmount,0)- ISNULL(DiscountConvertedAmount,0)- ISNULL(CommissionCAmount,0) +
			ISNULL(VATConvertedAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0) +
			(CASE WHEN ISNUMERIC(OT2002.nvarchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar04) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar05) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar06) END +
			 CASE WHEN ISNUMERIC(OT2002.nvarchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar07) END)*OT2001.ExchangeRate) AS ConvertedAmount,
			Sum(ISNULL(OriginalAmount,0)- ISNULL(DiscountOriginalAmount,0) - ISNULL(CommissionOAmount, 0) +
			ISNULL(VAToriginalAmount, 0) - ISNULL(OT2002.DiscountSaleAmountDetail,0) +
			CASE WHEN ISNUMERIC(OT2002.nvarchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar04) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar05) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar06) END +
			CASE WHEN ISNUMERIC(OT2002.nvarchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar07) END) AS OriginalAmount,
			OT2001.Notes,  
			OT2001.ShipDate,
			SUM(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) AS KmNumber,
			OT2002.Ana01ID
		
	FROM OT2001  WITH (NOLOCK)
	LEFT JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SorderID = OT2002.SorderID 
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = OT2001.ObjectID 
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = OT2001.EmployeeID
	LEFT JOIN OT1001 WITH (NOLOCK) ON OT2001.DivisionID = OT1001.DivisionID AND OT1001.ClassifyID = OT2001.ClassifyID AND OT1001.TypeID = 'SO'
	WHERE	OT2001.DivisionID = @DivisionID 
			AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear
			AND OT2001.IsConfirm = 1
			AND OT2001.OrderType = 0  
			AND ISNULL(OT2001.IsAllocation, 0) = 0
			AND CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END > 0
			AND ISNULL(OT2002.Ana01ID, '') IN (Select Ana01ID From AT9000
                                               Where DivisionID = @DivisionID AND 
                                               TranMonth = @TranMonth AND 
                                               TranYear = @TranYear AND 
                                               (DebitAccountID IN (SELECT DISTINCT AccountID From OT0005 Where ISNULL(AccountID, '') <> '' And TypeID Between 'SD21' And 'SD40') 
                                               OR CreditAccountID IN (SELECT DISTINCT AccountID From OT0005 Where ISNULL(AccountID, '') <> '' And TypeID Between 'SD21' And 'SD40'))) 
	GROUP BY 
	OT2001.DivisionID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate, OT2001.ContractNo, OT2001.ContractDate, OT2001.CurrencyID, OT2001.ExchangeRate, OT2001.ObjectID, AT1202.ObjectName,
	OT2001.DeliveryAddress, OT2001.ClassifyID, ClassifyName, OT2001.EmployeeID, AT1103.FullName, OT2001.Notes, OT2001.ShipDate, OT2002.Ana01ID
	ORDER BY OrderDate, VoucherNo	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
