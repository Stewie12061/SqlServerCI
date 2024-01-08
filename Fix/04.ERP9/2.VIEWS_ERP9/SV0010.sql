IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SV0010]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[SV0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lưu danh sách các nghiệp vụ có xét duyệt, danh sách điều kiện áp dụng khi thiết lập xét duyệt
-- <History>
---- Create on 18/12/2018 Bảo Anh
---- Modified on 22/02/2019 by Như Hàn: Bổ sung Loại yêu cầu mua hàng
---- Modified on 19/03/2019 by Như Hàn: Bổ sung Loại đơn hàng mua
---- Modified on 05/04/2019 by Như Hàn: Bổ sung Loại kế hoạch thu chi
---- Modified on 20/05/2019 by Như Hàn: Bổ sung Loại Ngân sách
---- Modified on 08/06/2020 by Trọng Kiên: Bổ sung các đối tượng:
----									+ Đề nghị tạm ứng / Đề nghị thanh toán / Đề nghị thanh toán tạm ứng (DNTU/DNTT/DNTTTU)
----									+ Đề nghị công tác
----									+ Thanh toán đi lại
----									+ Thời gian công tác
----									+ Báo cáo công tác
----									+ Phiếu dịch chứng từ
---- Modified on 22/12/2020 by Đình Ly: Bổ sung duyệt Thông tin sản xuất (TTSX)
---- Modified on 15/03/2022 by Hoài Bảo: Bổ sung duyệt Yêu cầu nhập - xuất - vận chuyển nội bộ (YCNK - YCXK - YCVCNB)
---- Modified on 24/08/2022 by Đức Tuyên: Bổ sung duyệt Đề nghị chi (DNC)
---- Modified on 24/08/2022 by Thanh Lượng: Bổ sung duyệt Quản lý chất lượng ca (QLCLC)
---  Modified on 12/05/2023 by Thanh Lượng: Bổ sung duyệt chương trình khuyến mãi theo điều kiện(KMTDK).BGSI
---  Modified on 12/05/2023 by Thanh Lượng: Bổ sung duyệt Bảng giá Sell-in(BGSI).
---  Modified on 12/07/2023 by Thanh Lượng: Bổ sung duyệt KH doanh số (Sell In)(KHDSSI).
---  Modified on 25/07/2023 by Thanh Lượng: Bổ sung duyệt KH doanh số (Sell Out)(KHDSSO).
---- Modified on... by...:

CREATE VIEW [dbo].[SV0010] AS
--- Danh sách nghiệp vụ có xét duyệt
--SELECT 'APRList' AS TransactionTypeID, 0 AS Orders, 'DXP' AS TypeID, N'Đơn xin phép' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
--SELECT 'APRList' AS TransactionTypeID, 1 AS Orders, 'DXDC' AS TypeID, N'Đơn xin đổi ca' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
--SELECT 'APRList' AS TransactionTypeID, 2 AS Orders, 'DXLTG' AS TypeID, N'Đơn xin làm thêm giờ' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
--SELECT 'APRList' AS TransactionTypeID, 3 AS Orders, 'DXBSQT' AS TypeID, N'Đơn xin bổ sung quẹt thẻ' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
--SELECT 'APRList' AS TransactionTypeID, 4 AS Orders, 'DXRN' AS TypeID, N'Đơn xin ra ngoài' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
--SELECT 'APRList' AS TransactionTypeID, 5 AS Orders, 'BPC' AS TypeID, N'Bảng phân ca' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--UNION ALL
SELECT 'APRList' AS TransactionTypeID, 6 AS Orders, 'KHTD' AS TypeID, N'Kế hoạch tuyển dụng' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 7 AS Orders, 'QDTD' AS TypeID, N'Quyết định tuyển dụng' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 7 AS Orders, 'BPC' AS TypeID, N'Bảng phân ca' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 8 AS Orders, 'YCMH' AS TypeID, N'Yêu cầu mua hàng' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 9 AS Orders, 'DHM' AS TypeID, N'Đơn hàng mua' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 10 AS Orders, 'KHTC' AS TypeID, N'Kế hoạch thu chi' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 11 AS Orders, 'NS' AS TypeID, N'Ngân sách' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 13 AS Orders, 'PBG' AS TypeID, N'Phiếu báo giá' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 14 AS Orders, 'DMDA' AS TypeID, N'Định mức dự án' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 15 AS Orders, 'BGNCC' AS TypeID, N'Báo giá nhà cung cấp' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 16 AS Orders, 'DHB' AS TypeID, N'Đơn hàng bán' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListDTI' AS TransactionTypeID, 17 AS Orders, 'PBGKHCU' AS TypeID, N'Phiếu báo giá (KHCU)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListDTI' AS TransactionTypeID, 18 AS Orders, 'PBGNC' AS TypeID, N'Phiếu báo giá (NC)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListDTI' AS TransactionTypeID, 19 AS Orders, 'PBGSALE' AS TypeID, N'Phiếu báo giá (Sale)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListMTH' AS TransactionTypeID, 20 AS Orders, 'DHDC' AS TypeID, N'Đơn hàng điều chỉnh' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListMTH' AS TransactionTypeID, 21 AS Orders, 'DT' AS TypeID, N'Dự toán' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListDTI' AS TransactionTypeID, 22 AS Orders, 'CH' AS TypeID, N'Cơ hội' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 23 AS Orders, 'PDN' AS TypeID, N'DNTU/DNTT/DNTTTU' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 24 AS Orders, 'DNCT' AS TypeID, N'Đề nghị công tác' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 24 AS Orders, 'DTCP' AS TypeID, N'Dự trù chi phí' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
-- UNION ALL
-- SELECT 'APRList' AS TransactionTypeID, 25 AS Orders, 'TTDL' AS TypeID, N'Thanh toán đi lại' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
-- UNION ALL
-- SELECT 'APRList' AS TransactionTypeID, 26 AS Orders, 'TGCT' AS TypeID, N'Thời gian công tác' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
-- UNION ALL
-- SELECT 'APRList' AS TransactionTypeID, 27 AS Orders, 'BCCT' AS TypeID, N'Báo cáo công tác' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
-- UNION ALL
-- SELECT 'APRList' AS TransactionTypeID, 28 AS Orders, 'DCT' AS TypeID, N'Phiếu dịch chứng từ' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName

--UNION ALL
--SELECT 8 AS Orders, 'KHTC' AS TypeID, N'Kế hoạch thu/chi' AS Description
--UNION ALL
--SELECT 9 AS Orders, 'NS' AS TypeID, N'Ngân sách' AS Description

--- Danh sách điều kiện áp dụng khi xét duyệt
UNION ALL
SELECT 'CONDList' AS TransactionTypeID, 0 AS Orders, 'LP' AS TypeID, N'Loại phép' AS Description, 'OOT1000' AS TableID, 'AbsentTypeID' AS ColumnID, 'Description' AS ColumnName
UNION ALL
SELECT 'CONDList' AS TransactionTypeID, 1 AS Orders, 'CLV' AS TypeID, N'Ca làm việc' AS Description, 'HT1020' AS TableID, 'ShiftID' AS ColumnID, 'ShiftName' AS ColumnName
UNION ALL
SELECT 'CONDList' AS TransactionTypeID, 2 AS Orders, 'PB' AS TypeID, N'Phòng ban' AS Description, 'AT1102' AS TableID, 'DepartmentID' AS ColumnID, 'DepartmentName' AS ColumnName

--- Danh sách TypeID không xét duyệt hoàng loạt
UNION ALL
SELECT 'LockTypeID' AS TransactionTypeID, 1 AS Orders, 'YCMH' AS TypeID, N'Yêu cầu mua hàng' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'LockTypeID' AS TransactionTypeID, 2 AS Orders, 'DHM' AS TypeID, N'Đơn hàng mua' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'LockTypeID' AS TransactionTypeID, 3 AS Orders, 'KHTC' AS TypeID, N'Kế hoạch thu chi' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRListMTH' AS TransactionTypeID, 3 AS Orders, 'TTSX' AS TypeID, N'Thông tin sản xuất' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName


--- ĐÌnh Hòa[21/06/2021] : Bổ sung bảng xét duyệt tính giá
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 25 AS Orders, 'BTG' AS TypeID, N'Bảng tính giá' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName

--- ĐÌnh Hòa[03/08/2021] : Bổ sung bảng xét phiếu báo giá (Bộ phận kinh doanh) - (SGNP)
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 25 AS Orders, 'PBGKD' AS TypeID, N'Phiếu báo giá Sale' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName

--- Kiều Nga[10/08/2021] : Bổ sung duyệt phương án kinh doanh
UNION ALL	
SELECT 'APRList' AS TransactionTypeID, 26 AS Orders, 'PAKD' AS TypeID, N'Phương án kinh doanh' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName

--- Kiều Nga[15/03/2022] : Bổ sung duyệt Yêu cầu nhập - xuất - vận chuyển nội bộ (YCNK - YCXK - YCVCNB)
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 27 AS Orders, 'YCNK' AS TypeID, N'Yêu cầu nhập kho' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 28 AS Orders, 'YCXK' AS TypeID, N'Yêu cầu xuất kho' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 29 AS Orders, 'YCVCNB' AS TypeID, N'Yêu cầu vận chuyển nội bộ' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName

--- Đức Tuyên [24/08/2022] : Bổ sung duyệt Đề nghị chi (DNC)
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 30 AS Orders, 'DNT' AS TypeID, N'Đề nghị thu' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 31 AS Orders, 'DNC' AS TypeID, N'Đề nghị chi' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Thanh Lượng [05/04/2023] : Bổ sung duyệt Quản lý chất lượng ca (QLCLC)
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 32 AS Orders, 'QLCLC' AS TypeID, N'Quản lý chất lượng ca' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Thanh Lượng [12/05/2023] : Bổ sung duyệt chương trình khuyến mãi theo điều kiện(KMTDK).
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 33 AS Orders, 'KMTDK' AS TypeID, N'Chương trình khuyến mãi theo điều kiện' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Thanh Lượng [29/06/2023] : Bổ sung duyệt Bảng giá SELL-IN(BGSI).
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 34 AS Orders, 'BGSI' AS TypeID, N'Bảng giá (Sell in)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Thanh Lượng [12/07/2023] : Bổ sung duyệt KH doanh số (Sell In)(KHDSSI).
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 35 AS Orders, 'KHDSSI' AS TypeID, N'Kế hạch doanh số (Sell in)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Thanh Lượng [25/07/2023] : Bổ sung duyệt KH doanh số (Sell OUT)(KHDSSO).
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 36 AS Orders, 'KHDSSO' AS TypeID, N'Kế hạch doanh số (Sell Out)' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
--- Phương Thảo [24/10/2023] : Bổ sung duyệt Kết quả thử việc (KQTV).
UNION ALL
SELECT 'APRList' AS TransactionTypeID, 37 AS Orders, 'KQTV' AS TypeID, N'Kết quả thử việc' AS Description, NULL AS TableID, NULL AS ColumnID, NULL AS ColumnName
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

