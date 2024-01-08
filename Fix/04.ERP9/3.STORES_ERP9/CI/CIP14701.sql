IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14701]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP14701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CIP14701 Danh muc bảng giá mua
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 18/10/2022
----Modified by: Tiến Thành, Date: 24/03/2023 - Chỉnh sửa tính năng tìm kiếm 
-- <Example>
----    EXEC [CIP14701] @DivisionID = N'1B', @DivisionIDList = N'1B', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 1, @PeriodList = N'03/2023', @ID = N'BGMDV2023', @Description = N'', @OID = N'', @InventoryTypeID = N'', @CurrencyID = N'', @Disabled = N'', @UserID = N'DQT001', @PageNumber = 1, @PageSize = 25

CREATE PROCEDURE CIP14701 (
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(MAX),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsPeriod INT,
		@PeriodList VARCHAR(MAX),
        @ID nvarchar(50),
        @Description nvarchar(100),
        @OID NVARCHAR(100),
		@InventoryTypeID NVARCHAR(50),
		@CurrencyID  VARCHAR(50),
		@Disabled NVARCHAR(100),
		@UserID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
	SET @sWhere = 'ISNULL(OT1301.TypeID,0) = 1'
	SET @OrderBy = 'OT1301.CreateDate DESC, OT1301.ID ASC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
		SET @sWhere = @sWhere + 'AND (OT1301.DivisionID = '''+ @DivisionID+''')'
	ELSE 
		SET @sWhere = @sWhere + 'AND OT1301.DivisionID IN ('''+@DivisionIDList+''')'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (OT1301.FromDate >= ''' + @FromDateText + '''
												OR OT1301.ToDate >= ''' + @FromDateText + '''
												OR OT1301.CreateDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OT1301.FromDate <= ''' + @ToDateText + ''' 
												OR OT1301.ToDate <= ''' + @ToDateText + '''
												OR OT1301.CreateDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (OT1301.FromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										  OR OT1301.ToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										  OR OT1301.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(OT1301.FromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') 
									  OR (SELECT FORMAT(OT1301.ToDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')
									  OR (SELECT FORMAT(OT1301.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')) '
		END

	IF ISNULL(@ID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.ID,'''') LIKE N''%'+@ID+'%'' '
	IF ISNULL(@OID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.OID,'''') LIKE N''%'+@OID+'%'' '
	IF ISNULL(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.Description,'''') LIKE N''%'+@Description+'%'' '
	IF ISNULL(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND (OT1301.InventoryTypeName LIKE N''%' + @InventoryTypeID + '%'' OR OT1301.InventoryTypeID LIKE N''%' + @InventoryTypeID + '%'') '
	IF ISNULL(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.CurrencyID,0) LIKE N''%'+@CurrencyID+'%'' '
	IF ISNULL(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.Disabled,0) = '+@Disabled
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @OT1301 TABLE (
  				DivisionID NVARCHAR(50),
  				ID NVARCHAR(50),
  				Description NVARCHAR(MAX),
  				FromDate DATETIME,
  				ToDate DATETIME,
				CreateDate DATETIME,
  				OID NVARCHAR(250),
  				InventoryTypeID NVARCHAR(250),
  				InventoryTypeName NVARCHAR(250),
  				CurrencyID NVARCHAR(50),
				TypeID NVARCHAR(50),
  				IsConvertedPrice NVARCHAR(50),
  				Disabled NVARCHAR(50),
  				APK uniqueidentifier
			  )
			 INSERT INTO @OT1301
			 (
 				APK, DivisionID, ID, Description, FromDate, ToDate, CreateDate,
 				OID, InventoryTypeID, InventoryTypeName, CurrencyID, TypeID, IsConvertedPrice, Disabled
			 )
			 SELECT  AT13.APK, AT13.DivisionID, AT13.ID, AT13.Description, AT13.FromDate,
					AT13.ToDate, AT13.CreateDate,
					CASE 
						WHEN IIF(ISNULL(C.AnaName, '''') != '''', C.AnaName, ''%'') != ''%'' 
						THEN 
							C.AnaName
						ELSE 
							(SELECT [Name] FROM A00001 WHERE ID = ''A00.All'' AND LanguageID = ''vi-VN'')
					END
					AS OID,
					AT13.InventoryTypeID,
					CASE 
						WHEN IIF(ISNULL(B.InventoryTypeName, '''') != '''', B.InventoryTypeName, ''%'') != ''%'' 
						THEN 
							B.InventoryTypeName
						ELSE 
							(SELECT [Name] FROM A00001 WHERE ID = ''A00.All'' AND LanguageID = ''vi-VN'')
					END
					AS InventoryTypeName,
					AT13.CurrencyID, AT13.TypeID, AT13.IsConvertedPrice, AT13.Disabled
			 FROM OT1301 AT13 WITH (NOLOCK)
			 LEFT JOIN AT1015 C WITH (NOLOCK) ON C.AnaID = AT13.OID
			 LEFT JOIN AT1301 B WITH (NOLOCK) ON B.InventoryTypeID = AT13.InventoryTypeID
					'
    set @sSQL01='
						DECLARE @CountTotal NVARCHAR(Max)
						DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						BEGIN
							INSERT INTO @CountEXEC (CountRow)
							SELECT COUNT(OT1301.ID) FROM @OT1301 OT1301 WHERE '+@sWhere + '
						END
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (SELECT CountRow from @CountEXEC) AS TotalRow, OT1301.APK,
				 OT1301.DivisionID ,
				 OT1301.ID, OT1301.Description, OT1301.FromDate, OT1301.ToDate,
				 OT1301.OID, OT1301.InventoryTypeName, OT1301.InventoryTypeID, 
				 OT1301.CurrencyID, OT1301.IsConvertedPrice, OT1301.Disabled
				 FROM @OT1301 OT1301
				 WHERE '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT (@sSQL+ @sSQL01+@sSQL02)
EXEC (@sSQL+ @sSQL01+@sSQL02)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO