IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP15201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP15201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form CIP15201 Danh muc thiết lâp chương trình khuyến mãi theo điều kiện
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Thanh Lượng, Date: 11/05/2023
----Modified by ... on ... :
----Modified by Thanh Lượng on 09/08/2023 : Cải tiến chức năng lọc chương trình còn hiệu lực theo ngày tháng và kỳ.
----Modified by Thanh Lượng on 22/12/2023 : Bổ sung trường OjectID.
-- <Example>
----EXEC CIP15201 'AS','HT'',''AS'',''TB',null,null,null, null,null,null, 'NV01',1,10


CREATE PROCEDURE CIP15201 ( 
		  @DivisionID VARCHAR(50), 
		  @DivisionIDList NVARCHAR(2000),
		  @IsPeriod INT,
		  @PeriodList VARCHAR(MAX),
		  @PromoteID NVARCHAR(250),
		  @FromDate DATETIME,
		  @ToDate DATETIME,
		  @Description NVARCHAR(250),
		  @DisabledName NVARCHAR(50),
		  @IsCommonName NVARCHAR(50),
		  @StatusSS NVARCHAR(250) ='',
		  @UserID  VARCHAR(50),
		  @PageNumber INT,
		  @PageSize INT )
AS 
BEGIN
	DECLARE @sSQL01 NVARCHAR (MAX),
			@sSQL02 NVARCHAR (MAX),
			@sSQL03 NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@StringToMonth NVARCHAR(MAX),
			@StringFromMonth NVARCHAR(MAX)

	SET @sWhere = ''
	SET @sWhere1 = ''
	SET @OrderBy = 'CIT1220.DivisionID, CIT1220.PromoteID'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	Set @StringFromMonth = (SELECT Right(((SELECT CONCAT('','' + @PeriodList + ''))),7)) -- Lấy kỳ nhỏ nhất
	Set @StringToMonth = (SELECT LEFT(((SELECT CONCAT('','' + @PeriodList + ''))),7)) -- Lấy kỳ lớn nhất
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + '(CIT1220.DivisionID = '''+ @DivisionID+''' or CIT1220.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + '(CIT1220.DivisionID IN ('''+@DivisionIDList+''') or CIT1220.IsCommon = 1)'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (CIT1220.FromDate >= ''' + @FromDateText + '''
												OR CIT1220.ToDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (CIT1220.FromDate <= ''' + @ToDateText + '''
												OR CIT1220.ToDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				--SET @sWhere = @sWhere + ' AND (CIT1220.FromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
				--							OR CIT1220.ToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				SET @sWhere = @sWhere + ' AND (CIT1220.ToDate >=''' + @FromDateText + ''') AND (CIT1220.FromDate <=''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
			BEGIN
				SET @sWhere = @sWhere + ' AND 		
				((SELECT FORMAT(CIT1220.ToDate, ''MM/yyyy'')) >= ('''+@StringFromMonth+''') AND (SELECT FORMAT(CIT1220.FromDate, ''MM/yyyy'')) <= ('''+@StringToMonth+ ''')) '
			END

	
	IF Isnull(@DisabledName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CIT1220.Disabled,0) ='+@DisabledName
	
	IF isnull(@IsCommonName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(CIT1220.IsCommon,0) = '+@IsCommonName

	IF ISNULL(@StatusSS,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(T1.StatusSS, '''')) = '''+@StatusSS+''''
	
	
	--Do search bằng Name, nên đưa vào biến bảng, xử lý giảm tình trạng deadlock với With (NOLOCK)
	SET @sSQL01 = '		DECLARE @CIT1220 table 
						(	APK NVARCHAR(Max),
							DivisionID NVARCHAR(Max),
							PromoteID NVARCHAR(Max),
							PromoteName NVARCHAR(Max),
							FromDate Datetime,
							ToDate Datetime,						
							Description NVARCHAR(Max),
							Disabled Tinyint,
							IsCommon Tinyint,
							IsDiscountWallet Tinyint,
							IsEnd Tinyint,
							OID  NVARCHAR(Max),
							ObjectID  NVARCHAR(Max),
							ObjectName NVARCHAR(Max),
							StatusSS  NVARCHAR(Max),
							ApprovalNotes  NVARCHAR(Max)
						)
						INSERT INTO @CIT1220 (APK, DivisionID, PromoteID, PromoteName, FromDate, ToDate, Description
											, Disabled, IsCommon,IsDiscountWallet, IsEnd, OID,ObjectID,ObjectName,StatusSS,ApprovalNotes)
						SELECT  DISTINCT CIT1220.APK,  CIT1220.DivisionID
							  , CIT1220.PromoteID, CIT1220.PromoteName, CIT1220.FromDate, CIT1220.ToDate							 							  							  
							  , CIT1220.[Description], CIT1220.Disabled, CIT1220.IsCommon, CIT1220.IsDiscountWallet, CIT1220.IsEnd
							  , CIT1220.OID,CIT1220.ObjectID, AT1202.ObjectName, CIT1220.StatusSS ,CIT1220.ApprovalNotes				
						FROM CIT1220 WITH (NOLOCK)
						LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (CIT1220.DivisionID,''@@@'') and AT1202.ObjectID = CIT1220.ObjectID
						WHERE ' + @sWhere
	--Kiểm tra load mac định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL02 = '		
					Declare @CountTotal NVARCHAR(Max)
					DECLARE @CountEXEC table (CountRow NVARCHAR(Max))
					IF '+Cast(@PageNumber as varchar(2)) + ' = 1
					Begin
						Insert into @CountEXEC (CountRow)
						Select Count(PromoteID) From @CIT1220 CIT1220 WHERE' + @sWhere + @sWhere1 + '
					End '
	--Lấy kết quả có search bằng name
	SET @sSQL03 = '		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, (Select CountRow from @CountEXEC) AS TotalRow	
							  , CIT1220.APK
							  , CIT1220.DivisionID
							  , CIT1220.PromoteID, CIT1220.PromoteName, CIT1220.FromDate, CIT1220.ToDate
							  , CIT1220.Description , CIT1220.ObjectID, CIT1220.ObjectName
							  , CIT1220.Disabled, CIT1220.IsCommon,CIT1220.IsDiscountWallet,CIT1220.IsDiscountWallet, CIT1220.IsEnd,
						STUFF(( SELECT '', '' + AT1015.AnaName
						FROM   AT1015 WITH (NOLOCK) 
						WHERE   AT1015.AnaID IN (SELECT Value FROM dbo.StringSplit(REPLACE(CIT1220.OID, '' '', ''''), '',''))
						ORDER BY AT1015.AnaID
						FOR XML PATH('''')), 1, 1, '''') AS OID, S3.Description As StatusSS,CIT1220.ApprovalNotes
							  FROM  @CIT1220 CIT1220
						LEFT JOIN OOT0099 S3 WITH(NOLOCK) ON CIT1220.StatusSS = S3.ID AND S3.CodeMaster = ''Status''
						WHERE ' + @sWhere + @sWhere1 + '
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	--PRINT (@sSQL01+@sSQL02+@sSQL03)
	EXEC (@sSQL01+@sSQL02+@sSQL03)
END	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
