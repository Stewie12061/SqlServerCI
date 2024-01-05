-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2072- POS
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
SET @FormID = 'SOF2072';

SET @LanguageValue = N'Xem chi tiết kế hoạch bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 1'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 2'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 3'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 4'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity4' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 5'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity5' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 6'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity6' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 7'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity7' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 8'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity8' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 9'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity9' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 10'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 11'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity11' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng 12'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Quantity12' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch năm'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.YearPlan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.TabInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.TabInfo1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, N'SOF2072.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kĩ thuật'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2072.Specification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'QC01'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC02'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S02ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC03'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S03ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC04'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S04ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC05'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S05ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC06'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S06ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC07'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S07ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC08'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S08ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC09'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S09ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC10'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S10ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC11'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S11ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC12'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S12ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC13'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S13ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC14'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S14ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC15'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S15ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC16'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S16ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC17'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S17ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC18'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S18ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC19'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S19ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'QC20'; EXEC ERP9AddLanguage @ModuleID, 'SOF2072.S20ID' , @FormID, @LanguageValue, @Language;

