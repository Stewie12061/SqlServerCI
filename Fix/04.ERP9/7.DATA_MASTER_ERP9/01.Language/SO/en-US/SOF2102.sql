-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2102- SO
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
SET @Language = 'en-US' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2102';

SET @LanguageValue = N'Delivery schedule details';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.SOrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Date30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address17', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity (Standard unit)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ConvertedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivered';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ShippedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remained';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.RemainedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 4';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 5';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 6';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 7';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 8';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 9';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 11';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 12';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 13';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 14';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 15';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 17';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 18';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 19';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 20';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 21';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 22';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 23';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 24';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 25';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 26';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 27';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 28';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 29';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 30';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Quantity30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule information';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ThongTinTienDoGiaoHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule details';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ThongTinChiTietTienDoGiaoHang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'A00.OT2004', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule';
EXEC ERP9AddLanguage @ModuleID, 'A00.OT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.Address30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Train departure date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2102.ShipStartDate', @FormID, @LanguageValue, @Language;

