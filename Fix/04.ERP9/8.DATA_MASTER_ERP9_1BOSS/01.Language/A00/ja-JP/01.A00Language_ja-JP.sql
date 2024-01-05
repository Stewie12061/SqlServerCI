------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ A00 - Dùng chung
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@LanguageValue NVARCHAR(50),
------------------------------------------------------------------------------------------------------
-- Button
------------------------------------------------------------------------------------------------------
@ControlName NVARCHAR(4000),
-----------------------------------------------------------------------------------------------------
-- Menu
------------------------------------------------------------------------------------------------------
@mnuParent_Child NVARCHAR(4000),
@mnuGrandParent_Parent_Child NVARCHAR(4000),

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
SET @Language = 'ja-JP' 
SET @ModuleID = '00';
SET @FormID = 'A00';
------------------------------------------------------------------------------------------------------
-- Button
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Tính';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCal' , @FormID, @ControlName, @Language;

SET @ControlName = N'保存&インプット';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveNew' , @FormID, @ControlName, @Language;

SET @ControlName = N'保存＆コピー';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveCopy' , @FormID, @ControlName, @Language;

SET @ControlName = N'保存＆クローズ';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveClose' , @FormID, @ControlName, @Language;

SET @ControlName = N'閉める';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnClose' , @FormID, @ControlName, @Language;

SET @ControlName = N'Add new';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnAddNew' , @FormID, @ControlName, @Language;

SET @ControlName = N'修正';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnEdit' , @FormID, @ControlName, @Language;

SET @ControlName = N'削除';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnDelete' , @FormID, @ControlName, @Language;

SET @ControlName = N'エクセルにダウンロード';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnExcel' , @FormID, @ControlName, @Language;

SET @ControlName = N'隠す';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnHide' , @FormID, @ControlName, @Language;

SET @ControlName = N'現れる';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnShow' , @FormID, @ControlName, @Language;

SET @ControlName = N'フィルタ';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnFilter' , @FormID, @ControlName, @Language;

SET @ControlName = N'再作業';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnResetFilter' , @FormID, @ControlName, @Language;

SET @ControlName = N'ログイン';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnLogin' , @FormID, @ControlName, @Language;

SET @ControlName = N'個人情報';
EXEC ERP9AddLanguage @ModuleID, 'A00.InfoPerson' , @FormID, @ControlName, @Language;

SET @ControlName = N'Logout';
EXEC ERP9AddLanguage @ModuleID, 'A00.Logout' , @FormID, @ControlName, @Language;

SET @ControlName = N'保存';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSave' , @FormID, @ControlName, @Language;

SET @ControlName = N'原稿＆詳細インプット';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveDetails' , @FormID, @ControlName, @Language;

SET @ControlName = N'同意';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnOK' , @FormID, @ControlName, @Language;

SET @ControlName = N'キャンセル';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCancel' , @FormID, @ControlName, @Language;

SET @ControlName = N'設定保存';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveSetting' , @FormID, @ControlName, @Language;

SET @ControlName = N'アップロード';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnUpload' , @FormID, @ControlName, @Language;

SET @ControlName = N'プリント';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrint' , @FormID, @ControlName, @Language;

SET @ControlName = N'In biểu đồ';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrintBD' , @FormID, @ControlName, @Language;


SET @ControlName = N'書簡を印刷する';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrintCV' , @FormID, @ControlName, @Language;

SET @ControlName = N'Duyệt hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnConfirmAll' , @FormID, @ControlName, @Language;

SET @ControlName = N'Import ngân hàng rút về';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnImportBank' , @FormID, @ControlName, @Language;

SET @ControlName = N'継承';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnInherit' , @FormID, @ControlName, @Language;

SET @ControlName = N'選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChoose' , @FormID, @ControlName, @Language;

SET @ControlName = N'選択解除';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnUnChoose' , @FormID, @ControlName, @Language;

SET @ControlName = N'...';
EXEC ERP9AddLanguage @ModuleID, 'A00.threedot' , @FormID, @ControlName, @Language;

SET @ControlName = N'データーを読む';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnRead' , @FormID, @ControlName, @Language;

SET @ControlName = N'Update';
EXEC ERP9AddLanguage @ModuleID, 'A00.titleNew' , @FormID, @ControlName, @Language;

SET @ControlName = N'Update';
EXEC ERP9AddLanguage @ModuleID, 'A00.titleEdit' , @FormID, @ControlName, @Language;

SET @ControlName = N'新コードを取る';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnGetNewID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Add content';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnAddContent' , @FormID, @ControlName, @Language;

SET @ControlName = N'ワードファイルから読む';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnImportWord' , @FormID, @ControlName, @Language;

SET @ControlName = N'ファイル選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChooseFile' , @FormID, @ControlName, @Language;

SET @ControlName = N'メール送信';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSendEmail' , @FormID, @ControlName, @Language;

SET @ControlName = N'送信';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSend' , @FormID, @ControlName, @Language;

SET @ControlName = N'原稿保存';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSaveDraft' , @FormID, @ControlName, @Language;

SET @ControlName = N'暫定な選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChooseTemplate' , @FormID, @ControlName, @Language;

SET @ControlName = N'Select to Campaign';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnAddToCampaign' , @FormID, @ControlName, @Language;

