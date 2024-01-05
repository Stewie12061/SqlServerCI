IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[SHMP1020]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[SHMP1020];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

-- <Summary>
--Load danh mục đợt phát hành
-- <History>
----Create on 11/09/2018 by Xuân Minh
----Edited by Hoàng vũ, on 17/10/2018
----Edited by Hoàng vũ, on 02/07/2019: Fix lỗi Double số liệu
----Edited by Lương Mỹ, on 20/11/2019: Tính QuantityPreferredShare & QuantityCommonShare

----Example: 
/*
--Lọc nâng cao
EXEC SHMP1020 'BS', 'a', 'a', 1, 25, 'a', 'a', '2018-10-10', 'a', '0', '0', N' where IsNull(SHPublishPeriodID,'''') = N''asdas'''

--Lọc thường
EXEC SHMP1020 'BS', 'a', 'a', 1, 25, 'a', 'a', '2018-10-10', 'a', '0', '0', ''
*/

CREATE PROCEDURE SHMP1020
(
    @DivisionID VARCHAR(50),
    @DivisionList VARCHAR(MAX),
    @UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
    @SHPublishPeriodID VARCHAR(50),
    @SHPublishPeriodName NVARCHAR(250),
    @SHPublishPeriodDate DATETIME,
    @ShareTypeID VARCHAR(50),
    @IsCommon VARCHAR(50),
    @Disabled VARCHAR(50),
    @SearchWhere NVARCHAR(MAX) = NULL --Lọc nâng cao
)
AS
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N'';
SET @OrderBy = 'SHPublishPeriodDate Desc, SHPublishPeriodID';
SET @sWhere = ' 1 = 1 ';
IF @PageNumber = 1
    SET @TotalRow = 'COUNT(*) OVER ()';
ELSE
    SET @TotalRow = 'NULL';

IF ISNULL(@SearchWhere, '') = '' --Lọc thường
BEGIN
    IF ISNULL(@DivisionList, '') != ''
        SET @sWhere = @sWhere + ' AND SHMT1020.DivisionID IN (''' + @DivisionList + ''', ''@@@'') ';
    ELSE
        SET @sWhere = @sWhere + ' AND SHMT1020.DivisionID IN (''' + @DivisionID + ''', ''@@@'') ';

    IF ISNULL(@SHPublishPeriodID, '') != ''
        SET @sWhere = @sWhere + ' AND SHMT1020.SHPublishPeriodID LIKE N''%' + @SHPublishPeriodID + '%'' ';

    IF ISNULL(@SHPublishPeriodName, '') != ''
        SET @sWhere = @sWhere + ' AND SHMT1020.SHPublishPeriodName LIKE N''%' + @SHPublishPeriodName + '%'' ';

    IF ISNULL(@SHPublishPeriodDate, '') != ''
        SET @sWhere
            = @sWhere + ' AND CONVERT(VARCHAR(10), SHMT1020.SHPublishPeriodDate,112) <= '
              + CONVERT(VARCHAR(10), @SHPublishPeriodDate, 112);

    IF ISNULL(@ShareTypeID, '') != ''
        SET @sWhere = @sWhere + ' AND SHMT1021.ShareTypeID LIKE N''%' + @ShareTypeID + '%'' ';

    IF ISNULL(@Disabled, '') != ''
        SET @sWhere = @sWhere + N' AND SHMT1020.Disabled = ' + @Disabled + '';

    IF ISNULL(@IsCommon, '') != ''
        SET @sWhere = @sWhere + N' AND SHMT1020.IsCommon = ' + @IsCommon + '';
    --nếu giá trị NULL thì set về rổng 
    SET @SearchWhere = ISNULL(@SearchWhere, '');
END;

SET @sSQL
    = @sSQL
      + N'
		SELECT Distinct SHMT1020.APK,SHMT1020.DivisionID, SHMT1020.SHPublishPeriodID, 
		SHMT1020.SHPublishPeriodName,SHMT1020.SHPublishPeriodDate,
				MyTemp.QuantityPreferredShare,MyTemp.QuantityCommonShare,
				SHMT1020.QuantityTotal, SHMT1020.IsCommon, SHMT1020.Disabled
		INTO #SHMT1020
		FROM SHMT1020 WITH (NOLOCK) 
		LEFT JOIN SHMT1021 WITH (NOLOCK) ON SHMT1020.APK = SHMT1021.APKMaster AND SHMT1020.DivisionID = SHMT1021.DivisionID
		FULL JOIN (
			SELECT ISNULL(A.APKMaster,B.APKMaster) as APKMaster, A.QuantityPreferredShare, B.QuantityCommonShare
			FROM (
				SELECT T2.APKMaster,SUM(T2.Quantity) AS QuantityPreferredShare
				FROM SHMT1020 T1 WITH (NOLOCK)
				INNER JOIN SHMT1021 T2  WITH (NOLOCK) ON T2.APKMaster = T1.APK
				INNER JOIN SHMT1010 T3  WITH (NOLOCK) ON T2.ShareTypeID = T3.ShareTypeID
				WHERE T3.SharedKind = 1 -- Ưu đãi
				GROUP BY T2.APKMaster ) A
			
			FULL JOIN 
			(
				SELECT T2.APKMaster,SUM(T2.Quantity) AS QuantityCommonShare
				FROM SHMT1020 T1 WITH (NOLOCK)
				INNER JOIN SHMT1021 T2  WITH (NOLOCK) ON T2.APKMaster = T1.APK
				INNER JOIN SHMT1010 T3  WITH (NOLOCK) ON T2.ShareTypeID = T3.ShareTypeID
				WHERE T3.SharedKind = 0 -- Phổ thông
				GROUP BY T2.APKMaster
				) B ON A.APKMaster = B.APKMaster
		)MyTemp ON MyTemp.APKMaster = SHMT1021.APKMaster
		WHERE ' + @sWhere + '
		
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, ' + @TotalRow
      + ' AS TotalRow,
				APK, DivisionID, SHPublishPeriodID, SHPublishPeriodName, SHPublishPeriodDate,
				QuantityPreferredShare, QuantityCommonShare, (QuantityPreferredShare + QuantityCommonShare ) as QuantityTotal, IsCommon, Disabled
		FROM #SHMT1020
		'   + @SearchWhere + '
		ORDER BY ' + @OrderBy + ' 
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY ';

EXEC (@sSQL);
PRINT (@sSQL);



GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
