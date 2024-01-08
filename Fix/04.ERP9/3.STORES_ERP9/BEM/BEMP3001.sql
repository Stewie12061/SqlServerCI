IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP3001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP3001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load dữ liệu báo cáo phiếu DNTT/DNTTTU/DNTU.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by	Đình Ly	on 23/06/2020
----Update by Tấn Thành on 29/07/2020
-- <Example>

CREATE PROCEDURE BEMP3001 
( 
	@DivisionID VARCHAR(50),
	@FromDatePeriodControl DATETIME = NULL,
	@ToDatePeriodControl DATETIME = NULL,
	@CheckListPeriodControl VARCHAR(200) = NULL,
	@IsPeriod VARCHAR(1) = NULL,
	@DepartmentID VARCHAR(MAX),
	@EmployeeID NVARCHAR(MAX),
	@TypeID VARCHAR(50)
) 
AS 
BEGIN

	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20)

	-- [Tấn Thành] - [29/07/2020] - Begin Update
	-- Thêm điều kiện lọc theo Kỳ và ngày
	IF(@IsPeriod = '0')
		BEGIN
			PRINT('NGÀY')
			SET @FromDateText = CONVERT(NVARCHAR(20), @FromDatePeriodControl, 111)
			SET @ToDateText = CONVERT(NVARCHAR(10), @ToDatePeriodControl, 111) + ' 23:59:59'
			SET @sWhere = '(B0.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	ELSE IF @IsPeriod = '1' AND ISNULL(@CheckListPeriodControl, '') != ''
		BEGIN
			PRINT('KỲ')
			SET @sWhere = 'RIGHT(CONCAT(''0'',B0.TranMonth,''/'',B0.TranYear),7) IN ( ''' + @CheckListPeriodControl + ''') '
		END

	-- [Tấn Thành] - [29/07/2020] - End Update

	IF ISNULL(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' AND B0.DivisionID IN (''' + @DivisionID + ''') '

	IF ISNULL(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND B0.DepartmentID IN (''' + @DepartmentID + ''') '

	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere = @sWhere + ' AND B0.ApplicantID IN (''' + REPLACE(@EmployeeID,',',''',''') + ''') '

	IF ISNULL(@TypeID, '') != ''
		SET @sWhere = @sWhere + ' AND B0.TypeID IN (''' + @TypeID + ''') '

	-- Trường hợp in báo cáo Đề nghị tạm ứng.
	IF @TypeID = 'DNTU'
	BEGIN
		SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY B0.VoucherNo) AS Row 
						 , B0.TypeID
						 , A2.AnaName AS DepartmentName
						 , B0.VoucherNo
						 , B0.DepartmentID
						 , B0.ApplicantID 
						 , B0.CurrencyID 
						 , B1.Description
						 , A3.FullName AS ApplicantName
						 , CASE B0.Status
								WHEN 0 THEN N''Chưa duyệt''
							ELSE N''Đã duyệt''
						 END AS Status
						 , CONVERT(VARCHAR, B0.Deadline, 103) AS Deadline
						 , CONVERT(VARCHAR, B0.VoucherDate, 103) AS VoucherDate
						 , CONVERT(varchar, CAST(B1.RequestAmount AS money), 1) AS AdvanceAmount
					FROM BEMT2001 B1 WITH(NOLOCK)
						LEFT JOIN BEMT2000 B0 WITH (NOLOCK) ON B0.APK = B1.APKMaster
						LEFT JOIN BEMT0000 B2 WITH (NOLOCK) ON B2.DivisionID = B1.DivisionID 
						LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaID = B0.DepartmentID AND A2.AnaTypeID = B2.SubsectionAnaID AND A2.DivisionID = B1.DivisionID
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = B0.ApplicantID
        			WHERE ' + @sWhere + ''
		EXEC (@sSQL)
	END

	-- Trường hợp in báo cáo Đề nghị thanh toán.
	IF @TypeID = 'DNTT'
	BEGIN
		SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY B0.VoucherNo) AS Row 
						 , B1.InvoiceNo
						 , B0.TypeID
						 , B0.VoucherNo
						 , B0.ApplicantID 
						 , B0.CurrencyID 
						 , B1.Description
						 , B0.AdvanceUserID
						 , B0.DepartmentID
						 , A2.AnaName AS DepartmentName
						 , A3.FullName AS ApplicantName
						 , A4.FullName AS AdvanceUserName
						 , CASE B0.Status
								WHEN 0 THEN N''Chưa duyệt''
							ELSE N''Đã duyệt''
						 END AS Status
						 , CONVERT(VARCHAR, B0.Deadline, 103) AS Deadline
						 , CONVERT(VARCHAR, B0.VoucherDate, 103) AS VoucherDate
						 , CONVERT(varchar, CAST(B1.RequestAmount AS money), 1) AS PaymentAmount
						 , CASE
								WHEN (A5.ObjectName IS NOT NULL AND A5.ObjectName <> '''')
								THEN A5.ObjectName
								WHEN (A5.ObjectName IS NULL OR A5.ObjectName = '''')
								THEN A5.ObjectID
							END AS SupplierName
					FROM BEMT2001 B1 WITH(NOLOCK)
						LEFT JOIN BEMT2000 B0 ON B0.APK = B1.APKMaster 
						LEFT JOIN BEMT0000 B2 WITH (NOLOCK) ON B2.DivisionID = B1.DivisionID
						LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaID = B0.DepartmentID AND A2.AnaTypeID = B2.SubsectionAnaID AND A2.DivisionID = B1.DivisionID
						LEFT JOIN AT1103 A3 ON A3.EmployeeID = B0.ApplicantID
						LEFT JOIN AT1103 A4 ON A4.EmployeeID = B0.AdvanceUserID
						LEFT JOIN AT1202 A5 ON A5.ObjectID = B0.AdvanceUserID AND A5.DivisionID IN (B1.DivisionID, ''@@@'')
        			WHERE ' + @sWhere + ''
		EXEC (@sSQL)
	END

	-- Trường hợp in báo cáo Đề nghị thanh toán tạm ứng.
	IF @TypeID = 'DNTTTU'
	BEGIN
		SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY B0.VoucherNo) AS Row 
						 , B0.TypeID
						 , B0.VoucherNo
						 , B0.ApplicantID 
						 , B0.CurrencyID 
						 , B1.Description
						 , B1.APKDInherited
						 , B0.DepartmentID
						 , A2.AnaName AS DepartmentName
						 , A3.FullName AS ApplicantName
						 , CASE B0.Status
								WHEN 0 THEN N''Chưa duyệt''
							ELSE N''Đã duyệt''
						 END AS Status
						 , B1.CostAnaID AS AdvanceRequestNo
						 , CONVERT(VARCHAR, B0.Deadline, 103) AS Deadline
						 , CONVERT(VARCHAR, B0.VoucherDate, 103) AS VoucherDate
						 , CONVERT(varchar, CAST(B1.RequestAmount AS money), 1) AS AdvanceAmount
						 , CONVERT(varchar, CAST(B3.RequestAmount AS money), 1) AS PaymentAmount
						 , CONVERT(varchar, CAST((B1.RequestAmount - B3.RequestAmount) AS money), 1) AS DifferenceAmount
					FROM BEMT2001 B1 WITH(NOLOCK)
						LEFT JOIN BEMT2000 B0 ON B0.APK = B1.APKMaster 
						LEFT JOIN BEMT0000 B2 WITH (NOLOCK) ON B2.DivisionID = B1.DivisionID
						LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaID = B0.DepartmentID AND A2.AnaTypeID = B2.SubsectionAnaID AND A2.DivisionID = B1.DivisionID
						LEFT JOIN AT1103 A3 ON A3.EmployeeID = B0.ApplicantID
						LEFT JOIN BEMT2001 B3 ON B3.APK = B1.APKDInherited
        			WHERE ' + @sWhere + ''
		EXEC (@sSQL)
	END

	PRINT (@sSQL)
END










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