SET @ControlName = N'Select to Receiver';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnAddToReceiver' , @FormID, @ControlName, @Language;

SET @ControlName = N'シフト変更';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeShift' , @FormID, @ControlName, @Language;

SET @ControlName = N'>';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeSingle' , @FormID, @ControlName, @Language;

SET @ControlName = N'>>';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeAll' , @FormID, @ControlName, @Language;

SET @ControlName = N'<';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeReturn' , @FormID, @ControlName, @Language;
SET @ControlName = N'<<';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnReturnAll' , @FormID, @ControlName, @Language;

SET @ControlName = N'設定保存';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnConfig' , @FormID, @ControlName, @Language;

SET @ControlName = N'Kiểm tra kết nối';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCheckConfig' , @FormID, @ControlName, @Language;

SET @ControlName = N'Đổi hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeInventory' , @FormID, @ControlName, @Language;

SET @ControlName = N'在庫品返還';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnReturnInventory' , @FormID, @ControlName, @Language;

SET @ControlName = N'Đề nghị gửi công văn XR';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSendDocXR' , @FormID, @ControlName, @Language;

SET @ControlName = N'Đề nghị gửi công văn VPL';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSendDocVPL' , @FormID, @ControlName, @Language;

SET @ControlName = N'ドキュメント保存';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnSendDoc' , @FormID, @ControlName, @Language;

SET @ControlName = N'ファイル閉め';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCloseResume' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mở hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnOpenResume' , @FormID, @ControlName, @Language;

SET @ControlName = N'インポート';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnImport' , @FormID, @ControlName, @Language;

SET @ControlName = N'データExport';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnExportF' , @FormID, @ControlName, @Language;

SET @ControlName = N'ファイル選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChooseAttachment' , @FormID, @ControlName, @Language;

SET @ControlName = N'パスワード';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPassword' , @FormID, @ControlName, @Language;

SET @ControlName = N'Templateアップロード';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnDownloadTPL' , @FormID, @ControlName, @Language;

SET @ControlName = N'In phí thu hồi nợ';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrintDebtRecoveryFee' , @FormID, @ControlName, @Language;

SET @ControlName = N'データーを読む';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnReadData' , @FormID, @ControlName, @Language;

SET @ControlName = N'チームに社員を追加する';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnEmpToTeam' , @FormID, @ControlName, @Language;

SET @ControlName = N'ユーザーをロックする';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnLockUser' , @FormID, @ControlName, @Language;

SET @ControlName = N'ユーザーのロックを開ける';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnUnLockUser' , @FormID, @ControlName, @Language;

SET @ControlName = N'パスワードリセット';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnResetPassUser' , @FormID, @ControlName, @Language;

SET @ControlName = N'全部削除';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnDeleteAll' , @FormID, @ControlName, @Language;

SET @ControlName = N'毎日の処理';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnDailyProcess' , @FormID, @ControlName, @Language;

SET @ControlName = N'未承認';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnNotConfirm' , @FormID, @ControlName, @Language;

SET @ControlName = N'承認';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnConfirm' , @FormID, @ControlName, @Language;

SET @ControlName = N'却下';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCancelConfirm' , @FormID, @ControlName, @Language;

SET @ControlName = N'Công văn Xương Rồng 1';
EXEC ERP9AddLanguage @ModuleID, 'A00.CVXR1' , @FormID, @ControlName, @Language;

SET @ControlName = N'公安の書簡';
EXEC ERP9AddLanguage @ModuleID, 'A00.CVCA' , @FormID, @ControlName, @Language;

SET @ControlName = N'Báo cáo lịch sử làm việc loại 1';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReportHistory1' , @FormID, @ControlName, @Language;

SET @ControlName = N'Báo cáo lịch sử làm việc loại 2';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReportHistory2' , @FormID, @ControlName, @Language;

--------------30/06/2020 - Đình Ly: Ngôn ngữ nút show giao diện GridView--------------
SET @ControlName = N'GridView display';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnGridView' , @FormID, @ControlName, @Language;

--------------30/06/2020 - Đình Ly: Ngôn ngữ nút show giao diện Kanban--------------
SET @ControlName = N'Kanban display';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnKanbanView' , @FormID, @ControlName, @Language;

--------------30/06/2020 - Đình Ly: Ngôn ngữ nút show giao diện Ganttchart--------------
SET @ControlName = N'Ganchart display';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnGanChartView' , @FormID, @ControlName, @Language;

--------------10/08/2020 - Tấn Lộc: Ngôn ngữ nút nhận mail --------------
SET @ControlName = N'Get mail';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnReceiveMail' , @FormID, @ControlName, @Language;

--------------02/10/2020 - Vĩnh Tâm: Ngôn ngữ common: Thành công, Thất bại --------------
SET @ControlName = N'Success';
EXEC ERP9AddLanguage @ModuleID, 'A00.Success' , @FormID, @ControlName, @Language;

SET @ControlName = N'Failure';
EXEC ERP9AddLanguage @ModuleID, 'A00.Failure' , @FormID, @ControlName, @Language;

--------------30/09/2020 - Tấn Lộc: Ngôn ngữ thiết lập rules--------------
SET @ControlName = N'Mail rules setting';
EXEC ERP9AddLanguage @ModuleID, 'A00.SF2020' , @FormID, @ControlName, @Language;

--------------02/10/2020 - Vĩnh Tâm: Menu màn hình Quản lý Pipeline, Lịch sử truy cập --------------
SET @ControlName = N'Pipelines management';
EXEC ERP9AddLanguage @ModuleID, 'A00.SF2010' , @FormID, @ControlName, @Language;

SET @ControlName = N'Login history';
EXEC ERP9AddLanguage @ModuleID, 'A00.SF0012' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Menu
------------------------------------------------------------------------------------------------------
SET @mnuParent_Child = N'';
SET @mnuGrandParent_Parent_Child = N'';

------------------------------------------------------------------------------------------------------
-- Dùng chung
------------------------------------------------------------------------------------------------------

SET @ControlName = N'作成日';
EXEC ERP9AddLanguage @ModuleID, 'A00.CreateDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'作成者';
EXEC ERP9AddLanguage @ModuleID, 'A00.CreateUserID' , @FormID, @ControlName, @Language;

SET @ControlName = N'更新者';
EXEC ERP9AddLanguage @ModuleID, 'A00.LastModifyUserID' , @FormID, @ControlName, @Language;

SET @ControlName = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'A00.LastModifyDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'システム';
EXEC ERP9AddLanguage @ModuleID, 'A00.SystemInfo' , @FormID, @ControlName, @Language;

SET @ControlName = N'歴史の情報';
EXEC ERP9AddLanguage @ModuleID, 'A00.HistoryInfo' , @FormID, @ControlName, @Language;

SET @ControlName = N'選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.ChooseCol' , @FormID, @ControlName, @Language;

SET @ControlName = N'数';
EXEC ERP9AddLanguage @ModuleID, 'A00.Number' , @FormID, @ControlName, @Language;

SET @ControlName = N'数';
EXEC ERP9AddLanguage @ModuleID, 'A00.Order' , @FormID, @ControlName, @Language;

SET @ControlName = N'Shiftキーを押しながらEnterキーを押すことで投稿する';
EXEC ERP9AddLanguage @ModuleID, 'A00.NoteMessage' , @FormID, @ControlName, @Language;

SET @ControlName = N'内容';
EXEC ERP9AddLanguage @ModuleID, 'A00.Content' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Login
------------------------------------------------------------------------------------------------------
SET @ControlName = N'ユーザーID';
EXEC ERP9AddLanguage @ModuleID, 'A00.UserID' , @FormID, @ControlName, @Language;

SET @ControlName = N'パスワード';
EXEC ERP9AddLanguage @ModuleID, 'A00.Password' , @FormID, @ControlName, @Language;

SET @ControlName = N'ユーザーグループ';
EXEC ERP9AddLanguage @ModuleID, 'A00.GroupID' , @FormID, @ControlName, @Language;

SET @ControlName = N'承認コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.Captcha' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- Report Date/Period
------------------------------------------------------------------------------------------------------
SET @ControlName = N'～日から';
EXEC ERP9AddLanguage @ModuleID, 'A00.FromDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'日まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.ToDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'日付';
EXEC ERP9AddLanguage @ModuleID, 'A00.Date' , @FormID, @ControlName, @Language;

SET @ControlName = N'～期間から';
EXEC ERP9AddLanguage @ModuleID, 'A00.FromPeriod' , @FormID, @ControlName, @Language;

SET @ControlName = N'期間まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.ToPeriod' , @FormID, @ControlName, @Language;

SET @ControlName = N'報告書を見る';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReportViewer' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- Thông tin công ty
------------------------------------------------------------------------------------------------------
SET @ControlName = N'ASOFT CORPORATION';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyName' , @FormID, @ControlName, @Language;

SET @ControlName = N'T+ (+ 84) 1900-6123';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyTel' , @FormID, @ControlName, @Language;

SET @ControlName = N'(+ 84.8) 3997-6838';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyFax' , @FormID, @ControlName, @Language;

SET @ControlName = N'A+ No.46, Street 5, Ward 7, Go Vap District, HCMC, VN';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyAddress' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- Kỳ kế toán
------------------------------------------------------------------------------------------------------
SET @ControlName = N'期間';
EXEC ERP9AddLanguage @ModuleID, 'A00.Period' , @FormID, @ControlName, @Language;

SET @ControlName = N'単位';
EXEC ERP9AddLanguage @ModuleID, 'A00.DivisionID' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- TabStrip Title, message title
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Updating';
EXEC ERP9AddLanguage @ModuleID, 'A00.Updating' , @FormID, @ControlName, @Language;

SET @ControlName = N'添付';
EXEC ERP9AddLanguage @ModuleID, 'A00.Attach' , @FormID, @ControlName, @Language;

SET @ControlName = N'歴史';
EXEC ERP9AddLanguage @ModuleID, 'A00.History' , @FormID, @ControlName, @Language;

SET @ControlName = N'詳細';
EXEC ERP9AddLanguage @ModuleID, 'A00.Details' , @FormID, @ControlName, @Language;

SET @ControlName = N'通報';
EXEC ERP9AddLanguage @ModuleID, 'A00.Message' , @FormID, @ControlName, @Language;

SET @ControlName = N'Connecting, please wait';
EXEC ERP9AddLanguage @ModuleID, 'A00.PrintMessage' , @FormID, @ControlName, @Language;


