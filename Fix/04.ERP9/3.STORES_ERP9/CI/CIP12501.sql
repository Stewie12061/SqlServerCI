IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12501]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP12501]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12501 Danh muc bảng giá bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 08/04/2016
----Modified by: Hoài Bảo, Date: 27/04/2022 - Thay đổi cách load theo ngày, kỳ, load tên các cột: Nhóm khách hàng, Loại mặt hàng
----Modified by: Hoài Bảo, Date: 29/08/2022 - Bổ sung loại "Tất cả" Nhóm khách hàng, Loại mặt hàng
----Modified by: Hoài Bảo, Date: 20/09/2022 - Bổ sung load loại bảng giá
----Modified by: Hoài Bảo, Date: 18/10/2022 - Bổ sung điều kiện kiểm tra bảng giá bán
----Modified by: Tiến Thành, Date: 24/03/2023 - Chỉnh sửa tính năng tìm kiếm 
-- <Example>
----    EXEC CIP12501 'AS','AS'',''GS','','','','','', '','','','ASOFTADMIN',1,10


CREATE PROCEDURE CIP12501 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(MAX),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsPeriod INT,
		@PeriodList VARCHAR(MAX),
        @ID nvarchar(50),
        @Description nvarchar(100),
        @OID NVARCHAR(100),
		@InventoryTypeID  NVARCHAR(50),
		@CurrencyID  VARCHAR(50),
		@TypeID VARCHAR(50),
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
		
	SET @sWhere = 'ISNULL(OT1301.TypeID,0) = 0'
	SET @OrderBy = 'OT1301.CreateDate DESC, OT1301.ID ASC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (OT1301.DivisionID = '''+ @DivisionID+''')'
	Else 
		SET @sWhere = @sWhere + 'and OT1301.DivisionID IN ('''+@DivisionIDList+''')'

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
									  OR (SELECT FORMAT(OT1301.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') )'
		END

	IF Isnull(@ID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.ID,'''') LIKE N''%'+@ID+'%'' '
	IF isnull(@OID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.OID,'''') LIKE N''%'+@OID+'%'' '
	IF isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.Description,'''') LIKE N''%'+@Description+'%'' '
	IF isnull(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND (OT1301.InventoryTypeName LIKE N''%' + @InventoryTypeID + '%'' OR OT1301.InventoryTypeID LIKE N''%' + @InventoryTypeID + '%'') '
	IF isnull(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.CurrencyID,0) LIKE N''%'+@CurrencyID+'%'' '
	IF isnull(@TypeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(OT1301.TypeID,0) LIKE N''%'+@TypeID+'%'' '
	IF Isnull(@Disabled, '') != ''
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
  				IsConvertedPrice NVARCHAR(50),
				TypeID NVARCHAR(50),
				TypeName NVARCHAR(250),
  				Disabled NVARCHAR(50),
				StatusSS NVARCHAR(50),
				ApprovalNotes NVARCHAR(50),
  				APK uniqueidentifier
			  )
			 INSERT INTO @OT1301
			 (
 				APK, DivisionID, ID, Description, FromDate, ToDate, CreateDate,
 				OID, InventoryTypeID, InventoryTypeName, CurrencyID, IsConvertedPrice, TypeID, TypeName, Disabled,StatusSS,ApprovalNotes
			 )
			 SELECT DISTINCT AT13.APK, AT13.DivisionID, AT13.ID, AT13.Description, AT13.FromDate,
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
					AT13.CurrencyID, AT13.IsConvertedPrice, AT13.TypeID,
					CASE WHEN ISNULL(AT13.TypeID,0) = 0 
						 THEN 
							(SELECT [Name] FROM A00001 WHERE ID = ''CIF1250.SalePrice'' AND LanguageID = ''vi-VN'')
						 ELSE 
							(SELECT [Name] FROM A00001 WHERE ID = ''CIF1250.PurchasePrice'' AND LanguageID = ''vi-VN'')
						 END AS TypeName, AT13.Disabled,AT13.StatusSS,AT13.ApprovalNotes
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
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	, OT1301.APK,
				 OT1301.DivisionID , 
				 OT1301.ID, OT1301.Description, OT1301.FromDate, OT1301.ToDate,
				 OT1301.OID, OT1301.InventoryTypeName, OT1301.InventoryTypeID, 
				 OT1301.CurrencyID,
				 OT1301.IsConvertedPrice, OT1301.Disabled, OT1301.TypeName AS TypeID, S3.Description As StatusSS,OT1301.ApprovalNotes
				 FROM @OT1301 OT1301
				 LEFT JOIN OOT0099 S3 WITH(NOLOCK) ON OT1301.StatusSS = S3.ID AND S3.CodeMaster = ''Status''

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
