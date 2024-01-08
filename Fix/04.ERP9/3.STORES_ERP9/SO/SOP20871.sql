IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20871]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20871]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Load màn hình chọn phiếu thông tin sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Văn Tài on 17/07/2023: Copy từ store SOP20085 để điều chỉnh.
----Modified by ... on ... :
-- <Example> exec sp_executesql N'SOP20871 @DivisionID=N''MT'',@TxtSearch=N'''',@UserID=N''HCM07'',@PageNumber=N''1'',@PageSize=N''25'',@ConditionObjectID=N'''',@IsOrganize=0',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(3)',@CreateUserID=N'HCM07',@LastModifyUserID=N'HCM07',@DivisionID=N'HCM'

 CREATE PROCEDURE SOP20871 (
     @DivisionID NVARCHAR(2000),
     @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
     @FromDate VARCHAR(50),
     @ToDate VARCHAR(50),
     @FromMonth INT,
     @FromYear INT,
     @ToMonth INT,
     @ToYear INT,
     @ObjectID NVARCHAR(250) = '',
     @Inventory NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ScreenID NVARCHAR(50) = 'SOF2081'
)
AS
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText varchar(50),
		@ToDateTex varchar(50)

IF (ISNULL(@FromDate, '') <> '')
	SET @FromDateText = CONVERT(DATETIME, @FromDate, 103)
IF (ISNULL(@ToDate, '') <> '')
	SET @ToDateTex = CONVERT(DATETIME, @ToDate, 103)

SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

-- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'AND S1.TranMonth + S1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateTex + ''')'
        ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate >= ''' + @FromDateText + ''')'
        ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (S1.VoucherDate <= ''' + @ToDateTex + ''')'
    END

IF ISNULL(@ObjectID, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(S1.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' OR ISNULL(A1.ObjectName, '''') like N''%' + @ObjectID + '%'')'

IF ISNULL(@Inventory, '') != ''
    SET @sWhere = @sWhere + ' AND (ISNULL(S1.InventoryID, '''') LIKE N''%' + @Inventory + '%'' OR ISNULL(A2.InventoryName, '''') LIKE N''%' + @Inventory + '%'')'

--IF @ScreenID = 'SOF2081'
--BEGIN
--	SET @sWhere = @sWhere + ' AND ISNULL(S1.SemiProduct,'''') <> '''' '
--END
	  
SET @sSQL = N'SELECT DISTINCT S1.APK
						, S1.VoucherNo
						, S1.ObjectID
						, A1.ObjectName
						, S1.VoucherDate
						, S1.InventoryID
						, S1.StatusID
						, S4.[Description]		AS StatusName
						, S1.PaperTypeID		AS PaperTypeID
						, MT91.[Description]	AS PaperTypeName
						, S1.PrintTypeID		AS PrintTypeID
						, MT92.[Description]	AS PrintTypeName
						, MT22.NodeID			AS NodeID
						, MT22.APK_BomVersion	AS APK_BomVersion
						, MT22.VersionBOM		AS VersionBOM
						, MT22.UnitID
						, MT22.UnitName	AS UnitName
						, A2.UnitID			AS UnitIDProduct
						, A4.UnitName		AS UnitNameProduct												
						, MT22.RoutingTime
						, S1.ActualQuantity AS OrderQuantity
						, S1.ActualQuantity AS ActualQuantity
						, S1.DeliveryAddressName
						, A2.InventoryName
						, S1.[Length]
						, S1.[Width]
						, S1.[Height]
						, CONVERT(VARCHAR, S1.DeliveryTime, 103) AS DeliveryTime
						, S1.Notes			AS Notes
						, COUNT(*) OVER () AS TotalRow
              FROM SOT2080 S1 WITH (NOLOCK)
			      LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.DivisionID IN (''@@@'', S1.DivisionID) AND A1.ObjectID = S1.ObjectID
			      LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.DivisionID IN (''@@@'', S1.DivisionID) AND A2.InventoryID = S1.InventoryID				  
				  LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A2.UnitID = A4.UnitID
				  LEFT JOIN SOT0099 S4 WITH (NOLOCK) ON S1.StatusID = S4.ID AND S4.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(S4.Disabled, 0) = 0
				  LEFT JOIN CRMT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster = ''CRMT00000022''
															AND ISNULL(MT91.[Disabled], 0) = 0
															AND MT91.ID = S1.PaperTypeID
				  LEFT JOIN CRMT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = ''CRMF2111.PrintType''
													AND ISNULL(MT92.[Disabled], 0) = 0
													AND MT92.ID = S1.PrintTypeID
				  OUTER APPLY
				  (
					SELECT TOP 1 
							MT22.NodeID		AS NodeID
							, MT22.APK		AS APK_BomVersion
							, MT22.[Version]	AS VersionBOM
							, M2.UnitID
							, M2.RoutingTime
							, M3.[Description]	AS UnitName
					FROM MT2123 MT23 WITH (NOLOCK)
					INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = MT23.DivisionID
															AND MT22.APK = MT23.APK_2120
					--- Quy trinh
					LEFT JOIN MT2130 M2 WITH (NOLOCK) ON M2.DivisionID = MT23.DivisionID AND M2.RoutingID = MT22.RoutingID
					LEFT JOIN MT0099 M3 WITH (NOLOCK) ON M2.UnitID = M3.ID AND M3.CodeMaster = ''RoutingUnit'' AND ISNULL(M3.Disabled, 0)= 0
					INNER JOIN SOT2081 ST81 WITH (NOLOCK) ON ST81.DivisionID = MT23.DivisionID
															AND ST81.APKMaster = S1.APK
															AND ST81.APKDInherited = MT23.APK
				  ) MT22	  
					--- Kiem tra ke thua
				  OUTER APPLY
				  (
					SELECT TOP 1 OT01.*
					FROM OT2201 OT01 WITH (NOLOCK)
					INNER JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.DivisionID = OT01.DivisionID AND OT02.EstimateID = OT01.EstimateID
					WHERE
						OT01.DivisionID = S1.DivisionID
						AND ISNULL(OT01.DeleteFlg, 0) = 0
						AND ISNULL(OT02.MOrderID, '''') LIKE ''%'' + S1.VoucherNo + ''%''
				  ) OT01
			  WHERE S1.DivisionID = '''+@DivisionID+''' 
				AND ISNULL(S1.Status, 0) = 1
				AND S1.DeleteFlg = 0 
				AND OT01.APK IS NULL
				' + @sWhere + '
			 ORDER BY S1.VoucherDate DESC, S1.VoucherNo DESC

			 '
	SET @sSQL2 = @sSQL2 + N'	
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT  (@sSQL + @sSQL2)
EXEC (@sSQL + @sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
