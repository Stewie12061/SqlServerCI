IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP3015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Total Sales Report – POSR3015
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 03/01/2018
----Modify by: Thị Phượng on 03/04/2018: Fix bug cột số tiền (AMOUNT) sai dữ liệu  và cột OKIAFRIEND, và bỏ tính phiếu cọc
-- <Example> EXEC POSP3015 'HCM', 'HCM', 'AEONTANPHU', 'CH-HCM001'',''AEONTANPHU', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018', 'ASOFTADMIN'

CREATE PROCEDURE POSP3015 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
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
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionID+''') '	
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF Isnull(@ShopIDList, '')!= ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.ShopID IN ('''+@ShopID+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
											Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
		----Chuyển dòng thành cột
	--Lấy dữ liệu bảng					 	    
	SET @sSQL=N'	

			Select M.DivisionID, Convert (VARCHAR, M.VoucherDate, 103) AS VoucherDate, M.ShopID, M.ShopName, Sum(M.Amount) as Amount
			, Sum(VATAmount) as VATAmount, isnull(Sum(M.OKIAFRIEND),0) as OKIAFRIEND
			INTO #POST3015 From
			(
				SELECT Distinct M.DivisionID, M.VoucherDate, Sum(M.TotalTaxAmount) as VATAmount, Sum(M.Amount) - Sum(isnull(M.OKIAFRIEND,0)) Amount
				, M.ShopID, M.ShopName, Sum(M.OKIAFRIEND) OKIAFRIEND
				FROM (SELECT  M.DivisionID, M.VoucherDate, Case When M.PVoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount
														 When M.PVoucherNo is not null and M.CVoucherNo is null then (-1) * M.TotalInventoryAmount
														 When M.PVoucherNo is null and M.CVoucherNo is not null then M.ChangeAmount
														 end as Amount, M.TotalTaxAmount, M.ShopID, A2.ShopName, A.OKIAFRIEND
				FROM POST0016 M WITH (NOLOCK) 
				LEFT JOIN (SELECT D.APKMaster, D.DeleteFlg, Sum(D.InventoryAmount + D.TaxAmount) as OKIAFRIEND 
							FROM POST00161 D WITH (NOLOCK) 
							LEFT JOIN AT1302 B WITH (NOLOCK) ON D.InventoryID = B.InventoryID
							WHERE B.IsVIP = 1 AND  D.DeleteFlg = 0
							Group by D.APKMaster, D.DeleteFlg )A ON A.APKMaster = M.APK and A.DeleteFlg = M.DeleteFlg
				LEFT JOIN POST0010 A2 WITH (NOLOCK) ON A2.DivisionID = M.DivisionID and A2.ShopID = M.ShopID
				WHERE M.DeleteFlg = 0   '+@sWhere+'
				)M 
				Group by M.DivisionID, M.VoucherDate, M.ShopID, M.ShopName 
			)M
				Group by M.DivisionID, M.VoucherDate, M.ShopID, M.ShopName 
			DECLARE @columns NVARCHAR(MAX), 
							@sql NVARCHAR(MAX);
					SET @columns = N'''';
					
					SELECT @columns += N'', '' + quotename(ShopName)
					FROM (SELECT ShopName FROM #POST3015 group by ShopName ) AS x Order by ShopName;
					
					SET @sql = N''
					SELECT DivisionID, ShopID, VoucherDate, VATAmount, OKIAFRIEND , '' + STUFF(@columns, 1, 2, '''') + ''
					FROM
						(
						  SELECT DivisionID, VoucherDate, ShopName,ShopID, VATAmount, Amount, OKIAFRIEND
						  FROM  #POST3015
					  
						  ) AS j
									PIVOT
									(
									  SUM(Amount) FOR ShopName IN (''
									  + STUFF(REPLACE(@columns, '', ['', '',[''), 1, 1, '''')
									  + '')
									) AS p;'';
					EXEC sp_executesql @sql;
		'		
		EXEC (@sSQL)
		Print (@sSQL)
		
		
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
