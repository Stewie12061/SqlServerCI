IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load dữ liệu màn hình Danh sách phiếu DNTT/DNTTTU/DNTU - BEMF2000
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Vĩnh Tâm, Date 19/06/2020
----Modified by: Vĩnh Tâm, Date 22/10/2020: Bổ sung lấy dữ liệu theo Phân quyền dữ liệu của màn hình BEMF2000
----Modified by: Vĩnh Tâm, Date 02/11/2020: Fix lỗi không search được dữ liệu có dấu tiếng Việt
----Modified by: Vĩnh Tâm, Date 19/01/2021: Bổ sung lọc nâng cao và SearchMode để lọc dữ liệu cho chức năng Xét duyệt
----Modified by: Trọng Kiên, Date 19/02/2021: Fix dữ số tiền RequestAmount = AdvancePayment (TẤN TÀI làm)
---- Updated by Đình Ly on 29/03/2021 - Load dữ liệu cột Phân loại nguồn hình thành (FormationID).
/* <Example
	EXEC [BEMP2000] 
	@DivisionID = N'MK', @DivisionIDList = N'', @VoucherNo = N'', @IsPeriod = 0, @FromDate = N'2020-10-10 00:00:00', 
	@ToDate = N'2020-10-22 00:00:00', @ListPeriod = N'', @TypeID = N'', @ApplicantID = N'', @AdvanceUserID = N'', 
	@Status = N'', @SearchMode = N'1', @ConditionBEMT2000 = N'000060,UNASSIGNED', @PageNumber = 1, @PageSize = 25
 */

