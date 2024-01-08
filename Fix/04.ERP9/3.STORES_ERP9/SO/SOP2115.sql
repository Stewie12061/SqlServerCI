IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2115]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2115]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid: màn hình kế thừa bảng tính giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Đình Hòa on 17/05/2020
----Created by Kiều Nga on 17/07/2021 : Fix lỗi lọc khách hàng

-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE SOP2115
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID VARCHAR(50),
     @IsDate TINYINT, --0:Datetime; 1:Period
	 @Periods NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PageNumber INT,
	 @PageSize INT,
	 @InventoryName NVARCHAR(250),
	 @AccountName NVARCHAR(250)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N''

SET @sWhere = @sWhere + N' S01.DivisionID  ='''+@DivisionID+''' AND ISNULL(S01.DeleteFlag, 0) = 0 '

IF ISNULL(@InventoryName,'')<> ''
SET @sWhere = @sWhere + N' AND (S01.InventoryID LIKE N''%' +@InventoryName+'%'' OR S02.InventoryName LIKE N''%' +@InventoryName+'%'')'

IF ISNULL(@AccountName,'')<> ''
SET @sWhere = @sWhere + N' AND ( rtrim(ltrim(S04.ObjectName)) LIKE N''%' +@AccountName+'%'')'


IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), S01.CreateDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
ELSE 
	SET @sWhere = @sWhere + ' AND (Case When S01.TranMonth < 10 then ''0''+rtrim(ltrim(str(S01.TranMonth)))+''/''+ltrim(Rtrim(str(S01.TranYear))) 
								Else rtrim(ltrim(str(S01.TranMonth)))+''/''+ltrim(Rtrim(str(S01.TranYear))) End) IN ('''+@Periods+''')'

SET @sSQL = @sSQL + N'SELECT S02.InventoryName, S02.UnitID, S03.UnitName, S01.*, A15.AnaName AS ColorName, S04.ObjectName AS AccountName
					INTO #InheritSOT2110
					FROM SOT2110 S01 WITH(NOLOCK)
					LEFT JOIN AT1302 S02 WITH(NOLOCK) ON S01.InventoryID = S02.InventoryID
					LEFT JOIN AT1304 S03 WITH(NOLOCK) ON S02.UnitID = S03.UnitID
					LEFT JOIN AT1202 S04 WITH(NOLOCK) ON S01.AccountID = S04.ObjectID
					LEFT JOIN AT1015 A15 WITH(NOLOCK) ON S01.ColorID = A15.AnaID AND A15.AnaTypeID = ''I02'' AND A15.DivisionID IN (''@@@'',S01.DivisionID)
					WHERE' + @sWhere + ' AND S01.StatusSS = 1 
					      AND S01.APK NOT IN (SELECT InheritVoucherID FROM OT2102 WITH (NOLOCK) WHERE InheritTableID =''SOT2110'')'

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY S01.InventoryID) AS RowNum
			, COUNT(*) OVER () AS TotalRow, S01.*
			  FROM #InheritSOT2110 S01
			  Order BY S01.InventoryID
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)
PRINT @sSQL
PRINT @sSQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
