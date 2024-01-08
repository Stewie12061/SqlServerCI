IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2004_EXV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2004_EXV]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- In phiếu chất lượng đầu ca - EXEDY
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by Viết Toàn on 29/06/2023
----Modified by Mạnh Cường on 28/07/2023: Cải tiến hiệu suất truy vấn
----Modified by ... on ...

CREATE PROCEDURE [dbo].[QCP2004_EXV]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK_QCT2001 NVARCHAR(50),
	 @InheritTable NVARCHAR(50)
)
AS
DECLARE @APK NVARCHAR(50)


SELECT @APK = APKMaster FROM QCT2001 WHERE APK = @APK_QCT2001

-- Phần thông tin chung: Sheet1 + Sheet2
IF @InheritTable = N'OT3001' -- Phiếu kế thừa từ đơn hàng mua
BEGIN
	SELECT N'Model' AS Model
					, @InheritTable AS [Table]
					, N'TIÊU CHUẨN KIỂM TRA HÀNG NHẬP' AS TitleVN
					, N'RECEIVING INSPECTION STANDARD' AS TitleENG
					, Q00.VoucherNo
					, Q00.VoucherDate
					, AT11.AnaID
					, AT11.AnaName
					, Q01.InventoryID
					, A02.InventoryName
					, OT01.ObjectName AS Supplier
					, Q20.Notes02
					, Q20.Notes03
					, Q20.UpdateDate
					, Q00.SourceNo
					, OT01.OrderDate
					, A02.I01ID
					, Q01.MethodTestID
	FROM QCT2000 Q00 WITH (NOLOCK)
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.APKMaster = Q00.APK
		LEFT JOIN OT3001 OT01 WITH (NOLOCK) ON OT01.APK = Q01.InheritVoucher
		LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON Q00.Ana04ID = AT11.AnaID
		LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON Q00.ObjectID = AT02.ObjectID
		LEFT JOIN QCT1020 Q20 WITH (NOLOCK) ON Q20.InventoryID = Q01.InventoryID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = Q01.InventoryID
	WHERE Q00.APK = @APK
		AND Q01.DivisionID = @DivisionID
		AND Q01.APK = @APK_QCT2001
END
ELSE IF @InheritTable = N'MT2211' 
BEGIN
	SELECT N'Model' AS Model
					, @InheritTable AS [Table]
					, N'TIÊU CHUẨN KIỂM TRA CÔNG ĐOẠN SẢN XUẤT' AS TitleVN
					, N'PRODUCTION INSPECTION STANDARD' AS TitleENG
					, Q00.VoucherNo
					, Q00.VoucherDate -- Ngày kiểm tra
					, AT11.AnaID
					, AT11.AnaName
					, Q01.InventoryID
					, A02.InventoryName
					, Q20.Notes02
					, Q20.Notes03
					, Q20.UpdateDate
					, Q00.SourceNo
					, A02.I01ID
					, Q01.MethodTestID
					, A26.PhaseName
	FROM QCT2000 Q00 WITH (NOLOCK)
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.APKMaster = Q00.APK
		LEFT JOIN MT2211 MT11 WITH (NOLOCK) ON Q01.InheritVoucher = MT11.APK
		LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON Q00.Ana04ID = AT11.AnaID
		LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON Q00.ObjectID = AT02.ObjectID
		LEFT JOIN QCT1020 Q20 WITH (NOLOCK) ON Q20.InventoryID = Q01.InventoryID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = Q01.InventoryID
		LEFT JOIN AT0126 A26 WITH (NOLOCK) ON A26.PhaseID = Q01.PhaseID
	WHERE Q00.APK = @APK
		AND Q01.DivisionID = @DivisionID
		AND Q01.APK = @APK_QCT2001
END
ELSE
BEGIN
	SELECT N'Model' AS Model
					, @InheritTable AS [Table]
					, N'TIÊU CHUẨN KIỂM TRA HÀNG XUẤT' AS TitleVN
					, N'DELIVERY INSPECTION STANDARD' AS TitleENG
					, Q00.VoucherNo
					, Q00.VoucherDate
					, AT11.AnaID
					, AT11.AnaName
					, Q01.InventoryID
					, A02.InventoryName
					, AT02.ObjectName
					, Q20.Notes02
					, Q20.Notes03
					, Q20.UpdateDate
					, WT95.VoucherDate AS DeliveryDate -- Ngày xuất
					, A02.I01ID
					, Q01.MethodTestID
	FROM QCT2000 Q00 WITH (NOLOCK)
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.APKMaster = Q00.APK
		LEFT JOIN WT0096 WT96 WITH (NOLOCK) ON WT96.APK = Q01.InheritVoucher
		LEFT JOIN WT0095 WT95 WITH (NOLOCK) ON WT95.VoucherID = WT96.VoucherID
		LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON Q00.Ana04ID = AT11.AnaID
		LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON Q00.ObjectID = AT02.ObjectID
		LEFT JOIN QCT1020 Q20 WITH (NOLOCK) ON Q20.InventoryID = Q01.InventoryID
		LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = Q01.InventoryID
	WHERE Q00.APK = @APK
		AND Q01.DivisionID = @DivisionID
		AND Q01.APK = @APK_QCT2001
END

-- Phần hình ảnh
SELECT TOP 1 N'Model1' AS Model
	, @InheritTable AS [Table]
	, CRM02.APK
	, CRM02.AttachID
	, CRM02.AttachFile
	, CRM02.AttachName
FROM CRMT00002 CRM02
	INNER JOIN CRMT00002_REL CRM02_REL WITH (NOLOCK) ON CRM02.AttachID = CRM02_REL.AttachID
	LEFT JOIN QCT1020 QCT20 WITH (NOLOCK) ON CONVERT(NVARCHAR(50), QCT20.APK) = CRM02_REL.RelatedToID
	LEFT JOIN QCT2001 QCT01 WITH (NOLOCK) ON QCT20.InventoryID = QCT01.InventoryID
WHERE CRM02_REL.DivisionID IN ('@@@', @DivisionID)
	AND CRM02_REL.RelatedToTypeID_REL = 47
	AND QCT01.APK = @APK_QCT2001
ORDER BY CRM02.CreateDate DESC

-- Phần lịch sử chỉnh sửa
	SELECT * INTO TEMPP_HISTORY FROM A00001 WHERE LanguageID = 'vi-VN' AND Module IN ('00', 'QC');
	SELECT TOP 1 ROW_NUMBER() OVER (ORDER BY QCT03.CreateDate DESC) AS RowNum
			, COUNT(*) OVER () AS TotalRow
			, N'Model2' AS Model
			, @InheritTable AS [Table]
			, QCT03.APK
			, QCT03.DivisionID
			, QCT03.HistoryID 
			, dbo.QCF_ContentChange(QCT03.[Description]) AS [Description] -- thông tin lịch sử chỉnh sửa
			, QCT03.RelatedToID
			, QCT03.RelatedToTypeID
			, QCT03.CreateDate -- thời gian chỉnh sửa
			, AT03.FullName AS [Name] -- Người chỉnh sửa
	FROM QCT2001 QCT01
		INNER JOIN QCT1020 QCT20 WITH (NOLOCK) ON QCT20.InventoryID = QCT01.InventoryID
		LEFT JOIN QCT00003 QCT03 WITH (NOLOCK) ON QCT20.APK = QCT03.RelatedToID
		LEFT JOIN CRMT0099 CRMT99 WITH (NOLOCK) ON CRMT99.ID = QCT03.StatusID AND CRMT99.CodeMaster = N'CRMT00000016'
		LEFT JOIN AT1103 AT03 WITH (NOLOCK) ON QCT03.CreateUserID = AT03.EmployeeID
	WHERE QCT01.APK = @APK_QCT2001
		AND QCT01.DivisionID = @DivisionID
	ORDER BY QCT03.CreateDate DESC
	DROP TABLE TEMPP_HISTORY
