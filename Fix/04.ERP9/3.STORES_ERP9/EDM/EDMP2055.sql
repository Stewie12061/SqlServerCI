IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2055]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2055]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
----	Lấy danh sách khoản thu trong năm của học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: [Lương Mỹ] on [14/2/2020]
-- <Example>
---- 


CREATE PROCEDURE [dbo].[EDMP2055]
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@StudentID VARCHAR(50)='',
	@DateSearch DATETIME = NULL,
	@APK VARCHAR(50),	-- APK của EDMT2010
	@Mode INT			-- 0: Toàn bộ Gói phí theo tháng ( Không phân trang)
						-- 1: Toàn bộ Gói phí theo tháng ( phân trang)
						-- 2: Lịch sử thay đổi gói phí
						-- 3: Chỉ những Học phí, Tiền ăn TypeOfFee = 5,12,13 => Nghiệp vụ Thay đổi mức đóng
						-- 4: Chỉ những Học phí, Tiền ăn TypeOfFee = 5,12,13 & Tiền ăn trả lại 10,11 -- Phục vụ bảo lưu, chuyển nhượng
						-- 5: Toàn bộ Gói Phí search theo ToDate > DateSearch: Chú ý => Result là List
)
AS 


BEGIN 

DECLARE @sSQL VARCHAR(MAX) = N'',
		@sWhere VARCHAR(MAX) = N'',
		@sOrder VARCHAR(MAX) = N'',
		@sPageList VARCHAR(MAX) = N'',
		@SchoolYearID VARCHAR(50)

IF ISNULL(@StudentID,'') = ''
BEGIN

	SELECT @StudentID = StudentID FROM EDMT2010 WITH(NOLOCK) WHERE APK = @APK

END

SELECT @SchoolYearID = SchoolYearID FROM EDMT1040 WHERE GETDATE() BETWEEN DateFrom AND DateTo AND DivisionID IN (@DivisionID, '@@@')

-- Order By
SET @sOrder = N' ORDER BY T2.ReceiptTypeID, T2.FromDate';

-- Điều kiện Where
IF @DateSearch IS NOT NULL
BEGIN
	SET @sWhere = N' AND ''' + CONVERT(VARCHAR(50), @DateSearch) +''' BETWEEN T2.FromDate AND T2.ToDate'
END

-- Phân trang
SET @sPageList = N'
	OFFSET (' + CONVERT(VARCHAR(10), @PageNumber) + '-1) * ' + CONVERT(VARCHAR(10), @PageSize) + N' ROWS
	FETCH NEXT '+ CONVERT(VARCHAR(10), @PageSize) +' ROWS ONLY'	


SET @sSQL = N'T2.APK, T1.NewFeeID, T2.DivisionID, 
		T2.ReceiptTypeID, 
		T3.ReceiptTypeName, T3.TypeOfFee,
		T2.PaymentMethod, T4.Description AS PaymentMethodName, 
		T2.IsCSVC,
		T2.FromDate,T2.ToDate, 
		T2.Quantity,
		T2.UnitPrice, T2.Amount, T2.AmountPromotion, T2.AmountTotalPromotion,
		( T2.AmountTotalPromotion - (T2.AmountReceived - ISNULL(T5.ConvertedAmount,0) )  ) as AmountPaid,
		T2.DeleteFlg,
		T2.IsNew, T2.CreateDate
	FROM EDMT2200 T1 WITH(NOLOCK)
	INNER JOIN EDMT2201 T2 WITH(NOLOCK) ON T2.APKMaster = T1.APK 
	INNER JOIN EDMT1050 T3 WITH(NOLOCK) ON T3.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T4 WITH(NOLOCK) ON T4.ID = T2.PaymentMethod AND T4.CodeMaster=''PaymentMethod''
	INNER JOIN 
	(
		SELECT A2.APK, A2.ReceiptTypeID,A2.FromDate,A2.ToDate,A2.CreateDate,
		ROW_NUMBER() OVER (PARTITION BY A2.ReceiptTypeID,A2.FromDate ORDER BY A2.ReceiptTypeID,A2.FromDate,A2.CreateDate DESC ) AS RowIndex,
		MAX(A2.CreateDate) OVER (PARTITION BY A2.ReceiptTypeID ORDER BY A2.ReceiptTypeID,A2.FromDate,A2.CreateDate DESC,A2.LastModifyDate DESC ) AS MaxCreateDate
			FROM EDMT2200 A1 WITH(NOLOCK)
			INNER JOIN EDMT2201 A2 WITH(NOLOCK) ON A2.APKMaster = A1.APK 

				WHERE  A1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') 
				AND A1.SchoolYearID = ''' + @SchoolYearID +'''
				AND A1.StudentID = ''' + @StudentID +'''
				AND A1.DeleteFlg = 0
				AND A2.DeleteFlg = 2 -- Chỉ lấy dữ liệu ngầm

	)AS TableFinal ON TableFinal.APK = T2.APK AND TableFinal.RowIndex = 1 AND TableFinal.MaxCreateDate = T2.CreateDate
	--Lấy số tiền thu ở dưới 8
	LEFT JOIN AT9000 T5 WITH(NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.InventoryID = T2.ReceiptTypeID AND CONVERT(VARCHAR(50), T5.InheritTransactionID) = CONVERT(VARCHAR(50), T2.InheritTransactionID)
	WHERE 	T1.StudentID = ''' + @StudentID + ''' AND T1.SchoolYearID = ''' + @SchoolYearID +'''
	AND T2.DeleteFlg = 2
	'


-- 0: Load toàn bộ khoản phí của học sinh trong năm học hiện tại KHÔNG phân trang
IF @Mode = 0
BEGIN 

	SET @sSQL = N'SELECT  ' 
	+ @sSQL 
	+ @sWhere 
	+ @sOrder
	

END

-- 1: Load toàn bộ khoản phí của học sinh trong năm học hiện tại có phân trang
IF @Mode = 1
BEGIN 
	SET @sSQL = N'SELECT CONVERT(INT, ROW_NUMBER() OVER (' + @sOrder +' )) AS RowNum, COUNT(*) OVER () AS TotalRow,
	' 
	+ @sSQL 
	+ @sWhere 
	+ @sOrder
	+ @sPageList
	
END

-- 2: Lịch sử thay đổi gói phí
IF @Mode = 2
BEGIN 

	SET @sSQL = N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (' + @sOrder+ N')) AS RowNum, COUNT(*) OVER () AS TotalRow,
	T1.APK, T1.VoucherNo, T1.StudentID,
	T2.ReceiptTypeID, T5.ReceiptTypeName,
	T1.ImlementationDate,
	T2.CurrentPaymentMethod, T6.Description AS OldPaymentMethodName, 
	T2.PaymentMethod, T7.Description AS NewPaymentMethodName,
	T2.FromDate,T2.ToDate, T2.AmountReceived,
	T2.DeleteFlg

	FROM EDMT2200 T1 WITH(NOLOCK)
	INNER JOIN EDMT2201 T2 WITH(NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg = 0 -- Chỉ load các dòng lưu

	INNER JOIN EDMT1050 T5 WITH(NOLOCK) ON T5.ReceiptTypeID = T2.ReceiptTypeID
	LEFT JOIN EDMT0099 T6 WITH(NOLOCK) ON T6.ID = T2.CurrentPaymentMethod AND T6.CodeMaster=''PaymentMethod''
	LEFT JOIN EDMT0099 T7 WITH(NOLOCK) ON T7.ID = T2.PaymentMethod AND T7.CodeMaster=''PaymentMethod''

	WHERE T1.StudentID = ''' + @StudentID + ''' AND T1.SchoolYearID = ''' + @SchoolYearID +'''
	AND ISNULL(T1.VoucherNo, '''') <> ''''
	'
	+@sOrder
	+@sPageList

END

-- 3: Chỉ những Học phí, Tiền ăn TypeOfFee = 5,12,13
IF @Mode = 3
BEGIN 

	SET @sWhere = @sWhere + N' AND T3.TypeOfFee IN (5,12,13) '

	SET @sSQL = N'SELECT DISTINCT ' 
	+ @sSQL 
	+ @sWhere 
	+ @sOrder
	

END


-- 4: Chỉ những Học phí, Tiền ăn TypeOfFee = 5,12,13 & Tiền ăn trả lại 10,11
-- Bảo lưu, nghỉ học
IF @Mode = 4
BEGIN 
	DECLARE 
			@sSQL2 VARCHAR(MAX) = N''

	SET @sSQL2 = N'

	UNION ALL 
----Lấy khoản thu tiền ăn hoàn trả 
SELECT T2.APK, T1.FeeID, T1.DivisionID, T2.ReceiptTypeID, T3.ReceiptTypeName, T3.TypeOfFee,
NULL AS PaymentMethod, NULL AS IsCVC, NULL AS PaymentMethodName, NULL AS FromDate, NULL AS ToDate, 0 AS Quantity,
T2.AmountOfDay AS UnitPrice, T2.AmountOfDay AS Amount, 0 AS AmountPromotion, T2.AmountOfDay AS AmountTotalPromotion, 0 as AmountPaid,
0 AS DeleteFlg, 0 AS IsNew, T1.CreateDate

	
FROM EDMT1090 T1 WITH(NOLOCK)
LEFT JOIN EDMT1091 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster 
LEFT JOIN EDMT1050 T3 WITH (NOLOCK) ON T2.ReceiptTypeID = T3.ReceiptTypeID 
LEFT JOIN EDMT1051 T4 WITH (NOLOCK) ON T3.APK = T4.APKMaster 
LEFT JOIN EDMT2013 T5 WITH (NOLOCK) ON T5.FeeID = T1.FeeID AND T5.SchoolYearID = ''' + @SchoolYearID +'''
OUTER APPLY (SELECT TOP 1 * FROM EDMT2013 A1 WITH (NOLOCK) WHERE T5.SchoolYearID = A1.SchoolYearID AND T5.StudentID = A1.StudentID  AND A1.DeleteFlg = 0 
			 ORDER BY A1.CreateDate DESC) A
WHERE T3.TypeOfFee IN (10,11) AND T4.Business = 4 AND T5.StudentID = ''' + @StudentID + ''' AND A.APK = T5.APK
	'
	SET @sWhere = @sWhere + N' AND T3.TypeOfFee IN (5,12,13) AND T2.IsNew = 0'

	SET @sSQL = N'SELECT ' 
	+ @sSQL 
	+ @sWhere 
	--End SQL1
	+ @sSQL2
	

END

-- 5: Toàn bộ Gói Phí search theo ToDate > DateSearch
-- Trả ra List
IF @Mode = 5
BEGIN 
	
	-- Điều kiện Where mới
	IF @DateSearch IS NOT NULL
	BEGIN
		SET @sWhere = N' AND T2.ToDate > ''' + CONVERT(VARCHAR(50), @DateSearch) +''' '
	END


	SET @sSQL = N'SELECT  ' 
	+ @sSQL 
	+ @sWhere 
	+ @sOrder
	

END

print (@sSQL)
EXEC (@sSQL)

END 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
