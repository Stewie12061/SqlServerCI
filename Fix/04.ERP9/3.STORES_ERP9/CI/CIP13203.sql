IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP13203]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP13203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Load Gird danh mục loại chứng từ
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thị Phượng, Date: 20/05/2016
-- <Example> EXEC CIP13203 'KC','','','','','','','','','', '', '', '', '','ASOFTADMIN'

CREATE PROCEDURE CIP13203 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
        @VoucherTypeID  nvarchar(50), 
        @VoucherTypeName nvarchar(50),
		@ObjectID nvarchar(50),
		@WareHouseID nvarchar(100),
     	@BankAccountID nvarchar(100), 
     	@DebitAccountID nvarchar(100), 
     	@CreditAccountID nvarchar(100), 
     	@VATTypeID  nvarchar(50),
     	@IsDefaultName  nvarchar(50),
     	@Description NVARCHAR(250),
		@DisabledName nvarchar(50),
		@IsCommonName nvarchar(50),
        @UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL01 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)
		SET @sWhere = ''
	SET @OrderBy = 'AT1007.DivisionID, AT1007.VoucherTypeID'
	
	--Check DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and (AT1007.DivisionID = '''+ @DivisionID+''' or AT1007.IsCommon = 1)'
	Else 
		SET @sWhere = @sWhere + 'and (AT1007.DivisionID IN ('''+@DivisionIDList+''') or AT1007.IsCommon = 1)'
	IF Isnull(@VoucherTypeID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.VoucherTypeID,'''') LIKE N''%'+@VoucherTypeID+'%'' '
	IF isnull(@VoucherTypeName,'') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(AT1007.VoucherTypeName,'''') LIKE N''%'+@VoucherTypeName+'%'' '
	IF isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.ObjectName, '''') LIKE N''%'+@ObjectID+'%'' '
	IF isnull(@WareHouseID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.WareHouseName, '''') LIKE N''%'+@WareHouseID+'%'' '
	IF isnull(@BankAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.BankAccountID,'''') LIKE N''%'+@BankAccountID+'%'' '
	IF isnull(@DebitAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.DebitAccountID,'''') LIKE N''%'+@DebitAccountID+'%'' '
	IF isnull(@CreditAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.CreditAccountID,'''') LIKE N''%'+@CreditAccountID+'%'' '
	IF Isnull(@VATTypeID, '') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.VATTypeName,'''') LIKE N''%'+@VATTypeID+'%'' '
	IF isnull(@IsDefaultName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.IsDefault,0) = '+@IsDefaultName
	IF Isnull(@Description, '') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.Description,'''') LIKE N''%'+@Description+'%'' '
	IF Isnull(@DisabledName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.Disabled,0) ='+@DisabledName
	IF isnull(@IsCommonName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT1007.IsCommon,0) = '+@IsCommonName
	--Kiểm tra load mac84 định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL = N'   
				Declare @AT1007 TABLE (
  				DivisionID NVARCHAR(50),
  				VoucherTypeID NVARCHAR(50),
  				VoucherTypeName NVARCHAR(250),
  				ObjectID NVARCHAR(50),
  				ObjectName NVARCHAR(50),
  				WareHouseID NVARCHAR(50),
  				WareHouseName NVARCHAR(50),
  				VATTypeID NVARCHAR(50),
  				VATTypeName NVARCHAR(50),
  				BankAccountID NVARCHAR(50),
  				DebitAccountID NVARCHAR(50),
  				CreditAccountID NVARCHAR(50),
  				VDescription NVARCHAR(50),
  				BDescription NVARCHAR(50),
  				TDescription NVARCHAR(50),
  				[Description] NVARCHAR(50),
  				IsDefault NVARCHAR(50),
  				IsCommon NVARCHAR(50),
  				[Disabled] NVARCHAR(50),
  				VoucherGroupID NVARCHAR(50),
  				VoucherGroupName NVARCHAR(250)
			  )
			 INSERT INTO @AT1007
			 (
 				DivisionID, VoucherTypeID, VoucherTypeName, IsDefault, 
 				ObjectID,ObjectName, WareHouseID, WareHouseName, VATTypeID,VATTypeName,
 				BankAccountID, DebitAccountID,CreditAccountID, VDescription, BDescription,
 				TDescription, [Description], IsCommon, [Disabled], VoucherGroupID, VoucherGroupName
			 )
			 SELECT AT07.DivisionID, AT07.VoucherTypeID, AT07.VoucherTypeName,
					AT07.IsDefault, AT07.ObjectID, (AT07.ObjectID+''_'' + A.ObjectName), AT07.WareHouseID,
					(AT07.WareHouseID+''_'' + B.WareHouseName),AT07.VATTypeID,
					(AT07.VATTypeID +''_''+ C.VATTypeName), 
					AT07.BankAccountID, AT07.DebitAccountID, AT07.CreditAccountID, AT07.VDescription,
					AT07.TDescription,AT07.BDescription,
					(AT07.VDescription +''_'' + AT07.TDescription+''_'' + AT07.BDescription),
					AT07.IsCommon, AT07.[Disabled], AT07.VoucherGroupID, (AT07.VoucherGroupID+''_'' + AT1017.Description)
			 FROM AT1007 AT07 With (NOLOCK)
			 LEFT JOIN AT1017  With (NOLOCK) ON AT1017.VoucherGroupID = AT07.VoucherGroupID
			 LEFT JOIN AT1202 A With (NOLOCK) ON A.ObjectID = AT07.ObjectID 
			 LEFT JOIN AT1303 B With (NOLOCK) ON B.WareHouseID = AT07.WareHouseID
			 LEFT JOIN AT1009 C With (NOLOCK) ON C.VATTypeID = AT07.VATTypeID
					'
  
    ---lấy kết quả
	SET @sSQL01 = N'
				 SELECT 
				 Case when AT1007.IsCommon =1 then '''' else AT1007.DivisionID end as DivisionID,
				 AT1007.VoucherTypeID, AT1007.VoucherTypeName, AT1007.ObjectID,
				 AT1007.ObjectName, AT1007.WareHouseID, AT1007.WareHouseName, AT1007.VATTypeID,
				 AT1007.VATTypeName, AT1007.BankAccountID, AT1007.DebitAccountID,
				 AT1007.CreditAccountID, AT1007.VDescription, AT1007.BDescription,
				 AT1007.TDescription, AT1007.IsDefault, AT1007.IsCommon, AT1007.[Disabled],
				 AT1007.[Description], AT1007.VoucherGroupID, AT1007.VoucherGroupName
				 FROM @AT1007 AT1007
				 WHERE 1=1 '+@sWhere+'
				ORDER BY '+@OrderBy
	EXEC (@sSQL+ @sSQL01)
