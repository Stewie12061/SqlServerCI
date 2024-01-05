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
SET @Language = 'vi-VN'
SET @ModuleID = 'M'


SET @MessageValue=N'Tổng thời gian {0} sử dụng trong ngày quá 24 giờ. Máy đã được sử dụng ở các phiếu khác: {1} {2}'
EXEC ERP9AddMessage @ModuleID,'MFML0000001', @MessageValue, @Language;

SET @MessageValue=N'Tổng thời gian {0} sử dụng trong ngày lớn hơn thời gian định mức'
EXEC ERP9AddMessage @ModuleID,'MFML0000002', @MessageValue, @Language;

SET @MessageValue=N'Tổng thời gian các máy sử dụng trong ngày lớn hơn thời gian định mức. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'MFML0000003', @MessageValue, @Language;

SET @MessageValue=N'{0} vượt năng lực sản xuất chuẩn'
EXEC ERP9AddMessage @ModuleID,'MFML0000004', @MessageValue, @Language;

SET @MessageValue=N'Các máy sản xuất vượt năng lực sản xuất chuẩn. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'MFML0000005', @MessageValue, @Language;

SET @MessageValue=N'Phiếu thông tin sản xuất ''{0}'': Thời gian giao hàng đang nhỏ hơn thời gian hoàn thành sản xuất'
EXEC ERP9AddMessage @ModuleID,'MFML0000006', @MessageValue, @Language;

SET @MessageValue=N'Công đoạn {0} của {1}: Tổng số lượng vượt quá số lượng sản xuất ({2} sản phẩm)'
EXEC ERP9AddMessage @ModuleID,'MFML0000007', @MessageValue, @Language;

SET @MessageValue=N'Vui lòng chọn các phiếu cùng đối tượng'
EXEC ERP9AddMessage @ModuleID,'MFML0000008', @MessageValue, @Language;

SET @MessageValue=N'Nhân viên sản xuất vượt quá! Tổng số lao động tối đa: {0} người.'
EXEC ERP9AddMessage @ModuleID,'MFML0000009', @MessageValue, @Language;

SET @MessageValue=N'Máy đã vượt quá năng lực sản xuất trong ngày, số lượng máy đang sản xuất trong ngày là {0} sản phẩm, năng lực máy là {1} sản phẩm. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'MFML0000010', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải nhập thông tin tính dự trù!'
EXEC ERP9AddMessage @ModuleID,'MFML000341', @MessageValue, @Language;

SET @MessageValue=N'Vui lòng chọn các phiếu cùng công đoạn'
EXEC ERP9AddMessage @ModuleID,'MFML0000011', @MessageValue, @Language;

SET @MessageValue = N'{0} này đã được sử dụng. Bạn không thể Xóa';
EXEC ERP9AddMessage @ModuleID,'MFML0000012', @MessageValue, @Language;

SET @MessageValue=N'BOM {0} đã được sử dụng, không thể xóa.'
EXEC ERP9AddMessage @ModuleID,'MFML000343', @MessageValue, @Language;

SET @MessageValue=N'Sản phẩm đã tồn tại Định mức.'
EXEC ERP9AddMessage @ModuleID,'MFML000344', @MessageValue, @Language;

SET @MessageValue=N'Sản phẩm chưa có bộ định mức , vui lòng tạo bộ định mức cho sản phẩm!'
EXEC ERP9AddMessage @ModuleID,'MFML000345', @MessageValue, @Language;

SET @MessageValue=N'Nguồn lực đã được tạo trong ngày!'
EXEC ERP9AddMessage @ModuleID,'MFML000346', @MessageValue, @Language;

SET @MessageValue=N'Vui lòng chọn chuyền sản xuất!'
EXEC ERP9AddMessage @ModuleID,'MFML000347', @MessageValue, @Language;

SET @MessageValue=N'Nếu bạn thay đổi dự trù này, có thể ảnh hưởng nghiêm trọng tới giữ chổ nguyên vật liệu/máy móc/nhân công ở các dự trù khác có tham chiếu. Bạn có chắc là muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'MFML000348', @MessageValue, @Language;

SET @MessageValue=N'Sản phẩm: {0} chưa khai báo định mức!'
EXEC ERP9AddMessage @ModuleID,'MFML000349', @MessageValue, @Language;

SET @MessageValue=N'{0} này đã được sử dụng. Bạn chỉ được chỉnh sửa một số thông tin (Diễn giải, Tình trạng).'
EXEC ERP9AddMessage @ModuleID,'MFML000350', @MessageValue, @Language;

SET @MessageValue=N'Máy {0} - Ngày {1} - Số lượng vượt quá {2} so với công suất máy là {3} sản phẩm.';
EXEC ERP9AddMessage @ModuleID,'MFML000351', @MessageValue, @Language;

SET @MessageValue=N'Bạn có muốn tiếp tục không?';
EXEC ERP9AddMessage @ModuleID,'MFML000352', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn đơn vị'
EXEC ERP9AddMessage @ModuleID,'MFML000353', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn năm'
EXEC ERP9AddMessage @ModuleID,'MFML000354', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn tháng'
EXEC ERP9AddMessage @ModuleID,'MFML000355', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn quý'
EXEC ERP9AddMessage @ModuleID,'MFML000356', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn loại sản phẩm'
EXEC ERP9AddMessage @ModuleID,'MFML000357', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chọn sản phẩm'
EXEC ERP9AddMessage @ModuleID,'MFML000358', @MessageValue, @Language;