-- Inspection items haven't in picture (Lấy những tiêu chuẩn thuộc loại tiêu chuẩn khác)

	SELECT ROW_NUMBER() OVER (ORDER BY Q02.Orders) AS RowNum
		   , COUNT(*) OVER () AS TotalRow
		   , N'Model3' AS Model
		   , @InheritTable AS [Table]
		   , CONCAT(Q10.StandardID, '(', Q10.StandardName, ')') AS StandardName -- Tên tiêu chuẩn
		   , Q02.Standard AS [Target] -- Mục tiêu
		   , Q21.SRange02 AS MinValue -- Nhỏ nhất
		   , Q21.SRange04 AS MaxValue -- Lớn nhất
	FROM QCT2002 Q02 WITH (NOLOCK)
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q02.APKMaster = Q01.APK
		LEFT JOIN QCT1000 Q10 WITH (NOLOCK) ON Q10.StandardID = Q02.StandardID
		LEFT JOIN QCT1020 Q20 WITH (NOLOCK) ON Q01.InventoryID = Q20.InventoryID
		LEFT JOIN QCT1021 Q21 WITH (NOLOCK) ON Q21.APKMaster = Q20.APK AND Q21.StandardID = Q02.StandardID
	WHERE Q01.APK = @APK_QCT2001
		AND Q01.DivisionID IN ('@@@', @DivisionID)
		AND Q10.TypeID = N'OTH'
	ORDER BY Q02.Orders

-- Thông tin chi tiết

	SELECT ROW_NUMBER() OVER (ORDER BY Q02.Orders) AS RowNum
		   , COUNT(*) OVER () AS TotalRow
		   , N'Model4' AS Model
		   , CONCAT(Q10.StandardName, '/ ', Q10.StandardNameE) AS StandardName
		   , Q10.StandardNameE
		   , Q21.SRange03 AS [Target]
		   , Q21.SRange02 AS MinValue -- Ngưỡng dưới
		   , Q21.SRange04 AS MaxValue -- Ngưỡng trên
		   , Q21.SRange06 AS Tool 
		   , Q21.SRange07 AS Class
		   , Q02.CheckValue AS CheckValue01 -- Giá trị kiểm tra 01
		   , Q02.CheckValue02 AS CheckValue02 -- Giá trị kiểm tra 02
		   , Q02.CheckValue03 AS CheckValue03 -- Giá trị kiểm tra 03
		   , Q02.CheckValue04 AS Checkvalue04 -- Giá trị kiểm tra 04
		   , Q02.CheckValue05 AS CheckValue05 -- Giá trị kiểm tra 05
		   , Q02.SRange09
		   , CASE WHEN ISNULL(Q02.StatusID, 0) = 0 THEN NULL 
				  WHEN ISNULL(Q02.StatusID, 0) = 1 THEN N'OK'
				  ELSE N'NG' END AS StatusName
	FROM QCT2002 Q02 WITH (NOLOCK)
		LEFT JOIN QCT2001 Q01 WITH (NOLOCK) ON Q01.APK = Q02.APKMaster
		LEFT JOIN QCT1000 Q10 WITH (NOLOCK) ON Q10.StandardID = Q02.StandardID
		LEFT JOIN QCT1020 Q20 WITH (NOLOCK) ON Q01.InventoryID = Q20.InventoryID
		LEFT JOIN QCT1021 Q21 WITH (NOLOCK) ON Q21.APKMaster = Q20.APK AND Q21.StandardID = Q02.StandardID
	WHERE Q01.APK = @APK_QCT2001
		AND Q01.DivisionID IN ('@@@', @DivisionID)
		AND Q10.TypeID <> N'OTH'
	ORDER BY Q02.Orders





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