------------------------------------------------------------------------------------------------------
-- Status
------------------------------------------------------------------------------------------------------
SET @ControlName = N'はい';
EXEC ERP9AddLanguage @ModuleID, 'A00.Yes' , @FormID, @ControlName, @Language;

SET @ControlName = N'いいえ';
EXEC ERP9AddLanguage @ModuleID, 'A00.No' , @FormID, @ControlName, @Language;

SET @ControlName = N'キャンセル';
EXEC ERP9AddLanguage @ModuleID, 'A00.Cancel' , @FormID, @ControlName, @Language;

SET @ControlName = N'送信済み';
EXEC ERP9AddLanguage @ModuleID, 'A00.Send' , @FormID, @ControlName, @Language;

SET @ControlName = N'Not send';
EXEC ERP9AddLanguage @ModuleID, 'A00.NotSend' , @FormID, @ControlName, @Language;

SET @ControlName = N'締め切り';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnCloseBook' , @FormID, @ControlName, @Language;

SET @ControlName = N'帳簿開設';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnOpenBook' , @FormID, @ControlName, @Language;

SET @ControlName = N'全て';
EXEC ERP9AddLanguage @ModuleID, 'A00.All' , @FormID, @ControlName, @Language;

SET @ControlName = N'会計期間の帳簿締め';
EXEC ERP9AddLanguage @ModuleID, 'A00.CloseBook' , @FormID, @ControlName, @Language;

SET @ControlName = N'帳簿開設';
EXEC ERP9AddLanguage @ModuleID, 'A00.OpenBook' , @FormID, @ControlName, @Language;

SET @ControlName = N'システム設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.Config' , @FormID, @ControlName, @Language;

SET @ControlName = N'システム';
EXEC ERP9AddLanguage @ModuleID, 'A00.System' , @FormID, @ControlName, @Language;

SET @ControlName = N'一般設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.CommonConfig' , @FormID, @ControlName, @Language;

SET @ControlName = N'システム設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.ConfigSystem' , @FormID, @ControlName, @Language;

SET @ControlName = N'Thông tin mặc định';
EXEC ERP9AddLanguage @ModuleID, 'A00.DefaultInfo' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module CI';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleCI' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module DRM';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleDRM' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module S';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleS' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module T';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleT' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module HRM';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleHRM' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module WM';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleWM' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module MT';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleMT' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module POS';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModulePOS' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module FA';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleFA' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module OP';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleOP' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module CRM';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleCRM' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module OO';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleOO' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module SO';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleSO' , @FormID, @ControlName, @Language;

SET @ControlName = N'Other person data permission';
EXEC ERP9AddLanguage @ModuleID, 'A00.PermissionSeeDataAnotherPerson' , @FormID, @ControlName, @Language;

SET @ControlName = N'画面の権限設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.ScreenPermission' , @FormID, @ControlName, @Language;

SET @ControlName = N'データ権限設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.ConfigurePermissionData' , @FormID, @ControlName, @Language;

SET @ControlName = N'Data permission';
EXEC ERP9AddLanguage @ModuleID, 'A00.PermissionData' , @FormID, @ControlName, @Language;

SET @ControlName = N'Report permission';
EXEC ERP9AddLanguage @ModuleID, 'A00.PermissionReport' , @FormID, @ControlName, @Language;

SET @ControlName = N'History permission';
EXEC ERP9AddLanguage @ModuleID, 'A00.PermissionHistory' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- MENU
------------------------------------------------------------------------------------------------------

SET @ControlName = N'設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.Setting' , @FormID, @ControlName, @Language;

SET @ControlName = N'リスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.List' , @FormID, @ControlName, @Language;

SET @ControlName = N'会社';
EXEC ERP9AddLanguage @ModuleID, 'A00.Business' , @FormID, @ControlName, @Language;

SET @ControlName = N'レポート';
EXEC ERP9AddLanguage @ModuleID, 'A00.Report' , @FormID, @ControlName, @Language;

SET @ControlName = N'サーポット';
EXEC ERP9AddLanguage @ModuleID, 'A00.Help' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- CRM
------------------------------------------------------------------------------------------------------
SET @ControlName = N'添付ファイル選択';
EXEC ERP9AddLanguage @ModuleID, 'A00.ChoseAttachFile' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- POS
------------------------------------------------------------------------------------------------------


SET @ControlName = N'Point of Sale';
EXEC ERP9AddLanguage @ModuleID, 'A00.POS' , @FormID, @ControlName, @Language;

SET @ControlName = N'店のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Shop' , @FormID, @ControlName, @Language;

SET @ControlName = N'店にある商品のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Product' , @FormID, @ControlName, @Language;

SET @ControlName = N'会員のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Member' , @FormID, @ControlName, @Language;

SET @ControlName = N'支払い方法のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Payment' , @FormID, @ControlName, @Language;

SET @ControlName = N'会員カードのリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_MemberCard' , @FormID, @ControlName, @Language;

SET @ControlName = N'カードの種類のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_MemberCardType' , @FormID, @ControlName, @Language;

SET @ControlName = N'地区のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_AreaCategory' , @FormID, @ControlName, @Language;

SET @ControlName = N'表のリスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_TableCategory' , @FormID, @ControlName, @Language;

SET @ControlName = N'期間リスト';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Time' , @FormID, @ControlName, @Language;

SET @ControlName = N'Stock Balance Receipt';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_List_Stock_Inventory' , @FormID, @ControlName, @Language;

