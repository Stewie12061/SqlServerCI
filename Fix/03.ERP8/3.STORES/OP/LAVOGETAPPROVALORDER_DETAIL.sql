IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LAVOGETAPPROVALORDER_DETAIL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LAVOGETAPPROVALORDER_DETAIL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- Edit by Quốc Tuấn, Date 09/02/2015 Đổi CreatDate thành order_created_date.
-- Edit by Quốc Tuấn, Date 13/04/2016 Bổ sung thêm các trường sale_price,vat_percent,PriceListID
---- Modified on 22/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified on 10/08/2020 by Đức Thông: Thêm mã khách hàng vào tên
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--	LAVOGETAPPROVALORDER_DETAIL 'KE','asoftadmin','D302407F-2335-4F37-8C93-BC9622B354E4'

CREATE PROCEDURE LAVOGETAPPROVALORDER_DETAIL
(
	@DivisionID VARCHAR(50),
	@user_id VARCHAR(50),
	@order_id VARCHAR(50)
)
AS
SELECT A01.order_id, A01.order_no, A01.route_id, A01.customer_id, A01.customer_id + '-' + A02.ObjectName customer_name, A02.DeAddress customer_address,
	A01.order_created_date , A01.discount_percent, A01.discount_money, A01.[priority], A01.note,
	A01.OrderStatus as order_status,
	 A01.product_id, A03.InventoryName product_name, A01.quantity, A01.unit,A01.Latitude,A01.Longitude,
	 A01.SalePrice price,A01.VATPercent vat_percent,A01.PriceListID,A01.Address, A01.[user_id], A01.VoucherNo, A04.UnitName
FROM APT0001 A01
LEFT JOIN AT1302 A03 ON A03.DivisionID IN ('@@@', A01.DivisionID) AND A03.InventoryID = A01.product_id
LEFT JOIN AT1202 A02 ON A02.DivisionID IN (@DivisionID, '@@@') AND A02.ObjectID = A01.customer_id
left join at1304 A04 on A01.unit = A04.UnitID
WHERE A01.DivisionID = @DivisionID
AND A01.order_id = @order_id
ORDER BY A01.Orders





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO