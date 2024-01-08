IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV9991]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV9991]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- View chết thể hiện mã màn hình và bảng nghiệp vụ tương ứng cần tách
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Trương Ngọc Phương Thảo on 09/08/2016:
---- Modified: Huỳnh Thừ on 18/08/2020: Merge Code: MEKIO và MTE
-- <Example>
---- 


  
CREATE VIEW [dbo].[AV9991] AS   
  
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2406' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2407' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2408' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, '' AS FormID, N'' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0373' AS FormID, N'Báo cáo quét dữ liệu chấm công' AS FormName, 'HT2408' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0084' AS FormID, N'Báo cáo chấm công ngày' AS FormName, 'HT2401' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0384' AS FormID, N'Báo cáo tổng hợp công' AS FormName, 'HT2401' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'AF0262' AS FormID, N'Kết chuyển bút toán lương tự động' AS FormName, 'HT2400' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0034' AS FormID, N'Bảng phân ca' AS FormName, 'HT2401' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0034' AS FormID, N'Bảng phân ca' AS FormName, 'HT2402' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0282' AS FormID, N'Chấm công nhân viên (theo ca)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0137' AS FormID, N'Hồ sơ lương nhân viên' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0137' AS FormID, N'Hồ sơ lương nhân viên' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0137' AS FormID, N'Hồ sơ lương nhân viên' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0376' AS FormID, N'Báo cáo số giờ làm thêm theo ca' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0380' AS FormID, N'Báo cáo theo dõi chế độ con nhỏ' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0385' AS FormID, N'Danh sách nhân viên hưởng chế độ con nhỏ bị âm ngày phép' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0381' AS FormID, N'Báo cáo thống kê số giờ nghỉ bù' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0226' AS FormID, N'Phát sinh chấm công ngày' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0166' AS FormID, N'Quản lý điều động công tác' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0196' AS FormID, N'Kết chuyển chấm công thẻ' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0196' AS FormID, N'Kết chuyển chấm công thẻ' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0154' AS FormID, N'Đăng ký BHXH' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0154' AS FormID, N'Đăng ký BHXH' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0154' AS FormID, N'Đăng ký BHXH' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0145' AS FormID, N'Cập nhật hồ sơ lương - điều  chuyển tạm thời' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0145' AS FormID, N'Cập nhật hồ sơ lương - điều  chuyển tạm thời' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0145' AS FormID, N'Cập nhật hồ sơ lương - điều  chuyển tạm thời' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0236' AS FormID, N'Báo cáo chấm công tháng nhân viên' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0236' AS FormID, N'Báo cáo chấm công tháng nhân viên' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0236' AS FormID, N'Báo cáo chấm công tháng nhân viên' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF00192' AS FormID, N'Tính phép' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF00192' AS FormID, N'Tính phép' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF00192' AS FormID, N'Tính phép' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF00190' AS FormID, N'Hủy bỏ tính phép' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF00190' AS FormID, N'Hủy bỏ tính phép' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0117' AS FormID, N'Hồ sơ phép' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0117' AS FormID, N'Hồ sơ phép' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2001' AS FormID, N'Cập nhật bảng phân ca (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2011' AS FormID, N'Cập nhật đơn xin phép (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2021' AS FormID, N'Cập nhật đơn xin ra ngoài (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2031' AS FormID, N'Cập nhật đơn xin làm thêm giờ (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2041' AS FormID, N'Cập nhật đơn xin hủy/quẹt thẻ (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2071' AS FormID, N'Cập nhật đơn xin đổi ca (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2012' AS FormID, N'Cập nhật đơn xin phé (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2032' AS FormID, N'Xem thông tin đơn làm thêm giờ (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2051' AS FormID, N'Duyệt bảng phân ca' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2052' AS FormID, N'Duyệt đơn xin phép' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2053' AS FormID, N'Duyệt đơn xin ra ngoài' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2054' AS FormID, N'Duyệt đơn xin làm thêm giờ' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2054' AS FormID, N'Duyệt đơn xin hủy/quẹt thẻ (Approve)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2057' AS FormID, N'Duyệt đơn xin đổi ca' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'OOF2056' AS FormID, N'Duyệt đơn hàng loạt' AS FormName, 'HT2401' AS TableName, 0 AS Disable
------------------------
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0141' AS FormID, N'Cập nhật hồ sơ lương' AS FormName, 'HT2400' AS TableName, 0 AS Disable  
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0142' AS FormID, N'Kế thừa hồ sơ lương' AS FormName, 'HT2400' AS TableName, 0 AS Disable 
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0218' AS FormID, N'Chấm công (theo ngày)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0234' AS FormID, N'Chấm công (theo tháng)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0275' AS FormID, N'Cập nhật bảng phân ca' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0282' AS FormID, N'Chấm công nhân viên (theo ca)' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0282' AS FormID, N'Chấm công nhân viên (theo ca)' AS FormName, 'HT2401' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0319' AS FormID, N'Hiệu chỉnh chấm công ca' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0283' AS FormID, N'Phát sinh chấm công ca' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0288' AS FormID, N'Cập Nhật chấm công sản phẩm phương pháp chỉ định' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0355' AS FormID, N'Kế thừa từ kết quả sản xuất (Customize secoin)' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0289' AS FormID, N'Chấm công sản phẩm phương pháp phân bổ' AS FormName, 'HT2400' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0289' AS FormID, N'Chấm công sản phẩm phương pháp phân bổ' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0299' AS FormID, N'Báo cáo theo dõi thi đua' AS FormName, 'HT2402' AS TableName, 0 AS Disable
UNION ALL
SELECT 'HRM' AS ModuleID, 'HF0408' AS FormID, N'Báo cáo lương' AS FormName, 'HT2402' AS TableName, 0 AS Disable




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