SET @ControlName = N'Stock Balance Receipt';
EXEC ERP9AddLanguage @ModuleID, 'A00.POS_Stock_Inventory' , @FormID, @ControlName, @Language;

SET @ControlName = N'商売領収書';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_Sale' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu nhập hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_Import' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu đề nghị xuất/ trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_Export_Refund' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_Export' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu kiểm kê kho';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_CheckWarehouse' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu điều chỉnh kho';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_ChangeWarehouse' , @FormID, @ControlName, @Language;

SET @ControlName = N'Phiếu nhật ký hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_DiarySale' , @FormID, @ControlName, @Language;

SET @ControlName = N'グラフレポート';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Report_Chart' , @FormID, @ControlName, @Language;

-- Phiếu chênh lệch
SET @ControlName = N'Phiếu chênh lệch';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemPOS_Business_Disparity', @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- S
------------------------------------------------------------------------------------------------------
SET @ControlName = N'ASOFT-S';
EXEC ERP9AddLanguage @ModuleID, 'A00.ASOFTS', @FormID, @ControlName, @Language;

SET @ControlName = N'ユーザーグループ';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemS_List_GroupName', @FormID, @ControlName, @Language;

SET @ControlName = N'ユーザー';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemS_List_UserName', @FormID, @ControlName, @Language;

SET @ControlName = N'言語';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemS_List_Language' , @FormID, @ControlName, @Language;

SET @ControlName = N'通報';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemS_List_Message' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- CI
------------------------------------------------------------------------------------------------------
SET @ControlName = N'ASOFT-CI';
EXEC ERP9AddLanguage @ModuleID, 'A00.ASOFTCI', @FormID, @ControlName, @Language;

SET @ControlName = N'課';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemCI_List_DepartmentCategory', @FormID, @ControlName, @Language;

SET @ControlName = N'チーム';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemCI_List_TeamCategory', @FormID, @ControlName, @Language;

SET @ControlName = N'役職';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemCI_List_DutyCategory', @FormID, @ControlName, @Language;

SET @ControlName = N'暫定なメール';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemCI_List_TemplateCategory', @FormID, @ControlName, @Language;

SET @ControlName = N'サーバーメール設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.ConfigMailServer', @FormID, @ControlName, @Language;

SET @ControlName = N'支店';
EXEC ERP9AddLanguage @ModuleID, 'A00.ItemCI_List_AnaID', @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- OO
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Approve time setting';
EXEC ERP9AddLanguage @ModuleID, 'A00.OOF0010', @FormID, @ControlName, @Language;

SET @ControlName = N'Overtime setting';
EXEC ERP9AddLanguage @ModuleID, 'A00.OOF0020', @FormID, @ControlName, @Language;

SET @ControlName = N'Thiết lập hệ thống quản lý phép';
EXEC ERP9AddLanguage @ModuleID, 'A00.HF0390', @FormID, @ControlName, @Language;

--------------15/09/2021 - Hoài Bảo: Mail không có chủ đề--------------
SET @ControlName = N'(Không có chủ đề)';
EXEC ERP9AddLanguage @ModuleID, 'A00.DefaultSubjectEmail' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- GRIDVIEW
------------------------------------------------------------------------------------------------------

SET @ControlName = N'結果・ページ';
EXEC ERP9AddLanguage @ModuleID, 'A00.RecordPerPage' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- ACTION
------------------------------------------------------------------------------------------------------

SET @ControlName = N'活動';
EXEC ERP9AddLanguage @ModuleID, 'A00.Action' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Combox A00
------------------------------------------------------------------------------------------------------
SET @ControlName = N'分析のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1011_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'分析の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1011_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'社員のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1103_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'社員の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1103_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1004_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1004_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'単位のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1101_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'単位の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1101_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'支払い方法のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1205_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'支払いの名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1205_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'Member ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0011_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Member Name';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0011_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'タイプのコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1007_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'タイプの名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1007_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'商品のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1302_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'商品の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1302_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'内容のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRV0099_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'内容';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRV0099_Name' , @FormID, @ControlName, @Language; 

SET @ControlName = N'言語のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.A00000_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'言語の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.A00000_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'暫定なコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT0129_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'暫定な名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT0129_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'分類コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ContractGroupID' , @FormID, @ControlName, @Language;

SET @ControlName = N'分類の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ContractGroupName' , @FormID, @ControlName, @Language;

SET @ControlName = N'活動のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST0099_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'活動の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST0099_Description' , @FormID, @ControlName, @Language;

SET @ControlName = N'業務のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST0007_TableID' , @FormID, @ControlName, @Language;

SET @ControlName = N'業務の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST0007_TableName' , @FormID, @ControlName, @Language;

--------------17/02/2022 - Hoài Bảo: Bổ sung ngôn ngữ combobox mã phân tích WM--------------
SET @ControlName = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'A00.ComboBoxWM_AnaID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'A00.ComboBoxWM_AnaName' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Combox POS
------------------------------------------------------------------------------------------------------
SET @ControlName = N'店のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1015_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'店の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1015_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'対象のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1202_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'対象の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1202_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Payment ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.PaymentID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Payment Name 1';
EXEC ERP9AddLanguage @ModuleID, 'A00.PaymentName01' , @FormID, @ControlName, @Language;

