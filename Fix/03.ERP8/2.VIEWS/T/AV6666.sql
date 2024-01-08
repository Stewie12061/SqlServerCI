IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV6666]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV6666]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- Created by Nguyen Van Nhan. Date 05/11/2003  
-- View chet loc ra cac chi tieu  
-- Edit by Thiên Huỳnh on 09/11/2012: Kết thêm Đơn vị để lên báo cáo phân tích
--Modify by Thanh Sơn: Thêm Cột Orderby
--- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
--Modify on 22/08/2017 by Khả Vi: Bổ sung loại mặt hàng
--- Modify on 04/03/2018 by Bảo Anh: Bổ sung Kho giữ chỗ (đơn hàng bán)

create VIEW [dbo].[AV6666] AS  
  
-- Mã tài khoản  
SELECT 'AC' AS SelectionType, AccountID AS SelectionID, AccountName AS SelectionName, AT1005.DivisionID,  AccountID AS Orderby
FROM AT1005 WITH (NOLOCK) WHERE Disabled = 0 AND IsNotShow = 0  
  
UNION ALL -- Loại chứng từ  
SELECT 'VT', VoucherTypeID, VoucherTypeName, AT1007.DivisionID, VoucherTypeID AS Orderby
FROM AT1007 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Loại nguyên tệ  
SELECT 'CV', CurrencyID, CurrencyName, AT1004.DivisionID, CurrencyID AS Orderby
FROM AT1004 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Đơn vị  
SELECT 'DV', AT1101.DivisionID, AT1101.DivisionName, T11.DivisionID, AT1101.DivisionID  AS Orderby
FROM AT1101 WITH (NOLOCK) 
LEFT JOIN AT1101 T11 WITH (NOLOCK) On 1=1
WHERE AT1101.Disabled = 0  
  
UNION ALL -- Đối tượng  
SELECT 'OB', ObjectID, ObjectName, AT1202.DivisionID, ObjectID AS Orderby
FROM AT1202 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Mã tài khoản  
SELECT 'CO', AccountID, AccountName, AT1005.DivisionID, AccountID AS Orderby
FROM AT1005 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Mặt hàng  
SELECT 'IN', InventoryID, InventoryName, AT1302.DivisionID, InventoryID  AS Orderby
FROM AT1302 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL --   
SELECT 'PE', PeriodID, Description, MT1601.DivisionID, PeriodID  AS Orderby
FROM MT1601 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Mã phân tích  
SELECT AnaTypeID, AnaID, AnaName, AT1011.DivisionID, AnaID  AS Orderby
FROM AT1011 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Mã phân tích  
SELECT AnaTypeID, AnaID, AnaName, AT1015.DivisionID, AnaID  AS Orderby
FROM AT1015 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Phân loại đối tượng  
SELECT CASE WHEN STypeID = 'O01' THEN 'CO1'  
ELSE CASE WHEN STypeID = 'O02' THEN 'CO2'  
ELSE CASE WHEN STypeID = 'O03' THEN 'CO3'  
END END END, S, SName, AT1207.DivisionID, S AS Orderby
FROM AT1207 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Phân loại mặt hàng  
SELECT CASE WHEN STypeID = 'I01' THEN 'CI1'  
ELSE CASE WHEN STypeID = 'I02' THEN 'CI2'  
ELSE CASE WHEN STypeID = 'I03' THEN 'CI3'  
END END END, S, SName, AT1310.DivisionID,  S  AS Orderby
FROM AT1310 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Đơn hàng bán  
SELECT 'SO', VoucherNo, CONVERT(NVARCHAR(10), OrderDate, 103), OT2001.DivisionID, VoucherNo  AS Orderby
FROM OT2001 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Đơn hàng mua 
SELECT 'PO', VoucherNo, CONVERT(NVARCHAR(10), OrderDate, 103), OT3001.DivisionID, VoucherNo AS Orderby
FROM OT3001 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Tháng  
SELECT Distinct 'MO', MonthYear, MonthYear, AV9999.DivisionID, STR(TranYear*100+TranMonth)  AS Orderby
FROM AV9999  
  
UNION ALL -- Quý  
SELECT Distinct 'QU', Quarter, Quarter, AV9999.DivisionID, STR(TranYear*10+ltrim(rtrim(Case when TranMonth %3 = 0 then TranMonth/3  Else TranMonth/3+1  End))) AS Orderby
FROM AV9999 
  
UNION ALL -- Năm  
SELECT Distinct 'YE', STR(TranYear), STR(TranYear), AV9999.DivisionID, STR(TranYear) AS Orderby
FROM AV9999  
  
UNION ALL -- Phân loại đơn hàng bán  
SELECT 'SCO', ClassifyID, ClassifyName, OT1001.DivisionID, ClassifyID AS Orderby
FROM OT1001 WITH (NOLOCK) WHERE Disabled = 0 AND TypeID = 'SO'  
  
UNION ALL -- Phân loại đơn hàng mua  
SELECT 'PCO', ClassifyID, ClassifyName, OT1001.DivisionID, ClassifyID  AS Orderby
FROM OT1001 WITH (NOLOCK) WHERE Disabled = 0 AND TypeID = 'PO'  
  
UNION ALL  
SELECT AnaTypeID, AnaID, AnaName, OT1002.DivisionID, AnaID AS Orderby
FROM OT1002 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Tháng  
SELECT Distinct 'OMO', MonthYear, MonthYear, OV9999.DivisionID, STR(TranYear*100+TranMonth ) AS Orderby
FROM OV9999  
  
UNION ALL -- Quý  
SELECT Distinct 'OQU', Quarter, Quarter, OV9999.DivisionID, STR (TranYear*10+ltrim(rtrim(Case when TranMonth %3 = 0 then TranMonth/3  Else TranMonth/3+1  End)))  AS Orderby
FROM OV9999  
 
UNION ALL -- Năm  
SELECT Distinct 'OYE', STR(TranYear), STR(TranYear), OV9999.DivisionID, STR(TranYear) AS Orderby
FROM OV9999  
  
UNION ALL -- Nhân viên  
SELECT Distinct 'EM', EmployeeID, FullName, AT1103.DivisionID,  EmployeeID AS Orderby
FROM AT1103 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Nhân viên  
SELECT Distinct 'SM', EmployeeID, FullName, AT1103.DivisionID, EmployeeID  AS Orderby
FROM AT1103 WITH (NOLOCK) WHERE Disabled = 0  
  
UNION ALL -- Tình trạng đơn hàng bán  
SELECT Distinct 'SSO', STR(OrderStatus), Description, OT1101.DivisionID,  STR(OrderStatus)  AS Orderby
FROM OT1101 WITH (NOLOCK) WHERE TypeID = 'SO'  
  
UNION ALL -- Tình trạng đơn hàng mua  
SELECT Distinct 'PSO', STR(OrderStatus), Description, OT1101.DivisionID, STR(OrderStatus)  AS Orderby
FROM OT1101 WITH (NOLOCK) WHERE TypeID = 'PO'

UNION ALL-- Loại mặt hàng 
Select 'INT' as SelectionType,InventoryTypeID as SelectionID, InventoryTypeName as SelectionName,AT1301.DivisionID, InventoryTypeID as Orderby
      From AT1301 WITH (NOLOCK)
      Where Disabled=0

UNION ALL -- Kho giữ chỗ đơn hàng bán  
SELECT Distinct 'SOW', WarehouseID, WarehouseName, AT1303.DivisionID,  WarehouseID  AS Orderby
FROM AT1303 WITH (NOLOCK) WHERE Disabled = 0

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
