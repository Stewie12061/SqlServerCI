DECLARE @ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@MessageValue NVARCHAR(400),
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT
------------------------------------------------------------------------------------------------------
-- Set value va Execute query
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US
- Tieng Nhat: ja-JP
- Tieng Trung: zh-CN
*/
SET @Language = 'ja-JP'
SET @ModuleID = 'BEM'

SET @MessageValue=N'費用分析コードと部門分析コードが重複しています。もう一度確認してください'
EXEC ERP9AddMessage @ModuleID,'BEMFML000000', @MessageValue, @Language;
SET @MessageValue=N'データをフィルタリングする前に対象を選択する必要があります！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000001', @MessageValue, @Language;
SET @MessageValue=N'請求金額は残りの金額を超してはなりません！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000002', @MessageValue, @Language;
SET @MessageValue=N'有効期間が無効です。もう一度確認してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000003', @MessageValue, @Language;
SET @MessageValue=N'申請書のみまたは申請書なしのリストを選択する必要があります'
EXEC ERP9AddMessage @ModuleID,'BEMFML000004', @MessageValue, @Language;
SET @MessageValue=N'理由が入力されていません。もう一度確認してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000005', @MessageValue, @Language;
SET @MessageValue=N'出張日数が不正です。もう一度確認してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000006', @MessageValue, @Language;
SET @MessageValue=N'日別出張費が入力されていません。もう一度確認してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000007', @MessageValue, @Language;
SET @MessageValue=N'カテゴリーを申請書としてお選びください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000008', @MessageValue, @Language;
SET @MessageValue=N'申請書を変更すると、グリッド上のすべてのデータが削除されます。よろしいですか。'
EXEC ERP9AddMessage @ModuleID,'BEMFML000009', @MessageValue, @Language;
SET @MessageValue=N'同対象ありの伝票だけ継承できます。'
EXEC ERP9AddMessage @ModuleID,'BEMFML000010', @MessageValue, @Language;
SET @MessageValue=N'開始日から～終了日までをご入力ください。'
EXEC ERP9AddMessage @ModuleID,'BEMFML000011', @MessageValue, @Language;
SET @MessageValue=N'同通貨ありの伝票だけ継承できます。'
EXEC ERP9AddMessage @ModuleID,'BEMFML000012', @MessageValue, @Language;
SET @MessageValue=N'保存できませんでした。{0}申請書は使用中です。'
EXEC ERP9AddMessage @ModuleID,'BEMFML000013', @MessageValue, @Language;
SET @MessageValue=N'{0}の一時的な収入/支出が承認されました。承認ステータスを変更することはできません！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000014', @MessageValue, @Language;
SET @MessageValue=N'{0}には{1}伝票の注釈があります。もう一度確認してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000015', @MessageValue, @Language;
SET @MessageValue=N'請求金額が伝票の残額を上回っています！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000016', @MessageValue, @Language;
SET @MessageValue=N'{0}は自動的に生成されます。削除・編集してはなりません！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000017', @MessageValue, @Language;
SET @MessageValue=N'申請種類を選択してください！'
EXEC ERP9AddMessage @ModuleID,'BEMFML000018', @MessageValue, @Language;
SET @MessageValue=N'The detail data is not valid, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000019', @MessageValue, @Language;
