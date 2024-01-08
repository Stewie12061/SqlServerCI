IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP13001') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP13001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP13001 Danh muc loại định mức tồn kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 03/06/2016
-- <Example>
----    EXEC CIP13001 'AS','','','','','', 'ASOFTADMIN',1,25

CREATE PROCEDURE CIP13001 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @NormID nvarchar(50),
        @Description nvarchar(100),
        @Disabled nvarchar(100),
        @IsCommon nvarchar(50),
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sSQL02 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		
		SET @sWhere = ''
	SET @OrderBy = 'AT1313.DivisionID, AT1313.NormID'
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (AT1313.DivisionID = '''+ @DivisionID+''' or AT1313.DivisionID = ''@@@'')'
	Else 
		SET @sWhere = @sWhere + 'and (AT1313.DivisionID IN ('''+@DivisionIDList+''') or AT1313.DivisionID = ''@@@'')'
	IF Isnull(@NormID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1313.NormID,'''') LIKE N''%'+@NormID+'%'' '
	IF isnull(@Description,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT1313.Description,'''') LIKE N''%'+@Description+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1313.Disabled,0) ='+@Disabled
	IF isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1313.IsCommon,0) = '+@IsCommon
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @AT1313 TABLE (
  				DivisionID NVARCHAR(50),
  				NormID NVARCHAR(50),
  				Description NVARCHAR(50),
  				MinQuantity Decimal(28,8),
  				MaxQuantity Decimal(28,8),
  				ReOrderQuantity Decimal(28,8),
  				Disabled int,
  				IsCommon int
			  )
			 INSERT INTO @AT1313
			 (
 				DivisionID, NormID, Description, MinQuantity, MaxQuantity, ReOrderQuantity, Disabled, IsCommon
			 )
			 SELECT AT1313.DivisionID, AT1313.NormID, AT1313.Description, AT1313.MinQuantity, AT1313.MaxQuantity, 
			 AT1313.ReOrderQuantity, AT1313.Disabled, AT1313.IsCommon
			 FROM AT1313  WITH (NOLOCK)
					'
    set @sSQL01='
						Declare @CountTotal NVARCHAR(Max)
						DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						Begin
							Insert into @CountEXEC (CountRow)
							Select Count(AT1313.NormID) From @AT1313 AT1313 WHERE 1=1 '+@sWhere + '
						End
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	,AT1313.DivisionID,
				  
				 AT1313.NormID, AT1313.Description, AT1313.MinQuantity, AT1313.MaxQuantity, 
			     AT1313.ReOrderQuantity, AT1313.Disabled, AT1313.IsCommon
				 FROM @AT1313 AT1313
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL+ @sSQL01+@sSQL02)