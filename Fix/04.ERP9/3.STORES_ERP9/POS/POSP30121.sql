IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP30121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP30121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- ĐỐI CHIẾU SỐ LƯỢNG HÀNG XUẤT KHO SO VỚI HÀNG BÁN RA - POSR3012
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng on 17/08/2017
----Modify by: 
-- <Example> EXEC POSP30121 'MS', 'MS', 'CH001', 'CH001', 1, '2017-01-01', '2017-12-30', '12/2016'',''01/2017'',''02/2017', '', '', 'ASOFTADMIN'

CREATE PROCEDURE POSP30121 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToInventoryID			VARCHAR(MAX),
	@FromInventoryID		VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@Date  NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''

		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID = N'''+@DivisionID+''''	
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.ShopID = N'''+@ShopID+''''

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		--Search theo hội viên  (Dữ liệhội viên nhiều nên dùng control từ hội viên , đến hội viên
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

 	    
		SET @sSQL = N'
			Select  M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName,  D.InventoryID, D.InventoryName
					, sum(D.ActualQuantity) as ActualQuantity, Sum(isnull(A.ExQuantity,0)) as ExportQuantity
					
			from POST0016 M  WITH (NOLOCK) 
			Inner Join POST00161 D   WITH (NOLOCK) ON M.APK =D.APKMaster
			Left JOIn (select M.DivisionID, M.ShopID, D.InventoryID, Sum(D.ShipQuantity) as ExQuantity
										FROM POST0027 M WITH (NOLOCK) inner join POST0028 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg =0
										Group by M.DivisionID, M.ShopID, D.InventoryID
										)A On A.DivisionID= M.DivisionID and A.ShopID =M.ShopID and A.InventoryID = D.InventoryID
			Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
			Left join AT1101 A01 WITH (NOLOCK) on M.DivisionID = A01.DivisionID
			Where M.DeleteFlg = 0 and M.CVoucherNo is null and M.PVoucherNo is null  
			'+@sWhere+'
			Group by M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName, D.InventoryID, D.InventoryName
			Order by D.InventoryID
			'
		EXEC (@sSQL)
		Print (@sSQL)
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
