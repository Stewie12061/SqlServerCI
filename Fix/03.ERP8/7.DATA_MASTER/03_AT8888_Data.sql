-- <Summary>
---- Add Report
-- <History>
---- Create on 05/07/2012 by Bảo Anh
---- Modified on 07/10/2014 by Lê Thị Hạnh
---- Modified on 22/04/2015 by Lê Thị Hạnh: Bổ sung IN PHIẾU GIAO HÀNG [LAVO] 
---- Modified on 29/07/2013 by Lê Thị Thu Hiền: Báo cáo có bổ sung thêm trường 
---- Modified on 29/07/2013 by Lê Thị Thu Hiền: Mẫu AR7602.rpt là mẫu dùng để In Thiết lập báo cáo chứ không phải dùng để In Báo cáo thiết lập. 
---- Modified on 23/04/2013 by Le Thi Thu Hien 
---- Modified on 10/10/2012 by Lê Thị Thu Hiền: Không WHERE đơn vị nữa vì In nhiều đơn vị
---- Modified on 05/11/2015 by Tiểu Mai: Bổ sung thêm mẫu report AR7010.
---- Modified on 10/11/2015 by Phương Thảo: Bổ sung thêm mẫu report AR0295 - Thuế nhà thầu.
---- Modified on 10/11/2015 by Phương Thảo: Bổ sung thêm mẫu report AR0295 - Thuế nhà thầu.
---- Modified on 22/02/2016 by Kim Vu: Bổ sung Type = 5 thẻ TSCĐ trong GroupID = 02
---- Modified on 22/02/2016 by Hoang Vu: BO sung Customize hoang trần báo cáo chi tiết công nợ phái trả phãi thu
---- Modified by Phương Thảo on 01/06/2016 : Add AR03132, AR03142: Tình hình thanh toán công nợ phải thu (Phát sinh giảm)
---- Modified on 25/07/2016 by Hoang Vu: Bo sung Customize Secoin báo cáo phân tích chỉ số tài chính
---- Modified on 04/12/2018 by Kim Thư: Bổ sung mẫu Phiếu trả hàng - AR3039 - AR3040
---- Modified on 19/09/2023 by Đức Tuyên: Mở báo cáo phân tích chỉ số tài chính cho INNOTEK
---- Modified on 23/11/2023 by Hoàng Long: Bổ sung báo cáo chi tiết số lượng hàng bán.
---- <Example>

DECLARE @CustomerName INT

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
---- Add AR2016
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'AR2016', @ReportName = N'Mẫu 1',
	 @ReportNameE = N'Form 1', @ReportTitle = N'Phiếu nhập kho', @ReportTitleE = N'Receiving voucher',
	 @Description = N'NHẬP KHO', @DescriptionE = N'RECEIVING', @Type = 26, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR6013
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR6013', @ReportName = N'Báo cáo tổng hợp theo mã phân tích',
	 @ReportNameE = N'General report by analysis code', @ReportTitle = N'BÁO CÁO TỔNG HỢP THEO MÃ PHÂN TÍCH', 
	 @ReportTitleE = N'GENERAL REPORT BY ANALYSIS CODE', @Description = N'BÁO CÁO TỔNG HỢP THEO MÃ PHÂN TÍCH', 
	 @DescriptionE = N'GENERAL REPORT BY ANALYSIS CODE', @Type = 99, @SQLstring = N'', @Orderby = N'Order by AnaID, VoucherDate, VoucherNo',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0287
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0287', @ReportName = N'Báo cáo so sánh giá các nhà cung cấp',
	 @ReportNameE = N'Price compare of suppliers', @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ CÁC NHÀ CUNG CẤP', 
	 @ReportTitleE = N'PRICE COMPARE OF SUPPLIERS', @Description = N'BÁO CÁO SO SÁNH GIÁ CÁC NHÀ CUNG CẤP', 
	 @DescriptionE = N'PRICE COMPARE OF SUPPLIERS', @Type = 31, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0288
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0288', @ReportName = N'Báo cáo so sánh giá theo hóa đơn',
	 @ReportNameE = N'Price compare of invoice', @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ THEO HÓA ĐƠN', 
	 @ReportTitleE = N'PRICE COMPARE OF INVOICE', @Description = N'BÁO CÁO SO SÁNH GIÁ THEO HÓA ĐƠN', 
	 @DescriptionE = N'PRICE COMPARE OF INVOICE', @Type = 32, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add WR20272
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20272', @ReportName = N'Mẫu 4',
	 @ReportNameE = N'FORM 4', @ReportTitle = N'FORM 4', 
	 @ReportTitleE = N'FORM 4', @Description = N'XUẤT KHO', 
	 @DescriptionE = N'DELIVERING', @Type = 27, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add WR20271
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20271', @ReportName = N'Mẫu 3',
	 @ReportNameE = N'FORM 3', @ReportTitle = N'FORM 3', 
	 @ReportTitleE = N'FORM 3', @Description = N'XUẤT KHO', 
	 @DescriptionE = N'DELIVERING', @Type = 27, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0310A
EXEC AP8888 @GroupID = N'G03', @ModuleID = 'ASoftT', @ReportID = N'AR0310A', @ReportName = N'Báo cáo chi tiết tình hình thanh toán',
	 @ReportNameE = N'The report details of payment situation', @ReportTitle = N'BÁO CÁO CHI TIẾT TÌNH HÌNH THANH TOÁN', 
	 @ReportTitleE = N'THE REPORT DETAILS OF PAYMENT SITUATION', @Description = N'BÁO CÁO CHI TIẾT TÌNH HÌNH THANH TOÁN', 
	 @DescriptionE = N'THE REPORT DETAILS OF PAYMENT SITUATION', @Type = 3, 
	 @SQLstring = N'Select * From AV0310  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N'Order by GroupID, VoucherDate, VoucherNo, TransactionTypeID,Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR1020 (mẫu cũ)
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR1020', @ReportName = N'Thông tin hợp đồng',
	 @ReportNameE = N'Contract information', @ReportTitle = N'THÔNG TIN HỢP ĐỒNG', 
	 @ReportTitleE = N'CONTRACT INFORMATION', @Description = N'Thông tin hợp đồng', 
	 @DescriptionE = N'Contract information', @Type = 120, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR1020_A
IF @CustomerName = 20 --- Customize Sinolife
BEGIN
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR1020_A', @ReportName = N'Hợp đồng chuyển nhượng',
	 @ReportNameE = N'Transfer contract', @ReportTitle = N'HỢP ĐỒNG CHUYỂN NHƯỢNG', 
	 @ReportTitleE = N'TRANSFER CONTRACT', @Description = N'Hợp đồng chuyển nhượng', 
	 @DescriptionE = N'Transfer contract', @Type = 120, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR1020_B
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR1020_B', @ReportName = N'Bảng thanh toán hàng tháng',
	 @ReportNameE = N'Monthly payment sheet', @ReportTitle = N'MONTHLY PAYMENT SHEET', 
	 @ReportTitleE = N'MONTHLY PAYMENT SHEET', @Description = N'Monthly payment sheet', 
	 @DescriptionE = N'Monthly payment sheet', @Type = 120, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'	
END
---- Add WR20262
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20262', @ReportName = N'Mẫu 4',
	 @ReportNameE = N'Form 4', @ReportTitle = N'Form 4', @ReportTitleE = N'Form 4', @Description = N'NHẬP KHO', 
	 @DescriptionE = N'RECEIVING', @Type = 26, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3032B
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3032B', @ReportName = N'Báo cáo hàng bán trả lại (nhóm theo khu vực - đối tượng)',
	 @ReportNameE = N'Return Goods Group by Area - Object', @ReportTitle = N'BÁO CÁO HÀNG BÁN TRẢ LẠI', @ReportTitleE = N'RETURN GOODS', @Description = N'Báo cáo hàng bán trả lại (nhóm theo khu vực - đối tượng)', 
	 @DescriptionE = N'Return Goods Group by Area - Object', @Type = 12, @SQLstring = N'Select * From AV3052  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by S2, ObjectID, VoucherDate, VoucherNo, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR7002
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'AR7002', @ReportName = N'Báo cáo chi tiết nhập xuất tồn theo mặt hàng',
	 @ReportNameE = N'General report of receiving - delivering - remaining', @ReportTitle = N'BÁO CÁO CHI TIẾT NHẬP XUẤT TỒN THEO MẶT HÀNG', @ReportTitleE = N'RETURN GOODS', @Description = N'REPORT OF RECEIVING - DELIVERING - REMAINING', 
	 @DescriptionE = N'REPORT OF RECEIVING - DELIVERING - REMAINING ACCORDING', @Type = 39, @SQLstring = N'Select * from AV2009 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by InventoryID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0249
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'ASoftT', @ReportID = N'AR0249', @ReportName = N'Báo cáo theo dõi tình hình xuất hóa đơn',
	 @ReportNameE = N'Report situation invoice', @ReportTitle = N'BÁO CÁO THEO DÕI TÌNH HÌNH XUẤT HÓA ĐƠN', @ReportTitleE = N'REPORT SITUATION INVOICE',
	 @Description = N'Báo cáo theo dõi tình hình xuất hóa đơn', @DescriptionE = N'Report situation invoice', @Type = 3, 
	 @SQLstring = N'SELECT * FROM AV0249 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'ORDER BY DivisionID, VoucherDate, VoucherNo, OrderID, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add WR20261
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20261', @ReportName = N'Mẫu 3',
	 @ReportNameE = N'FORM 3', @ReportTitle = N'FORM 3', @ReportTitleE = N'FORM 3',
	 @Description = N'NHẬP KHO', @DescriptionE = N'RECEIVING', @Type = 26, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0310B
EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0310B', @ReportName = N'Bảng kê đối chiếu công nợ theo tuổi nợ',
	 @ReportNameE = N'List of compare debt by age', @ReportTitle = N'BẢNG KÊ ĐỐI CHIẾU CÔNG NỢ THEO TUỔI NỢ', @ReportTitleE = N'LIST OF COMPARE DEBT BY AGE',
	 @Description = N'BẢNG KÊ ĐỐI CHIẾU CÔNG NỢ THEO TUỔI NỢ', @DescriptionE = N'LIST OF COMPARE DEBT BY AGE', @Type = 15, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0290
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0290', @ReportName = N'Doanh thu theo thời gian (so sánh kỳ này - kỳ trước)',
	 @ReportNameE = N'Sales in times (compare this period with last period)', @ReportTitle = N'BÁO CÁO DOANH THU THEO THỜI GIAN', @ReportTitleE = N'SALES IN TIMES',
	 @Description = N'DOANH THU THEO THỜI GIAN (SO SÁNH KỲ NÀY - KỲ TRƯỚC)', @DescriptionE = N'SALES IN TIMES (COMPARE THIS PERIOD - LAST PERIOD)', @Type = 34, @SQLstring = N'', @Orderby = N'Order by InventoryID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0291
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0291', @ReportName = N'Doanh thu theo thời gian (so sánh nhiều kỳ)',
	 @ReportNameE = N'Sales in times (compare many periods)', @ReportTitle = N'BÁO CÁO DOANH THU THEO THỜI GIAN', @ReportTitleE = N'SALES IN TIMES',
	 @Description = N'DOANH THU THEO THỜI GIAN (SO SÁNH NHIỀU KỲ)', @DescriptionE = N'SALES IN TIMES (COMPARE MANY PERIODS)', @Type = 35, @SQLstring = N'', @Orderby = N'Order by InventoryID,MonthYear',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0292
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0292', @ReportName = N'Doanh thu theo thời gian (so sánh nhiều kỳ, nhóm theo loại hàng)',
	 @ReportNameE = N'Sales in times (compare many periods, group by inventory type)', @ReportTitle = N'BÁO CÁO DOANH THU THEO THỜI GIAN', @ReportTitleE = N'SALES IN TIMES',
	 @Description = N'DOANH THU THEO THỜI GIAN (SO SÁNH NHIỀU KỲ, NHÓM THEO LOẠI HÀNG)', @DescriptionE = N'SALES IN TIMES (COMPARE MANY PERIODS, GROUP BY INVENTORY TYPE)', @Type = 35, @SQLstring = N'', @Orderby = N'Order by InventoryTypeID,InventoryID,MonthYear',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0293
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0293', @ReportName = N'Doanh thu theo thời gian (phân tích theo mặt hàng)',
	 @ReportNameE = N'Sales in times (lost & profit by inventory)', @ReportTitle = N'PHÂN TÍCH DOANH THU THEO MẶT HÀNG', @ReportTitleE = N'LOST & PROFIT BY INVENTORY',
	 @Description = N'DOANH THU THEO THỜI GIAN (PHÂN TÍCH THEO MẶT HÀNG)', @DescriptionE = N'SALES IN TIMES (LOST & PROFIT BY INVENTORY)', 
	 @Type = 36, @SQLstring = N'', @Orderby = N'Order by InventoryID',
	 @TEST = 0, @TableID = N'AT8888'
----AR0258A: Mẫu 1 - PHIẾU THU QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR0258A', @ReportName = N'Phiếu thu qua ngân hàng (Mẫu 1)',
	 @ReportNameE = N'Receipts through banks (From 1)', @ReportTitle = N'PHIẾU THU QUA NGÂN HÀNG', @ReportTitleE = N'RECEIPTS THROUGH BANKS',
	 @Description = N'Phiếu thu qua ngân hàng (Mẫu 1)', @DescriptionE = N'Receipts through banks (From 1)', 
	 @Type = 4, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0258C: Mẫu 3 - PHIẾU KẾ TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR0258C', @ReportName = N'Phiếu kế toán',
	 @ReportNameE = N'Voucher Accounting', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'Voucher Accounting',
	 @Description = N'Phiếu kế toán', @DescriptionE = N'Voucher Accounting', 
	 @Type = 4, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3501: Mẫu 1 - ỦY NHIỆM CHI
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3501', 
	 @ReportName = N'Ủy nhiệm chi', @ReportNameE = N'Authoridez Payment', 
	 @ReportTitle = N'ỦY NHIỆM CHI', @ReportTitleE = N'AUTHORIZED PAYMENT',
	 @Description = N'Ủy nhiệm chi', @DescriptionE = N'Authoridez Payment', 
	 @Type = 5, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3502: Mẫu 2 - PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3502', 
	 @ReportName = N'Phiếu chi qua ngân hàng', @ReportNameE = N'Payment through banks', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu chi qua ngân hàng', @DescriptionE = N'Payment through banks', 
	 @Type = 5, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3503: Mẫu 3 - PHIẾU KẾ TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3503', 
	 @ReportName = N'Phiếu kế toán', @ReportNameE = N'Voucher Accounting', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'VOUCHER ACCOUNTING',
	 @Description = N'Phiếu kế toán', @DescriptionE = N'Voucher Accounting', 
	 @Type = 5, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR8001: DANH SÁCH PHIẾU THU QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR8001', 
	 @ReportName = N'Danh sách phiếu thu', @ReportNameE = N'Receipts list', 
	 @ReportTitle = N'PHIẾU THU QUA NGÂN HÀNG', @ReportTitleE = N'RECEIPTS THROUGH BANKS',
	 @Description = N'Danh sách phiếu thu', @DescriptionE = N'Receipts list', 
	 @Type = 9, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR8002: DANH SÁCH PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR8002', 
	 @ReportName = N'Danh sách phiếu chi', @ReportNameE = N'Payment list', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Danh sách phiếu chi', @DescriptionE = N'Payment list', 
	 @Type = 9, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888' 
---- Add AR3043: Mẫu 1 - PHIẾU THU QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3043', 
	 @ReportName = N'Phiếu thu qua ngân hàng (Mẫu 1)', @ReportNameE = N'Receipts through banks (From 1)', 
	 @ReportTitle = N'PHIẾU THU QUA NGÂN HÀNG', @ReportTitleE = N'RECEIPTS THROUGH BANKS',
	 @Description = N'Phiếu thu qua ngân hàng (Mẫu 1)', @DescriptionE = N'Receipts through banks (From 1)', 
	 @Type = 6, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888' 
---- Add AR3053: Mẫu 2 - PHIẾU THU QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3053', 
	 @ReportName = N'Phiếu thu qua ngân hàng (Mẫu 2)', @ReportNameE = N'Receipts through banks (From 2)', 
	 @ReportTitle = N'PHIẾU THU QUA NGÂN HÀNG', @ReportTitleE = N'RECEIPTS THROUGH BANKS',
	 @Description = N'Phiếu thu qua ngân hàng (Mẫu 2)', @DescriptionE = N'Receipts through banks (From 2)', 
	 @Type = 6, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3073: Mẫu 3 - PHIẾU KẾ TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3073', 
	 @ReportName = N'Phiếu kế toán', @ReportNameE = N'Voucher Accounting', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'VOUCHER ACCOUNTING',
	 @Description = N'Phiếu kế toán', @DescriptionE = N'Voucher Accounting', 
	 @Type = 6, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3046: Mẫu 1 - ỦY NHIỆM CHI
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3046', 
	 @ReportName = N'Ủy nhiệm chi', @ReportNameE = N'Authoridez Payment', 
	 @ReportTitle = N'ỦY NHIỆM CHI', @ReportTitleE = N'AUTHORIZED PAYMENT',
	 @Description = N'Ủy nhiệm chi', @DescriptionE = N'Authoridez Payment', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3047: Mẫu 2 - PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3047', 
	 @ReportName = N'Phiếu chi qua ngân hàng (Mẫu 2)', @ReportNameE = N'Payment through banks (Form 2)', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu chi qua ngân hàng (Mẫu 2)', @DescriptionE = N'Payment through banks (Form 2)', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3048: Mẫu 3 - PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3048', 
	 @ReportName = N'Phiếu chi qua ngân hàng (Mẫu 3)', @ReportNameE = N'Payment through banks (Form 3)', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu chi qua ngân hàng (Mẫu 3)', @DescriptionE = N'Payment through banks (Form 3)', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3049: Mẫu 4 - PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3049', 
	 @ReportName = N'Phiếu chi qua ngân hàng (Mẫu 4)', @ReportNameE = N'Payment through banks (Form 4)', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu chi qua ngân hàng (Mẫu 4)', @DescriptionE = N'Payment through banks (Form 4)', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3050: Mẫu 5 - PHIẾU CHI QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3050', 
	 @ReportName = N'Phiếu chi qua ngân hàng (Mẫu 5)', @ReportNameE = N'Payment through banks (Form 5)', 
	 @ReportTitle = N'PHIẾU CHI QUA NGÂN HÀNG', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu chi qua ngân hàng (Mẫu 5)', @DescriptionE = N'Payment through banks (Form 5)', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3075: Mẫu 6 - PHIẾU KẾ TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3075', 
	 @ReportName = N'Phiếu kế toán', @ReportNameE = N'Voucher Accounting', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'PAYMENT THROUGH BANKS',
	 @Description = N'Phiếu kế toán', @DescriptionE = N'Voucher Accounting', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'	
---- Add AR3113: Mẫu 1 - PHIẾU CHUYỂN KHOẢN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3113', 
	 @ReportName = N'Phiếu chuyển khoản', @ReportNameE = N'Slip transfer', 
	 @ReportTitle = N'PHIẾU CHUYỂN KHOẢN', @ReportTitleE = N'SLIP TRANSFER',
	 @Description = N'Phiếu chuyển khoản', @DescriptionE = N'Slip transfer', 
	 @Type = 8, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3113: AR3115: Mẫu 2 - PHIẾU KẾ TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3115', 
	 @ReportName = N'Phiếu kế toán', @ReportNameE = N'Voucher Accounting', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'VOUCHER ACCOUNTING',
	 @Description = N'Phiếu kế toán', @DescriptionE = N'Voucher Accounting', 
	 @Type = 8, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
--[Đức Tuyên] on [03/01/2023]
IF @CustomerName = 158 --- Khách hàng HIPC
BEGIN
	---- Mẫu 1 - IN THEO 3 MẪU (Thu-Chi)
	---- Add AR3011: Mẫu 1 - THU
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3011', 
		 @ReportName = N'Mẫu báo cáo 1 - AR3011', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 1 (THU)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
	---- Add AR3012: Mẫu 1 - CHI
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3012', 
		 @ReportName = N'Mẫu báo cáo 1 - AR3012', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 1 (CHI)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'

	---- Add AR3051: Mẫu 2 - THU
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3051', 
		 @ReportName = N'Mẫu báo cáo 2 - AR3051', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 2 (THU)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
	---- Add AR3052: Mẫu 2 - CHI
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3052', 
		 @ReportName = N'Mẫu báo cáo 2 - AR3052', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 2 (CHI)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'

	---- Add AR3041: Mẫu 3 - THU
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3041', 
		 @ReportName = N'Mẫu báo cáo 3 - AR3041', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 3 (THU)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
	---- Add AR3042: Mẫu 3 - CHI
	EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3042', 
		 @ReportName = N'Mẫu báo cáo 3 - AR3042', @ReportNameE = N'Slip transfer', 
		 @ReportTitle = N'Mẫu báo cáo 3 (CHI)', @ReportTitleE = N'SLIP TRANSFER',
		 @Description = N'IN THEO 3 MẪU (Thu-Chi)', @DescriptionE = N'Slip transfer', 
		 @Type = 13, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
END
--[Đức Tuyên] on [03/01/2023]
---- Add WR2027
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR2027', 
	 @ReportName = N'Mẫu 2', @ReportNameE = N'Form 2', 
	 @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'ACCOUNTING VOUCHER',
	 @Description = N'XUẤT KHO', @DescriptionE = N'DELIVERING', 
	 @Type = 27, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR7624
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftWM', @ReportID = N'AR7624', 
	 @ReportName = N'Báo cáo kết quả kinh doanh theo ngân sách', @ReportNameE = N'Business result according to budget', 
	 @ReportTitle = N'KẾT QUẢ KINH DOANH THEO NGÂN SÁCH', @ReportTitleE = N'BUSINESS RESULT ACCORDING TO BUDGET',
	 @Description = N'KẾT QUẢ KINH DOANH THEO NGÂN SÁCH', @DescriptionE = N'BUSINESS RESULT ACCORDING TO BUDGET', 
	 @Type = 54, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add WR2026
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR2026', 
	 @ReportName = N'Mẫu 2', @ReportNameE = N'Form 2', 
	 @ReportTitle = N'Phiếu kế toán', @ReportTitleE = N'Accounting voucher',
	 @Description = N'NHẬP KHO', @DescriptionE = N'RECEIVING', 
	 @Type = 26, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0294
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR0294', 
	 @ReportName = N'TỜ KHAI THUẾ BẢO VỆ MÔI TRƯỜNG', @ReportNameE = N'Environment Protection Commitment', 
	 @ReportTitle = N'TỜ KHAI THUẾ BẢO VỆ MÔI TRƯỜNG', @ReportTitleE = N'ENVIRONMENT PROTECTION COMMITMENT',
	 @Description = N'TỜ KHAI THUẾ BẢO VỆ MÔI TRƯỜNG', @DescriptionE = N'ENVIRONMENT PROTECTION COMMITMENT', 
	 @Type = 12, @SQLstring = N'', @Orderby = N'ORDER BY IID, UnitID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR7614
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR7614', 
	 @ReportName = N'Báo cáo kết quả kinh doanh nhiều kỳ', @ReportNameE = N'PROFIT & LOSS BY PERIODS', 
	 @ReportTitle = N'BÁO CÁO KẾT QUẢ KINH DOANH NHIỀU KỲ', @ReportTitleE = N'PROFIT & LOSS BY PERIODS',
	 @Description = N'BÁO CÁO KẾT QUẢ KINH DOANH NHIỀU KỲ', @DescriptionE = N'PROFIT & LOSS BY PERIODS', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'ORDER BY PrintCode, MonthYear',
	 @TEST = 0, @TableID = N'AT8888'	
---- Add AR7617
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR7617', 
	 @ReportName = N'BÁO CÁO KẾT QUẢ KINH DOANH NHIỀU KỲ (CÓ BIỂU ĐỒ)', @ReportNameE = N'PROFIT & LOSS BY PERIODS (WITH CHARTS)', 
	 @ReportTitle = N'BÁO CÁO KẾT QUẢ KINH DOANH NHIỀU KỲ (CÓ BIỂU ĐỒ)', @ReportTitleE = N'PROFIT & LOSS BY PERIODS (WITH CHARTS)',
	 @Description = N'BÁO CÁO KẾT QUẢ KINH DOANH NHIỀU KỲ (CÓ BIỂU ĐỒ)', @DescriptionE = N'PROFIT & LOSS BY PERIODS (WITH CHARTS)', 
	 @Type = 7, @SQLstring = N'', @Orderby = N'ORDER BY TypeID, PrintCode, MonthYear',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0601A
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0601A', 
	 @ReportName = N'Báo cáo chi tiết mua hàng', @ReportNameE = N'The report details purchase', 
	 @ReportTitle = N'BÁO CÁO CHI TIẾT MUA HÀNG', @ReportTitleE = N'THE REPORT DETAILS PURCHASE',
	 @Description = N'BÁO CÁO CHI TIẾT MUA HÀNG', @DescriptionE = N'THE REPORT DETAILS PURCHASE', 
	 @Type = 4, @SQLstring = N'Select * From AV0601  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by Group1ID,VoucherNo',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0255
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'ASoftT', @ReportID = N'AR0255', 
	 @ReportName = N'Báo cáo theo dõi chi tiết đơn hàng', @ReportNameE = N'Orders Status Report', 
	 @ReportTitle = N'BÁO CÁO THEO DÕI CHI TIẾT ĐƠN HÀNG', @ReportTitleE = N'ORDERS STATUS REPORT',
	 @Description = N'BÁO CÁO THEO DÕI CHI TIẾT ĐƠN HÀNG', @DescriptionE = N'ORDERS STATUS REPORT', 
	 @Type = 113, @SQLstring = N'SELECT * FROM AV0255', @Orderby = N'ORDER BY DivisionID, OrderDate, SOrderID, GroupID',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR2017
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftT', @ReportID = N'AR2017', 
	 @ReportName = N'Mẫu 1', @ReportNameE = N'Form 1', 
	 @ReportTitle = N'PHIẾU XUẤT KHO', @ReportTitleE = N'DELIVERING VOUCHER',
	 @Description = N'XUẤT KHO', @DescriptionE = N'DELIVERING', 
	 @Type = 27, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR3022A
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3022A', 
	 @ReportName = N'Báo cáo chi tiết bán hàng', @ReportNameE = N'The report detail sales', 
	 @ReportTitle = N'BÁO CÁO CHI TIẾT BÁN HÀNG', @ReportTitleE = N'THE REPORT DETAIL SALES',
	 @Description = N'BÁO CÁO CHI TIẾT BÁN HÀNG', @DescriptionE = N'THE REPORT DETAIL SALES', 
	 @Type = 1, @SQLstring = N'Select * From AV3025  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by ObjectID,InventoryID',
	 @TEST = 0, @TableID = N'AT8888'	 
----Add AR0258B: Mẫu 2 - PHIẾU THU QUA NGÂN HÀNG
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR0258B', 
     @ReportName = N'Phiếu thu qua ngân hàng (Mẫu 2)', @ReportNameE = N'Receipts through banks (From 2)', 
     @ReportTitle = N'PHIẾU THU QUA NGÂN HÀNG', @ReportTitleE = N'RECEIPTS THROUGH BANKS',
	 @Description = N'Phiếu thu qua ngân hàng (Mẫu 2)', @DescriptionE = N'Receipts through banks (From 2)', 
	 @Type = 4, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'	 
----Add AR3032A
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR3032A', 
     @ReportName = N'Báo cáo hàng bán trả lại (nhóm theo đối tượng)', @ReportNameE = N'Return Goods Group by Object', 
     @ReportTitle = N'BÁO CÁO HÀNG BÁN TRẢ LẠI', @ReportTitleE = N'RETURN GOODS',
	 @Description = N'Báo cáo hàng bán trả lại (nhóm theo đối tượng)', @DescriptionE = N'Return Goods Group by Object', 
	 @Type = 12, @SQLstring = N'Select * From AV3052  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by ObjectID, VoucherDate, VoucherNo, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'	
----Add WR0012
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR0012', 
     @ReportName = N'Phiếu giao hàng', @ReportNameE = N'Delivery Note', 
     @ReportTitle = N'PHIẾU GIAO HÀNG', @ReportTitleE = N'DELIVERY NOTE',
	 @Description = N'PHIẾU GIAO HÀNG', @DescriptionE = N'DELIVERY NOTE', 
	 @Type = 27, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
---- Add AR0289
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR0289', 
	 @ReportName = N'Báo cáo so sánh giá mua nhiều kỳ', @ReportNameE = N'Price compare of periods', 
	 @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ NHIỀU KỲ', @ReportTitleE = N'PRICE COMPARE OF PERIODS', 
	 @Description = N'BÁO CÁO SO SÁNH GIÁ NHIỀU KỲ', @DescriptionE = N'PRICE COMPARE OF PERIODS', 
	 @Type = 33, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'
	 
---- Add AR7010
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'AR7010', @ReportName = N'Báo cáo nhập xuất tồn theo quy cách hàng hóa',
	 @ReportNameE = N'General report of receiving - delivering - remaining', @ReportTitle = N'BÁO CÁO CHI TIẾT NHẬP XUẤT TỒN THEO QUY CÁCH HÀNG HÓA', @ReportTitleE = N'RETURN GOODS', @Description = N'REPORT OF RECEIVING - DELIVERING - REMAINING', 
	 @DescriptionE = N'REPORT OF RECEIVING - DELIVERING - REMAINING ACCORDING', @Type = 97, @SQLstring = N'Select * from AV2009 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order by InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0295: Thuế nhà thầu
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR0295', @ReportName = N'Tờ khai nộp Thuế nhà thầu',
	 @ReportNameE = N'Withhoding Tax Commitment', @ReportTitle = N'TỜ KHAI NỘP THUẾ NHÀ THẦU', @ReportTitleE = N'WITHHOLDING TAX COMMITMENT', @Description = N'WITHHOLDING TAX COMMITMENT', 
	 @DescriptionE = N'WITHHOLDING TAX COMMITMENT', @Type = 34, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Modified by Phương Thảo on 01/06/2016 : ---- Add AR03132, AR03142: Tình hình thanh toán công nợ phải thu (Phát sinh giảm)
EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR03132', @ReportName = N'Tình hình thanh toán (A4L)',
	 @ReportNameE = N'Payment situation (A4L)', @ReportTitle = N'CHI TIẾT TÌNH HÌNH THANH TOÁN (PHÁT SINH GIẢM CÔNG NỢ)', @ReportTitleE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Description = N'DETAIL OF PAYMENT SITUATION (DECREASE)', 
	 @DescriptionE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Type = 12, @SQLstring = N'Select * From AV0313  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by GroupID, CreditVoucherDate,BatchID, DebitVoucherNo',
	 @TEST = 0, @TableID = N'AT8888'

EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR03142', @ReportName = N'Tình hình thanh toán (A4L)',
	 @ReportNameE = N'Payment situation (A4L)', @ReportTitle = N'CHI TIẾT TÌNH HÌNH THANH TOÁN (PHÁT SINH GIẢM CÔNG NỢ)', @ReportTitleE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Description = N'DETAIL OF PAYMENT SITUATION (DECREASE)', 
	 @DescriptionE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Type = 12, @SQLstring = N'Select * From AV0313  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by GroupID, CreditVoucherDate,BatchID, DebitVoucherNo',
	 @TEST = 0, @TableID = N'AT8888'

 ---- Add AR04131, AR04141: Tình hình thanh toán công nợ phải trả (Phát sinh giảm)
EXEC AP8888 @GroupID = N'G04', @ModuleID = 'AsoftT', @ReportID = N'AR04131', @ReportName = N'Chi tiết thanh toán nợ phải trả (A4L)',
	 @ReportNameE = N'Detail of payable situation', @ReportTitle = N'CHI TIẾT THANH TOÁN NỢ PHẢI TRẢ (PHÁT SINH GIẢM CÔNG NỢ)', @ReportTitleE = N'DETAIL OF PAYABLE SITUATION (DECREASE)', @Description = N'DETAIL OF PAYMENT SITUATION (DECREASE)', 
	 @DescriptionE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Type = 12, @SQLstring = N'Select * From AV0414  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' order by GroupID, DebitVoucherDate,BatchID, CreditVoucherNo',
	 @TEST = 0, @TableID = N'AT8888'

EXEC AP8888 @GroupID = N'G04', @ModuleID = 'AsoftT', @ReportID = N'AR04141', @ReportName = N'Chi tiết thanh toán nợ phải trả (A4L)',
	 @ReportNameE = N'Detail of payable situation', @ReportTitle = N'CHI TIẾT THANH TOÁN NỢ PHẢI TRẢ (PHÁT SINH GIẢM CÔNG NỢ)', @ReportTitleE = N'DETAIL OF PAYABLE SITUATION (DECREASE)', @Description = N'DETAIL OF PAYMENT SITUATION (DECREASE)', 
	 @DescriptionE = N'DETAIL OF PAYMENT SITUATION (DECREASE)', @Type = 12, @SQLstring = N'Select * From AV0414  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' order by GroupID, DebitVoucherDate,BatchID, CreditVoucherNo',
	 @TEST = 0, @TableID = N'AT8888'

IF @CustomerName = 50 --- Customize Meiko
BEGIN
	EXEC AP8888 @GroupID = N'G02', @ModuleID = 'AsoftFA', @ReportID = N'FR1540', @ReportName = N'Báo cáo theo dõi XDCB dở dang',
	 @ReportNameE = N'CIP report', @ReportTitle = N'BÁO CÁO THEO DÕI XDCB DỞ DANG', @ReportTitleE = N'CONTRUCTION IN PROGRESS REPORT', @Description = N'CONTRUCTION IN PROGRESS', 
	 @DescriptionE = N'CONTRUCTION IN PROGRESSG', @Type = 3, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

	EXEC AP8888 @GroupID = N'G02', @ModuleID = 'AsoftFA', @ReportID = N'FR1511', @ReportName = N'Báo cáo theo dõi khấu hao TSCĐ',
	 @ReportNameE = N'Fixed Asset depreciation', @ReportTitle = N'BÁO CÁO THEO DÕI KHẤU HAO TSCĐ', @ReportTitleE = N'FIXED ASSET DEPRECIATION', @Description = N'FIXED ASSET DEPRECIATION', 
	 @DescriptionE = N'FIXED ASSET DEPRECIATION', @Type = 4, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'	 	 
END

---- Add AR1520: Thẻ TSCĐ
EXEC AP8888 @GroupID = N'G02', @ModuleID = 'AsoftFA', @ReportID = N'AR1520', @ReportName = N'Thẻ tài sản cố định',
	 @ReportNameE = N'Thẻ tài sản cố định', @ReportTitle = N'THẺ TÀI SẢN CỐ ĐỊNH', @ReportTitleE = N'THẺ TÀI SẢN CỐ ĐỊNH', @Description = N'THẺ TÀI SẢN CỐ ĐỊNH', 
	 @DescriptionE = N'THẺ TÀI SẢN CỐ ĐỊNH', @Type = 5, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Update Report
UPDATE AT8888STD SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0720'
UPDATE AT8888STD SET Orderby = ' ORDER BY InventoryID, VoucherDate ' WHERE ReportID = 'AR0721'
UPDATE AT8888STD SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0722'
UPDATE AT8888STD SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0723'
UPDATE AT8888STD SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0724'
UPDATE AT8888    SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0720'
UPDATE AT8888    SET Orderby = ' ORDER BY InventoryID, VoucherDate ' WHERE ReportID = 'AR0721'
UPDATE AT8888    SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0722'
UPDATE AT8888    SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0723'
UPDATE AT8888    SET Orderby = ' ORDER BY ObjectID, InventoryID, VoucherDate ' WHERE ReportID = 'AR0724'
UPDATE AT8888
SET SQLstring = 'SELECT * FROM AV7211  WHERE UserID = @UserID'
WHERE GroupID = 'G99' AND Type IN( 1) AND ReportID = 'AR7201'
UPDATE AT8888STD
SET SQLstring = 'SELECT * FROM AV7211  WHERE UserID = @UserID'
WHERE GroupID = 'G99' AND Type IN(1) AND ReportID = 'AR7201'
UPDATE AT8888
SET SQLstring = 'SELECT * FROM AV7201 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))'
WHERE GroupID = 'G99' AND Type IN( 1) AND ReportID = 'AR7202'
UPDATE AT8888STD
SET SQLstring = 'SELECT * FROM AV7201 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))'
WHERE GroupID = 'G99' AND Type IN( 1) AND ReportID = 'AR7202'
UPDATE AT8888
SET SQLstring = ''
WHERE GroupID = 'G99' AND Type IN( 0)
UPDATE AT8888STD
SET SQLstring = ''
WHERE GroupID = 'G99' AND Type IN(0)
UPDATE	AT8888
SET    	SQLstring = 'SELECT * FROM AV1313 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))'
WHERE	GroupID ='G05' 
		AND Type IN (9,10)
UPDATE AT8888STD
SET SQLString = N'SELECT DISTINCT * FROM AT2018 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))'
WHERE ReportID = 'AR7006'
UPDATE AT8888STD
SET SQLstring = N'SELECT * FROM AV4706 WHERE (1=1)'
WHERE ReportID IN ('AR4000', 'AR4001', 'AR4002', 'AR4010', 'AR4011', 'AR4014', 'AR4015', 'AR4016', 'AR4017')
UPDATE AT8888STD
SET SQLstring = N'SELECT * FROM AV6003 WHERE (1=1)'
WHERE ReportID IN ('AR6003','AR6004')

UPDATE AT8888STD
SET SQLstring = N'SELECT * FROM AV6600 WHERE (1=1)'
WHERE ReportID IN ('AR6600')
UPDATE	AT8888STD
SET    	SQLstring = 'SELECT * FROM AV1313 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))'
WHERE	GroupID ='G05' 
		AND Type IN (9,10)

If @CustomerName = 51--HoangTran (Nếu là hoàng trần thì chạy câu SQL update, ngược lại thì chạy câu SQL bản chuẩn
Begin
		UPDATE AT8888
		SET SQLstring = 'SELECT * FROM AV7405'
		WHERE GroupID = 'G03' AND Type IN( 1,11) AND ReportID in ('AR7401', 'AR7405', 'AR7415', 'AR7421', 'AR7422', 'AR7445')
		UPDATE AT8888STD
		SET SQLstring = 'SELECT * FROM AV7405'
		WHERE GroupID = 'G03' AND Type IN( 1,11) AND ReportID in ('AR7401', 'AR7405', 'AR7415', 'AR7421', 'AR7422', 'AR7445')
		UPDATE AT8888
		SET SQLstring = 'SELECT * FROM AV7408'
		WHERE GroupID = 'G04' AND Type IN( 1,11) AND ReportID in ('AR7406','AR7407','AR7410','AR7419','AR7426','AR7427','AR7446')
		UPDATE AT8888STD
		SET SQLstring = 'SELECT * FROM AV7408'
		WHERE GroupID = 'G04' AND Type IN( 1,11) AND ReportID in ('AR7406','AR7407','AR7410','AR7419','AR7426','AR7427','AR7446')

End

---- Delete Report
Delete AT8888 Where GroupID = 'G99' AND Type = 7 And ReportID = 'AR7602'

---- Modified by Tieu Mai on 27/04/2016: Customize KOYO
IF @CustomerName = 52 --- KOYO
BEGIN
	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0394', @ReportName = N'Báo cáo theo dõi công nợ phải thu theo tuổi nợ',
	 @ReportNameE = N'Debit report', @ReportTitle = N'BÁO CÁO THEO DÕI CÔNG NỢ PHẢI THU THEO TUỔI NỢ', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 9, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
	 
	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0326', @ReportName = N'Báo cáo công nợ phải thu theo khách hàng - nhóm ngành',
	 @ReportNameE = N'Debit - Inductries report', @ReportTitle = N'BÁO CÁO CÔNG NỢ PHẢI THU THEO KHÁCH HÀNG - NHÓM NGÀNH', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 38, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
	 
	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0332', @ReportName = N'Báo cáo công nợ phải thu theo nhân viên',
	 @ReportNameE = N'Debit - Employee report', @ReportTitle = N'BÁO CÁO CÔNG NỢ PHẢI THU THEO NHÂN VIÊN', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 39, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
	 
	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0333', @ReportName = N'Báo cáo công nợ phải thu - đã thu theo nhân viên',
	 @ReportNameE = N'Debit - Accept report', @ReportTitle = N'BÁO CÁO CÔNG NỢ PHẢI THU - ĐÃ THU THEO NHÂN VIÊN', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 39, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'	 

	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0334', @ReportName = N'Báo cáo doanh số bán hàng theo nhân viên',
	 @ReportNameE = N'Sales report', @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG THEO NHÂN VIÊN', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 39, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0335', @ReportName = N'Báo cáo kết quả hoạt động kinh doanh',
	 @ReportNameE = N'Business Results report', @ReportTitle = N'BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 39, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

	EXEC AP8888 @GroupID = N'G03', @ModuleID = 'AsoftT', @ReportID = N'AR0395', @ReportName = N'Báo cáo theo dõi công nợ phải thu theo tuổi nợ (Quy đổi)',
	 @ReportNameE = N'Debit report', @ReportTitle = N'BÁO CÁO THEO DÕI CÔNG NỢ PHẢI THU THEO TUỔI NỢ (QUY ĐỔI)', @ReportTitleE = N'', @Description = N'', 
	 @DescriptionE = N'', @Type = 34, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
	 
		EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR7620A', @ReportName = N'Bảng kết quả kinh doanh theo mã phân tích',
	 @ReportNameE = N'Debit report', @ReportTitle = N'BẢNG KẾT QUẢ KINH DOANH THEO MÃ PHÂN TÍCH', @ReportTitleE = N'REPORT OF BUSINESS RESULT ACCORDING TO ANALYSIS ID', @Description = N'Bảng kết quả kinh doanh theo mã phân tích', 
	 @DescriptionE = N'', @Type = 54, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'
END

IF @CustomerName = 54 ---- AN PHÁT
BEGIN
	EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR7620_AP', @ReportName = N'Bảng kết quả kinh doanh theo mã phân tích',
		 @ReportNameE = N'Report of business result according analysis ID', @ReportTitle = N'BẢNG KẾT QUẢ KINH DOANH THEO MÃ PHÂN TÍCH', @ReportTitleE = N'REPORT OF BUSINESS RESULT ACCORDING TO ANALYSIS ID', @Description = N'Bảng kết quả kinh doanh theo mã phân tích', 
		 @DescriptionE = N'', @Type = 54, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'

	EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftT', @ReportID = N'AR7003AP', 
		 @ReportName = N'Sổ chi tiết vật tư theo đơn vị tính quy đổi', @ReportNameE = N'Material book', 
		 @ReportTitle = N'SỔ CHI TIẾT VẬT TƯ THEO ĐƠN VỊ TÍNH QUY ĐỔI', @ReportTitleE = N'MATERIAL BOOK',
		 @Description = N'SỔ CHI TIẾT VẬT TƯ', @DescriptionE = N'MATERIAL BOOK', 
		 @Type = 17, @SQLstring = N'Select * from AV2022 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by InventoryID, VoucherDate, ImExOrders,VoucherNo',
		 @TEST = 0, @TableID = N'AT8888'
		 
	EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftT', @ReportID = N'AR7203AP', 
		 @ReportName = N'Sổ chi tiết vật tư theo đơn vị tính quy đổi', @ReportNameE = N'Inventory Books', 
		 @ReportTitle = N'SỔ CHI TIẾT VẬT TƯ THEO ĐƠN VỊ TÍNH QUY ĐỔI', @ReportTitleE = N'MATERIAL BOOK',
		 @Description = N'SỔ CHI TIẾT VẬT TƯ', @DescriptionE = N'MATERIAL BOOK', 
		 @Type = 17, @SQLstring = N'Select * from AV2022 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by InventoryID, VoucherDate, ImExOrders,VoucherNo',
		 @TEST = 0, @TableID = N'AT8888'			 		 
END

IF @CustomerName IN (43, 161) ---- Secoin, INNOTEK
BEGIN
	EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR7930_SC', @ReportName = N'Báo cáo phân tích chỉ số tài chính',
		 @ReportNameE = N'Report analyzes the financial index', @ReportTitle = N'Báo cáo phân tích chỉ số tài chính', @ReportTitleE = N'Report analyzes the financial index', @Description = N'Báo cáo phân tích chỉ số tài chính', 
		 @DescriptionE = N'', @Type = 55, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
END

BEGIN
	EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR3015', @ReportName = N'Phiếu kế toán',
		 @ReportNameE = N'Accounting Bill', @ReportTitle = N'Phiếu kế toán', @ReportTitleE = N'Accounting Bill', @Description = N'', 
		 @DescriptionE = N'', @Type = 56, @SQLstring = N'', @Orderby = N'',
		 @TEST = 0, @TableID = N'AT8888'
END

---- Modified by Bảo Thy on 25/04/2017: Bổ sung báo cáo theo quy cách vào chuẩn

---- Add AR2016_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'AR2016_QC', @ReportName = N'Mẫu 1 có quy cách',
	 @ReportNameE = N'Form 1_Specificate', @ReportTitle = N'Phiếu nhập kho', @ReportTitleE = N'Receiving voucher',
	 @Description = N'NHẬP KHO', @DescriptionE = N'RECEIVING', @Type = 926, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR2026_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR2026_QC', @ReportName = N'Mẫu 2 có quy cách',
	 @ReportNameE = N'Form 2_Specificate', @ReportTitle = N'Phiếu kế toán', @ReportTitleE = N'Accounting voucher',
	 @Description = N'NHẬP KHO', @DescriptionE = N'RECEIVING', @Type = 926, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR20261_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20261_QC', @ReportName = N'Mẫu 3 có quy cách',
	 @ReportNameE = N'Form 3_Specificate', @ReportTitle = N'Mẫu 3', @ReportTitleE = N'FORM 3',
	 @Description = N'MẪU 3', @DescriptionE = N'FORM 3', @Type = 926, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR20262_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'AsoftWM', @ReportID = N'WR20262_QC', @ReportName = N'Mẫu 4 có quy cách',
	 @ReportNameE = N'Form 4_Specificate', @ReportTitle = N'Mẫu 4', @ReportTitleE = N'FORM 4',
	 @Description = N'MẪU 4', @DescriptionE = N'FORM 4', @Type = 926, @SQLstring = N'', @Orderby = N' Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR2017_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2017_QC', @ReportName = N'Mẫu 1 có quy cách', 
	 @ReportNameE = N'Form 1_Specificate',  @ReportTitle = N'PHIẾU XUẤT KHO', @ReportTitleE = N'DELIVERING VOUCHER',
	 @Description = N'XUẤT KHO', @DescriptionE = N'DELIVERING', @Type = 927, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR0012_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR0012_QC', @ReportName = N'Phiếu giao hàng có quy cách', 
	 @ReportNameE = N'Delivery Note_Specificate',  @ReportTitle = N'PHIẾU GIAO HÀNG', @ReportTitleE = N'DELIVERY NOTE',
	 @Description = N'PHIẾU GIAO HÀNG', @DescriptionE = N'DELIVERY NOTE', @Type = 927, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR2027_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR2027_QC', @ReportName = N'Mẫu 2 có quy cách', 
	 @ReportNameE = N'Form 2_Specificate',  @ReportTitle = N'PHIẾU KẾ TOÁN', @ReportTitleE = N'ACCOUNTING VOUCHER',
	 @Description = N'PHIẾU KẾ TOÁN', @DescriptionE = N'ACCOUNTING VOUCHER', @Type = 927, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR20271_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR20271_QC', @ReportName = N'Mẫu 3 có quy cách', 
	 @ReportNameE = N'Form 3_Specificate',  @ReportTitle = N'MẪU 3', @ReportTitleE = N'FORM 3',
	 @Description = N'MẪU 3', @DescriptionE = N'FORM 3', @Type = 927, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR20272_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR20272_QC', @ReportName = N'Mẫu 4 có quy cách', 
	 @ReportNameE = N'Form 4_Specificate',  @ReportTitle = N'MẪU 4', @ReportTitleE = N'FORM 4',
	 @Description = N'MẪU 4', @DescriptionE = N'FORM 4', @Type = 927, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR2018
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2018', @ReportName = N'Xuất kho kiêm VCNB', 
	 @ReportNameE = N'Internal Delivery Form',  @ReportTitle = N'PHIẾU XUẤT KHO KIÊM VẬN CHUYỂN NỘI BỘ', @ReportTitleE = N'INTERNAL DELIVERY VOUCHER',
	 @Description = N'XUẤT KHO KIÊM VCNB', @DescriptionE = N'INTERNAL DELIVERY VOUCHER', @Type = 42, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'	 

---- Add AR2018_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2018_QC', @ReportName = N'Xuất kho kiêm VCNB có quy cách', 
	 @ReportNameE = N'Internal Delivery Form_Specificate',  @ReportTitle = N'PHIẾU XUẤT KHO KIÊM VẬN CHUYỂN NỘI BỘ', 
	 @ReportTitleE = N'INTERNAL DELIVERY VOUCHER', @Description = N'XUẤT KHO KIÊM VCNB',
	 @DescriptionE = N'INTERNAL DELIVERY VOUCHER', @Type = 942, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'	 

---- Add AR2009_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2009_QC', @ReportName = N'Báo cáo nhập xuất tồn theo kho (mẫu 1) có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock according to warehouse_Specificate',  @ReportTitle = N'NHẠP XUẤT TỒN THEO KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE', @Description = N'NHẠP XUẤT TỒN THEO KHO', 
	 @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE', 
	 @Type = 904, @SQLstring = N'Select * from AV2008  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by  GroupID1, GroupID2,  InventoryID', @TEST = 0, @TableID = N'AT8888'	

---- Add AR7001_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7001_QC', @ReportName = N'Báo cáo nhập xuất tồn theo kho có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock according to warehouse_Specificate',  @ReportTitle = N'NHẠP XUẤT TỒN THEO KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE',@Description = N'NHẠP XUẤT TỒN THEO KHO', 
	 @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE', 
	 @Type = 904, @SQLstring = N'Select * from AV2008  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by  GroupID1, GroupID2,  InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR7011_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7011_QC', @ReportName = N'Báo cáo nhập xuất tồn theo kho (mẫu 2) có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock according to warehouse_Specificate',  @ReportTitle = N'NHẠP XUẤT TỒN THEO KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE',@Description = N'NHẠP XUẤT TỒN THEO KHO', 
	 @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK ACCORDING TO WAREHOUSE', 
	 @Type = 904, @SQLstring = N'Select * from AV2008  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by  GroupID1, GroupID2,  InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR3008_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR3008_QC', @ReportName = N'Báo cáo nhập xuất tồn tất cả các kho có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock in all warehouses_Specificate',  @ReportTitle = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES',
	 @Description = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO CÓ QUY CÁCH', @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES', 
	 @Type = 905, @SQLstring = N'Select * from AV3008 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by  GroupID1, GroupID2, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'	 

---- Add AR3009_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR3009_QC', @ReportName = N'Báo cáo nhập xuất tồn tất cả các kho (nhóm 1 cấp) có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock in all warehouses (1 level)_Specificate',  @ReportTitle = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES',
	 @Description = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO CÓ QUY CÁCH', @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES', 
	 @Type = 905, @SQLstring = N'Select * from AV3008  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by  GroupID1, GroupID2, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'	

---- Add AR3010_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR3010_QC', @ReportName = N'Báo cáo nhập xuất tồn tất cả các kho (nhóm 2 cấp) có quy cách', 
	 @ReportNameE = N'Report of Receiving-Delivering-Stock in all warehouses (2 levels)_Specificate',  @ReportTitle = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO', 
	 @ReportTitleE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES',
	 @Description = N'BÁO CÁO NHẬP XUẤT TỒN TẤT CẢ CÁC KHO CÓ QUY CÁCH', @DescriptionE = N'REPORT OF RECEIVING-DELIVERING-STOCK IN ALL WAREHOUSES', 
	 @Type = 905, @SQLstring = N'Select * from AV3008  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N' Order by  GroupID1, GroupID2, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'	

---- Add AR7003_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7003_QC', @ReportName = N'Sổ chi tiết vật tư có quy cách', 
	 @ReportNameE = N'Material book_Specificate',  @ReportTitle = N'SỔ CHI TIẾT VẬT TƯ', @ReportTitleE = N'MATERIAL BOOK',
	 @Description = N'SỔ CHI TIẾT VẬT TƯ', @DescriptionE = N'MATERIAL BOOK', @Type = 902, @SQLstring = N'Select * from AV2018 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID, VoucherDate, ImExOrders,VoucherNo',
	 @TEST = 0, @TableID = N'AT8888'	

---- Add AR7203_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7203_QC', @ReportName = N'Sổ chi tiết vật tư có quy cách', 
	 @ReportNameE = N'Material book_Specificate',  @ReportTitle = N'SỔ CHI TIẾT VẬT TƯ', @ReportTitleE = N'MATERIAL BOOK',
	 @Description = N'SỔ CHI TIẾT VẬT TƯ', @DescriptionE = N'MATERIAL BOOK', @Type = 902, @SQLstring = N'Select * from AV2018  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID, VoucherDate, ImExOrders,VoucherNo',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR2007_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2007_QC', @ReportName = N'Báo cáo tồn kho theo tài khoản có quy cách', 
	 @ReportNameE = N'Report of stock according to account_Specificate',  @ReportTitle = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN', 
	 @ReportTitleE = N'REPORT OF STOCK ACCORDING TO ACCOUNT', @Description = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN', 
	 @DescriptionE = N'REPORT OF STOCK ACCORDING TO ACCOUNT', @Type = 900, @SQLstring = N'Select * From AV2007 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR2008_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2008_QC', @ReportName = N'Báo cáo tồn kho theo tài khoản có quy cách', 
	 @ReportNameE = N'Report of stock according to account_Specificate',  @ReportTitle = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN', 
	 @ReportTitleE = N'REPORT OF STOCK ACCORDING TO ACCOUNT', @Description = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN', 
	 @DescriptionE = N'REPORT OF STOCK ACCORDING TO ACCOUNT', @Type = 900, @SQLstring = N'Select * From AV2007 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR3018
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR3018', @ReportName = N'Thẻ kho', 
	 @ReportNameE = N'Stock card',  @ReportTitle = N'THẺ KHO', 
	 @ReportTitleE = N'STOCK CARD', @Description = N'THẺ KHO', 
	 @DescriptionE = N'STOCK CARD', @Type = 40, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888'

---- Add AR3018_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR3018_QC', @ReportName = N'Thẻ kho có quy cách', 
	 @ReportNameE = N'Stock card_Specificate',  @ReportTitle = N'THẺ KHO', 
	 @ReportTitleE = N'STOCK CARD', @Description = N'THẺ KHO', 
	 @DescriptionE = N'STOCK CARD', @Type = 940, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888'

---- Add AR3004_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3004_QC', @ReportName = N'Hóa đơn bán hàng (nhóm theo mặt hàng) có quy cách', 
	 @ReportNameE = N'Sale Invoice (group by inventory)_Specificate',  @ReportTitle = N'HÓA ĐƠN BÁN HÀNG (NHÓM THEO MẶT HÀNG)', 
	 @ReportTitleE = N'SALE INVOICE (GROUP BY INVENTORY)', @Description = N'HÓA ĐƠN BÁN HÀNG (NHÓM THEO MẶT HÀNG)', 
	 @DescriptionE = N'SALE INVOICE (GROUP BY INVENTORY)', @Type = 920, @SQLstring = N'', @Orderby = N'Order by InventoryID, TaxOrders, Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR2102_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR2102_QC', @ReportName = N'Phụ lục có quy cách', 
	 @ReportNameE = N'Appendix_Specificate',  @ReportTitle = N'PHỤ LỤC', 
	 @ReportTitleE = N'APPENDIX', @Description = N'PHỤ LỤC', 
	 @DescriptionE = N'APPENDIX', @Type = 920, @SQLstring = N'', @Orderby = N'Order by Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3014_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3014_QC', @ReportName = N'Hóa đơn bán hàng có quy cách', 
	 @ReportNameE = N'Sale invoice_Specificate',  @ReportTitle = N'HÓA ĐƠN BÁN HÀNG', 
	 @ReportTitleE = N'SALE INVOICE', @Description = N'HÓA ĐƠN BÁN HÀNG', 
	 @DescriptionE = N'SALE INVOICE', @Type = 920, @SQLstring = N'', @Orderby = N'Order by TaxOrders, Orders, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3016_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3016_QC', @ReportName = N'Chứng từ bán hàng có quy cách', 
	 @ReportNameE = N'Sale voucher_Specificate',  @ReportTitle = N'CHỨNG TỪ BÁN HÀNG', 
	 @ReportTitleE = N'SALE VOUCHER', @Description = N'CHỨNG TỪ BÁN HÀNG', 
	 @DescriptionE = N'SALE VOUCHER', @Type = 920, @SQLstring = N'', @Orderby = N'Order by TaxOrders, Orders, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3013_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3013_QC', @ReportName = N'Phiếu mua hàng có quy cách', 
	 @ReportNameE = N'Purchase voucher_Specificate',  @ReportTitle = N'PHIẾU MUA HÀNG', 
	 @ReportTitleE = N'PURCHASE VOUCHER', @Description = N'PHIẾU MUA HÀNG', 
	 @DescriptionE = N'PURCHASE VOUCHER', @Type = 913, @SQLstring = N'', @Orderby = N'Order by TaxOrders, Orders, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR3018
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR3018', @ReportName = N'Thẻ kho theo đơn vị tính quy đổi', 
	 @ReportNameE = N'Stock card according to converted unit',  @ReportTitle = N'THẺ KHO', 
	 @ReportTitleE = N'STOCK CARD', @Description = N'THẺ KHO', 
	 @DescriptionE = N'STOCK CARD', @Type = 41, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Add WR3018_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'WR3018_QC', @ReportName = N'Thẻ kho theo đơn vị tính quy đổi có quy cách', 
	 @ReportNameE = N'Stock card according to converted unit_Specificate',  @ReportTitle = N'THẺ KHO', 
	 @ReportTitleE = N'STOCK CARD', @Description = N'THẺ KHO', 
	 @DescriptionE = N'STOCK CARD', @Type = 941, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0601_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0601_QC', @ReportName = N'Báo cáo chi tiết doanh số hàng mua (1 cấp) có quy cách', 
	 @ReportNameE = N'Detail report of purchase turnover (1 level)_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N' DETAIL REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N' DETAIL REPORT OF PURCHASE TURNOVER', @Type = 904, @SQLstring = N'Select * From AV0601 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID,VoucherNo', @TEST = 0, @TableID = N'AT8888'

---- Add AR0601A_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0601A_QC', @ReportName = N'Báo cáo chi tiết mua hàng có quy cách', 
	 @ReportNameE = N'The report details purchase_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT MUA HÀNG', 
	 @ReportTitleE = N'THE REPORT DETAILS PURCHASE', @Description = N'BÁO CÁO CHI TIẾT MUA HÀNG', 
	 @DescriptionE = N'THE REPORT DETAILS PURCHASE', @Type = 904, @SQLstring = N'Select * From AV0601  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID,VoucherNo', @TEST = 0, @TableID = N'AT8888'

---- Add AR0605_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0605_QC', @ReportName = N'Báo cáo doanh số hàng mua theo mặt hàng (nhóm theo đối tượng) có quy cách', 
	 @ReportNameE = N'Report of purchase turnover according to inventory (group by object)_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'REPORT OF PURCHASE TURNOVER', @Type = 904, @SQLstring = N'Select * From AV0601 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID,VoucherNo', @TEST = 0, @TableID = N'AT8888'

---- Add AR0611_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0611_QC', @ReportName = N'Báo cáo chi tiết doanh số hàng mua (2 cấp) có quy cách', 
	 @ReportNameE = N'Detail report of purchase turnover (2 levels)_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'DETAIL REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'DETAIL REPORT OF PURCHASE TURNOVER', @Type = 914, @SQLstring = N'Select * From AV0601 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID,Group2ID,VoucherNo', @TEST = 0, @TableID = N'AT8888'

---- Add AR0621_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0621_QC', @ReportName = N'Báo cáo chi tiết doanh số hàng mua không nhóm có quy cách', 
	 @ReportNameE = N'Detail report of purchase turnover (Ungroup)_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'DETAIL REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO CHI TIẾT DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'DETAIL REPORT OF PURCHASE TURNOVER', @Type = 924, @SQLstring = N'Select * From AV0601 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by VoucherNo', @TEST = 0, @TableID = N'AT8888'

---- Add AR0602_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0602_QC', @ReportName = N'Báo cáo tổng hợp doanh số hàng mua (1 cấp) có quy cách', 
	 @ReportNameE = N'General report of purchase turnover (1 level)_Specificate',  @ReportTitle = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'GENERAL REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'GENERAL REPORT OF PURCHASE TURNOVER', @Type = 905, @SQLstring = N'Select * From AV0602 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID ', @TEST = 0, @TableID = N'AT8888'

---- Add AR0612_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0612_QC', @ReportName = N'Báo cáo tổng hợp doanh số hàng mua (2 cấp) có quy cách', 
	 @ReportNameE = N'General report of purchase turnover (2 levels)_Specificate',  @ReportTitle = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'GENERAL PURCHASING TURNOVER', @Description = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'GENERAL PURCHASING TURNOVER', @Type = 915, @SQLstring = N'Select * From AV0602 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by Group1ID,Group2ID', @TEST = 0, @TableID = N'AT8888'

---- Add AR0622_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0622_QC', @ReportName = N'Báo cáo tổng hợp doanh số hàng mua không nhóm có quy cách', 
	 @ReportNameE = N'General report of purchase turnover (Ungroup)_Specificate',  @ReportTitle = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @ReportTitleE = N'GENERAL REPORT OF PURCHASE TURNOVER', @Description = N'BÁO CÁO TỔNG HỢP DOANH SỐ HÀNG MUA', 
	 @DescriptionE = N'GENERAL REPORT OF PURCHASE TURNOVER', @Type = 925, @SQLstring = N'Select * From AV0602 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by ObjectID, InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR0710_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0710_QC', @ReportName = N'Nhập xuất tồn theo đối tượng có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock according to object_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN THEO ĐỐI TƯỢNG', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK', @Description = N'NHẬP XUẤT TỒN THEO ĐỐI TƯỢNG', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK', @Type = 918, @SQLstring = N'Select * from AV0710  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by  ObjectID', @TEST = 0, @TableID = N'AT8888'

---- Add AR0720_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0720_QC', @ReportName = N'Nhập xuất tồn chi tiết theo đối tượng có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock according to object_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN THEO ĐỐI TƯỢNG', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Description = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Type = 928, @SQLstring = N'Select * from AV0720  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' ORDER BY ObjectID, InventoryID, VoucherDate ', @TEST = 0, @TableID = N'AT8888'

---- Add AR0721_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0721_QC', @ReportName = N'Nhập xuất tồn chi tiết theo đối tượng có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock according to object_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN THEO ĐỐI TƯỢNG', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Description = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Type = 928, @SQLstring = N'Select * from AV0720  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' ORDER BY InventoryID, VoucherDate ',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0722_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0722_QC', @ReportName = N'Nhập xuất tồn chi tiết theo đối tượng có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock according to object_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN THEO ĐỐI TƯỢNG', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Description = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK ACCORDING TO OBJECT', @Type = 928, @SQLstring = N'Select * from AV0720  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' ORDER BY InventoryID, VoucherDate ',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0723_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0723_QC', @ReportName = N'Nhập xuất tồn chi tiết theo đối tượng (nhóm 2 cấp) có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock (2 levels)_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG (NHÓM 2 CẤP)', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK (2 LEVELS)', @Description = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG (NHÓM 2 CẤP)', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK (2 LEVELS)', @Type = 928, @SQLstring = N'Select * from AV0720  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' ORDER BY ObjectID, InventoryID, VoucherDate ',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0724_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0724_QC', @ReportName = N'Nhập xuất tồn chi tiết theo đối tượng (nhóm 2 cấp) có quy cách', 
	 @ReportNameE = N'Report of receiving - delivering - stock (2 levels)_Specificate',  @ReportTitle = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG (NHÓM 2 CẤP)', 
	 @ReportTitleE = N'RECEIVING - DELIVERING - STOCK (2 LEVELS)', @Description = N'NHẬP XUẤT TỒN CHI TIẾT THEO ĐỐI TƯỢNG (NHÓM 2 CẤP)', 
	 @DescriptionE = N'RECEIVING - DELIVERING - STOCK (2 LEVELS)', @Type = 928, @SQLstring = N'Select * from AV0720  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' ORDER BY ObjectID, InventoryID, VoucherDate ',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0114_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0114_QC', @ReportName = N'Báo cáo tồn kho chi tiết theo lô có quy cách', 
	 @ReportNameE = N'Report of detail according to Lot_Specificate',  @ReportTitle = N'BÁO CÁO TỒN KHO CHI TIẾT THEO LÔ', 
	 @ReportTitleE = N'REPORT OF RECEIVING - DELIVERING - REMAINING ACCORDING TO LOT', @Description = N'BÁO CÁO TỒN KHO CHI TIẾT THEO LÔ', 
	 @DescriptionE = N'REPORT OF RECEIVING - DELIVERING - REMAINING ACCORDING TO LOT', @Type = 901, @SQLstring = N'Select * from AV0114 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by WareHouseID, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0214_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0214_QC', @ReportName = N'Báo cáo chi tiết theo phiếu có quy cách', 
	 @ReportNameE = N'Detail report according to receipt_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT THEO PHIẾU', 
	 @ReportTitleE = N'DETAIL REPORT ACCORDING TO RECEIPT', @Description = N'BÁO CÁO CHI TIẾT THEO PHIẾU', 
	 @DescriptionE = N'DETAIL REPORT ACCORDING TO RECEIPT', @Type = 924, @SQLstring = N'Select * from AV0214 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by WareHouseID,InventoryID,ReVoucherDate,ReVoucherNo,ResourceNo,DeVoucherDate,DeVoucherNo ',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0215_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0215_QC', @ReportName = N'Báo cáo nhập xuất tồn tổng hợp theo lô có quy cách', 
	 @ReportNameE = N'General report of receiving - delivering - stock according Lot_Specificate',  @ReportTitle = N'BÁO CÁO NHẬP XUẤT TỒN TỔNG HỢP THEO LÔ', 
	 @ReportTitleE = N'GENERAL OF REPORT OF RECEIVING - DELIVERING - STOCK ACCORDING TO LOT', @Description = N'BÁO CÁO NHẬP XUẤT TỒN TỔNG HỢP THEO LÔ', 
	 @DescriptionE = N'GENERAL OF REPORT OF RECEIVING - DELIVERING - STOCK ACCORDING TO LOT', @Type = 930, @SQLstring = N'Select * from AV0117 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR0217_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR0217_QC', @ReportName = N'Báo cáo nhập xuất tồn tổng hợp theo lô có quy cách', 
	 @ReportNameE = N'General report of receiving - delivering - stock according Lot_Specificate',  @ReportTitle = N'BÁO CÁO NHẬP XUẤT TỒN TỔNG HỢP THEO LÔ', 
	 @ReportTitleE = N'GENERAL OF REPORT OF RECEIVING - DELIVERING - STOCK ACCORDING TO LOT', @Description = N'BÁO CÁO NHẬP XUẤT TỒN TỔNG HỢP THEO LÔ', 
	 @DescriptionE = N'GENERAL OF REPORT OF RECEIVING - DELIVERING - STOCK ACCORDING TO LOT', @Type = 930, @SQLstring = N'Select * from AV0117 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID', @TEST = 0, @TableID = N'AT8888'

---- Add AR1313_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR1313_QC', @ReportName = N'Báo cáo tổng hợp tồn kho theo định mức có quy cách', 
	 @ReportNameE = N'General report of stock according to norm_Specificate',  @ReportTitle = N'BÁO CÁO TỔNG HỢP TỒN KHO THEO ĐỊNH MỨC', 
	 @ReportTitleE = N'GENERAL REPORT OF STOCK ACCORDING TO NORM', @Description = N'BÁO CÁO TỔNG HỢP TỒN KHO THEO ĐỊNH MỨC', 
	 @DescriptionE = N'GENERAL REPORT OF STOCK ACCORDING TO NORM', @Type = 909, @SQLstring = N'SELECT * FROM AV1313 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by GroupID,InventoryID,DetailID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR1316_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR1316_QC', @ReportName = N'Báo cáo kiểm tra tồn kho theo định mức có quy cách', 
	 @ReportNameE = N'General report of stock according to norm_Specificate',  @ReportTitle = N'BÁO CÁO KIỂM TRA TỒN KHO THEO ĐỊNH MỨC', 
	 @ReportTitleE = N'IN STOCK ACCORDING TO NORM', @Description = N'BÁO CÁO KIỂM TRA TỒN KHO THEO ĐỊNH MỨC', 
	 @DescriptionE = N'IN STOCK ACCORDING TO NORM', @Type = 910, @SQLstring = N'SELECT * FROM AV1313 WHERE DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by GroupID,InventoryID,DetailID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR7006_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7006_QC', @ReportName = N'Nhật ký nhập xuất kho có quy cách', 
	 @ReportNameE = N'Diary of receiving - delivering_Specificate',  @ReportTitle = N'NHẬT KÝ NHẬP XUẤT KHO', 
	 @ReportTitleE = N'DAIRY OF RECEIVING - DELIVERING', @Description = N'NHẬT KÝ NHẬP XUẤT KHO', 
	 @DescriptionE = N'DAIRY OF RECEIVING - DELIVERING', @Type = 903, @SQLstring = N'SELECT DISTINCT * FROM AT2018 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by WareHouseID, Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR7007_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7007_QC', @ReportName = N'Nhật ký nhập xuất kho có quy cách', 
	 @ReportNameE = N'Diary of receiving - delivering_Specificate',  @ReportTitle = N'NHẬT KÝ NHẬP XUẤT KHO', 
	 @ReportTitleE = N'DAIRY OF RECEIVING - DELIVERING', @Description = N'NHẬT KÝ NHẬP XUẤT KHO', 
	 @DescriptionE = N'DAIRY OF RECEIVING - DELIVERING', @Type = 903, @SQLstring = N'Select * from AT2018 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by WareHouseID, Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR7017_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR7017_QC', @ReportName = N'Nhật ký nhập xuất kho - âm có quy cách', 
	 @ReportNameE = N'Diary of receiving - delivering (Negative)_Specificate',  @ReportTitle = N'NHẬT KÝ NHẬP XUẤT KHO - ÂM', 
	 @ReportTitleE = N'DAIRY OF RECEIVING - DELIVERING (NEGATIVE)', @Description = N'NHẬT KÝ NHẬP XUẤT KHO - ÂM', 
	 @DescriptionE = N'DAIRY OF RECEIVING - DELIVERING (NEGATIVE)', @Type = 903, @SQLstring = N'Select * from AT2018 Where InventoryID in (select InventoryID from AT2018 Where EndQuantity < 0)', 
	 @Orderby = N' Order by WareHouseID, InventoryID, Orders',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3028_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3028_QC', @ReportName = N'Tổng hợp doanh số mua theo mặt hàng, đối tượng và giá mua có quy cách', 
	 @ReportNameE = N'General of turnover according to inventory, object, sale price_Specificate',  @ReportTitle = N'TỔNG HỢP DOANH SỐ MUA THEO MẶT HÀNG, ĐỐI TƯỢNG VÀ GIÁ MUA', 
	 @ReportTitleE = N'GENERAL OF TURNOVER ACCORDING TO INVENTORY, OBJECT, PURCHASE PRICE', @Description = N'TỔNG HỢP DOANH SỐ MUA THEO MẶT HÀNG, ĐỐI TƯỢNG VÀ GIÁ MUA', 
	 @DescriptionE = N'GENERAL OF TURNOVER ACCORDING TO INVENTORY, OBJECT, PURCHASE PRICE', @Type = 909, @SQLstring = N'Select * from AV3029  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID, ObjectID, UnitPrice',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0287_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0287_QC', @ReportName = N'Báo cáo so sánh giá các nhà cung cấp có quy cách', 
	 @ReportNameE = N'Price compare of suppliers_Specificate',  @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ CÁC NHÀ CUNG CẤP', 
	 @ReportTitleE = N'PRICE COMPARE OF SUPPLIERS', @Description = N'BÁO CÁO SO SÁNH GIÁ CÁC NHÀ CUNG CẤP', 
	 @DescriptionE = N'PRICE COMPARE OF SUPPLIERS', @Type = 931, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0288_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0288_QC', @ReportName = N'Báo cáo so sánh giá theo hóa đơn có quy cách', 
	 @ReportNameE = N'Price compare of invoice_Specificate',  @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ THEO HÓA ĐƠN', 
	 @ReportTitleE = N'PRICE COMPARE OF INVOICE', @Description = N'BÁO CÁO SO SÁNH GIÁ THEO HÓA ĐƠN', 
	 @DescriptionE = N'PRICE COMPARE OF INVOICE', @Type = 932, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0289_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR0289_QC', @ReportName = N'Báo cáo so sánh giá mua nhiều kỳ có quy cách', 
	 @ReportNameE = N'Price compare of periods_Specificate',  @ReportTitle = N'BÁO CÁO SO SÁNH GIÁ NHIỀU KỲ', 
	 @ReportTitleE = N'PRICE COMPARE OF PERIODS', @Description = N'BÁO CÁO SO SÁNH GIÁ NHIỀU KỲ', 
	 @DescriptionE = N'PRICE COMPARE OF PERIODS', @Type = 933, @SQLstring = N'', @Orderby = N'Order by InventoryID, ObjectID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3021_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3021_QC', @ReportName = N'Báo cáo doanh số bán hàng có quy cách', 
	 @ReportNameE = N'Report of sales turnover_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @ReportTitleE = N'REPORT OF SALES TURNOVER', @Description = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @DescriptionE = N'REPORT OF SALES TURNOVER', @Type = 900, @SQLstring = N'Select * From AV3021 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID, InvoiceDate',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3022_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3022_QC', @ReportName = N'Báo cáo doanh số bán hàng có quy cách', 
	 @ReportNameE = N'Report of sales turnover_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @ReportTitleE = N'REPORT OF SALES TURNOVER', @Description = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @DescriptionE = N'REPORT OF SALES TURNOVER', @Type = 901, @SQLstring = N'Select * From AV3025 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by ObjectID,InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3022A_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3022A_QC', @ReportName = N'Báo cáo chi tiết bán hàng có quy cách', 
	 @ReportNameE = N'The report detail sales_Specificate',  @ReportTitle = N'BÁO CÁO CHI TIẾT BÁN HÀNG', 
	 @ReportTitleE = N'THE REPORT DETAIL SALES', @Description = N'BÁO CÁO CHI TIẾT BÁN HÀNG', 
	 @DescriptionE = N'THE REPORT DETAIL SALES', @Type = 901, @SQLstring = N'Select * From AV3025  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by ObjectID,InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3029_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3029_QC', @ReportName = N'Báo cáo doanh số bán hàng chi tiết theo hóa đơn có quy cách', 
	 @ReportNameE = N'Detail report of sales turnover according to invoice_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG CHI TIẾT THEO HOÁ ĐƠN', 
	 @ReportTitleE = N'DETAIL REPORT OF SALES TURNOVER ACCORDING TO INVOICE', @Description = N'BÁO CÁO DOANH SỐ BÁN HÀNG CHI TIẾT THEO HOÁ ĐƠN', 
	 @DescriptionE = N'DETAIL REPORT OF SALES TURNOVER ACCORDING TO INVOICE', @Type = 901, @SQLstring = N'Select * From AV3025 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InvoiceNo,InvoiceDate,ObjectID,InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3023_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3023_QC', @ReportName = N'Báo cáo doanh số bán hàng có quy cách', 
	 @ReportNameE = N'Report of sales turnover_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @ReportTitleE = N'REPORT OF SALES TURNOVER', @Description = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @DescriptionE = N'REPORT OF SALES TURNOVER', @Type = 902, @SQLstring = N'Select * From AV3023 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3024_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3024_QC', @ReportName = N'Báo cáo doanh số bán hàng có quy cách', 
	 @ReportNameE = N'Report of sales turnover_Specificate',  @ReportTitle = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @ReportTitleE = N'REPORT OF SALES TURNOVER', @Description = N'BÁO CÁO DOANH SỐ BÁN HÀNG', 
	 @DescriptionE = N'REPORT OF SALES TURNOVER', @Type = 903, @SQLstring = N'Select * From AV3026  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by ObjectID, InvoiceNo',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR3025_QC
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'ASoftT', @ReportID = N'AR3025_QC', @ReportName = N'Báo cáo danh sách hóa đơn có quy cách', 
	 @ReportNameE = N'Detail of invoice list_Specificate',  @ReportTitle = N'BÁO CÁO DANH SÁCH HÓA ĐƠN', 
	 @ReportTitleE = N'DETAIL OF INVOICE LIST', @Description = N'BÁO CÁO DANH SÁCH HÓA ĐƠN', 
	 @DescriptionE = N'DETAIL OF INVOICE LIST', @Type = 903, @SQLstring = N'Select * From AV3026 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by ObjectID, InvoiceNo',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR2207_QC
EXEC AP8888 @GroupID = N'G05', @ModuleID = 'ASoftWM', @ReportID = N'AR2207_QC', @ReportName = N'Báo cáo tồn kho theo tài khoản (Nhóm theo kho) có quy cách', 
	 @ReportNameE = N'Report of stock according to account (group by warehouse)_Specificate',  @ReportTitle = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN (NHÓM THEO KHO)', 
	 @ReportTitleE = N'REPORT OF STOCK ACCORDING TO ACCOUNT (GOUP BY WAREHOUSE)', @Description = N'BÁO CÁO TỒN KHO THEO TÀI KHOẢN (NHÓM THEO KHO)', 
	 @DescriptionE = N'REPORT OF STOCK ACCORDING TO ACCOUNT (GOUP BY WAREHOUSE)', @Type = 920, @SQLstring = N'Select * From AV2007  where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', 
	 @Orderby = N' Order by WareHouseID, InventoryID',
	 @TEST = 0, @TableID = N'AT8888'

---- Add AR0296: Thuế TNDN (PACIFIC)
EXEC AP8888 @GroupID = N'G99', @ModuleID = 'AsoftT', @ReportID = N'AR0296', @ReportName = N'Tờ khai nộp thuế TNDN',
	 @ReportNameE = N'Corporate Income Tax', @ReportTitle = N'TỜ KHAI NỘP THUẾ TNDN', @ReportTitleE = N'CORPORATE INCOME TAX', @Description = N'CORPORATE INCOME TAX', 
	 @DescriptionE = N'CORPORATE INCOME TAX', @Type = 35, @SQLstring = N'', @Orderby = N'',
	 @TEST = 0, @TableID = N'AT8888'

---- Modified by Bảo Thy on 27/06/2017: bổ sung mẫu Yêu cầu thanh toán và nhóm báo cáo tạm chi tiền mặt
---- Add AR3102: PHIẾU TẠM CHI
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3102', 
	 @ReportName = N'Phiếu tạm chi',  @ReportNameE  = N'Temporary Payment', 
	 @ReportTitle = N'PHIẾU TẠM CHI', @ReportTitleE = N'TEMPORARY PAYMENT',
	 @Description = N'Phiếu tạm chi', @DescriptionE = N'Temporary Payment', 
	 @Type = 10, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888' 

---- Add AR3103: YÊU CẦU THANH TOÁN
EXEC AP8888 @GroupID = N'G01', @ModuleID = 'AsoftT', @ReportID = N'AR3103', 
	 @ReportName = N'Yêu cầu thanh toán',  @ReportNameE  = N'Payment Request', 
	 @ReportTitle = N'YÊU CẦU THANH TOÁN', @ReportTitleE = N'PAYMENT REQUEST',
	 @Description = N'Yêu cầu thanh toán', @DescriptionE = N'Payment Request', 
	 @Type = 11, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888' 

---- Modified on 04/12/2018 by Kim Thư: Bổ sung mẫu Phiếu trả hàng - AR3039 - AR3040
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR3039', 
	 @ReportName = N'Phiếu trả hàng',  @ReportNameE  = N'Return', 
	 @ReportTitle = N'PHIẾU TRẢ HÀNG', @ReportTitleE = N'RETURN',
	 @Description = N'Phiếu trả hàng (HBTL)', @DescriptionE = N'Return', 
	 @Type = 100, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888' 

EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR3040', 
	 @ReportName = N'Phiếu trả hàng',  @ReportNameE  = N'Return', 
	 @ReportTitle = N'PHIẾU TRẢ HÀNG', @ReportTitleE = N'RETURN',
	 @Description = N'Phiếu trả hàng (HMTL)', @DescriptionE = N'Return', 
	 @Type = 101, @SQLstring = N'', @Orderby = N'', @TEST = 0, @TableID = N'AT8888' 

---- Modified on 21/11/2023 by Hoàng Long: Bổ sung mẫu Bổ sung báo cáo chi tiết số lượng hàng bán - AR3126NCK
IF @CustomerName = 166 --- Customize Nệm Kim Cương
BEGIN
EXEC AP8888 @GroupID = N'G07', @ModuleID = 'AsoftT', @ReportID = N'AR3126NKC', @ReportName = N'Báo cáo chi tiết số lượng hàng bán',
	 @ReportNameE = N'Detailed reports on the number of sales', @ReportTitle = N'BÁO CÁO CHI TIẾT SỐ LƯỢNG HÀNG BÁN', 
	 @ReportTitleE = N'DETAILED REPORTS ON THE NUMBER OF SALES', @Description = N'BÁO CÁO CHI TIẾT SỐ LƯỢNG HÀNG BÁN', 
	 @DescriptionE = N'DETAILED REPORTS ON THE NUMBER OF SALES', @Type = 27, @SQLstring = N'Select * From AV3121 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))', @Orderby = N'Order By Group1ID',
	 @TEST = 0, @TableID = N'AT8888'
END

DROP TABLE #CustomerName