CREATE PROCEDURE BEMP2000
( 
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@VoucherNo VARCHAR(50),
	@IsPeriod INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ListPeriod VARCHAR(500),
	@TypeID VARCHAR(50),
	@FormationID VARCHAR(50),
	@ApplicantID NVARCHAR(250),
	@AdvanceUserID NVARCHAR(50),
	@Status VARCHAR(50),
	@SearchMode VARCHAR(50),			-- 1: Search dữ liệu, 2: Search xét duyệt
	@ConditionBEMT2000 VARCHAR(MAX),
	@SearchWhere NVARCHAR(MAX),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sSQL1 NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@sSQLPermission NVARCHAR(MAX),
			@sSQLJoinPermission NVARCHAR(MAX) = '',
			@sSelectApproval NVARCHAR(MAX) = '',
			@sJoinApproval NVARCHAR(MAX) = '',
			@sWhereApproval NVARCHAR(MAX) = ''

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'B1.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Trường hợp không dùng Search nâng cao
	IF ISNULL(@SearchWhere, '') = ''
	BEGIN
		-- Check Para DivisionIDList null then get DivisionID
		IF ISNULL(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionIDList + ''') '
		ELSE
			SET @sWhere = @sWhere + ' (B1.DivisionID = ''' + @DivisionID + ''') '

		IF ISNULL(@VoucherNo, '') != ''
			SET @sWhere = @sWhere + ' AND (ISNULL(B1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'') '

		IF ISNULL(@TypeID, '') != ''
			SET @sWhere = @sWhere + ' AND (ISNULL(B1.TypeID, '''') = ''' + @TypeID + ''') '

		IF ISNULL(@FormationID, '') != ''
			SET @sWhere = @sWhere + ' AND (ISNULL(B1.InheritType, '''') = ''' + @FormationID + ''') '

		IF ISNULL(@ApplicantID, '') != ''
			SET @sWhere = @sWhere + N' AND (ISNULL(A2.FullName, '''') LIKE N''%' + @ApplicantID + N'%'' OR ISNULL(B1.ApplicantID, '''') LIKE N''%' + @ApplicantID + '%'') '

		IF ISNULL(@AdvanceUserID, '') != ''
			SET @sWhere = @sWhere + N' AND (ISNULL(A1.ObjectName, '''') LIKE N''%' + @AdvanceUserID + '%'' OR ISNULL(B1.AdvanceUserID, '''') LIKE N''%' + @AdvanceUserID + '%'') '
		
		-- Lọc theo Ngày
		IF @IsPeriod = 0
		BEGIN
			IF (ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate >= ''' + @FromDateText + ''' OR B1.VoucherDate >= ''' + @FromDateText + ''')'
			END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate <= ''' + @ToDateText + ''' OR B1.VoucherDate <= ''' + @ToDateText + ''')'
			END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
		END
		ELSE IF @IsPeriod = 1 AND ISNULL(@ListPeriod, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND RIGHT(CONCAT(''0'', B1.TranMonth, ''/'', B1.TranYear), 7) IN (''' + @ListPeriod + ''') '
		END
	END
	-- Trường hợp dùng Search nâng cao
	ELSE
	BEGIN
		SET @sWhere = ' 1 = 1'
	END

	-- Trường hợp lọc dữ liệu Xét duyệt
	IF @SearchMode = 2
	BEGIN
		-- Bỏ điều kiện lọc dữ liệu theo phân quyền dữ liệu
		SET @sSQLJoinPermission = N''
	END
	ELSE
	BEGIN
		-- Lọc dữ liệu theo phân quyền dữ liệu
		SET @sSQLJoinPermission = N'INNER JOIN #PermissionBEMT2000 P1 ON P1.Value IN (B1.CreateUserID, B1.ApplicantID)'

		IF ISNULL(@Status, '') != ''
			SET @sWhere = @sWhere + ' AND (ISNULL(B1.Status, ''0'') = ''' + @Status + ''') '
	END

	SET @sSQLPermission = N'IF OBJECT_ID(''tempdb..#PermissionBEMT2000'') IS NOT NULL DROP TABLE #PermissionBEMT2000

			SELECT Value
			INTO #PermissionBEMT2000
			FROM STRINGSPLIT(''' + ISNULL(@ConditionBEMT2000, '') + N''', '','')

			IF OBJECT_ID(''tempdb..#FilterRequestAPK'') IS NOT NULL DROP TABLE #FilterRequestAPK

			SELECT DISTINCT B1.APK
			INTO #FilterRequestAPK
			FROM BEMT2000 B1 WITH (NOLOCK)
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = B1.AdvanceUserID AND A1.DivisionID = B1.DivisionID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = B1.ApplicantID AND A2.DivisionID = B1.DivisionID
				' + @sSQLJoinPermission + '
			WHERE ISNULL(B1.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			'

	-- Trường hợp lọc dữ liệu Tra cứu
	IF @SearchMode = 1
	BEGIN
		SET @sSQL = N'SELECT B1.APK, B1.APKMaster_9000, B1.DivisionID, B1.VoucherNo, B1.VoucherDate
				, CASE
					WHEN B1.InheritType IS NULL THEN ISNULL(B2.Description, B1.TypeID)
					ELSE CONCAT(ISNULL(B2.Description, B1.TypeID), '' - '', B1.InheritType)
				END AS TypeID
				, A4.AnaName AS DepartmentID
				, B1.AdvanceUserID
				, A1.ObjectName AS AdvanceUserName
				, A2.FullName AS ApplicantName
				, B1.Status, O1.Description AS StatusName
				, B1.DueDate, B1.Deadline
				, (SELECT SUM(ISNULL(BEMT2001.RequestAmount,0)) FROM BEMT2001 WHERE BEMT2001.APKmaster =  B1.APK) AS AdvancePayment
				, B1.CurrencyID
				, ISNULL(A3.Description, B1.FCT) AS FCT
				, ISNULL(A5.PaymentName, B1.MethodPay) AS MethodPay
				, ISNULL(A6.PaymentTermName, B1.PaymentTermID) AS PaymentTermID
				, B1.DescriptionMaster, B1.CreateDate, B1.TypeID AS TypeID_Print, B1.InheritType
			INTO #BEMFT2000
			FROM BEMT2000 B1 WITH (NOLOCK)
				INNER JOIN #FilterRequestAPK F1 ON F1.APK = B1.APK
				LEFT JOIN BEMT0000 B0 WITH (NOLOCK) ON B0.DivisionID = B1.DivisionID
				LEFT JOIN BEMT0099 B2 WITH (NOLOCK) ON B2.ID = B1.TypeID AND B2.CodeMaster = ''ProposalTypeID''
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID = B1.DivisionID AND A1.ObjectID = B1.AdvanceUserID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.DivisionID = B1.DivisionID AND A2.EmployeeID = B1.ApplicantID
				LEFT JOIN AT0099 A3 WITH (NOLOCK) ON A3.ID = B1.FCT AND A3.CodeMaster = ''AT00000004''
				LEFT JOIN AT1011 A4 WITH (NOLOCK) ON B0.DivisionID = A4.DivisionID AND A4.AnaTypeID = B0.SubsectionAnaID AND A4.AnaID = B1.DepartmentID
				LEFT JOIN AT1205 A5 WITH (NOLOCK) ON A5.DivisionID IN (B1.DivisionID, ''@@@'') AND A5.PaymentID = B1.MethodPay
				LEFT JOIN AT1208 A6 WITH (NOLOCK) ON A6.DivisionID IN (B1.DivisionID, ''@@@'') AND A6.PaymentTermID = B1.PaymentTermID
				LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = ISNULL(B1.Status, 0) AND O1.CodeMaster = ''Status''
			ORDER BY ' + @OrderBy + ''
	END
	-- Trường hợp lọc dữ liệu Xét duyệt
	ELSE IF @SearchMode = 2
	BEGIN
		SET @sSQL = N'SELECT B1.APK, B1.APKMaster_9000, B1.DivisionID, B1.VoucherNo, B1.VoucherDate
				, CASE
					WHEN B1.InheritType IS NULL THEN ISNULL(B2.Description, B1.TypeID)
					ELSE CONCAT(ISNULL(B2.Description, B1.TypeID), '' - '', B1.InheritType)
				END AS TypeID
				, A4.AnaName AS DepartmentID
				, B1.AdvanceUserID
				, A1.ObjectName AS AdvanceUserName
				, A2.FullName AS ApplicantName
				, OOT91.Status, O1.Description AS StatusName
				, B1.DueDate, B1.Deadline
				, (SELECT SUM(ISNULL(BEMT2001.RequestAmount,0)) FROM BEMT2001 WHERE BEMT2001.APKmaster =  B1.APK) AS AdvancePayment
				, B1.CurrencyID
				, ISNULL(A3.Description, B1.FCT) AS FCT
				, ISNULL(A5.PaymentName, B1.MethodPay) AS MethodPay
				, ISNULL(A6.PaymentTermName, B1.PaymentTermID) AS PaymentTermID
				, B1.DescriptionMaster, B1.CreateDate, B1.TypeID AS TypeID_Print, B1.InheritType
			INTO #BEMFT2000
			FROM BEMT2000 B1 WITH (NOLOCK)
				INNER JOIN #FilterRequestAPK F1 ON F1.APK = B1.APK
				INNER JOIN
				(
					SELECT MIN(Level) AS Level, DivisionID, ApprovePersonID, APKMaster, APKDetail
					FROM OOT9001 WITH (NOLOCK)
					GROUP BY DivisionID, ApprovePersonID, APKMaster, APKDetail
				) OOT9 ON OOT9.DivisionID = B1.DivisionID AND OOT9.APKMaster = B1.APKMaster_9000
				INNER JOIN OOT9001 OOT91 WITH (NOLOCK) ON OOT91.DivisionID = OOT9.DivisionID AND OOT91.APKMaster = OOT9.APKMaster AND OOT91.ApprovePersonID = ''' + @UserID + '''
								AND ISNULL(CAST(OOT91.APKDetail AS VARCHAR(50)), '''') = ISNULL(CAST(OOT9.APKDetail AS VARCHAR(50)), '''') AND OOT91.Level = OOT9.Level
				LEFT JOIN OOT9001 OOT912 WITH (NOLOCK) ON OOT912.DivisionID = OOT91.DivisionID AND OOT912.APKMaster = OOT91.APKMaster 
								AND ISNULL(CAST(OOT912.APKDetail AS VARCHAR(50)), '''') = ISNULL(CAST(OOT91.APKDetail AS VARCHAR(50)), '''') AND OOT912.[Level] = OOT91.[Level] - 1
				LEFT JOIN BEMT0000 B0 WITH (NOLOCK) ON B0.DivisionID = B1.DivisionID
				LEFT JOIN BEMT0099 B2 WITH (NOLOCK) ON B2.ID = B1.TypeID AND B2.CodeMaster = ''ProposalTypeID''
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID = B1.DivisionID AND A1.ObjectID = B1.AdvanceUserID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.DivisionID = B1.DivisionID AND A2.EmployeeID = B1.ApplicantID
				LEFT JOIN AT0099 A3 WITH (NOLOCK) ON A3.ID = B1.FCT AND A3.CodeMaster = ''AT00000004''
				LEFT JOIN AT1011 A4 WITH (NOLOCK) ON B0.DivisionID = A4.DivisionID AND A4.AnaTypeID = B0.SubsectionAnaID AND A4.AnaID = B1.DepartmentID
				LEFT JOIN AT1205 A5 WITH (NOLOCK) ON A5.DivisionID IN (B1.DivisionID, ''@@@'') AND A5.PaymentID = B1.MethodPay
				LEFT JOIN AT1208 A6 WITH (NOLOCK) ON A6.DivisionID IN (B1.DivisionID, ''@@@'') AND A6.PaymentTermID = B1.PaymentTermID
				LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = ISNULL(OOT91.Status, 0) AND O1.CodeMaster = ''Status''
			WHERE ISNULL(OOT912.[Status], 3) NOT IN (0, 2) AND ISNULL(OOT91.Status, 0) = ' + @Status + '
			ORDER BY ' + @OrderBy + ''
	END

	-- Set cứng giá trị Type = 'PDN' để xử lý cho trường hợp xét duyệt tại màn hình BEMF2000
	SET @sSQL1 = N'
	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, COUNT(*) OVER () AS TotalRow
		, APK, APKMaster_9000, DivisionID, VoucherNo, VoucherDate, TypeID, DepartmentID
		, AdvanceUserID, AdvanceUserName, ApplicantName, Status, StatusName, DueDate
		, Deadline, AdvancePayment, CurrencyID, FCT, MethodPay, PaymentTermID, CreateDate, InheritType
		, DescriptionMaster, ''PDN'' AS Type, TypeID_Print
	FROM #BEMFT2000 B1
	' + ISNULL(@SearchWhere, '') + '
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	--PRINT(@sSQLPermission)
	--PRINT(@sSQL)
	--PRINT(@sSQL1)
	EXEC (@sSQLPermission + @sSQL + @sSQL1)
	PRINT (@sSQLPermission + @sSQL + @sSQL1)

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