SET @ControlName = N'Payment Name 2';
EXEC ERP9AddLanguage @ModuleID, 'A00.PaymentName02' , @FormID, @ControlName, @Language;

SET @ControlName = N'割引のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1328_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'割引のプログラム';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1328_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'底のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1303_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'底の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1303_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1005_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1005_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0031_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Division Name';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0031_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0032_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Table Name';
EXEC ERP9AddLanguage @ModuleID, 'A00.POST0032_Name' , @FormID, @ControlName, @Language;
------------------------------------------------------------------------------------------------------
-- Not found
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Page not found';
EXEC ERP9AddLanguage @ModuleID, 'A00.PageNotFoundTitle' , @FormID, @ControlName, @Language;

SET @ControlName = N'Error 404 - Page not found';
EXEC ERP9AddLanguage @ModuleID, 'A00.PageNotFound' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Access Denied
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Access Denied';
EXEC ERP9AddLanguage @ModuleID, 'A00.PageAccessDeniedTitle' , @FormID, @ControlName, @Language;

SET @ControlName = N'アクセルエラー';
EXEC ERP9AddLanguage @ModuleID, 'A00.ErrorDenied' , @FormID, @ControlName, @Language;

SET @ControlName = N'User Denied';
EXEC ERP9AddLanguage @ModuleID, 'A00.UserDenied' , @FormID, @ControlName, @Language;

SET @ControlName = N'サーポットのため管理者へご連絡ください';
EXEC ERP9AddLanguage @ModuleID, 'A00.ContactAdmin' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- Config
------------------------------------------------------------------------------------------------------
SET @ControlName = N'会社情報設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyInfo' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Aの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0060' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Bの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0070' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Cの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0080' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Dの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0090' , @FormID, @ControlName, @Language;

SET @ControlName = N'利益の指標設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0100' , @FormID, @ControlName, @Language;

SET @ControlName = N'グループの報酬の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0110' , @FormID, @ControlName, @Language;

SET @ControlName = N'割り当ての割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0120' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Eの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0160' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Fの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0170' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客Gの回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0180' , @FormID, @ControlName, @Language;

SET @ControlName = N'機能での権限';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0130' , @FormID, @ControlName, @Language;

SET @ControlName = N'新報酬割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0220' , @FormID, @ControlName, @Language;

SET @ControlName = N'Funtion権限';
EXEC ERP9AddLanguage @ModuleID, 'A00.FunctionPermission' , @FormID, @ControlName, @Language;

SET @ControlName = N'最低レベルと比べ回収費の割合設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0200' , @FormID, @ControlName, @Language;

SET @ControlName = N'Chốt số liệu chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRF0210' , @FormID, @ControlName, @Language;

SET @ControlName = N'分析コードの定義';
EXEC ERP9AddLanguage @ModuleID, 'A00.ConfigAnaID' , @FormID, @ControlName, @Language;

------------------------------------------------------------------------------------------------------
-- ComboBox
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Team ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.TeamID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Team Name';
EXEC ERP9AddLanguage @ModuleID, 'A00.TeamName' , @FormID, @ControlName, @Language;

SET @ControlName = N'支店のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.BranchID' , @FormID, @ControlName, @Language;

SET @ControlName = N'支店の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.BranchName' , @FormID, @ControlName, @Language;

SET @ControlName = N'役職コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.DutyID' , @FormID, @ControlName, @Language;

SET @ControlName = N'役職の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.DutyName' , @FormID, @ControlName, @Language;

SET @ControlName = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeID' , @FormID, @ControlName, @Language;

SET @ControlName = N'社員の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeName' , @FormID, @ControlName, @Language;

SET @ControlName = N'部コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeGroupID' , @FormID, @ControlName, @Language;

SET @ControlName = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeGroupName' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.CustomerID' , @FormID, @ControlName, @Language;

SET @ControlName = N'顧客の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.CustomerName' , @FormID, @ControlName, @Language;

SET @ControlName = N'活動のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionID' , @FormID, @ControlName, @Language;

SET @ControlName = N'活動の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionName' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã ĐT tiếp xúc';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionObjectID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên ĐT tiếp xúc';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionObjectName' , @FormID, @ControlName, @Language;

SET @ControlName = N'接続先コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionPlaceID' , @FormID, @ControlName, @Language;

SET @ControlName = N'接続先の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionPlaceName' , @FormID, @ControlName, @Language;

SET @ControlName = N'結果のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ResultID' , @FormID, @ControlName, @Language;

SET @ControlName = N'結果の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ResultName' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã ĐT tác động';
EXEC ERP9AddLanguage @ModuleID, 'A00.AssetStatusID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên ĐT tác động';
EXEC ERP9AddLanguage @ModuleID, 'A00.AssetStatusName' , @FormID, @ControlName, @Language;

SET @ControlName = N'アドレスのコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionAddressID' , @FormID, @ControlName, @Language;

SET @ControlName = N'アドレス';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionAddressName' , @FormID, @ControlName, @Language;

SET @ControlName = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionAddressNote' , @FormID, @ControlName, @Language;

SET @ControlName = N'処理者のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionEmployeeID' , @FormID, @ControlName, @Language;

SET @ControlName = N'処理者の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ActionEmployeeName' , @FormID, @ControlName, @Language;

