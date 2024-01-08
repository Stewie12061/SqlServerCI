-- <Summary>
---- Insert dữ liệu ngầm vào bảng CRMT0099
-- <History>
---- Create on 13/02/2017 by Thị Phượng: Tạo dữ liệu ngầm cho bảng CRMT0099
---- Create on 13/02/2017 by Hoàng Vũ: Tạo dữ liệu ngầm cho bảng CRMT0099 (Loại giai đoạn bán hàng [CRM])
---- Modified on 26/06/2017 by Thị Phượng: Bổ sung ID cho danh mục lĩnh vực kinh doanh vào mục Loại đối tượng (CRM)
---- Modified on 10/08/2017 by Hoàng Vũ: Bổ sung Classification danh mục xếp loại
---- Modified on 11/08/2017 by Hoàng Vũ: Bổ sung TargetsGroupID danh mục nhóm chỉ tiêu KPI/DGNL
---- Modified on 17/08/2017 by Thị Phượng: Bổ sung CommissionRate (customize Kim Yến) danh mục mức huê hồng theo doanh thu tích lũy
---- Modified on 12/09/2017 by Hoàng Vũ: Bổ sung AssessmentSelfID, BonusFeatureID, AppraisalSelfID phân quyền xem dữ liệu/vai trò KPI/DGNL
---- Modify by: Thị Phượng, Date :26/09/2017: Bổ sung thêm phân quyền đơn hàng bán dưới APP APPSaleOrderID
---- Modify by: Thị Phượng, Date :29/09/2017: Bổ sung thêm ghi nhận lịch sử phân hệ TM (QLCV)
---- Modify by: Hoàng Vũ, Date :18/09/2018: Bổ sung thêm Phân quyền xem dữ liệu Phiếu bảo hành [khách hàng OKIA]
---- Modify by: Đình Hòa, Date : 12/11/2020: Delete các ID của Kỳ vọng của chiến dịch để update lại kết hợp vào Tình trạng chiến dịch
---- Modify by: Trọng Kiên, Date: 21/12/2020: Bổ sung List phiếu in Thông tin sản xuất
---- Modify by: Hoài Phong, Date: 03/03/20212: Bổ sung các gói hợp đồng
---- Modify by: Tấn Thành, Date: 16/03/2021: Bổ sung dữ liệu ngầm Lịch sử cuộc gọi (Chuyển từ OO).
---- Modify by: Tấn Thành, Date: 17/03/2021: Bổ sung dữ liệu ngầm Yêu cầu hỗ trợ (Chuyển từ OO).
---- Modify by: Tấn Lộc, Date: 23/07/2021: Tách dữ liệu Tình trạng chiến dịch và Đáp ứng mong đợi sang CodeMaster tướng ứng. Tình trạng chiến dịch = CRMT00000012, Đáp ứng mong đợi chiến dịch = CRMT00000013
---- Modify by: Hoài Bảo, Date: 28/07/2021: Bổ sung dữ liệu cột [CodeMasterName] 
---- Modify by: Thu Hào, Date: 06/10/2023:  Bổ sung dữ liệu ngầm lịch phỏng vấn cho CodeMaster 'CalendarBusiness' còn thiếu

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang CustomerIndex 
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DROP TABLE #CustomerName
DECLARE @CodeMaster VARCHAR(50), @OrderNo INT, @ID VARCHAR(50), @Description NVARCHAR(250), @DescriptionE NVARCHAR(250), @Disabled TINYINT, @LanguageID VARCHAR(50) = NULL, @CodeMasterName NVARCHAR(MAX) = NULL
----------Phân quyền_Permission
SET @CodeMaster = 'CRMT00000001' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Cá nhân' 
SET @DescriptionE = N'See Own Data' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nhóm người dùng'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Nhóm' 
SET @DescriptionE = N'See Own Group' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Quản lý' 
SET @DescriptionE = N'Manager' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tình trạng task thực hiện
SET @CodeMaster = 'CRMT00000003' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Chưa thực hiện' 
SET @DescriptionE = N'New' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái task thực hiện'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Đang thực hiện' 
SET @DescriptionE = N'In Progress' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Đã xong' 
SET @DescriptionE = N'Completed' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Tạm hoãn' 
SET @DescriptionE = N'Pending' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Hủy' 
SET @DescriptionE = N'Cancel' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tình trạng task thực hiện
----------Loại chuyển đổi
SET @CodeMaster = 'CRMT00000004' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Chuyển đổi từ liên hệ qua khách hàng' 
SET @DescriptionE = N'Converted from contact to customer' 
SET @Disabled = 0 
SET @CodeMasterName = N'Tình trạng task thực hiện - Loại chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Chuyển đổi từ cơ hội qua khách hàng' 
SET @DescriptionE = N'Converted from opportunity to customer' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Chuyển đổi từ đầu mối qua khách hàng' 
SET @DescriptionE = N'Converted from lead to customer' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Chuyển đổi từ cơ hội qua báo giá' 
SET @DescriptionE = N'Converted from opportunity to quotation' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Loại chuyển đổi
----------Loại hoạt động
SET @CodeMaster = 'CRMT00000005' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Gọi điện thoại' 
SET @DescriptionE = N'Call phone' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại hoạt động'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Gửi mail' 
SET @DescriptionE = N'Send Email' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Gặp trực tiếp' 
SET @DescriptionE = N'Meeting' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Sự kiện nhóm' 
SET @DescriptionE = N'Group Event' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Loại Hoạt động
----------Độ ưu tiên
SET @CodeMaster = 'CRMT00000006' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Thấp' 
SET @DescriptionE = N'Low' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại Hoạt động - Độ ưu tiên'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Bình thường' 
SET @DescriptionE = N'Normal' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Cao' 
SET @DescriptionE = N'High' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Rất cao' 
SET @DescriptionE = N'Highest' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = '5'
SET @Description = N'Khẩn cấp'
SET @DescriptionE = N'Urgency'
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Độ ưu tiên
----------Tình trạng đầu mối
SET @CodeMaster = 'CRMT00000007' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Mới tạo' 
SET @DescriptionE = N'New' 
SET @Disabled = 0 
SET @CodeMasterName = N'Tình trạng đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Đang thử liên hệ' 
SET @DescriptionE = N'Trying Contact' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Đã liên hệ' 
SET @DescriptionE = N'Contacted' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Không liên hệ được' 
SET @DescriptionE = N'Not Contacted' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = '5' 
SET @Description = N'Bị loại' 
SET @DescriptionE = N'Disqualified' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Tình trạng đầu mối
----------Nguồn đầu mối
SET @CodeMaster = 'CRMT00000008' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Gọi điện' 
SET @DescriptionE = N'Cold Call' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Website' 
SET @DescriptionE = N'Website' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Chiến dịch' 
SET @DescriptionE = N'Campaign' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Hội nghị' 
SET @DescriptionE = N'Conference' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = '5' 
SET @Description = N'Gửi mail trực tiếp' 
SET @DescriptionE = N'Direct mail' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Quan hệ cộng đồng' 
SET @DescriptionE = N'Public relations' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 7
SET @ID = '7' 
SET @Description = N'Đối tác' 
SET @DescriptionE = N'Partner' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 8
SET @ID = '8' 
SET @Description = N'Nhân viên' 
SET @DescriptionE = N'Employee' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 9
SET @ID = '9' 
SET @Description = N'Tự tạo ra' 
SET @DescriptionE = N'Self Generated' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 10
SET @ID = '10' 
SET @Description = N'Từ khách hàng cũ' 
SET @DescriptionE = N'Existing customer' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 11
SET @ID = '11' 
SET @Description = N'Mạng xã hội' 
SET @DescriptionE = N'Facebook' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 12
SET @ID = '12' 
SET @Description = N'Hội chợ thương mại' 
SET @DescriptionE = N'Trade show' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 13
SET @ID = '13' 
SET @Description = N'Truyền miệng' 
SET @DescriptionE = N'Word of mouth' 
SET @Disabled = 0 
SET @CodeMasterName = N'Nguồn đầu mối'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Nguồn đầu mối
----------Loại hình doanh nghiệp
SET @CodeMaster = 'CRMT00000009' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Ngân hàng' 
SET @DescriptionE = N'Banking' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại hình doanh nghiệp'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Nhà hàng' 
SET @DescriptionE = N'Restaurant' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Khách sạn' 
SET @DescriptionE = N'Hotel' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Hội nghị' 
SET @DescriptionE = N'Conference' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = '5' 
SET @Description = N'Công nghệ' 
SET @DescriptionE = N'Technology' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Truyền thông' 
SET @DescriptionE = N'Communication' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 7
SET @ID = '7' 
SET @Description = N'Tài chính' 
SET @DescriptionE = N'Finance' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 8
SET @ID = '8' 
SET @Description = N'Bảo hiểm' 
SET @DescriptionE = N'Insurance' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 9
SET @ID = '9' 
SET @Description = N'Giải trí' 
SET @DescriptionE = N'Entertainment' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 10
SET @ID = '10' 
SET @Description = N'Thời trang' 
SET @DescriptionE = N'Fashion' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 11
SET @ID = '11' 
SET @Description = N'Giáo dục' 
SET @DescriptionE = N'Education' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 12
SET @ID = '12' 
SET @Description = N'Bệnh viên' 
SET @DescriptionE = N'Hospitality' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 13
SET @ID = '13' 
SET @Description = N'Công ty phi lợi nhuận' 
SET @DescriptionE = N'Not for profit' 
SET @Disabled = 0 
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 14
SET @ID = '14' 
SET @Description = N'Sản xuất' 
SET @DescriptionE = N'Manufacturing' 
SET @Disabled = 0 
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 15
SET @ID = '15' 
SET @Description = N'Thực phẩm & nước giải khát' 
SET @DescriptionE = N'Food & Beverage' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 16
SET @ID = '16' 
SET @Description = N'Xây dựng' 
SET @DescriptionE = N'Contruction' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 17
SET @ID = '17' 
SET @Description = N'Chăm sóc sức khỏe'
SET @DescriptionE = N'Healthcare' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 18
SET @ID = '18' 
SET @Description = N'Cửa hàng bán lẻ' 
SET @DescriptionE = N'Retail' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 19
SET @ID = '19' 
SET @Description = N'Vận chuyển' 
SET @DescriptionE = N'Shipping' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
SET @OrderNo = 20
SET @ID = '20' 
SET @Description = N'Khác' 
SET @DescriptionE = N'Other' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Loại hình doanh nghiệp
----------Số lượng nhân viên
SET @CodeMaster = 'CRMT00000010' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Từ 1 đến 10 nhân viên' 
SET @DescriptionE = N'1 - 10 employee' 
SET @Disabled = 0
SET @CodeMasterName = N'Số lượng nhân viên (màn hình cập nhật Đầu mối - CRMF2031)' 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Từ 10 đến 30 nhân viên' 
SET @DescriptionE = N'10 - 30 employee' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Từ 30 đến 50 nhân viên' 
SET @DescriptionE = N'30 - 50 employee' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Từ 50 đến 100 nhân viên' 
SET @DescriptionE = N'50 - 100 employee' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Trên 100 nhân viên' 
SET @DescriptionE = N'> 100 employee' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------Số lượng nhân viên
----------Loại chiến dịch
SET @CodeMaster = 'CRMT00000011' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Hội nghị' 
SET @DescriptionE = N'Conference' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại chiến dịch'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Tiếp thị qua điện thoại' 
SET @DescriptionE = N'Telemarketing' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Gửi mail trực tiếp' 
SET @DescriptionE = N'Direct mail' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Khảo sát' 
SET @DescriptionE = N'Banner ads' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = '5' 
SET @Description = N'Quảng cáo' 
SET @DescriptionE = N'Advertisement' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Giới thiệu sản phẩm' 
SET @DescriptionE = N'Refferral product' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 7
SET @ID = '7' 
SET @Description = N'Quan hệ công chúng' 
SET @DescriptionE = N'Public relations' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 8
SET @ID = '8' 
SET @Description = N'Hội chợ thương mại' 
SET @DescriptionE = N'Trade show' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 9
SET @ID = '9' 
SET @Description = N'Hội thảo trực tuyến' 
IF ISNULL(@CustomerName,0) = 114 
	BEGIN
		SET @Description = N'Hội thảo trực tiếp' 
	END
SET @DescriptionE = N'Webiner' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 10
SET @ID = '10' 
SET @Description = N'Khác' 
SET @DescriptionE = N'Other' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
-----------------
IF ISNULL(@CustomerName,0) = 114 
BEGIN
	SET @OrderNo =11
	SET @ID = '11' 
	SET @Description = N'Liên hệ - gặp gỡ' 
	SET @DescriptionE = N'Contact - meet' 
	SET @Disabled = 0 
	IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
END
----------Loại chiến dịch
----------Tình trạng chiến dịch
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 1
SET @ID = '1' 
SET @Description = N'Nháp' 
SET @DescriptionE = N'Draft' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Đang lên kế hoạch' 
SET @DescriptionE = N'Planning' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 3
SET @ID = '3' 
SET @Description = N'Chờ duyệt' 
SET @DescriptionE = N'WaitApproval' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Đang hoạt động' 
SET @DescriptionE = N'Active' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Hoàn tất' 
SET @DescriptionE = N'Completed' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Hủy' 
SET @DescriptionE = N'Cancelled' 
SET @Disabled = 0
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @CodeMaster = 'CRMT00000012' 
SET @OrderNo = 7
SET @ID = '7' 
SET @Description = N'Tạm ngưng' 
SET @DescriptionE = N'Pending' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái - chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------Tình trạng chiến dịch
----------Kỳ vọng của chiến dịch
SET @CodeMaster = 'CRMT00000013' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Xuất sắc' 
SET @DescriptionE = N'Excellent' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái chiến dịch Marketing'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID  	
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Tốt' 
SET @DescriptionE = N'Good' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID  	
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Trung bình' 
SET @DescriptionE = N'Average' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID  	
----------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Thấp' 
SET @DescriptionE = N'Poor' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID  	
----------Kỳ vọng của chiến dịch

----------Loại lý do
SET @CodeMaster = 'CRMT00000014' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Thành công' 
SET @DescriptionE = N'Success' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại lý do'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Thất bại' 
SET @DescriptionE = N'Failed' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Lý do khác' 
SET @DescriptionE = N'Other' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Loại lý do

----------Tình trạng phiếu báo giá CRM
SET @CodeMaster = 'CRMT00000015' 
SET @OrderNo = 1  
SET @ID = '0' 
SET @Description = N'Tạo mới' 
SET @DescriptionE = N'New' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái báo giá'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '1' 
SET @Description = N'Đã gửi mail' 
SET @DescriptionE = N'Quotation Sent' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = '2' 
SET @Description = N'Đơn đặt hàng' 
SET @DescriptionE = N'Sales Order' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 4  
SET @ID = '3' 
SET @Description = N'Hoàn tất' 
SET @DescriptionE = N'Complete' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Tình trạng phiếu báo giá CRM 

----------Loại ghi nhận lịch sử
SET @CodeMaster = 'CRMT00000016' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Thêm' 
SET @DescriptionE = N'Created' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại ghi nhận lịch sử'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Chỉnh sửa' 
SET @DescriptionE = N'Edit' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Xóa' 
SET @DescriptionE = N'Delete' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------

----------Tình trạng sự kiện
SET @CodeMaster = 'CRMT00000017' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Đã lên kế hoạch' 
SET @DescriptionE = N'Planned' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái sự kiện'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Đã tổ chức' 
SET @DescriptionE = N'Held' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái sự kiện'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Không được tổ chức' 
SET @DescriptionE = N'Not held' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái sự kiện'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Hủy' 
SET @DescriptionE = N'Cancelled' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái sự kiện'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
----------Loại sự kiện 
SET @CodeMaster = 'CRMT00000018' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Sự kiện' 
SET @DescriptionE = N'Event' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại (màn hình cập nhật sự kiện)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Nhiệm vụ' 
SET @DescriptionE = N'Task' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------

----------Phân quyền Xem dữ liệu
SET @CodeMaster = 'CRMT00000019' 
SET @OrderNo = 1  
SET @ID = 'LeadID' 
SET @Description = N'Đầu mối' 
SET @DescriptionE = N'Lead' 
SET @Disabled = 0 
SET @LanguageID ='A00.Lead'
SET @CodeMasterName = N'Phân quyền Xem dữ liệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = 'ContactID' 
SET @Description = N'Liên hệ' 
SET @DescriptionE = N'Contact' 
SET @Disabled = 0 
SET @LanguageID ='A00.Contact'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = 'ObjectID' 
SET @Description = N'Đối tượng' 
SET @DescriptionE = N'Object' 
SET @Disabled = 0 
SET @LanguageID ='A00.Object'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 4  
SET @ID = 'CampainID' 
SET @Description = N'Chiến dịch' 
SET @DescriptionE = N'Campain' 
SET @Disabled = 0 
SET @LanguageID ='A00.Campain'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 5  
SET @ID = 'OpportunityID' 
SET @Description = N'Cơ hội' 
SET @DescriptionE = N'Opportunity' 
SET @Disabled = 0 
SET @LanguageID ='A00.Opportunity'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 6  
SET @ID = 'QuotationID' 
SET @Description = N'Báo giá' 
SET @DescriptionE = N'Quotation' 
SET @Disabled = 0 
SET @LanguageID ='A00.Quotation'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 7 
SET @ID = 'SOrderID' 
SET @Description = N'Đơn hàng bán' 
SET @DescriptionE = N'SOrder' 
SET @Disabled = 0 
SET @LanguageID ='A00.SOrder'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 8
SET @ID = 'GroupReceiverID' 
SET @Description = N'Nhóm người nhận' 
SET @DescriptionE = N'GroupReceiver' 
SET @Disabled = 0 
SET @LanguageID ='A00.GroupReceiver'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 9
SET @ID = 'RequestID' 
SET @Description = N'Yêu cầu' 
SET @DescriptionE = N'Request' 
SET @Disabled = 0 
SET @LanguageID ='A00.Request'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 10
SET @ID = 'EventID' 
SET @Description = N'Sự kiện' 
SET @DescriptionE = N'Event' 
SET @Disabled = 0 
SET @LanguageID ='A00.Event'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------Modify by Cao thị Phượng bổ sung phân quyền tệp đính kèm
SET @OrderNo = 11
SET @ID = 'AttachID' 
SET @Description = N'Đính kèm' 
SET @DescriptionE = N'Attach' 
SET @Disabled = 0 
SET @LanguageID ='A00.Attach'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------Modify by Hoàng vũ bổ sung phân quyền [Cá nhân tự đánh giá (KPI)]
SET @OrderNo = 12
SET @ID = 'AssessmentSelfID' 
SET @Description = N'Cá nhân tự đánh giá (KPI)' 
SET @DescriptionE = N'Self assessment' 
SET @Disabled = 0 
SET @LanguageID ='A00.AssessmentSelfID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------Modify by Hoàng vũ bổ sung phân quyền [Tính thưởng (KPI)]
SET @OrderNo = 13
SET @ID = 'BonusFeatureID' 
SET @Description = N'Tính thưởng (KPI)' 
SET @DescriptionE = N'Bonus Feature' 
SET @Disabled = 0 
SET @LanguageID ='A00.BonusFeatureID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------Modify by Hoàng vũ bổ sung phân quyền Đánh giá năng lực (PA)
SET @OrderNo = 14
SET @ID = 'AppraisalSelfID' 
SET @Description = N'Đánh giá năng lực' 
SET @DescriptionE = N'Self Appraisal' 
SET @Disabled = 0 
SET @LanguageID ='A00.AppraisalSelfID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------- Asoft-APP (Asoft best seller)
SET @OrderNo = 15
SET @ID = 'APPSaleOrderID' 
SET @Description = N'Đơn hàng bán dưới APP'  
SET @DescriptionE = N'App Sale Order'
SET @Disabled = 0 
SET @LanguageID ='A00.APPSaleOrderID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

-----------Modify by Hoàng vũ bổ sung phân quyền Phiếu bảo hành (OKIA)
IF @CustomerName = 87
BEGIN
	SET @OrderNo = 16
	SET @ID = 'ConditionWarrantyID' 
	SET @Description = N'Đơn hàng bán dưới APP'  
	SET @DescriptionE = N'Warranty Voucher'
	SET @Disabled = 0 
	SET @LanguageID ='A00.ConditionWarrantyID'
	IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
END

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Công việc
SET @OrderNo = 17
SET @ID = 'TaskID'
SET @Description = N'Công việc'
SET @DescriptionE = N'Task'
SET @Disabled = 0
SET @LanguageID ='A00.Task'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 18
SET @ID = 'ProjectID'
SET @Description = N'Dự án/nhóm công việc'
SET @DescriptionE = N'Project/Group task'
SET @Disabled = 0
SET @LanguageID ='A00.Project'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 19
SET @ID = 'AssessTask'
SET @Description = N'Đánh giá công việc'
SET @DescriptionE = N'Assess task'
SET @Disabled = 0
SET @LanguageID ='A00.AssessTask'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 20
SET @ID = 'ProjectQuota'
SET @Description = N'Định mức dự án'
SET @DescriptionE = N'Project quota'
SET @Disabled = 0
SET @LanguageID ='A00.ProjectQuota'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 21
SET @ID = 'Inform'
SET @Description = N'Thông báo'
SET @DescriptionE = N'Inform'
SET @Disabled = 0
SET @LanguageID ='A00.Inform'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 22
SET @ID = 'CalculateEffectiveSalary'
SET @Description = N'Tính lương mềm'
SET @DescriptionE = N'Calculate Effective salary'
SET @Disabled = 0
SET @LanguageID ='A00.CalculateEffectiveSalary'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền Yêu cầu mua hàng
SET @OrderNo = 23
SET @ID = 'PurchaseRequest'
SET @Description = N'Yêu cầu mua hàng'
SET @DescriptionE = N'Goods purchase request'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseRequest'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền Báo giá nhà cung cấp
SET @OrderNo = 23
SET @ID = 'SupplierQuote'
SET @Description = N'Báo giá nhà cung cấp'
SET @DescriptionE = N'Supplier quote'
SET @Disabled = 0
SET @LanguageID ='A00.SupplierQuote'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền ĐƠN HÀNG MUA
SET @OrderNo = 24
SET @ID = 'PurchaseOrders'
SET @Description = N'Đơn hàng mua'
SET @DescriptionE = N'Purchase orders'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseOrders'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền ĐƠN HÀNG MUA
SET @OrderNo = 24
SET @ID = 'PurchaseOrders'
SET @Description = N'Đơn hàng mua'
SET @DescriptionE = N'Purchase orders'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseOrders'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID
--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền HỢP ĐỒNG
SET @OrderNo = 26
SET @ID = 'Contract'
SET @Description = N'Hợp đồng'
SET @DescriptionE = N'Contract '
SET @Disabled = 0
SET @LanguageID ='A00.Contract '
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Bảo toàn on 03/10/2019: bổ sung phân quyền HỢP ĐỒNG
IF EXISTS(SELECT 1 FROM CustomerIndex WHERE CustomerName = '114')
BEGIN
	SET @OrderNo = 27
	SET @ID = 'QuotaID'
	SET @Description = N'Hạn mức Quota'
	SET @DescriptionE = N'Quota Sale '
	SET @Disabled = 0
	SET @LanguageID ='A00.QuotaID '
	IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
		INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
		VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
	ELSE
		UPDATE CRMT0099
		SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
		WHERE CodeMaster = @CodeMaster AND ID = @ID
END

-------- Modify by Bảo toàn on 04/10/2019: bổ sung phân quyền HỢP ĐỒNG
SET @OrderNo = 28
SET @ID = 'SabbaticalProfileID'
SET @Description = N'Danh mục hồ sơ phép'
SET @DescriptionE = N' '
SET @Disabled = 0
SET @LanguageID ='A00.SabbaticalProfileID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 29
SET @ID = 'RecruitPlanID'
SET @Description = N'Kế hoạch tuyển dụng'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecruitPlanID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 30
SET @ID = 'RecruitPeriodID'
SET @Description = N'Đợt phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecruitPeriodID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 31
SET @ID = 'InterviewScheduleID'
SET @Description = N'Lịch phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.InterviewScheduleID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 32
SET @ID = 'InterviewResultID'
SET @Description = N'Truy vấn kết quả phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.InterviewResultID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 33
SET @ID = 'RecDecisionNo'
SET @Description = N'Quyết định tuyển dụng'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecDecisionNo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 34
SET @ID = 'ComfirmationRecruitmentID'
SET @Description = N'Xác nhận tuyển dụng '
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ComfirmationRecruitmentID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 35
SET @ID = 'BudgetID'
SET @Description = N'Danh mục ngân sách đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.BudgetID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 36
SET @ID = 'TrainingPlanID'
SET @Description = N'Kế hoạch đào tạo định kỳ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingPlanID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 37
SET @ID = 'TrainingRequestID'
SET @Description = N'Danh mục yêu cầu đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingRequestID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 38
SET @ID = 'TrainingProposeID'
SET @Description = N'Danh mục đề xuất đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingProposeID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 39
SET @ID = 'TrainingScheduleID'
SET @Description = N'Danh mục lịch đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingScheduleID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 40
SET @ID = 'TrainingCostID'
SET @Description = N'Ghi nhận chi phí'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingCostID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 41
SET @ID = 'TrainingResultID'
SET @Description = N'Ghi nhận kết quả'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingResultID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 42
SET @ID = 'ShiftID'
SET @Description = N'Bảng phân ca'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ShiftID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 43
SET @ID = 'ShiftChangeID'
SET @Description = N'Đơn đổi ca'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ShiftChangeID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 44
SET @ID = 'TimekeepingID'
SET @Description = N'Đơn xin phép bổ sung/hủy quẹt thẻ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TimekeepingID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 45
SET @ID = 'PermissionFormID'
SET @Description = N'Đơn xin phép'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 46
SET @ID = 'PermissionOutFormID'
SET @Description = N'Đơn xin ra ngoài'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionOutFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 47
SET @ID = 'OTFormID'
SET @Description = N'Đơn xin phép làm thêm giờ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.OTFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 48
SET @ID = 'AbnormalID'
SET @Description = N'Xử lý bất thường'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.AbnormalID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 49
SET @ID = 'PermissionCatalogID'
SET @Description = N'Danh mục đơn xin phép'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionCatalogID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 49
SET @ID = 'DISCID'
SET @Description = N'Danh mục tính cách D.I.S.C'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.DISCID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 50
SET @ID = 'EvaluationKitID'
SET @Description = N'Danh mục đánh giá năng lực '
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.EvaluationKitID'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID
-------- [END] Modify by Bảo toàn on 04/10/2019

--------- Modify by Vĩnh Tâm on 29/10/2019: Bổ sung phân quyền Quản lý vấn đề
SET @OrderNo = 51
SET @ID = 'IssueManagement'
SET @Description = N'Quản lý vấn đề'
SET @DescriptionE = N'Issue management'
SET @Disabled = 0
SET @LanguageID ='A00.IssueManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 09/11/2019: Bổ sung phân quyền Yêu cầu hỗ trợ
SET @OrderNo = 52
SET @ID = 'HelpDesk'
SET @Description = N'Yêu cầu hỗ trợ'
SET @DescriptionE = N'Help Desk'
SET @Disabled = 0
SET @LanguageID ='A00.HelpDesk'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 09/11/2019: Bổ sung phân quyền Yêu cầu hỗ trợ
SET @OrderNo = 53
SET @ID = 'CallsHistory'
SET @Description = N'Lịch sử cuộc gọi'
SET @DescriptionE = N'Calls history'
SET @Disabled = 0
SET @LanguageID ='A00.CallsHistory'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 26/12/2019: Bổ sung phân quyền Quản lý milestone
SET @OrderNo = 54
SET @ID = 'MilestoneManagement'
SET @Description = N'Quản lý milestone'
SET @DescriptionE = N'Milestone management'
SET @Disabled = 0
SET @LanguageID ='A00.MilestoneManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Vĩnh Tâm on 02/01/2020: Bổ sung phân quyền Quản lý Release
SET @OrderNo = 55
SET @ID = 'ReleaseManagement'
SET @Description = N'Quản lý Release'
SET @DescriptionE = N'Release management'
SET @Disabled = 0
SET @LanguageID ='A00.ReleaseManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID
	
--------- Modify by Tấn Lộc on 23/07/2020: Bổ sung phân quyền Quản lý License
SET @OrderNo = 56
SET @ID = 'LicenseManagement'
SET @Description = N'Quản lý License'
SET @DescriptionE = N'License management'
SET @Disabled = 0
SET @LanguageID ='A00.LicenseManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Tấn Thành on 28/07/2020: Bổ sung phân quyền Phiếu DNTT/DNTTTU/DNTU 
SET @OrderNo = 57
SET @ID = 'BEMT2000'
SET @Description = N'Phiếu DNTT/DNTTTU/DNTU'
SET @DescriptionE = N'Proposal'
SET @Disabled = 0
SET @LanguageID ='A00.Proposal'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID

--------- Modify by Tấn Thành on 28/07/2020: Bổ sung phân quyền Đơn xin duyệt công tác nghỉ phép về nước
SET @OrderNo = 58
SET @ID = 'BEMT2010'
SET @Description = N'Đơn xin duyệt công tác nghỉ phép về nước'
SET @DescriptionE = N'Category work confirmation letter'
SET @Disabled = 0
SET @LanguageID ='A00.CategoryWorkConfirmationLetter'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID)
	INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName)
	VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName)
ELSE
	UPDATE CRMT0099
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, CodeMasterName = @CodeMasterName
	WHERE CodeMaster = @CodeMaster AND ID = @ID
	
----------Phân quyền Xem dữ liệu----------Phân quyền Xem dữ liệu



----------Load combo [Loại giai đoạn] trong giai đoạn bán hàng CRMF10401
DELETE FROM CRMT0099 WHERE CODEMASTER = 'CRMT00000020'
SET @CodeMaster = 'CRMT00000020' 
SET @OrderNo = 1  
SET @ID = '0' 
SET @Description = N'Đầu mối' 
SET @DescriptionE = N'Lead Type' 
SET @Disabled = 0 
SET @LanguageID ='A00.LeadType'
SET @CodeMasterName = N'Combo [Loại giai đoạn] trong giai đoạn bán hàng CRMF10401'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '1' 
SET @Description = N'Cơ hội' 
SET @DescriptionE = N'Opportunity type' 
SET @Disabled = 0 
SET @LanguageID ='A00.OpportunityType'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = '2' 
SET @Description = N'Chiến dịch Marketing' 
SET @DescriptionE = N'Campaign Marketing' 
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 4 
SET @ID = '3' 
SET @Description = N'Ao đầu mối' 
SET @DescriptionE = N'Ao đầu mối' 
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Load combo [Loại giai đoạn] trong giai đoạn bán hàng CRMF10401


----------Load ngôn ngữ định nghĩa trong Store (Ví dụ: báo cáo Phễu bán hàng theo công ty - CRMR30111)
SET @CodeMaster = 'CRMT00000021' 
SET @OrderNo = 1  
SET @ID = 'ALL' 
SET @Description = N'Công ty' 
SET @DescriptionE = N'Company Name' 
SET @Disabled = 0 
SET @LanguageID ='A00.CompanyName'
SET @CodeMasterName = N'Load ngôn ngữ định nghĩa trong Store (Ví dụ: báo cáo Phễu bán hàng theo công ty - CRMR30111)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
 
---------
SET @OrderNo = 2  
SET @ID = 'Division' 
SET @Description = N'Từng đơn vị' 
SET @DescriptionE = N'Division Name' 
SET @Disabled = 0 
SET @LanguageID ='A00.Division'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------Load ngôn ngữ định nghĩa trong Store (Ví dụ: báo cáo Phễu bán hàng theo công ty - CRMR30111)


---------- Dữ liệu ngầm Combobox Thời gian phản hồi của màn hình Từ điển hỗ trợ

SET @CodeMaster = 'CRMT00000027'
SET @OrderNo = 1
SET @ID = '1'
SET @Description = N'1 giờ'
SET @DescriptionE = N'1 hour'
SET @Disabled = 0 
SET @LanguageID = NULL
SET @CodeMasterName = N'Dữ liệu ngầm Combobox Thời gian phản hồi của màn hình Từ điển hỗ trợ'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 2
SET @ID = '2'
SET @Description = N'2 giờ'
SET @DescriptionE = N'2 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 3
SET @ID = '3'
SET @Description = N'3 giờ'
SET @DescriptionE = N'3 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 4
SET @ID = '4'
SET @Description = N'4 giờ'
SET @DescriptionE = N'4 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 5
SET @ID = '5'
SET @Description = N'5 giờ'
SET @DescriptionE = N'5 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 6
SET @ID = '6'
SET @Description = N'6 giờ'
SET @DescriptionE = N'6 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 7
SET @ID = '7'
SET @Description = N'7 giờ'
SET @DescriptionE = N'7 hours'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 8
SET @ID = '8'
SET @Description = N'1 ngày'
SET @DescriptionE = N'1 day'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 9
SET @ID = '12'
SET @Description = N'1.5 ngày'
SET @DescriptionE = N'1.5 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 10
SET @ID = '16'
SET @Description = N'2 ngày'
SET @DescriptionE = N'2 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 11
SET @ID = '24'
SET @Description = N'3 ngày'
SET @DescriptionE = N'3 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 12
SET @ID = '32'
SET @Description = N'4 ngày'
SET @DescriptionE = N'4 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 13
SET @ID = '40'
SET @Description = N'5 ngày'
SET @DescriptionE = N'5 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 14
SET @ID = '48'
SET @Description = N'6 ngày'
SET @DescriptionE = N'6 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 15
SET @ID = '56'
SET @Description = N'7 ngày'
SET @DescriptionE = N'7 days'
SET @Disabled = 0 
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------- Dữ liệu ngầm Combobox Thời gian phản hồi của màn hình Từ điển hỗ trợ

----------Tấn Lộc - Bổ sung dữ liệu ngâm cho cột Loại yêu cầu trong màn hình Yêu cầu - CRMF2080 ------------------
SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Tính năng mới' 
SET @DescriptionE = N'New Function' 
SET @Disabled = 0 
SET @LanguageID = 0
SET @CodeMasterName = N'Loại yêu cầu (màn hình cập nhật yêu cầu - CRMF2080)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Sửa/Cải tiến tính năng' 
SET @DescriptionE = N'Customized' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 3 
SET @ID = '3' 
SET @Description = N'Sửa/Cải tiến báo cáo' 
SET @DescriptionE = N'Edit Report' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Làm mới báo cáo' 
SET @DescriptionE = N'New Report' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Yêu cầu tư vấn' 
SET @DescriptionE = N'Consultant Request' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 6 
SET @ID = '6' 
SET @Description = N'Yêu cầu đào tạo' 
SET @DescriptionE = N'Training Request' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 7  
SET @ID = '7' 
SET @Description = N'Kiểm tra dữ liệu' 
SET @DescriptionE = N'Check the data' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2080.TypeOfRequest' 
SET @OrderNo = 8  
SET @ID = '8' 
SET @Description = N'Mua thêm licenses/Thuê server/HĐĐT' 
SET @DescriptionE = N'Buy more licenses/server/EInvoices' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'OffsetStatus_SOT2080' 
SET @OrderNo = 1  
SET @ID = '0' 
SET @Description = N'Chờ duyệt' 
SET @DescriptionE = N'Waiting approval' 
SET @Disabled = 0 
SET @LanguageID = 'A00.WaitingApproval'
SET @CodeMasterName = N'Trạng thái (Màn hình Xét duyệt file thiết kế - SOF2084)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'OffsetStatus_SOT2080' 
SET @OrderNo = 2  
SET @ID = '1' 
SET @Description = N'Duyệt' 
SET @DescriptionE = N'Approved' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Approved'
SET @CodeMasterName = N'Trạng thái (Màn hình Xét duyệt file thiết kế - SOF2084)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'OffsetStatus_SOT2080' 
SET @OrderNo = 3  
SET @ID = '2' 
SET @Description = N'Từ chối' 
SET @DescriptionE = N'Reject' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Reject'
SET @CodeMasterName = N'Trạng thái (Màn hình Xét duyệt file thiết kế - SOF2084)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tấn Lộc [20/07/2020] - Bổ sung dữ liệu ngâm cho cột trạng thái trong màn hình Cập nhật thông tin Profile - CRMF2131 ------------------
SET @CodeMaster = 'CRMF2130.Status' 
SET @OrderNo = 1  
SET @ID = 'TTLS0001' 
SET @Description = N'Tạo mới' 
SET @DescriptionE = N'Create New' 
SET @Disabled = 0 
SET @LanguageID = 0
SET @CodeMasterName = N'Trạng thái trong màn hình Cập nhật thông tin Profile - CRMF2131'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2130.Status' 
SET @OrderNo = 2  
SET @ID = 'TTLS0002' 
SET @Description = N'Hủy' 
SET @DescriptionE = N'Cancel' 
SET @Disabled = 0 
SET @LanguageID = 0
SET @CodeMasterName = N'Trạng thái trong màn hình Cập nhật thông tin Profile - CRMF2131'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tấn Lộc [20/07/2020] - Bổ sung dữ liệu ngâm cho cột True/False trong màn hình Cập nhật thông tin Profile - CRMF2131 để get Name cho cột ReportOnlyName ------------------
SET @CodeMaster = 'CRMF2130.ReportOnly' 
SET @OrderNo = 1  
SET @ID = '0' 
SET @Description = N'False' 
SET @DescriptionE = N'False' 
SET @Disabled = 0 
SET @LanguageID = 0
SET @CodeMasterName = N'Dữ liệu ngầm cho cột True/False trong màn hình Cập nhật thông tin Profile - CRMF2131 để get Name cho cột ReportOnlyName'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2130.ReportOnly' 
SET @OrderNo = 2  
SET @ID = '1' 
SET @Description = N'True' 
SET @DescriptionE = N'True' 
SET @Disabled = 0 
SET @LanguageID = 0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Đình Ly [10/12/2020] - Dữ liệu trạng thái (Master) cho dự toán, thông tin sản xuất (MAITHU)
SET @CodeMaster = 'CRMF2111.Status' 
SET @OrderNo = 0 
SET @ID = '0' 
SET @Description = N'Cũ' 
SET @DescriptionE = N'Old' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Dữ liệu trạng thái (Master) cho dự toán, thông tin sản xuất (MAITHU)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 

SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Mới' 
SET @DescriptionE = N'New' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 

----------Đình Ly [04/12/2020] - Dữ liệu loại in (Master) cho dự toán, thông tin sản xuất (MAITHU)
SET @CodeMaster = 'CRMF2111.PrintTypeID' 
SET @OrderNo = 0  
SET @ID = '0' 
SET @Description = N'Ống đồng' 
SET @DescriptionE = N'Copper pipe' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'In offset' 
SET @DescriptionE = N'Print offset' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 3 
SET @ID = '3' 
SET @Description = N'In flexo' 
SET @DescriptionE = N'Print flexo' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 4
SET @ID = '4' 
SET @Description = N'Túi dẹt' 
SET @DescriptionE = N'Flat bag' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 5 
SET @ID = '5' 
SET @Description = N'Túi vuông' 
SET @DescriptionE = N'Square bag' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Gia công' 
SET @DescriptionE = N'Outsource' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 7 
SET @ID = '7' 
SET @Description = N'Không in' 
SET @DescriptionE = N'No print' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Phương pháp in'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Đình Ly [04/12/2020] - Dữ liệu loại in (Details) cho dự toán, thông tin sản xuất (MAITHU)
SET @CodeMaster = 'CRMF2111.PrintType' 
SET @OrderNo = 0  
SET @ID = '0' 
SET @Description = N'1 mặt' 
SET @DescriptionE = N'1 side' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Dữ liệu loại in (Details) cho dự toán, thông tin sản xuất (MAITHU)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'2 mặt' 
SET @DescriptionE = N'2 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'2 tự trở' 
SET @DescriptionE = N'2 side self back' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'2 mặt trở nhíp' 
SET @DescriptionE = N'2 side tweezers' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 4
SET @ID = '4' 
SET @Description = N'2 mặt AB' 
SET @DescriptionE = N'2 side AB' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Đình Ly [04/12/2020] - Dữ liệu Chạy giấy (Details) cho dự toán, thông tin sản xuất (MAITHU)

SET @CodeMaster = 'CRMF2111.RunPaper' 
SET @OrderNo = 0  
SET @ID = '1' 
SET @Description = N'1 lớp' 
SET @DescriptionE = N'1 side' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Dữ liệu Chạy giấy (Details) cho dự toán, thông tin sản xuất (MAITHU)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 1  
SET @ID = '2' 
SET @Description = N'2 lớp' 
SET @DescriptionE = N'2 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 2  
SET @ID = '3' 
SET @Description = N'3 lớp' 
SET @DescriptionE = N'3 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 3
SET @ID = '4' 
SET @Description = N'4 lớp' 
SET @DescriptionE = N'4 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 4  
SET @ID = '5' 
SET @Description = N'5 lớp' 
SET @DescriptionE = N'5 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 5 
SET @ID = '6' 
SET @Description = N'6 lớp' 
SET @DescriptionE = N'6 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 6
SET @ID = '7' 
SET @Description = N'7 lớp' 
SET @DescriptionE = N'7 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 7
SET @ID = '8'
SET @Description = N'8 lớp' 
SET @DescriptionE = N'8 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 8
SET @ID = '9'
SET @Description = N'9 lớp' 
SET @DescriptionE = N'9 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @OrderNo = 9
SET @ID = '10'
SET @Description = N'10 lớp' 
SET @DescriptionE = N'10 side' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Kiều Nga [21/09/2020] - Load dữ liệu loại sản phẩm phiếu yêu cầu khách hàng, dự toán, thông tin sản xuất (MAITHU)
SET @CodeMaster = 'CRMT00000022' 
SET @OrderNo = 1  
SET @ID = '0' 
SET @Description = N'OFFSET' 
SET @DescriptionE = N'OFFSET' 
SET @Disabled = 0 
SET @LanguageID =0
SET @CodeMasterName = N'Loại sản phẩm phiếu yêu cầu khách hàng, dự toán, thông tin sản xuất (MAITHU)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
 
---------
SET @OrderNo = 2  
SET @ID = '1' 
SET @Description = N'CARTON' 
SET @DescriptionE = N'CARTON' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'OFFSET BỒI CARTON' 
SET @DescriptionE = N'OFFSET BỒI CARTON' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '3' 
SET @Description = N'LY GIẤY' 
SET @DescriptionE = N'Glass Paper' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '4' 
SET @Description = N'GIẤY GÓI QUÀ' 
SET @DescriptionE = N'GIFT WRAP' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '5' 
SET @Description = N'TÚI DẸT' 
SET @DescriptionE = N'BAG BAG' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '6' 
SET @Description = N'TÚI VUÔNG' 
SET @DescriptionE = N'SQUARE BAG' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '7' 
SET @Description = N'NHỰA' 
SET @DescriptionE = N'PLASTIC' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '8' 
SET @Description = N'KHÁC' 
SET @DescriptionE = N'OTHER' 
SET @Disabled = 0 
SET @LanguageID =0
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------	Đình Ly [20/10/2020] -  Dữ liệu nghiệp vụ Quản lý lịch	---------
SET @CodeMaster = 'CalendarBusiness' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Sự kiện' 
SET @DescriptionE = N'Event'
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu nghiệp vụ Quản lý lịch'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @CodeMaster = 'CalendarBusiness' 
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Công việc' 
SET @DescriptionE = N'Task' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu nghiệp vụ Quản lý lịch'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'CalendarBusiness' 
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Thiết bị' 
SET @DescriptionE = N'Device' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu nghiệp vụ Quản lý lịch'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------Thu Hà [06/10/2023] - Bổ sung dữ liệu ngầm lịch phỏng vấn cho CodeMaster 'CalendarBusiness' còn thiếu
SET @CodeMaster = 'CalendarBusiness' 
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Lịch phỏng vấn' 
SET @DescriptionE = N'Interview Schedule' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu nghiệp vụ Quản lý lịch'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Đình Hòa [12/11/2020] - Bổ sung CodeMaster CRMT00000002 còn thiếu 

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 0  
SET @ID = '1' 
SET @Description = N'Đầu mối' 
SET @DescriptionE = N'Đầu mối' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Lead'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 1  
SET @ID = '2' 
SET @Description = N'Liên hệ' 
SET @DescriptionE = N'Contact' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Contact'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 2  
SET @ID = '3' 
SET @Description = N'Đối tượng/Khách hàng' 
SET @DescriptionE = N'Customer' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Customer'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 3  
SET @ID = '4' 
SET @Description = N'Cơ hội' 
SET @DescriptionE = N'Opportunity' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Opportunity'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 4  
SET @ID = '5' 
SET @Description = N'Báo giá' 
SET @DescriptionE = N'Quotation' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Quotation'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 5  
SET @ID = '6' 
SET @Description = N'Chiến dịch' 
SET @DescriptionE = N'Campaign' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Campaign'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 6  
SET @ID = '7' 
SET @Description = N'Đơn hàng bán' 
SET @DescriptionE = N'Sale Order' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SaleOrder'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 7  
SET @ID = '8' 
SET @Description = N'Sự kiện' 
SET @DescriptionE = N'Event' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Event'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 8  
SET @ID = '9' 
SET @Description = N'Nhiệm vụ' 
SET @DescriptionE = N'Task' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Task'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 9  
SET @ID = '10' 
SET @Description = N'Email' 
SET @DescriptionE = N'Email' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Email'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 10  
SET @ID = '11' 
SET @Description = N'Nhóm người nhận' 
SET @DescriptionE = N'Group Receiver' 
SET @Disabled = 0 
SET @LanguageID = 'A00.GroupReceiver'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 11  
SET @ID = '12' 
SET @Description = N'Email mẫu' 
SET @DescriptionE = N'Khác' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Other'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 12  
SET @ID = '13' 
SET @Description = N'Giai đoạn' 
SET @DescriptionE = N'Stage' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Stage'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 13  
SET @ID = '14' 
SET @Description = N'Lý do' 
SET @DescriptionE = N'Cause' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Cause'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 14  
SET @ID = '15' 
SET @Description = N'Loại hình bán hàng' 
SET @DescriptionE = N'SalesTags' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SalesTags'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 15  
SET @ID = '16' 
SET @Description = N'Hành động' 
SET @DescriptionE = N'Action' 
SET @Disabled = 0 
SET @LanguageID = 'A00.ActionType'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 16  
SET @ID = '17' 
SET @Description = N'Đính kèm' 
SET @DescriptionE = N'Attach' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Attach'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 17  
SET @ID = '18' 
SET @Description = N'Ghi chú' 
SET @DescriptionE = N'Notes' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Note'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 18  
SET @ID = '19' 
SET @Description = N'Lịch sử' 
SET @DescriptionE = N'History' 
SET @Disabled = 0 
SET @LanguageID = 'A00.History'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 19  
SET @ID = '20' 
SET @Description = N'Yêu cầu' 
SET @DescriptionE = N'Request' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Request'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 20  
SET @ID = '21' 
SET @Description = N'Phân loại đầu mối' 
SET @DescriptionE = N'Lead Type' 
SET @Disabled = 0 
SET @LanguageID = 'A00.LeadType'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 21  
SET @ID = '22' 
SET @Description = N'Đơn hàng mua' 
SET @DescriptionE = N'Purchase Order' 
SET @Disabled = 0 
SET @LanguageID = 'A00.PurchaseOrder'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 22  
SET @ID = '23' 
SET @Description = N'Lĩnh vực kinh doanh' 
SET @DescriptionE = N'Lĩnh vực kinh doanh' 
SET @Disabled = 0 
SET @LanguageID = 'A00.BusinessLines'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 23  
SET @ID = '24' 
SET @Description = N'Phiếu thu' 
SET @DescriptionE = N'Reciepts' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Reciepts'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 24  
SET @ID = '25' 
SET @Description = N'Xếp loại' 
SET @DescriptionE = N'Classification' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Classification'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 25  
SET @ID = '26' 
SET @Description = N'Nhóm chỉ tiêu' 
SET @DescriptionE = N'Nhóm chỉ tiêu' 
SET @Disabled = 0 
SET @LanguageID = 'Nhóm chỉ tiêu'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 26  
SET @ID = '27' 
SET @Description = N'Từ điển chỉ tiêu' 
SET @DescriptionE = N'TargetsDictionaryID' 
SET @Disabled = 0 
SET @LanguageID = 'TargetsDictionaryID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 27  
SET @ID = '28' 
SET @Description = N'Chỉ tiêu' 
SET @DescriptionE = N'UnitKpiID' 
SET @Disabled = 0 
SET @LanguageID = 'UnitKpiID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 28  
SET @ID = '29' 
SET @Description = N'Khác' 
SET @DescriptionE = N'Khác' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Other'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 29  
SET @ID = '30' 
SET @Description = N'Nguồn đo' 
SET @DescriptionE = N'SourceID' 
SET @Disabled = 0 
SET @LanguageID = 'SourceID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 30  
SET @ID = '31' 
SET @Description = N'Mức hoa hồng' 
SET @DescriptionE = N'Mức hoa hồng' 
SET @Disabled = 0 
SET @LanguageID = 'A00.CommissionRate'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 31  
SET @ID = '32' 
SET @Description = N'Đợt đánh giá' 
SET @DescriptionE = N'Evaluation Phase' 
SET @Disabled = 0 
SET @LanguageID = 'A00.EvaluationPhaseID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 32  
SET @ID = '33' 
SET @Description = N'Thiết lập bảng đánh giá từng vị trí' 
SET @DescriptionE = N'Evaluation Set' 
SET @Disabled = 0 
SET @LanguageID = 'A00.EvaluationSetID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 33  
SET @ID = '34' 
SET @Description = N'Cá nhân tự đánh giá' 
SET @DescriptionE = N'Individual self-assessment' 
SET @Disabled = 0 
SET @LanguageID = ''
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 34  
SET @ID = '35' 
SET @Description = N'Tính thưởng' 
SET @DescriptionE = N'Bonus Amount' 
SET @Disabled = 0 
SET @LanguageID = 'A00.BonusAmount'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 35  
SET @ID = '36' 
SET @Description = N'Từ điển năng lực' 
SET @DescriptionE = N'Từ điển năng lực' 
SET @Disabled = 0 
SET @LanguageID = 'A00.AppraisalDictionaryID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 36  
SET @ID = '37' 
SET @Description = N'Năng lực' 
SET @DescriptionE = N'Appraisal' 
SET @Disabled = 0 
SET @LanguageID = 'A00.AppraisalID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 37  
SET @ID = '38' 
SET @Description = N'Thiết lập bảng đánh giá năng lực' 
SET @DescriptionE = N'Evaluation Kit' 
SET @Disabled = 0 
SET @LanguageID = 'A00.EvaluationKitID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 38  
SET @ID = '39' 
SET @Description = N'Đánh giá năng lực' 
SET @DescriptionE = N'Personal appraisal' 
SET @Disabled = 0 
SET @LanguageID = 'A00.PersonalAppraisalID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 39  
SET @ID = '40' 
SET @Description = N'Nhóm tính cách cá nhân' 
SET @DescriptionE = N'Nhóm tính cách cá nhân' 
SET @Disabled = 0 
SET @LanguageID = 'Nhóm tính cách cá nhân'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 40  
SET @ID = '41' 
SET @Description = N'Thiết lập thời gian làm việc' 
SET @DescriptionE = N'Setting work time' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SettingWorkTimeID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 41  
SET @ID = '42' 
SET @Description = N'Thông báo' 
SET @DescriptionE = N'Thông báo' 
SET @Disabled = 0 
SET @LanguageID = 'A00.NotificationID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 42  
SET @ID = '43' 
SET @Description = N'Quy trình' 
SET @DescriptionE = N'Process' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Process'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 43  
SET @ID = '44' 
SET @Description = N'Bước' 
SET @DescriptionE = N'Step' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Step'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 44  
SET @ID = '45' 
SET @Description = N'Trang thái' 
SET @DescriptionE = N'Status' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Status'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 47  
SET @ID = '48' 
SET @Description = N'Công việc' 
SET @DescriptionE = N'Work' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Work'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 48  
SET @ID = '49' 
SET @Description = N'Đề nghị chi' 
SET @DescriptionE = N'Suggest For Payment' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SuggestPayment'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 49  
SET @ID = '50' 
SET @Description = N'Phiếu cọc' 
SET @DescriptionE = N'Deposit' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Deposit'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 50  
SET @ID = '51' 
SET @Description = N'Đề nghị xuất hóa đơn' 
SET @DescriptionE = N'Request for invoice' 
SET @Disabled = 0 
SET @LanguageID = 'A00.RequestInvoice'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 51  
SET @ID = '52' 
SET @Description = N'Nhóm cổ đông' 
SET @DescriptionE = N'Share Holder Category' 
SET @Disabled = 0 
SET @LanguageID = 'A00.ShareHolderCategoryID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 52  
SET @ID = '53' 
SET @Description = N'Loại cổ phần' 
SET @DescriptionE = N'Share Type' 
SET @Disabled = 0 
SET @LanguageID = 'A00.ShareTypeID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 53  
SET @ID = '54' 
SET @Description = N'Đợt phát hành' 
SET @DescriptionE = N'Share Holder Publish Period' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SHPublishPeriodID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 54  
SET @ID = '55' 
SET @Description = N'Đăng ký mua cổ phần' 
SET @DescriptionE = N'Register equity' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SHRegisterID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 55  
SET @ID = '56' 
SET @Description = N'Sổ cổ đông' 
SET @DescriptionE = N'Shareholders Book' 
SET @Disabled = 0 
SET @LanguageID = 'A00.ShareholdersBookID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 56  
SET @ID = '57' 
SET @Description = N'Chuyển nhượng cổ phần' 
SET @DescriptionE = N'Transfer of shares' 
SET @Disabled = 0 
SET @LanguageID = 'A00.TransferOfSharesID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 57  
SET @ID = '58' 
SET @Description = N'Chia cổ tức' 
SET @DescriptionE = N'Dividend' 
SET @Disabled = 0 
SET @LanguageID = 'A00.DividendID'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------Đình Hoà [21/07/2020] - Thay đổi mô tả của đối tượng khách hàng 
IF EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = 'CRMT00000002' AND ID = '3')
BEGIN
	UPDATE CRMT0099
	SET Description = N'Đối tượng/Khách hàng'
	WHERE CodeMaster = 'CRMT00000002' AND ID = '3'
END

---------Đình Hoà [22/07/2020] - Bổ sung dữ liệu ngầm Mặt hàng 
SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 59  
SET @ID = '59' 
SET @Description = N'Mặt hàng' 
SET @DescriptionE = N'Inventory' 
SET @Disabled = 0 
SET @LanguageID ='A00.Inventory'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 


----------Tấn Lộc - Bổ sung dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041 ------------------
SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 60  
SET @ID = '60' 
SET @Description = N'Khác' 
SET @DescriptionE = N'Khác' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Other'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Khác" trong màn hình Cập nhật Email mẫu - CIF1041'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 61  
SET @ID = '61' 
SET @Description = N'Đăng kí clould online' 
SET @DescriptionE = N'Đăng kí clould online' 
SET @Disabled = 0 
SET @LanguageID = 'A00.RegisterDataOnline'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm Email là "Đăng kí clould online" trong màn hình Cập nhật Email mẫu - SF2121'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

-----Văn Tài [09/12/2021] --- Bổ sung dữ liệu ngầm Khách hàng Sale out
SET @CodeMaster = 'CRMT00000002' 
SET @OrderNo = 62
SET @ID = '62' 
SET @Description = N'Khách hàng Sale out' 
SET @DescriptionE = N'Sale out Customer' 
SET @Disabled = 0 
SET @LanguageID = 'A00.CustomerSaleOut'
SET @CodeMasterName = N'Dữ liệu ngâm cho Nhóm khách hàng sale out ERP 9 - API'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

-----Đình Hòa[16/11/2020] --- Bổ sung dữ liệu ngầm thông tin thương hiệu
SET @CodeMaster = 'CRMT00000028' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'WOW' 
SET @DescriptionE = N'WOW' 
SET @Disabled = 0 
SET @LanguageID = 'A00.WOW'
SET @CodeMasterName = N'Thông tin thương hiệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000028' 
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Đúng giờ' 
SET @DescriptionE = N'On Time' 
SET @Disabled = 0 
SET @LanguageID = 'A00.OnTime'
SET @CodeMasterName = N'Thông tin thương hiệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000028' 
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Cam kết' 
SET @DescriptionE = N'Commitment' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Commitment'
SET @CodeMasterName = N'Thông tin thương hiệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000028' 
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Sáng tạo' 
SET @DescriptionE = N'Creation' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Creation'
SET @CodeMasterName = N'Thông tin thương hiệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000028' 
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Teamwork' 
SET @DescriptionE = N'Teamwork' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Teamwork'
SET @CodeMasterName = N'Thông tin thương hiệu'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho cột trạng thái chiến dịch email trong màn hình cập nhật chiến dịch email - CRMF2141 ------------------
SET @CodeMaster = 'CRMT2140.StatusCampaignEmail' 
SET @OrderNo = 1  
SET @ID = 'TTCE00001' 
SET @Description = N'Đang hoạt động' 
SET @DescriptionE = N'Đang hoạt động' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Trạng thái chiến dịch email trong màn hình cập nhật chiến dịch email - CRMF2141'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2140.StatusCampaignEmail' 
SET @OrderNo = 2  
SET @ID = 'TTCE00002' 
SET @Description = N'Tạm ngưng' 
SET @DescriptionE = N'Tạm ngưng' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Trạng thái chiến dịch email trong màn hình cập nhật chiến dịch email - CRMF2141'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2140.StatusCampaignEmail' 
SET @OrderNo = 3  
SET @ID = 'TTCE00003' 
SET @Description = N'Hoàn tất' 
SET @DescriptionE = N'Hoàn tất' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Trạng thái chiến dịch email trong màn hình cập nhật chiến dịch email - CRMF2141'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

--------Đình Hòa[19/11/2020] --- Bổ sung dữ liệu ngầm mục tiêu chuyển đổi
IF ISNULL(@CustomerName,0) = 130
BEGIN 
SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 1  
SET @ID = 'SALE_MKTTOCED' 
SET @Description = N'Marketing to Seminar CED' 
SET @DescriptionE = N'Marketing to Seminar CED' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SeminarCED'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 2  
SET @ID = 'SALE_MKTTOADZ' 
SET @Description = N'Marketing To Seminar ADZ' 
SET @DescriptionE = N'Marketing To Seminar ADZ' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SeminarADZ'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 3  
SET @ID = 'SALE_MKTTO6STEPS' 
SET @Description = N'Marketing To Seminar 6 Steps' 
SET @DescriptionE = N'Marketing To Seminar 6 Steps' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Seminar6Steps1'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 4  
SET @ID = 'SALE_MKTTOLG' 
SET @Description = N'Marketing to Seminar Leverage Game' 
SET @DescriptionE = N'Marketing to Seminar Leverage Game' 
SET @Disabled = 0 
SET @LanguageID = 'A00.MKTTOLG'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 5  
SET @ID = 'SALE_BNICTO6STEPS' 
SET @Description = N'BNI Commitment to Seminar 6Steps' 
SET @DescriptionE = N'BNI Commitment to Seminar 6Steps' 
SET @Disabled = 0 
SET @LanguageID = 'A00.Seminar6Steps2'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 6  
SET @ID = 'SALE_CIATO6STEPS' 
SET @Description = N'CIA To Seminar 6 Steps' 
SET @DescriptionE = N'CIA To Seminar 6 Steps' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SALE_CIATO6STEPS'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 7  
SET @ID = 'HD_CEDTOCIA' 
SET @Description = N'Seminar CED To CIA' 
SET @DescriptionE = N'Seminar CED To CIA' 
SET @Disabled = 0 
SET @LanguageID = 'A00.CEDTOCIA'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 8  
SET @ID = 'HD_ADZTOBNI' 
SET @Description = N'Seminar ADZ To BNI Member' 
SET @DescriptionE = N'Seminar ADZ To BNI Member' 
SET @Disabled = 0 
SET @LanguageID = 'A00.ADZTOBNI'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 9  
SET @ID = 'HD_ADZTOCIA' 
SET @Description = N'Seminar ADZ To CIA' 
SET @DescriptionE = N'Seminar ADZ To CIA' 
SET @Disabled = 0 
SET @LanguageID = 'A00.HD_ADZTOCIA'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 10  
SET @ID = 'HD_6STEPSTOCIA' 
SET @Description = N'Seminar 6Steps to CIA' 
SET @DescriptionE = N'Seminar 6Steps to CIA' 
SET @Disabled = 0 
SET @LanguageID = 'A00.HD_6STEPSTOCIA'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 11  
SET @ID = 'HD_BNIOTOCIA' 
SET @Description = N'BNI Ownership to CIA' 
SET @DescriptionE = N'BNI Ownership to CIA' 
SET @Disabled = 0 
SET @LanguageID = 'A00.HD_BNIOTOCIA'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 12  
SET @ID = 'HD_LGTOCIA' 
SET @Description = N'Seminar Leverage Game to CIA' 
SET @DescriptionE = N'Seminar Leverage Game to CIA' 
SET @Disabled = 0 
SET @LanguageID = 'A00.HD_LGTOCIA'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 13  
SET @ID = 'HD_PRECOACH' 
SET @Description = N'Seminar to PreCoach' 
SET @DescriptionE = N'Seminar to PreCoach' 
SET @Disabled = 0 
SET @LanguageID = 'A00.HD_PRECOACH'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 14  
SET @ID = 'COD ' 
SET @Description = N'COD' 
SET @DescriptionE = N'COD' 
SET @Disabled = 0 
SET @LanguageID = 'A00.COD '
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000030' 
SET @OrderNo = 15  
SET @ID = 'DIAGS ' 
SET @Description = N'DIAGS' 
SET @DescriptionE = N'DIAGS' 
SET @Disabled = 0 
SET @LanguageID = 'A00.DIAGS'
SET @CodeMasterName = N'Dữ liệu ngầm mục tiêu chuyển đổi'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---Chuyên đề đào tạo 
SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 1  
SET @ID = 'PURPOSE' 
SET @Description = N'Purpose' 
SET @DescriptionE = N'Purpose' 
SET @Disabled = 0 
SET @LanguageID = 'A00.PURPOSE'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 2  
SET @ID = 'CASHFLOW' 
SET @Description = N'Cashflow' 
SET @DescriptionE = N'Cashflow' 
SET @Disabled = 0 
SET @LanguageID = 'A00.CASHFLOW'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 3  
SET @ID = 'MARKETING' 
SET @Description = N'Marketing' 
SET @DescriptionE = N'Marketing' 
SET @Disabled = 0 
SET @LanguageID = 'A00.MARKETING'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 4  
SET @ID = 'SALEPHONERICH' 
SET @Description = N'SaleRICH PhoneRICH' 
SET @DescriptionE = N'SaleRICH PhoneRICH' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SALEPHONERICH'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 5  
SET @ID = 'TEAMRICH' 
SET @Description = N'TeamRICH' 
SET @DescriptionE = N'TeamRICH' 
SET @Disabled = 0 
SET @LanguageID = 'A00.TEAMRICH'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 6  
SET @ID = 'SYSTEMRICH' 
SET @Description = N'SystemRICH' 
SET @DescriptionE = N'SystemRICH' 
SET @Disabled = 0 
SET @LanguageID = 'A00.SYSTEMRICH'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00000031' 
SET @OrderNo = 7 
SET @ID = 'LEVERAGAME' 
SET @Description = N'LEVERAGAME' 
SET @DescriptionE = N'LEVERAGAME' 
SET @Disabled = 0 
SET @LanguageID = 'A00.LEVERAGAME'
SET @CodeMasterName = N'Chuyên đề đào tạo'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----Đình Hòa 12/12/2020 Loại chiến dịch (CBD)
SET @CodeMaster = 'CRMT00000032' 
SET @OrderNo = 1  
SET @ID = 'TYPE_CED' 
SET @Description = N'CED' 
SET @DescriptionE = N'CED' 
SET @Disabled = 0 
SET @CodeMasterName = N'Loại chiến dịch (CBD)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = 'TYPE_ADZ' 
SET @Description = N'Adding Zeros' 
SET @DescriptionE = N'Adding Zeros' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = 'TYPE_6STEPS' 
SET @Description = N'6 Steps' 
SET @DescriptionE = N'6 Steps' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4  
SET @ID = 'TYPE_RBNIC' 
SET @Description = N'Referal BNI Commitment' 
SET @DescriptionE = N'Referal BNI Commitment' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5
SET @ID = 'TYPE_RBNIO' 
SET @Description = N'Referal BNI Ownership' 
SET @DescriptionE = N'Referal BNI Ownership' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 6
SET @ID = 'TYPE_RCIA' 
SET @Description = N'CIA Referal' 
SET @DescriptionE = N'CIA Referal' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 7
SET @ID = 'TYPE_LG' 
SET @Description = N'Leverage Game' 
SET @DescriptionE = N'Leverage Game' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 8
SET @ID = 'TYPE_PBC' 
SET @Description = N'PBC' 
SET @DescriptionE = N'PBC' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
END

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho cột version trong màn hình cập nhật License - CRMF2121 ------------------
SET @CodeMaster = 'CRMT2120.InformationVersion' 
SET @OrderNo = 1  
SET @ID = 'Standard' 
SET @Description = N'Standard' 
SET @DescriptionE = N'Standard' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Cột version trong màn hình cập nhật License - CRMF2121'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2120.InformationVersion' 
SET @OrderNo = 2  
SET @ID = 'Professional' 
SET @Description = N'Professional' 
SET @DescriptionE = N'Professional' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Cột version trong màn hình cập nhật License - CRMF2121'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2120.InformationVersion' 
SET @OrderNo = 3  
SET @ID = 'Enterprise' 
SET @Description = N'Enterprise' 
SET @DescriptionE = N'Enterprise' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Cột version trong màn hình cập nhật License - CRMF2121'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----Trọng Kiên 21/12/2020 List phiếu in Thông tin sản xuất
BEGIN
SET @CodeMaster = 'TemplatePrint.SOF2080'
SET @OrderNo = 1
SET @ID = 'SOF2080Report' 
SET @Description = N'In phiếu thông tin sản xuất' 
SET @DescriptionE = N'In phiếu thông tin sản xuất' 
SET @Disabled = 0 
SET @CodeMasterName = N'Mẫu phiếu in (màn hình chọn mẫu in - SOF2029)'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
--------- 
SET @OrderNo = 2 
SET @ID = 'SOF20801Report' 
SET @Description = N'In phiếu quyết định trục in' 
SET @DescriptionE = N'In phiếu quyết định trục in' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
---------
SET @OrderNo = 3  
SET @ID = 'SOF20802Report' 
SET @Description = N'In phiếu quyết đinh CTP' 
SET @DescriptionE = N'In phiếu quyết đinh CTP' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 4 
SET @ID = 'SOF20803Report' 
SET @Description = N'In phiếu quyết định inproof' 
SET @DescriptionE = N'In phiếu quyết định inproof' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 5  
SET @ID = 'SOF20804Report' 
SET @Description = N'In phiếu quyết định làm khuôn' 
SET @DescriptionE = N'In phiếu quyết định làm khuôn' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
END

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho cột trạng thái sms trong màn hình cập nhật sms - CRMF2191 ------------------
SET @CodeMaster = 'CRMT2190.StatusCampaignSMS' 
SET @OrderNo = 1  
SET @ID = 'TTCSMS00001' 
SET @Description = N'Đang hoạt động' 
SET @DescriptionE = N'Đang hoạt động' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Dữ liệu ngầm cho cột trạng thái sms trong màn hình cập nhật sms - CRMF2191'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2190.StatusCampaignSMS' 
SET @OrderNo = 2  
SET @ID = 'TTCSMS00002' 
SET @Description = N'Tạm ngưng' 
SET @DescriptionE = N'Tạm ngưng' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Dữ liệu ngầm cho cột trạng thái sms trong màn hình cập nhật sms - CRMF2191'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT2190.StatusCampaignSMS' 
SET @OrderNo = 3  
SET @ID = 'TTCSMS00003' 
SET @Description = N'Hoàn tất' 
SET @DescriptionE = N'Hoàn tất' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Dữ liệu ngầm cho cột trạng thái sms trong màn hình cập nhật sms - CRMF2191'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----------Kiều Nga - Bổ sung dữ liệu ngầm cho cột loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002 ------------------
SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 1  
SET @ID = 'Quantity' 
SET @Description = N'Số lượng' 
SET @DescriptionE = N'Số lượng' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 2  
SET @ID = 'Quantitative' 
SET @Description = N'Định lượng' 
SET @DescriptionE = N'Định lượng' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 3  
SET @ID = 'Size' 
SET @Description = N'Chiều khổ' 
SET @DescriptionE = N'Chiều khổ' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 4  
SET @ID = 'PrintType' 
SET @Description = N'Phương pháp in' 
SET @DescriptionE = N'Phương pháp in' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 5
SET @ID = 'Materials' 
SET @Description = N'Nguyên vật liệu' 
SET @DescriptionE = N'Nguyên vật liệu' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 6
SET @ID = 'NoType' 
SET @Description = N'Không có' 
SET @DescriptionE = N'Không có' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMT00004.ConditionType' 
SET @OrderNo = 7
SET @ID = 'Order' 
SET @Description = N'Khác' 
SET @DescriptionE = N'Khác' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Loại điều kiện trong màn hình thiết lập hao hụt - CRMF0002'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


-- Hoài Phong [03/03/2021] Bổ sung các gói hợp đồng
---------- gói hợp đồng
SET @CodeMaster = 'CIFT1360.ContractPackage' 
SET @OrderNo = 1  
SET @ID = '20%' 
SET @Description = N'Hợp đồng 20%' 
SET @DescriptionE = N'Contract 20%' 
SET @Disabled = 0 
SET @LanguageID = N'24'
SET @CodeMasterName = N'Gói hợp đồng'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) 
ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---------
SET @OrderNo = 2  
SET @ID = '25%' 
SET @Description = N'Hợp đồng 25%' 
SET @DescriptionE = N'Contract 25%' 
SET @Disabled = 0 
SET @LanguageID = N'16'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) 
ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '30%' 
SET @Description = N'Hợp đồng 30%' 
SET @DescriptionE = N'Contract 30%' 
SET @Disabled = 0 
SET @LanguageID = N'8'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) 
ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------

-- [Tấn Thành] - [16/03/2021] - Bổ sung dữ liệu ngầm Lịch sử cuộc gọi (Chuyển từ OO).

SET @CodeMaster = 'CRMF2150.StatusCall'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'ANSWERED', 1,1, N'Trả lời', N'ANSWERED', 0, NULL, N'Lịch sử cuộc gọi - Trạng thái cuộc gọi'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'NO ANSWER', 2,2, N'Không trả lời', N'NO ANSWER', 0, NULL, N'Lịch sử cuộc gọi - Trạng thái cuộc gọi'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'MISSED', 3,3, N'Bỏ lỡ', N'MISSED', 0, NULL, N'Lịch sử cuộc gọi - Trạng thái cuộc gọi'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'BUSY', 4,4, N'Máy bận', N'BUSY', 0, NULL, N'Lịch sử cuộc gọi - Trạng thái cuộc gọi'
SET @CodeMaster = 'CRMF2150.TypeOfCall'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'Inbound', 1,1, N'Cuộc gọi vào', N'Inbound', 0, NULL, N'Loại cuộc gọi'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'Outbound', 2,2, N'Cuộc gọi ra', N'Outbound', 0, NULL, N'Loại cuộc gọi'
EXEC AddDataMasterERP9 'CRMT0099', @CodeMaster, N'Local', 3,3, N'Cuộc gọi nội bộ', N'Local', 0, NULL, N'Loại cuộc gọi'
----------

-- [Tấn Thành] - [17/03/2021] - Bổ sung dữ liệu ngầm Yêu cầu hỗ trợ (Chuyển từ OO).
SET @CodeMaster = 'CRMF2160.TypeOfRequest'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'1', 1,1, N'Lỗi', N'Bugs', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'2', 2,2, N'Hỏi-Đáp', N'Question-Answer', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'3', 3,3, N'Thay đổi', N'Change', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'4', 4,4, N'Cải tiến', N'Suggest', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'5', 5,5, N'Hướng dẫn', N'Manual', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'6', 6,6, N'Cấp license', N'Provide license', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'7', 7,7, N'Chỉnh sửa báo cáo', N'Update report', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'
EXEC AddDataMasterERP9 'CRMT0099', N'CRMF2160.TypeOfRequest', N'8', 8,8, N'Kiểm tra dữ liệu', N'Check the data', 0, NULL, N'Loại yêu cầu (Danh mục yêu cầu hỗ trợ)'

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho cột StatusID trong màn hình Yêu cầu dịch vụ - CRMF2170 ------------------
SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 0  
SET @ID = '0' 
SET @Description = N'Tiếp nhận' 
SET @DescriptionE = N'Tiếp nhận' 
SET @Disabled = 0
SET @LanguageID = NULL
SET @CodeMasterName = N'Dữ liệu ngầm cho cột StatusID trong màn hình Yêu cầu dịch vụ - CRMF2170'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Đang sửa chữa' 
SET @DescriptionE = N'Đang sửa chữa' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Hoàn tất sửa chữa' 
SET @DescriptionE = N'Hoàn tất sửa chữa' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Không sửa được' 
SET @DescriptionE = N'Không sửa được' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 4  
SET @ID = '4' 
SET @Description = N'Giao hàng' 
SET @DescriptionE = N'Giao hàng' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 5  
SET @ID = '5' 
SET @Description = N'Hoàn tất giao hàng' 
SET @DescriptionE = N'Hoàn tất giao hàng' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 6  
SET @ID = '6' 
SET @Description = N'Hoàn tất' 
SET @DescriptionE = N'Hoàn tất' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

SET @CodeMaster = 'CRMF2170.StatusID' 
SET @OrderNo = 7  
SET @ID = '7' 
SET @Description = N'Cancel' 
SET @DescriptionE = N'Cancel' 
SET @Disabled = 0
SET @LanguageID = NULL
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], [LanguageID], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @LanguageID, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

----Trọng Kiên 28/04/2021 List phiếu in Báo giá cho MECI
IF ISNULL(@CustomerName,0) = 137
BEGIN
SET @CodeMaster = 'TemplatePrint.SOF2020'
SET @OrderNo = 1
SET @ID = 'SOR2020ReportMECI_1' 
SET @Description = N'Mẫu 01 (Cửa)' 
SET @DescriptionE = N'Mẫu 01 (Cửa)' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
--------- 
SET @OrderNo = 2 
SET @ID = 'SOR2020ReportMECI_2' 
SET @Description = N'Mẫu 02 (Màn nhựa)' 
SET @DescriptionE = N'Mẫu 02 (Màn nhựa)' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 3  
SET @ID = 'SOR2020ReportMECI_3' 
SET @Description = N'Mẫu 03 (Màn nhựa lớn)' 
SET @DescriptionE = N'Mẫu 03 (Màn nhựa lớn)' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
----------
SET @OrderNo = 4 
SET @ID = 'SOR2020ReportMECI_4' 
SET @Description = N'Mẫu 04 (Đèn)' 
SET @DescriptionE = N'Mẫu 04 (Đèn)' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled]) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled WHERE CodeMaster = @CodeMaster AND ID = @ID 
END

-- 05/07/2021 - [Đình Ly] - Begin add
-- Bổ sung dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK.
SET @CodeMaster = 'GluingType'
SET @OrderNo = 1
SET @ID = '1' 
SET @Description = N'Dán hông' 
SET @DescriptionE = N'Dán hông' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 2
SET @ID = '2' 
SET @Description = N'Dán khóa đáy' 
SET @DescriptionE = N'Dán khóa đáy' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 3
SET @ID = '3' 
SET @Description = N'Dán 2 mảnh' 
SET @DescriptionE = N'Dán 2 mảnh' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 4
SET @ID = '4' 
SET @Description = N'Dán góc thụt hộp' 
SET @DescriptionE = N'Dán góc thụt hộp' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 5
SET @ID = '5' 
SET @Description = N'Dán suppo' 
SET @DescriptionE = N'Dán suppo' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 6
SET @ID = '6' 
SET @Description = N'Dán ly single' 
SET @DescriptionE = N'Dán ly single' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 7
SET @ID = '7' 
SET @Description = N'Dán ly double wall' 
SET @DescriptionE = N'Dán ly double wall' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 8
SET @ID = '8' 
SET @Description = N'Chạp/Đóng kim' 
SET @DescriptionE = N'Chạp/Đóng kim' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @CodeMaster = 'GluingType'
SET @OrderNo = 9
SET @ID = '9' 
SET @Description = N'Gạt/Đóng cuốn' 
SET @DescriptionE = N'Gạt/Đóng cuốn' 
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm Nhóm dán công đoạn Dán/ĐK'

IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) 
INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) 
VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) 
ELSE 
UPDATE CRMT0099 SET OrderNo=@OrderNo,[Description]=@Description,DescriptionE=@DescriptionE,[Disabled]=@Disabled, CodeMasterName = @CodeMasterName
WHERE CodeMaster = @CodeMaster AND ID = @ID
-- 00/07/2021 - [Đình Ly] - End Add

----------Tấn Lộc - Bổ sung dữ liệu ngầm cho cột TypeOfSource trong màn hình Nguồn dữ liệu online - CRMF2210 ------------------
----------Tấn Lộc - Xóa dữ liệu ngầm của cột TypeOfSource chuyển sang lấy dữ liệu từ màn hình Nguồn đầu mối
DELETE FROM CRMT0099 WHERE CodeMaster = 'CRMF2210.TypeOfSource' 
------------------AT0014.StatusID----------------------------------
SET @CodeMaster = 'AT0014.StatusID' 
SET @OrderNo = 1  
SET @ID = '1' 
SET @Description = N'Đang hoạt động' 
SET @DescriptionE = N'Active' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái thuê bao cloud'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = '2' 
SET @Description = N'Lỗi' 
SET @DescriptionE = N'Error' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái thuê bao cloud'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID
----------
SET @OrderNo = 3  
SET @ID = '3' 
SET @Description = N'Khóa' 
SET @DescriptionE = N'Lock' 
SET @Disabled = 0 
SET @CodeMasterName = N'Trạng thái thuê bao cloud'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID


----Hoài Bảo 04/10/2022 Danh sách mẫu báo cáo thống kê yêu cầu
SET @CodeMaster = 'TemplateReport.CRMF3080'
SET @OrderNo = 1
SET @ID = 'CRMR30801'
SET @Description = N'Thống kê yêu cầu' 
SET @DescriptionE = N'Thống kê yêu cầu'
SET @Disabled = 0 
SET @CodeMasterName = N'Mẫu báo cáo thống kê yêu cầu - CRMF3080'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
--------- 
SET @OrderNo = 2
SET @ID = 'CRMR30801Report'
SET @Description = N'Thống kê yêu cầu theo khách hàng' 
SET @DescriptionE = N'Thống kê yêu cầu theo khách hàng' 
SET @Disabled = 0 
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID

---- Anh Đô 19/12/2022 Bổ sung dữ liệu ngầm cho cột StageType màn hình CRMF1041 - Cập nhật giai đoạn bán hàng ----
SET @CodeMaster = 'CRMT00000020'
SET @OrderNo = 4
SET @ID = '4'
SET @Description = N'Chiến dịch SMS' 
SET @DescriptionE = N'Chiến dịch SMS'
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm cho cột StageType màn hình CRMF1041 - Cập nhật giai đoạn bán hàng'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 

SET @CodeMaster = 'CRMT00000020'
SET @OrderNo = 5
SET @ID = '5'
SET @Description = N'Chiến dịch email' 
SET @DescriptionE = N'Chiến dịch email'
SET @Disabled = 0 
SET @CodeMasterName = N'Dữ liệu ngầm cho cột StageType màn hình CRMF1041 - Cập nhật giai đoạn bán hàng'
IF NOT EXISTS (SELECT TOP 1 1 FROM CRMT0099 WHERE CodeMaster = @CodeMaster AND ID = @ID) INSERT INTO CRMT0099 (CodeMaster, OrderNo, ID, [Description],DescriptionE, [Disabled], CodeMasterName) VALUES (@CodeMaster, @OrderNo, @ID, @Description, @DescriptionE, @Disabled, @CodeMasterName) ELSE UPDATE CRMT0099 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, CodeMasterName = @CodeMasterName WHERE CodeMaster = @CodeMaster AND ID = @ID 
