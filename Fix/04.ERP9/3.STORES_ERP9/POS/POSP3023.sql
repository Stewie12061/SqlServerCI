IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP3023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- DAILY DEPOSIT REPORT – POSR3023
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 25/01/2018
----Modify by: Hoàng Vũ, 27/08/2018: Bổ sung lấy thông tin gói sản phẩm
----Modify by: Hoàng Vũ, 08/04/20191: Bổ sung chặn những chứng từ năm 2018 không lên báo cáo daily deposit report theo yêu cầu của bên CON và khách hàng
----Modifi by: Văn Tài on 25/12/2019: Bổ load thông tin chứng từ: phiếu bán hàng, phiếu chi ERP, bút toán tổng hợp ERP.
-- <Example> EXEC POSP3023 'HCM', 'HCM', '50S1101', 'CH-HCM001'',''50S1101', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018','','','','', '', 'ASOFTADMIN'

CREATE PROCEDURE POSP3023 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@VoucherNo          VARCHAR(50),
	@ToSaleManID		VARCHAR(MAX),
	@FromSaleManID  	VARCHAR(MAX),
	@ToInventoryID		VARCHAR(MAX),
	@FromInventoryID	VARCHAR(MAX),
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL NVARCHAR(MAX),  
				@sSQL1 NVARCHAR(MAX),
				@sSQL2 NVARCHAR(MAX),
				@sSQL3 NVARCHAR(MAX),
				@sWhere NVARCHAR(MAX),
				@sWhereDate NVARCHAR(MAX),
				@Date  NVARCHAR(MAX),
				@sSQL_Case01 NVARCHAR(MAX),
				@sSQL_Case02 NVARCHAR(MAX),
				@sSQL_Case03 NVARCHAR(MAX)

		SET @Date = ''
		SET @sWhere = ''
		SET @sWhereDate = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF ISNULL(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
	
		--Nếu Danh sách @ShopIDList trống thì lấy biến môi trường @ShopID
		IF ISNULL(@ShopIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.ShopID IN (''' + @ShopIDList + ''')'
		ELSE 
			SET @sWhere = @sWhere + ' And M.ShopID IN (''' + @ShopID + ''')'

		IF @IsDate = 1	
			SET @sWhereDate = @sWhereDate + ' AND CONVERT(VARCHAR, M.VoucherDate, 112) BETWEEN ''' + CONVERT(VARCHAR, @FromDate, 112) + ''' AND ''' + CONVERT(VARCHAR, @ToDate, 112) + ''''
		ELSE
			SET @sWhereDate = @sWhereDate + ' AND (
													CASE WHEN M.TranMonth < 10 
														 THEN ''0'' + RTRIM(LTRIM(STR(M.TranMonth))) + ''/'' + LTRIM(RTRIM(STR(M.TranYear))) 
														 ELSE RTRIM(LTRIM(STR(M.TranMonth))) + ''/'' + LTRIM(RTRIM(STR(M.TranYear))) 
														 END
												) IN ('''+@PeriodIDList+''')'

		--Search theo nhân viên bán hàng (Dữ liệu nhân viên bán hàng nhiều nên dùng control từ nhân viên bán hàng , đến nhân viên bán hàng)
		IF ISNULL(@FromSaleManID, '') <> '' AND ISNULL(@ToSaleManID, '') = ''
			SET @sWhere = @sWhere + ' AND M.SaleManID >= N'''+@FromSaleManID + ''''
		ELSE IF ISNULL(@FromSaleManID, '') = '' AND ISNULL(@ToSaleManID, '') <> ''
			SET @sWhere = @sWhere + ' AND M.SaleManID <= N''' + @ToSaleManID + ''''
		ELSE IF ISNULL(@FromSaleManID, '') <> '' AND ISNULL(@ToSaleManID, '') <> ''
			SET @sWhere = @sWhere + ' AND M.SaleManID BETWEEN N''' + @FromSaleManID + ''' AND N''' + @ToSaleManID + ''''

		--Search theo mặt hàng  (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng , đến mặt hàng
		IF ISNULL(@FromInventoryID, '') <> '' AND ISNULL(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID >= N''' + @FromInventoryID + ''''
		ELSE IF ISNULL(@FromInventoryID, '') = '' AND ISNULL(@ToInventoryID, '') <> ''
			SET @sWhere = @sWhere + ' AND D.InventoryID <= N''' + @ToInventoryID + ''''
		ELSE IF ISNULL(@FromInventoryID, '') <> '' AND ISNULL(@ToInventoryID, '') <> ''
			SET @sWhere = @sWhere + ' AND D.InventoryID BETWEEN N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''''
		IF ISNULL(@VoucherNo, '') <> ''
			SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

		SET @sSQL = N'SELECT DISTINCT M.APK
								, M.DivisionID
								, M.ShopID
								, M.VoucherNo AS VoucherNoSO
								, M.BookingAmount
								, M.VoucherDate AS VoucherDateSO
								, M.DeleteFlg
								, CASE 
									WHEN LEFT_A.APKMInherited IS NOT NULL THEN LEFT_A.VoucherNoCB
									WHEN LEFT_B.APKMInherited IS NOT NULL THEN LEFT_B.VoucherNoCB
									WHEN LEFT_C.APKMInherited IS NOT NULL THEN LEFT_C.VoucherNoCB
								  END AS VoucherNoCB
								, CASE 
									WHEN LEFT_A.APKMInherited IS NOT NULL THEN LEFT_A.VoucherDateCB
									WHEN LEFT_B.APKMInherited IS NOT NULL THEN LEFT_B.VoucherDateCB
									WHEN LEFT_C.APKMInherited IS NOT NULL THEN LEFT_C.VoucherDateCB
								  END AS VoucherDateCB
								, CASE 
									WHEN LEFT_A.APKMInherited IS NOT NULL THEN LEFT_A.SumAmount
									WHEN LEFT_B.APKMInherited IS NOT NULL THEN LEFT_B.SumAmount
									WHEN LEFT_C.APKMInherited IS NOT NULL THEN LEFT_C.SumAmount
								  END AS SumAmount
								, CASE 
									WHEN LEFT_A.APKMInherited IS NOT NULL THEN LEFT_A.CBAmount
									WHEN LEFT_B.APKMInherited IS NOT NULL THEN LEFT_B.CBAmount
									WHEN LEFT_C.APKMInherited IS NOT NULL THEN LEFT_C.CBAmount
								  END AS CBAmount
								, CASE 
									WHEN LEFT_A.APKMInherited IS NOT NULL 
										THEN ISNULL(LEFT_A.SumAmount, 0) - ISNULL(LEFT_A.CBAmount, 0) - M.BookingAmount
									WHEN LEFT_B.APKMInherited IS NOT NULL 
										THEN ISNULL(LEFT_B.SumAmount, 0) - ISNULL(LEFT_B.CBAmount, 0) - M.BookingAmount
									WHEN LEFT_C.APKMInherited IS NOT NULL 
										THEN ISNULL(LEFT_C.SumAmount, 0) - ISNULL(LEFT_C.CBAmount, 0) - M.BookingAmount
									ELSE - M.BookingAmount
								  END AS SOAmount
								, D.InventoryID
								, D.InventoryName
								, M.SaleManID
								, M.Description AS Notes
								, B.ShopName 
								, D.PackagePriceID
								, D.PackageID
								, Tranmonth
								, Tranyear
					INTO #TEMPOST3023 
					FROM POST2010 M WITH (NOLOCK) 
					INNER JOIN POST2011 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID 
															AND D.APKMaster = M.APK 
															AND D.DeleteFlg = M.DeleteFlg

					LEFT JOIN POST0010 B WITH (NOLOCK) ON B.DivisionID = M.DivisionID 
															AND B.ShopID = M.ShopID
						'
		SET @sSQL_Case01 = N'
					LEFT JOIN (
								--- Danh sách phiếu bản hàng
								SELECT 
									M.DivisionID
									, M.VoucherNo AS VoucherNoCB
									, M.VoucherDate AS VoucherDateCB
									, M.TotalInventoryAmount AS SumAmount
									, M.TotalInventoryAmount - ISNULL(M.BookingAmount, 0) AS CBAmount
									, D.APKMInherited 
								FROM POST0016 M WITH (NOLOCK) 
								INNER JOIN POST00161 D WITH (NOLOCK) ON M.DivisionID = D.DivisionID 
																			AND M.APK = D.APKMaster 
																			AND M.DeleteFlg = D.DeleteFlg
																			AND M.DeleteFlg = 0
								WHERE 1 = 1 ' + @sWhereDate + '
							) LEFT_A ON LEFT_A.DivisionID = M.DivisionID 
									AND LEFT_A.APKMInherited = M.APK 
						'
		SET @sSQL_Case02 = N'
					LEFT JOIN
							(
								-- Danh sách phiếu chi
								SELECT M.DivisionID
										, M.VoucherNo AS VoucherNoCB
										, M.VoucherDate AS VoucherDateCB
										, SUM(M.ConvertedAmount) AS SumAmount
										, NULL AS CBAmount
										, T10.APK AS APKMInherited 
										, 0 AS DeleteFlg
								FROM AT9000 M WITH (NOLOCK) 
								LEFT JOIN POST2020 T20 WITH (NOLOCK)  ON T20.DivisionID = M.DivisionID
																			AND T20.APK = M.InheritPayPOS
								LEFT JOIN POST2021 T21 WITH (NOLOCK)  ON T21.DivisionID = M.DivisionID
																			AND T21.APKMaster = T20.APK
								LEFT JOIN POST00801 T81 WITH (NOLOCK) ON T81.DivisionID = T21.DivisionID
																			AND T81.VoucherNo = T21.InVoucherNo	
								LEFT JOIN POST00802 T82 WITH (NOLOCK) ON T82.DivisionID = T81.DivisionID
																			AND T82.APKMaster = T81.APK
								LEFT JOIN POST2010 T10 WITH (NOLOCK) ON T10.DivisionID = T82.DivisionID
																			AND T10.VoucherNo = T82.DepositVoucherNo
								WHERE 1 = 1 ' + @sWhereDate + '
								GROUP BY M.DivisionID
										, M.VoucherNo
										, M.VoucherDate
										, T10.APK

							) LEFT_B ON LEFT_B.DivisionID = M.DivisionID 
									AND LEFT_B.APKMInherited = M.APK 
						'
		SET @sSQL_Case03 = N'
					LEFT JOIN								
							(
								--- Danh sách phiếu bút toán tổng hợp
								SELECT M.DivisionID
										, M.VoucherNo AS VoucherNoCB
										, M.VoucherDate AS VoucherDateCB
										, SUM(M.ConvertedAmount) AS SumAmount
										, NULL AS CBAmount
										, T10.APK AS APKMInherited 
										, 0 AS DeleteFlg
								FROM AT9000 M WITH (NOLOCK) 
								LEFT JOIN POST2010 T10 WITH (NOLOCK) ON T10.DivisionID = M.DivisionID
																		AND T10.APK = M.InheritVoucherID
								WHERE M.InheritTableID = ''POST2010'' ' + @sWhereDate + '
								GROUP BY M.DivisionID
										, M.VoucherNo
										, M.VoucherDate
										, T10.APK
							) LEFT_C ON LEFT_C.DivisionID = M.DivisionID 
									AND LEFT_C.APKMInherited = M.APK 
									'
		SET @sSQL1 =N'
					WHERE M.DeleteFlg = 0 
							AND M.APK 
									NOT IN (SELECT RefAPK FROM POST3023_OK WITH (NOLOCK) WHERE StatusReport = 1 AND RefTableID = N''POST2010'')
						  ' + @sWhere + @sWhereDate 
						  + ''
		
		SET @sSQL2 = 'SELECT 
			ROW_NUMBER() OVER (ORDER BY M.ShopID, M.VoucherNoSO, M.InventoryID ) AS No
			, M.APK
			, M.DivisionID
			, A.DivisionName
			, M.ShopID
			, M.VoucherNoSO
			, M.BookingAmount
			, M.VoucherDateSO
			, Tranmonth
			, Tranyear
			, M.DeleteFlg
			, M.VoucherNoCB
			, M.VoucherDateCB
			, M.SumAmount
			, M.CBAmount
			, M.SOAmount
			, M.InventoryID
			, M.InventoryName
			, M.SaleManID
			, M.Notes
			, M.ShopName
			, M.PackagePriceID
			, M.PackageID
		FROM #TEMPOST3023 M 
		LEFT JOIN AT1101 A WITH (NOLOCK) ON A.DivisionID = M.DivisionID 
		ORDER BY M.ShopID, M.VoucherNoSO, M.InventoryID 
		'
		
		--PRINT(@sSQL)
		--PRINT(@sSQL_Case01)
		--PRINT(@sSQL_Case02)
		--PRINT(@sSQL_Case03)
		--PRINT(@sSQL1)
		--PRINT(@sSQL2)

		EXEC (
		@sSQL 
		+ @sSQL_Case01
		+ @sSQL_Case02
		+ @sSQL_Case03
		+ @sSQL1
		+ @sSQL2
		)
		
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