SET @ControlName = N'理由のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReasonID' , @FormID, @ControlName, @Language;

SET @ControlName = N'理由の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReasonName' , @FormID, @ControlName, @Language;

SET @ControlName = N'課のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1102_ID' , @FormID, @ControlName, @Language;
SET @ControlName = N'課の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1102_Name' , @FormID, @ControlName, @Language;
SET @ControlName = N'ユーザーのコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1405_ID' , @FormID, @ControlName, @Language;
SET @ControlName = N'ユーザー名';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1405_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1016_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1016_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1409_MODULEID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1409_DESCRIPTION' , @FormID, @ControlName, @Language;

SET @ControlName = N'データーのコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1408_ID' , @FormID, @ControlName, @Language;
SET @ControlName = N'データーの名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1408_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'暫定なコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.A00065_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'暫定な名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.A00065_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'Moduleコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.Module_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module名';
EXEC ERP9AddLanguage @ModuleID, 'A00.Module_Name' , @FormID, @ControlName, @Language;

SET @ControlName = N'単位のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1101_IDCombo' , @FormID, @ControlName, @Language;

SET @ControlName = N'単位の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1101_NameCombo' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1005_AccountID' , @FormID, @ControlName, @Language;

SET @ControlName = N'口座の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1005_AccountName' , @FormID, @ControlName, @Language;

SET @ControlName = N'グループのコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.ComboBoxGroupID' , @FormID, @ControlName, @Language;

SET @ControlName = N'グループの名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.ComboBoxGroupName' , @FormID, @ControlName, @Language;

SET @ControlName = N'県・市のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1002_CityID' , @FormID, @ControlName, @Language;

SET @ControlName = N'県・市の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1002_CityName' , @FormID, @ControlName, @Language;

SET @ControlName = N'区コード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1013_DistrictID' , @FormID, @ControlName, @Language;

SET @ControlName = N'区名';
EXEC ERP9AddLanguage @ModuleID, 'A00.AT1013_DistrictName' , @FormID, @ControlName, @Language;

SET @ControlName = N'書簡の種類のコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRT0099_ID' , @FormID, @ControlName, @Language;

SET @ControlName = N'書簡の種類の名前';
EXEC ERP9AddLanguage @ModuleID, 'A00.DRT0099_Description' , @FormID, @ControlName, @Language;

SET @ControlName = N'No data';
EXEC ERP9AddLanguage @ModuleID, 'A00.NoData' , @FormID, @ControlName, @Language;

SET @ControlName = N'~日から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterFromDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'～日まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterToDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'Voucher Type';
EXEC ERP9AddLanguage @ModuleID, 'A00.VoucherTypeID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Voucher Type Name';
EXEC ERP9AddLanguage @ModuleID, 'A00.VoucherTypeName' , @FormID, @ControlName, @Language;

SET @ControlName = N'レベル';
EXEC ERP9AddLanguage @ModuleID, 'A00.Level' , @FormID, @ControlName, @Language;

SET @ControlName = N'シフトコード';
EXEC ERP9AddLanguage @ModuleID, 'A00.AbsentTypeID' , @FormID, @ControlName, @Language;

SET @ControlName = N'シフト名';
EXEC ERP9AddLanguage @ModuleID, 'A00.AbsentName' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã PP tính lương';
EXEC ERP9AddLanguage @ModuleID, 'A00.HT5000_PayrollMethodID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên PP tính lương';
EXEC ERP9AddLanguage @ModuleID, 'A00.HT5000_PayrollMethodName' , @FormID, @ControlName, @Language;

SET @ControlName = N'Mã loại công nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'A00.HT5002_GenaralAbsentID' , @FormID, @ControlName, @Language;

SET @ControlName = N'Tên loại công nghỉ phép';
EXEC ERP9AddLanguage @ModuleID, 'A00.HT5002_GenaralAbsentName' , @FormID, @ControlName, @Language;

SET @ControlName = N'指定方法';
EXEC ERP9AddLanguage @ModuleID, 'A00.OOProductAbsentMethodRow1' , @FormID, @ControlName, @Language;

SET @ControlName = N'配分方法';
EXEC ERP9AddLanguage @ModuleID, 'A00.OOProductAbsentMethodRow2' , @FormID, @ControlName, @Language;

---- ngôn ngữ theo framework động
SET @ControlName = N'報告書ID';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReportID' , @FormID, @ControlName, @Language;

SET @ControlName = N'報告書名';
EXEC ERP9AddLanguage @ModuleID, 'A00.ReportName' , @FormID, @ControlName, @Language;

SET @ControlName = N'説明';
EXEC ERP9AddLanguage @ModuleID, 'A00.Description' , @FormID, @ControlName, @Language;

--Dùng cho partail View
SET @LanguageValue = N'顧客';
 EXEC ERP9AddLanguage @ModuleID, 'A00.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'A00.ContactName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tuyến giao hàng';
 EXEC ERP9AddLanguage @ModuleID, 'A00.RouteName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'A00.VATAccountID' , @FormID, @LanguageValue, @Language;

 -- @LanguageValue = N'Mã liên hệ';
 --EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeID' , @FormID, @LanguageValue, @Language;

 --SET @LanguageValue = N'Mã liên hệ';
 --EXEC ERP9AddLanguage @ModuleID, 'A00.SalesManID' , @FormID, @LanguageValue, @Language;
 --Dùng cho partail View

 -- Dùng cho parse động
 SET @LanguageValue = N'~日から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'～日まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請日 から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterFromCreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterToCreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外出日';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterGoFromDateTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外出日 から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterGoFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterGoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残業日 から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterWorkFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterWorkToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'打刻データー訂正日';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterBSQTFromDateTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'から';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterBSQTFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterBSQTToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期間別';
