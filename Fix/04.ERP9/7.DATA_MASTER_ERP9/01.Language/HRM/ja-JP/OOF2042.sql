------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2042 - OO 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'ja-JP';
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2042';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'休暇申請届けコード';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釈';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.StatusName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'申請者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.CreateUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'１次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'一次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson01Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'２次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'二次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson02Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'３次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'三次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson03Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'４次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'四次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson04Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'５次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'五次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson05Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'６次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson06Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'六次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson06Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'７次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson07Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'七次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson07Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'８次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson08Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'八次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson08Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'９次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson09Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'九次承認者からの備考';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson09Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'１０次承認者';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.ApprovePerson10Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EditTypeName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'打刻データ訂正時間の情報を表示する';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'打刻データ届けの情報';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2042.SubTitle1' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'打刻データ訂正時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Date' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'入/ 出tコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.InOutID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'入/ 出';
EXEC ERP9AddLanguage @ModuleID, 'OOF2042.InOutName' , @FormID, @LanguageValue, @Language;


