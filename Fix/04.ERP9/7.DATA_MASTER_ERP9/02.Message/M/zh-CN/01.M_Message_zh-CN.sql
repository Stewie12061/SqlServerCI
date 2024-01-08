DECLARE @ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@MessageValue NVARCHAR(400),
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT
------------------------------------------------------------------------------------------------------
-- Set value và Execute query
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US
- Tieng Nhat: ja-JP
- Tieng Trung: zh-CN
*/
SET @Language = 'zh-CN'
SET @ModuleID = 'M'


SET @MessageValue=N'{0}超出標準產能'
EXEC ERP9AddMessage @ModuleID,'MFML0000004', @MessageValue, @Language;

SET @MessageValue=N'操作過程中發生錯誤'
EXEC ERP9AddMessage @ModuleID,'MFML0000007', @MessageValue, @Language;

SET @MessageValue=N'優惠券{0}不存在。 請再檢查一次'
EXEC ERP9AddMessage @ModuleID,'MFML0000009', @MessageValue, @Language;

SET @MessageValue=N'如果您更改此估算，可能會嚴重影響其他參考估算中材料/機械/勞動力的可用性。 你確定你要繼續嗎？'
EXEC ERP9AddMessage @ModuleID,'MFML0000010', @MessageValue, @Language;

SET @MessageValue=N'請選擇生產線！'
EXEC ERP9AddMessage @ModuleID,'MFML0000011', @MessageValue, @Language;

SET @MessageValue=N'執行條件為空或無效，請重新檢查！'
EXEC ERP9AddMessage @ModuleID,'MFML000293', @MessageValue, @Language;

SET @MessageValue=N'操作{0}尚未更新，請再檢查一次！'
EXEC ERP9AddMessage @ModuleID,'MFML000320', @MessageValue, @Language;

SET @MessageValue=N'您必須從日  起輸入！'
EXEC ERP9AddMessage @ModuleID,'MFML000341', @MessageValue, @Language;

SET @MessageValue=N'生產機器超過標準生產能力。 你想繼續嗎？'
EXEC ERP9AddMessage @ModuleID,'MFML000343', @MessageValue, @Language;

SET @MessageValue=N'產品：{0}尚未申報規格！'
EXEC ERP9AddMessage @ModuleID,'MFML000345', @MessageValue, @Language;

SET @MessageValue=N'必須至少有 1 個有效的分類列！'
EXEC ERP9AddMessage @ModuleID,'MFML000346', @MessageValue, @Language;

SET @MessageValue=N'今天創建的資源！'
EXEC ERP9AddMessage @ModuleID,'MFML000348', @MessageValue, @Language;

SET @MessageValue=N'此 {0} 已被使用。 您只能編輯某些資訊（說明、狀態）。'
EXEC ERP9AddMessage @ModuleID,'MFML000350', @MessageValue, @Language;