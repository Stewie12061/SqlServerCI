IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load dữ liệu bảng BEMT2010 theo điều kiện.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 29/05/2020
----Modified by: Vĩnh Tâm, Date 22/10/2020: Fix lỗi không search được dữ liệu theo Trạng thái duyệt và Đối tượng tạm ứng
----Modified by: Vĩnh Tâm, Date 02/11/2020: Fix lỗi không search được dữ liệu có dấu tiếng Việt
----Modified by: Vĩnh Tâm, Date 25/01/2021: Update câu query load dữ liệu khi có nhiều cấp duyệt

/*
EXEC [BEMP2010]
	@DivisionIDList = N'', @DivisionID = N'MK', @PageNumber = 1, @PageSize = 25, @VoucherNo = N'',
	@StatusID = N'', @TypeID = N'', @TypeBSTripID = N'', @ApplicantName = N'', @FromDate = N'2020-11-02 00:00:00',
	@ToDate = N'2020-11-02 00:00:00', @IsPeriod = 0, @PeriodList = N'', @AdvancePaymentUserName = N'dũng', @DepartmentCharged = N'',
	@ConditionBEMT2010 = N'000060,UNASSIGNED'
 */

CREATE PROCEDURE BEMP2010 
( 
	@DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(MAX),
	@VoucherNo VARCHAR(50),
	@StatusID VARCHAR(50),
	@TypeID VARCHAR(50),
	@TypeBSTripID VARCHAR(50),
	@ApplicantName NVARCHAR(50),
	@AdvancePaymentUserName NVARCHAR(50),
	@DepartmentCharged VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@ConditionBEMT2010 VARCHAR(MAX)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@sSQLPermission NVARCHAR(MAX)
        
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'B1.VoucherNo DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
-- Check Para DivisionIDList null then get DivisionID
IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionIDList + ''') '
ELSE
	SET @sWhere = @sWhere + ' (B1.DivisionID = ''' + @DivisionID + ''') '

IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'') '

IF ISNULL(@StatusID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.Status, '''') = ''' + @StatusID + ''') '

IF ISNULL(@TypeID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.TypeID, '''') = ''' + @TypeID + ''') '

IF ISNULL(@TypeBSTripID, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.TypeBSTripID, '''') = ''' + @TypeBSTripID + ''') '

IF ISNULL(@DepartmentCharged, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(B1.DepartmentCharged, '''') = ''' + @DepartmentCharged + ''') '

IF ISNULL(@ApplicantName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A2.FullName, '''') LIKE N''%' + @ApplicantName + '%'' OR ISNULL(A2.EmployeeID, '''') LIKE N''%' + @ApplicantName + '%'') '	

IF ISNULL(@AdvancePaymentUserName, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(A1.ObjectID, '''') LIKE N''%' + @AdvancePaymentUserName + '%'' OR ISNULL(A1.ObjectName, '''') LIKE N''%' + @AdvancePaymentUserName + '%'') '	

-- Lọc theo FromDate và ToDate
IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate >= ''' + @FromDateText + '''
													OR B1.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate <= ''' + @ToDateText + ''' 
													OR B1.VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (B1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND RIGHT(CONCAT(''0'', B1.TranMonth, ''/'', B1.TranYear), 7) IN ( ''' + @PeriodList + ''') '
	END

SET @sSQLPermission = 'IF OBJECT_ID(''tempdb..#PermissionBEMT2010'') IS NOT NULL DROP TABLE #PermissionBEMT2010
								
							SELECT Value
							INTO #PermissionBEMT2010
							FROM STRINGSPLIT(''' + ISNULL(@ConditionBEMT2010, '') + ''', '','')

							IF OBJECT_ID(''tempdb..#FilterRequestAPK'') IS NOT NULL DROP TABLE #FilterRequestAPK

							SELECT DISTINCT B1.APK
							INTO #FilterRequestAPK
							FROM BEMT2010 B1 WITH (NOLOCK)
									LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = B1.AdvancePaymentUserID AND A1.DivisionID = B1.DivisionID
									LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = B1.Applicant AND A2.DivisionID = B1.DivisionID
									LEFT JOIN OOT9001 AS O1 WITH (NOLOCK) ON O1.APKMaster = B1.APKMaster_9000 AND O1.DivisionID = B1.DivisionID
									INNER JOIN #PermissionBEMT2010 P1 ON P1.Value IN (B1.CreateUserID, B1.Applicant)
							WHERE ISNULL(B1.DeleteFlg, 0) = 0 AND ' + @sWhere + ''

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
				, COUNT(*) OVER () AS TotalRow
				, B1.APK, B1.AdvanceEstimate
				, B1.CityID
				, B1.CompanyName, B1.CountryID
				, B1.CurrencyID, B1.DepartmentCharged
				, B1.DepartmentID, B1.AdvanceCurrencyID
				, B1.DivisionID, B1.DutyID
				, B1.EndDate, B1.NumberOfDateStay
				, B1.SectionID, B1.StartDate
				, B1.StatusID, B1.TotalFee
				, B1.TypeBSTripID, B1.TypeID
				, B1.VoucherDate, B1.VoucherNo 
				, A1.ObjectName AS AdvancePaymentUserName
				, A2.FullName AS ApplicantName
				, A3.CurrencyName AS AdvanceCurrencyName
				, A4.AnaName AS DepartmentChargedName
				, B2.[Description] AS TypeName
				, B3.[Description] AS TypeBSTripName
				, O1.[Description] AS StatusName
			FROM BEMT2010 B1 WITH (NOLOCK)
				INNER JOIN #FilterRequestAPK F1 ON F1.APK = B1.APK
				LEFT JOIN BEMT0099 B2 WITH (NOLOCK) ON B2.ID = B1.TypeID AND B2.CodeMaster = ''TypePriority''
				LEFT JOIN BEMT0099 B3 WITH (NOLOCK) ON B3.ID = B1.TypeBSTripID AND B3.CodeMaster = ''TypeBSTrip''
				LEFT JOIN BEMT0000 B4 WITH (NOLOCK) ON B4.DivisionID = B1.DivisionID
				LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = B1.AdvancePaymentUserID AND A1.DivisionID = B1.DivisionID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = B1.Applicant AND A2.DivisionID = B1.DivisionID
				LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.CurrencyID = B1.AdvanceCurrencyID AND A3.DivisionID = B1.DivisionID
				LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaID = B1.DepartmentCharged AND A4.AnaTypeID = B4.DepartmentAnaID AND A4.DivisionID = B1.DivisionID
				LEFT JOIN OOT0099 AS O1 WITH (NOLOCK) ON O1.ID = B1.Status AND O1.CodeMaster = ''Status''
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQLPermission + @sSQL)
--PRINT (@sSQLPermission + @sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