EXEC ERP9AddLanguage @ModuleID, 'A00.rdoFilterPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'システム';
EXEC ERP9AddLanguage @ModuleID, 'GR.HeThong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'システム設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.CRMF0000' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'プリント & インプット';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrintNew' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'システム設定';
EXEC ERP9AddLanguage @ModuleID, 'A00.SOF0000' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'プリント & 閉める';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnPrintClose' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'A00.StationOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'A00.StationID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'A00.StationName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'A00.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường';
EXEC ERP9AddLanguage @ModuleID, 'A00.Street' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'A00.Ward' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'区名';
EXEC ERP9AddLanguage @ModuleID, 'A00.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注釈';
EXEC ERP9AddLanguage @ModuleID, 'A00.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.FromAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.ToAccountID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'期間から';
EXEC ERP9AddLanguage @ModuleID, 'A00.FromPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期間まで';
EXEC ERP9AddLanguage @ModuleID, 'A00.ToPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.FromInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.ToInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'A00.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'A00.EmployeeID_BI' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyNameTitle' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyAddressTitle' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyTelTitle' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyFaxTitle' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'A00.CompanyEmailTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật bất thường thực tế hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'A00.btnChangeUnusualType' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Change Password';
EXEC ERP9AddLanguage @ModuleID, 'A00.ChangePass' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'All of ASM';
EXEC ERP9AddLanguage @ModuleID, 'A00.IsAll_BI' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @ControlName = N'Trở về trước';
EXEC ERP9AddLanguage @ModuleID, 'A00.Before' , @FormID, @ControlName, @Language;

SET @ControlName = N'Trở về sau';
EXEC ERP9AddLanguage @ModuleID, 'A00.After' , @FormID, @ControlName, @Language;

------Thiết lập BEM ------------

SET @ControlName = N'Proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2000' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail proposal voucher';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2001' , @FormID, @ControlName, @Language;

SET @ControlName = N'Business trip proposal';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2010' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail business trip proposal';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2011' , @FormID, @ControlName, @Language;

SET @ControlName = N'Travel voucher payment';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2020' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail Travel voucher payment';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2021' , @FormID, @ControlName, @Language;

SET @ControlName = N'Working time';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2030' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail working time';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2031' , @FormID, @ControlName, @Language;

SET @ControlName = N'Trip reports';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2040' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail trip reports';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2041' , @FormID, @ControlName, @Language;

SET @ControlName = N'Translate documents';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2050' , @FormID, @ControlName, @Language;

SET @ControlName = N'Detail translate documents';
EXEC ERP9AddLanguage @ModuleID, 'A00.BEMT2051' , @FormID, @ControlName, @Language;

SET @ControlName = N'Module BEM';
EXEC ERP9AddLanguage @ModuleID, 'A00.ModuleBEM' , @FormID, @ControlName, @Language;

SET @ControlName = N'Pipeline';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST2010' , @FormID, @ControlName, @Language;

SET @ControlName = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'A00.ST2011' , @FormID, @ControlName, @Language;

SET @ControlName = N'{0:00}次承認者';
EXEC ERP9AddLanguage @ModuleID, 'A00.ApprovePerson' , @FormID, @ControlName, @Language;

SET @ControlName = N'{0:00}次承認者の備考';
EXEC ERP9AddLanguage @ModuleID, 'A00.ApproveNote' , @FormID, @ControlName, @Language;

SET @ControlName = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'A00.ApproveStatus' , @FormID, @ControlName, @Language;

SET @ControlName = N'{0:00}次承認日';
EXEC ERP9AddLanguage @ModuleID, 'A00.ApproveDate' , @FormID, @ControlName, @Language;

SET @ControlName = N'Low';
EXEC ERP9AddLanguage @ModuleID, 'A00.PRIORITY_LEVEL_1' , @FormID, @ControlName, @Language;

SET @ControlName = N'Normal';
EXEC ERP9AddLanguage @ModuleID, 'A00.PRIORITY_LEVEL_2' , @FormID, @ControlName, @Language;

SET @ControlName = N'High';
EXEC ERP9AddLanguage @ModuleID, 'A00.PRIORITY_LEVEL_3' , @FormID, @ControlName, @Language;

SET @ControlName = N'Very high';
EXEC ERP9AddLanguage @ModuleID, 'A00.PRIORITY_LEVEL_4' , @FormID, @ControlName, @Language;

SET @ControlName = N'Emergency';
EXEC ERP9AddLanguage @ModuleID, 'A00.PRIORITY_LEVEL_5' , @FormID, @ControlName, @Language;

SET @ControlName = N'検索';
EXEC ERP9AddLanguage @ModuleID, 'A00.SearchMode_1' , @FormID, @ControlName, @Language;

SET @ControlName = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'A00.SearchMode_2' , @FormID, @ControlName, @Language;

-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;

