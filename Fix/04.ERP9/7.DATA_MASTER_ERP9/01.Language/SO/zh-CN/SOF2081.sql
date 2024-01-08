-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2081- SO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'SO';
SET @FormID = 'SOF2081';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'産品';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'産品名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地點';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂購數量';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承銷售訂單';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人意見';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評論者 {0:00}';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritAPKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKSOT2081', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優惠券狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨備注';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瓦楞紙核准狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'捲紙核准狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveWaveStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產資訊之繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Assemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AssembleValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APK_BomVersion', @FormID, @LanguageValue, @Language;

