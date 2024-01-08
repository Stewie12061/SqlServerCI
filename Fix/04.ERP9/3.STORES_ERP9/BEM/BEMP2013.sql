IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load grid kế thừa phiếu đề nghị công tác
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 03/06/2020 by Trọng Kiên
----Modified on 19/11/2020 by Vĩnh Tâm: Xử lý loại các dòng master không còn dữ liệu detail để kế thừa
-- <Example> EXEC BEMP2013 @DivisionID = 'DTI', @DivisionIDList = '', '2020/05/03', '2020/06/03', 0, 0 , 0 , 0, '331', 'TH/123/232', 'TH', 1, 100

CREATE PROCEDURE [dbo].[BEMP2013]
( 
    @DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(MAX),
    @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
    @FromDate DATETIME,
    @ToDate DATETIME,
    @FromMonth INT, 
    @FromYear INT, 
    @ToMonth INT, 
    @ToYear INT, 
    @ObjectID NVARCHAR(250),
    @VoucherNo NVARCHAR(250),
    @TypeBSTripID VARCHAR(50),
    @TypeID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT
)
AS
BEGIN
    DECLARE @sSQL NVARCHAR (MAX) = N'',
            @OrderBy NVARCHAR(MAX) = N'', 
            @TotalRow NVARCHAR(50) = N'',
            @sWhere NVARCHAR(MAX),
            @sSQLPermission NVARCHAR(MAX),
            @FromDateText NVARCHAR(20),
            @ToDateText NVARCHAR(20)

    SET @OrderBy = 'M.VoucherDate DESC'
    SET @sWhere = ''
    SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
    SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

    -- Check Para DivisionIDList null then get DivisionID
    IF ISNULL(@DivisionIDList, '') != ''
        SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionIDList + ''')'
    ELSE 
        SET @sWhere = @sWhere + ' B1.DivisionID IN (''' + @DivisionID + ''')'

    -- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'
        AND B1.TranMonth + B1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate >= ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''''

        IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate <= ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''''

        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N' AND B1.VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''' '
    END

    IF ISNULL(@ObjectID, '') != ''
    BEGIN
        SET @sWhere = @sWhere + ' AND ISNULL(B1.AdvancePaymentUserID, '''') = ''' + @ObjectID + ''''

        IF ISNULL(@VoucherNo, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(B1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

        IF ISNULL(@TypeBSTripID, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(B1.TypeBSTripID, '''') = ''' + @TypeBSTripID + ''''
    END

    IF ISNULL(@TypeID, '') != ''
    BEGIN
        IF (@TypeID = 'DNTT')
            SET @sWhere = @sWhere + ' AND (ISNULL(B1.AdvanceEstimate, 0) = 0 OR (ISNULL(B4.IsInherited_2000, 0) = 1 AND B4.TypeID = ''DNTU'')) '
        IF (@TypeID = 'DNTTTU')
            SET @sWhere = @sWhere + ' AND (ISNULL(B1.AdvanceEstimate, 0) > 0 AND ISNULL(B4.IsInherited_2000, 0) = 0) '
    END
	ELSE
	BEGIN
		-- Trường hợp load khi mở form
		SET @sWhere = @sWhere + ' AND B1.Status = 5'
	END

    IF @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'


    SET @sSQL = @sSQL + N'
        SELECT    B1.APK, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, B1.AdvancePaymentUserID AS ObjectID, A1.ObjectName
                , B1.TypeBSTripID, B1.TotalDate, B1.TotalFee, B3.Description AS TypeBSTrip, O1.Description AS Status
                , CASE
					WHEN ISNULL(A2.CountryName, '''') != '''' AND ISNULL(A3.CityName, '''') != ''''
						THEN CONCAT(A2.CountryName, '', '', A3.CityName)
					WHEN ISNULL(A2.CountryName, '''') != '''' THEN A2.CountryName
					WHEN ISNULL(A3.CityName, '''') != '''' THEN A3.CityName
					ELSE ''''
				  END AS WorkPlace, B4.AdvancePayment AS AdvanceTotalFee

        INTO #TempBEMT2013
        FROM BEMT2010 B1 WITH (NOLOCK)

            INNER JOIN BEMT2020 B2 WITH (NOLOCK) ON B2.APKMaster = B1.APK AND ISNULL(B2.DeleteFlg, 0) = 0
            INNER JOIN BEMT2021 B5 WITH (NOLOCK) ON B2.APK = B5.APKMaster AND ISNULL(B5.Amount, 0) > 0 AND ISNULL(B5.IsInherited, 0) = 0
            LEFT JOIN BEMT0099 B3 WITH (NOLOCK) ON B3.ID = B1.TypeBSTripID AND B3.CodeMaster = ''TypeBSTrip''
            LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID IN (B1.DivisionID, ''@@@'') AND A1.ObjectID = B1.AdvancePaymentUserID
            LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = ISNULL(B1.Status, 0) AND O1.CodeMaster = ''Status''
            LEFT JOIN AT1001 A2 WITH (NOLOCK) ON A2.CountryID = B1.CountryID
            LEFT JOIN AT1002 A3 WITH (NOLOCK) ON A3.CityID = B1.CityID
            LEFT JOIN BEMT2000 B4 WITH (NOLOCK) ON B4.APKInherited = B1.APK AND B4.TypeID = ''DNTU''

        WHERE ISNULL(B1.DeleteFlg, 0) = 0 AND ISNULL(B1.Status, 0) = 1 AND ' + @sWhere + '
        GROUP BY B1.APK, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, B1.AdvancePaymentUserID , A1.ObjectName
                , B1.TypeBSTripID, B1.TotalDate, B1.TotalFee, B3.Description, O1.Description
                , A2.CountryName, A3.CityName, B4.AdvancePayment

        DECLARE @Count INT
        SELECT @Count = COUNT (*) FROM #TempBEMT2013

        SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
              , M.APK
              , M.VoucherNo
              , M.VoucherDate
              , M.ObjectID
              , M.ObjectName
              , M.WorkPlace
              , M.TypeBSTripID
              , M.TypeBSTrip
              , M.TotalDate
              , M.TotalFee
              , M.Status
			  , M.AdvanceTotalFee
        FROM #TempBEMT2013 M
        ORDER BY ' + @OrderBy + '
        OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
        FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
    EXEC (@sSQL)
    PRINT(@sSQL)
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
