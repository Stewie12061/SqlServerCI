IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load màn hình duyệt bảng giá mua (ANGEL) 
---- EXEC CP0035 @DivisionID = 'ANG', @FromDate = '2016-03-13 00:00:00', @ToDate = '2017-03-13 00:00:00', @FromMonth = 1, @FromYear = 2016, @ToMonth = 3, @ToYear = 2016, @OID = '%', @InventoryType = '%', @CurrencyID = '%', @IsDate = 0, @Mode = 0, @FormMode = 0
-- <Param>

CREATE PROCEDURE [dbo].[CP0035] 
		@DivisionID NVARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@OID NVARCHAR(50),
		@InventoryTypeID NVARCHAR(50),
		@CurrencyID NVARCHAR(50),
		@StringWhere NVARCHAR(MAX) = '',
		@IsDate TINYINT, -- 0: theo kỳ, 1: Theo ngày
		@Mode TINYINT, -- 0: Bảng giá chưa duyệt, 1: Bảng giá đã duyệt			
		@FormMode TINYINT -- 0: Duyệt bảng giá, 1: Duyệt bảng giá cấp 1, 2: Duyệt bảng giá cấp 2				.
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSelect NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 NVARCHAR(MAX)

DECLARE @CustomerIndex int
set @CustomerIndex = (Select CustomerName  from customerindex)
if (@CustomerIndex=57)
	exec CP0035_AG @DivisionID, @FromDate, @ToDate, @FromMonth, @FromYear, @ToMonth, @ToYear, @OID, @InventoryTypeID, @CurrencyID, @StringWhere, @IsDate, @Mode, @FormMode
else
BEGIN
	IF @FormMode = 0
	BEGIN
		SET @sSelect = 'ISNULL(IsConfirm, 0) AS IsConfirm, ConfDescription'
		IF @Mode = 0
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm, 0) = 0'
		END
		ELSE
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm, 0) = 1'
		END
	END
	ELSE
	IF @FormMode = 1
	BEGIN
		SET @sSelect = 'ISNULL(IsConfirm01, 0) AS IsConfirm01, ConfDescription01'
		IF @Mode = 0
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm, 0) = 0 AND ISNULL(IsConfirm02, 0) = 0 AND ISNULL(IsConfirm01, 0) = 0'
		END
		ELSE
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm, 0) = 0 AND ISNULL(IsConfirm02, 0) = 0 AND ISNULL(IsConfirm01, 0) = 1'
		END	
	END	
	ELSE
	BEGIN
		SET @sSelect = 'ISNULL(IsConfirm01, 0) AS IsConfirm01, ConfDescription01, ISNULL(IsConfirm02, 0) AS IsConfirm02, ConfDescription02'
		IF @Mode = 0
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm01, 0) = 1 AND ISNULL(IsConfirm02, 0) = 0'
		END
		ELSE
		BEGIN
			SET @sWhere2 = 'ISNULL(IsConfirm01, 0) = 1 AND ISNULL(IsConfirm02, 0) = 1'
		END			
	END	

	IF @IsDate = 1
	BEGIN
		SET @sWhere = '	
		AND CreateDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 21) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 21) + ''''
	END
	ELSE
	BEGIN
		SET @sWhere = '	
		AND DATEPART(yy, CreateDate)*100 + DATEPART(m, CreateDate) BETWEEN ' + CONVERT(NVARCHAR(10),@FromMonth + @FromYear*100) + ' AND ' + CONVERT(NVARCHAR(10),@ToMonth + @ToYear*100)
	END	

	SET @sSQL = N'
		SELECT APK, DivisionID, ID, Description, FromDate, ToDate, OID, InventoryTypeID, ' + @sSelect + '
		FROM OT1301 WITH (NOLOCK)
		WHERE ISNULL(TypeID, 0) = 1
		AND DivisionID = ''' + @DivisionID + '''
		AND OID LIKE ''' + @OID + '''
		AND InventoryTypeID LIKE ''' + @InventoryTypeID + '''
		AND CurrencyID LIKE ''' + @CurrencyID + '''' + @sWhere + '
		AND ' + @sWhere2 + '
		ORDER BY ID
	'               
      
	PRINT @sSQL
	EXEC (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
             