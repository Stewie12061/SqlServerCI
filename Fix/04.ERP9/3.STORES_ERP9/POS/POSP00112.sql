IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00112]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Form POSP00112 In Danh muc hội viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng on 07/06/2016
-- <Example>
----    EXEC POSP00112 'AS','AS'',''GS','','','','','','','','','','',''
----
CREATE PROCEDURE POSP00112 ( 
        @DivisionID VARCHAR(50),  
		@DivisionIDList NVARCHAR(2000),  
        @MemberID nvarchar(50),
        @MemberName nvarchar(250),
		@ShopID varchar(50),
        @Address nvarchar(100), 
		@Identify nvarchar(100), 
		@Phone nvarchar(100), 
        @Tel nvarchar(100),
        @Fax nvarchar(100),
        @Email nvarchar(100),
        @DisabledName nvarchar(100),
        @IsCommon nvarchar(100)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
        
SET @sWhere = ''
SET @OrderBy = 'DivisionID, MemberID'


--Check Para DivisionIDList null then get DivisionID 
	IF isnull(@DivisionIDList, '') != '' 
		SET @DivisionIDList = @DivisionID
	IF isnull(@MemberID, '') != '' 
		SET @sWhere = @sWhere + ' AND MemberID LIKE N''%'+@MemberID+'%'' '
	IF isnull(@MemberName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(MemberName,'''') LIKE N''%'+@MemberName+'%''  '
	IF isnull(@ShopID, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL([ShopID],'''') LIKE N''%'+@ShopID+'%'' '
	IF isnull(@Address, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL([Address],'''') LIKE N''%'+@Address+'%'' '
	IF isnull(@Identify, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL(Identify,'''') LIKE N''%'+@Identify+'%'' '
	IF isnull(@Phone, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(Phone,'''') LIKE N''%'+@Phone+'%'' '
	IF isnull(@Tel, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL([Tel],'''') LIKE N''%'+@Tel+'%'' '
	IF isnull(@Fax, '') != '' 
		SET @sWhere = @sWhere +  'AND ISNULL([Fax],'''') LIKE N''%'+@Fax+'%'' '
	IF isnull(@Email, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL([Email],'''') LIKE N''%'+@Email+'%'' '
	IF isnull(@DisabledName, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(Disabled,0) = '+@DisabledName
	IF isnull(@IsCommon, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(IsCommon,0) = '+@IsCommon
SET @sSQL01 = '		DECLARE @POST0011 table 
								(	APK NVARCHAR(Max),
									DivisionID NVARCHAR(50),
									MemberID NVARCHAR(50),
									MemberName NVARCHAR(250),
									ShopID NVARCHAR(50),
									ShortName NVARCHAR(250),
									[Address] NVARCHAR(250),
									Identify NVARCHAR(250),
									Phone NVARCHAR(250),
									Tel NVARCHAR(250),
									Fax NVARCHAR(250),
									Email NVARCHAR(250),
									Birthday Datetime,
									AreaID NVARCHAR(50),
									CityID NVARCHAR(50),
									CountryID NVARCHAR(50),
									AccruedScore int, 
									Disabled tinyint,
									IsCommon tinyint
								)
								Insert into @POST0011 (APK, DivisionID, MemberID, MemberName, ShopID , ShortName, [Address]
														, Identify, Phone,Tel, Fax,
														Email, Birthday,  AreaID, CityID, CountryID, AccruedScore, Disabled, IsCommon)
								Select APK, DivisionID, MemberID, MemberName, ShopID , ShortName, [Address]
														, Identify, Phone,Tel, Fax,
														Email, Birthday,  AreaID, CityID, CountryID, AccruedScore, Disabled, IsCommon
								FROM POST0011 WITH (NOLOCK)
								WHERE DivisionID IN ('''+@DivisionIDList+''') or IsCommon =1' +@sWhere
SET @sSQL = '
	SELECT  x.DivisionID, x.MemberID, x.MemberName, x.ShopID, POST0010.ShopName, x.ShortName,
	x.[Address], x.Identify, x.Phone,  x.Tel, x.Fax, x.Email, x.Birthday, x.AreaID, x.CityID,
	x.CountryID, x.AccruedScore, x.[Disabled],AT0099.Description as DisabledName, x.IsCommon
	FROM @POST0011 x
	left join POST0010 on POST0010.ShopID = x.ShopID
	left join AT0099 on ID = x.Disabled and CodeMaster =''AT00000004''
	ORDER BY '+@OrderBy+' '
EXEC (@sSQL01 + @sSQL)