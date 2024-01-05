-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2071- POS
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2071';

SET @LanguageValue = N'Cập nhật kế hoạch bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 4'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity4' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 5'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity5' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 6';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity6' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 7';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity7' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 8';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity8' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 9';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity9' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 11';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 12';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Quantity12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch năm'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.YearPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.TypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Type.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC01'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC02'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S02ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC03'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S03ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC04'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S04ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC05'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S05ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC06'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S06ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC07'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S07ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC08'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S08ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC09'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S09ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC10'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S10ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC11'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S11ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC12'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S12ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC13'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S13ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC14'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S14ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC15'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S15ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC16'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S16ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC17'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S17ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC18'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S18ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC19'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S19ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC20'; EXEC ERP9AddLanguage @ModuleID, 'SOF2071.S20ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kĩ thuật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.Specification' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.UnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.UnitName.CB' , @FormID, @LanguageValue, @Language;

-- Đình Hòa [19/04/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2071.UnitPrice.CB' , @FormID, @LanguageValue, @Language;

