IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo theo dõi thu tiền TTTM– POSR3022
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 24/01/2018
----Modify by Hoàng Vũ, 27/11/2018: Chỉnh sửa cách lấy dữ liệu phiếu thu theo CB/SO
-- <Example> EXEC POSP3022 'HCM', 'HCM', '50S1101', 'CH-HCM001'',''50S1101', 1, '2017-01-01', '2018-12-31', '12/2017'',''01/2018'',''02/2018', '1', 'ASOFTADMIN'

CREATE PROCEDURE POSP3022 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@VoucherType        VARCHAR(50), --1: Phiếu đặt cọc; 2: phiếu bán/đổi hàng
	@UserID				VARCHAR(50)
)
AS
BEGIN
		DECLARE @sSQL   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@sWhereVoucherType NVARCHAR(MAX)

		SET @sWhere = ''
		SET @sWhereVoucherType = ''
		--Nếu Danh sách @DivisionIDList trống thì lấy biến môi trường @DivisionID
		IF Isnull(@DivisionIDList, '') != ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'
		ELSE 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionID+''')'	
	
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
		IF Isnull(@VoucherType, '') != ''
		SET @sWhereVoucherType = @sWhereVoucherType + ' AND ISNULL(M.VoucherType,'''') LIKE N''%'+@VoucherType+'%'' '
	
		SET @sSQL = N'
			SELECT M.APK, M.DivisionID, M.ShopID, M.VoucherNo, M.VoucherDate, M.VoucherDate_Receipts, M.VoucherNo_Receipts, M.Amount_Receipts, N'''+@UserID+''' as UserID
			INTO #TEMPOST3022
			From
				(	--Lấy những phiếu thu bán hàng/đổi hàng
					SELECT M.APK, M.DivisionID, M.ShopID, Case when M.CVoucherNo is not null then M.CVoucherNo else M.VoucherNo end VoucherNo
						   , M.VoucherDate, D.VoucherDate_Receipts, D.VoucherNo_Receipts, D.Amount_Receipts, 2 as VoucherType
					FROM POST0016 M WITH (NOLOCK) 
									INNER JOIN ( Select M.VoucherDate as VoucherDate_Receipts, M.VoucherNo as VoucherNo_Receipts, D.APKMInherited as APK, Sum(Amount) as Amount_Receipts
												 from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
												 Where Isnull(M.IsDeposit, 0) = 0 and M.DeleteFlg = 0 and D.APKMInherited is not null '+@sWhere+' 
												 Group by M.VoucherDate, M.VoucherNo,D.APKMInherited ) D on M.APK = D.APK
					WHERE ((M.CVoucherNo is null and M.PVoucherNo is null) or M.CVoucherNo is not null) and M.DeleteFlg = 0 '+@sWhere+' 
					--Lấy những phiếu thu từ đặt cọc
					UNION ALL 
					Select M.APK, M.DivisionID, M.ShopID , M.VoucherNo, M.VoucherDate, D.VoucherDate_Receipts, D.VoucherNo_Receipts, D.Amount_Receipts, 1 as VoucherType
					From POST2010 M WITH (NOLOCK) 
									INNER JOIN ( Select M.VoucherDate as VoucherDate_Receipts, M.VoucherNo as VoucherNo_Receipts, D.APKMInherited as APK, Sum(Amount) as Amount_Receipts
												 from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
												 Where Isnull(M.IsDeposit, 0) = 1 and M.DeleteFlg = 0 and D.APKMInherited is not null '+@sWhere+'  
												 Group by M.VoucherDate, M.VoucherNo,D.APKMInherited ) D on M.APK = D.APK
					Where M.DeleteFlg = 0 '+@sWhere+'
				)M
			Where 1=1 '+@sWhereVoucherType+'
		
			SELECT M.DivisionID, A01.DivisionName, M.ShopID, P10.ShopName, NULL as VoucherDateERP, M.VoucherNo, M.VoucherDate
				   , M.VoucherDate_Receipts, M.VoucherNo_Receipts, M.Amount_Receipts, M.UserID, A03.Fullname as UserName
			FROM #TEMPOST3022 M LEFT JOIN AT1101 A01 WITH (NOLOCK) ON A01.DivisionID = M.DivisionID 
								LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = M.UserID 
								LEFT JOIN POST0010 P10 WITH (NOLOCK) ON P10.DivisionID = M.DivisionID and P10.ShopID = M.ShopID
			ORDER BY M.VoucherDate_Receipts, M.VoucherNo_Receipts '
		EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
