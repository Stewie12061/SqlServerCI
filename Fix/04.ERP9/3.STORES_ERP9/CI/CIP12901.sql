IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP12901') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12901]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form CIP12901 Danh muc đơn vị tính
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 03/06/2016
-- <Example>
----    EXEC CIP12901 'KC','','','','','', 'ASOFTADMIN',1,25

CREATE PROCEDURE CIP12901 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @UnitID nvarchar(50),
        @UnitName nvarchar(100),
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
	SET @OrderBy = 'AT1304.DivisionID, AT1304.UnitID'
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (AT1304.DivisionID = '''+ @DivisionID+''' or AT1304.DivisionID = ''@@@'')'
	Else 
		SET @sWhere = @sWhere + 'and (AT1304.DivisionID IN ('''+@DivisionIDList+''') or AT1304.DivisionID = ''@@@'')'
	IF Isnull(@UnitID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1304.UnitID,'''') LIKE N''%'+@UnitID+'%'' '
	IF isnull(@UnitName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT1304.UnitName,'''') LIKE N''%'+@UnitName+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1304.Disabled,0) ='+@Disabled
	IF isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1304.IsCommon,0) = '+@IsCommon
	
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @AT1304 TABLE (
  				DivisionID NVARCHAR(50),
  				UnitID NVARCHAR(50),
  				UnitName NVARCHAR(50),
  				Disabled int,
  				IsCommon int
			  )
			 INSERT INTO @AT1304
			 (
 				DivisionID, UnitID, UnitName, Disabled, IsCommon
			 )
			 SELECT AT1304.DivisionID, AT1304.UnitID, AT1304.UnitName, AT1304.Disabled, AT1304.IsCommon
			 FROM AT1304  WITH (NOLOCK)
					'
    set @sSQL01='
						Declare @CountTotal NVARCHAR(Max)
						DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
						IF '+Cast(@PageNumber as varchar(2)) + ' = 1
						Begin
							Insert into @CountEXEC (CountRow)
							Select Count(AT1304.UnitID) From @AT1304 AT1304 WHERE 1=1 '+@sWhere + '
						End
    '
    ---lấy kết quả
	SET @sSQL02 = N'
				 SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	,
				 AT1304.DivisionID , 
				 AT1304.UnitID, AT1304.UnitName, AT1304.Disabled, AT1304.IsCommon
				 FROM @AT1304 AT1304
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL+ @sSQL01+@sSQL02)