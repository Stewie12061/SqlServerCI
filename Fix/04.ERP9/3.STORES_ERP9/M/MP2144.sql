IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2144]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2144]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn phiếu kế hoạch sản xuất (Master)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên
----Modified by Lê Hoàng on 03/06/2021 : Định dạng ngày thành ngày tháng năm
----Modified by Đình  Hòa on 09/06/2021 : Bổ sung load xác định loại kế thừa của phiếu
----Modified by Kiều  Nga on 27/01/2022 : Fix lỗi kế hoạch sản xuất đã kế thừa rồi vẫn còn load lại
----Modified by Kiều Nga on 04/10/2022: Fix lỗi lệnh sản xuất đã xóa nhưng không load lại kế thừa
----Modified by Viết Toàn on 18/05/2023: Lấy thêm cột số PO lên màn hình MF2161 (Lệnh sản xuất - THABICO)
----Modified by Minh Dũng on 03/10/2023: Fix lỗi không tìm kiếm được theo số chứng từ ở màn hình kế thừa
----Modified by Kiều Nga on 23/11/2023: Lấy thêm cột mã công thức (THABICO)
-- <Example> exec sp_executesql N'MP2144 @DivisionID=N''HCM'',@TxtSearch=N''77'',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'

 CREATE PROCEDURE MP2144 (
     @DivisionID NVARCHAR(2000),
     @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
     @FromDate VARCHAR(50),
     @ToDate VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @ObjectID NVARCHAR(250) = '',
     @VoucherNo NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText varchar(50),
		@ToDateTex varchar(50),
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomerIndex IN (117, 158))
BEGIN
IF (ISNULL(@FromDate, '') <> '')
	SET @FromDateText = CONVERT(DATETIME, @FromDate, 103)
IF (ISNULL(@ToDate, '') <> '')
	SET @ToDateTex = CONVERT(DATETIME, @ToDate, 103)

SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

-- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'AND M1.TranMonth + M1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateTex + ''')'
        ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate >= ''' + @FromDateText + ''')'
        ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (M1.VoucherDate <= ''' + @ToDateTex + ''')'
    END

IF ISNULL(@ObjectID, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(S1.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(M2.ObjectName, '''') LIKE N''%' + @ObjectID + '%'') '

IF ISNULL(@VoucherNo, '') != ''
    SET @sWhere = @sWhere + ' AND ISNULL(S1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

	  
SET @sSQL = N'SELECT DISTINCT M1.VoucherNo, M1.VoucherDate, M2.APK, M2.APKMaster, M2.VoucherNoProduct, M2.InventoryID, M2.InventoryName, M2.ObjectID
					 , M2.ObjectName, CONVERT(NVARCHAR(50), M2.DateDelivery, 103) AS DateDelivery, M2.StartDate, M2.EndDate, M2.StatusID
					 , M2.StatusName, S2.Length AS S01ID, S2.Width AS S02ID, S2.Height AS S03ID
					 , M2.Orders, M2.Number, M2.Quantity, M2.EndDatePlan, M2.UnitID, M2.UnitName, M2.NodeID, M2.VersionBOM
					 , CASE WHEN M1.InheritSOT2080 = 1 THEN 1 WHEN M1.InheritOrderProduce = 1 THEN 2 ELSE 0 END IsInherit
					 , '+@TotalRow+' AS TotalRow
              FROM MT2140 M1 WITH (NOLOCK)
			      LEFT JOIN MT2141 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.VoucherNo = M2.VoucherNoProduct
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
				  INNER JOIN MT2142 M42 WITH (NOLOCK) ON M1.APK = M42.APKMaster
				  INNER JOIN MT2143 M43 WITH (NOLOCK) ON M42.APK = M43.APKMaster 
			  WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.DeleteFlg = 0  
			  AND M43.APK NOT IN (SELECT MT2161.InheritTransactionID FROM MT2161 WITH (NOLOCK) 
							INNER JOIN MT2160 WITH (NOLOCK) ON MT2161.APKMaster = MT2160.APK 
							WHERE MT2161.InheritTableID =''MT2140'' AND MT2161.InheritTransactionID IS NOT NULL)
			  ' + @sWhere
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '')
		SET @FromDateText = CONVERT(DATETIME, @FromDate, 103)
	IF (ISNULL(@ToDate, '') <> '')
		SET @ToDateTex = CONVERT(DATETIME, @ToDate, 103)

	SET @TotalRow = ''
	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	-- Check Para FromDate và ToDate
		IF @IsDate = 0 
		BEGIN
			SET @sWhere = @sWhere + N'AND M1.TranMonth + M1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
		END
		ELSE
		BEGIN
			IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
				SET @sWhere = @sWhere + N'
				AND (M1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateTex + ''')'
			ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
				SET @sWhere = @sWhere + N'
				AND (M1.VoucherDate >= ''' + @FromDateText + ''')'
			ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
				SET @sWhere = @sWhere + N'
				AND (M1.VoucherDate <= ''' + @ToDateTex + ''')'
		END

	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M2.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(M2.ObjectName, '''') LIKE N''%' + @ObjectID + '%'') '

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

	SET @sSQL = N'SELECT DISTINCT M1.VoucherNo, M1.VoucherDate, M2.APK, M2.APKMaster, M2.VoucherNoProduct, M2.InventoryID, M2.InventoryName, M2.ObjectID
						, M2.ObjectName, CONVERT(NVARCHAR(50), M2.DateDelivery, 103) AS DateDelivery, M2.StartDate, M2.EndDate, M2.StatusID, M2.nvarchar01,M2.nvarchar02
						, M2.StatusName
						, M2.Orders, M2.Number, M2.Quantity, M2.EndDatePlan, M2.UnitID, M2.UnitName, M2.NodeID, M2.VersionBOM
						, CASE WHEN M1.InheritSOT2080 = 1 THEN 1 WHEN M1.InheritOrderProduce = 1 THEN 2 ELSE 0 END IsInherit
						, '+@TotalRow+' AS TotalRow
					FROM MT2140 M1 WITH (NOLOCK)
						LEFT JOIN MT2141 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
					WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.DeleteFlg = 0  
					' + @sWhere
					+ ' ORDER BY M1.VoucherNo, M2.Orders ASC'

END

PRINT  (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
