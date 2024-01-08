IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[DRP2018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[DRP2018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In/xuất excel Danh sách hồ sơ nợ tiêu dùng/ nợ thương mại
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Thanh Sơn, Date: 08/09/2014
----Modified by: Trần Quốc Tuấn, Date: 18/05/2016 bổ sung chỉ lấy 32767 ký tự WorkHistory
----Modified by Bảo Thy on 10/03/2017: Fix và bổ sung các thông tin NearPaidDate, NearPaidAmount, PaidAmount, RemainAmount, IsSendXRName, IsSendVPLName, NextAddressID, AddressID
----Modified by Bảo Thy on 23/05/2018: Fix lỗi search theo NextActionDate khi in dạng 1 NTD
-- <Example>
---- 
/*
exec DRP2018 @DivisionID=N'XR',@UserID=N'ASOFTADMIN',@TranMonth=3,@TranYear=2016,@IsSearch=1,@BranchIDList='sdga',@CustomerID=N'%',@DebtorID='sadfa',@DebtorName='asdvsav',
@ContractNo=N'0004450940000181457',@TeamID=N'%',@IsNew=NULL,@Ward='sdfa',@District='sdgsa',@City='vdsv',@Street='asfa',@ContractGroupID='safa',@FromNextActionDate='2016-10-11',
@ToNextActionDate='2016-10-11',@NextActionID='sdfsa',@PhoneNumber='asfa',@FromContractReceiveDate='2016-10-11',@ToContractReceiveDate='2016-10-11'
,@DispathTypeID=N'%',@ContractNoList=N'20150313-613003-0001',
@IsCheckAll=0,@Mode=1,@IsPrinted=0, @IsTypePrint=1

exec DRP2018 @DivisionID=N'XR',@UserID=N'ASOFTADMIN',@TranMonth=2,@TranYear=2015,@IsSearch=1,@BranchIDList=NULL,@CustomerID=N'%',@DebtorID=NULL,@DebtorName=NULL,@ContractNo=N'20150313-613003-0001',@TeamID=N'%',@IsNew=NULL,@Ward=NULL,@District=NULL,@City=NULL,@Street=NULL,@ContractGroupID=NULL,@FromNextActionDate=NULL,@ToNextActionDate=NULL,@NextActionID=NULL,@PhoneNumber=NULL,@ContractReceiveDate=NULL,@DispathTypeID=N'%',@ContractNoList=N'0004450930000032727',
@IsCheckAll=0,@Mode=1,@IsPrinted=Null, @IsTypePrint=2
*/

CREATE PROCEDURE DRP2018
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@IsSearch BIT,
	@BranchIDList NVARCHAR(2000),
	@CustomerID VARCHAR(50),
	@DebtorID VARCHAR(50),
	@DebtorName NVARCHAR(250),
	@ContractNo NVARCHAR(50),
	@TeamID VARCHAR(50),
	@IsNew TINYINT,
	@Ward NVARCHAR(250),
	@District NVARCHAR(250),
	@City NVARCHAR(250),
	@Street NVARCHAR(250),	
	@ContractGroupID VARCHAR(50),
	@FromNextActionDate DATETIME,
	@ToNextActionDate DATETIME,
	@NextActionID VARCHAR(50),
	@PhoneNumber NVARCHAR(250),
	@FromContractReceiveDate DATETIME,
	@ToContractReceiveDate DATETIME,
	@DispathTypeID VARCHAR(50),
	@ContractNoList NVARCHAR(MAX),
	@IsCheckAll TINYINT,
	@Mode TINYINT, -- 1:Nợ tiêu dùng, 2: nợ thương mại
	@IsPrinted TINYINT = NULL,
	@IsTypePrint TINYINT =1 ,-- 1: in dạng 1 và 2: in dạng 2
	@PortID VARCHAR(50) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX)='',
		@sSQL2 NVARCHAR (MAX)='',
		@sSQL3 NVARCHAR (MAX)='',
		@sSQL4 NVARCHAR (MAX)='',
		@sSQL5 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
        @TableID VARCHAR(50) = ''
--IF @Mode = 1 SET @TableID = 'DRT2010' ELSE SET @TableID = 'DRT2000'
SET @OrderBy = 'CustomerID,DebtorID ASC,ContractNo,ActionDate ASC'
IF @IsSearch = 1
BEGIN
	IF @BranchIDList IS NOT NULL SET @sWhere = @sWhere + '
	 AND H01.BranchID IN ('''+@BranchIDList+''') '
	IF ISNULL(@CustomerID,'%') <> '%' SET @sWhere = @sWhere + '
	 AND D10.CustomerID = '''+@CustomerID+''' '
	IF @DebtorID IS NOT NULL SET @sWhere = @sWhere + '
	 AND D10.DebtorID LIKE ''%'+@DebtorID+'%'' '
	IF @DebtorName IS NOT NULL 
	BEGIN
		IF @Mode = 1 ---NTD
		BEGIN 
			SET @sWhere = @sWhere + 
	' AND D11.DebtorName LIKE N''%'+@DebtorName+'%'' '
		END
		ELSE
		BEGIN ---NTM
			SET @sWhere = @sWhere + 
	' AND D10.DebtorName LIKE N''%'+@DebtorName+'%'' '
		END
	END
	
	IF @ContractNo IS NOT NULL SET @sWhere = @sWhere + '
	 AND D10.ContractNo LIKE ''%'+@ContractNo+'%'' '
	
	IF ISNULL(@TeamID,'%') <> '%' SET @sWhere = @sWhere + '
	 AND D12.TeamID = '''+@TeamID+''' '			
	
	IF (@FromContractReceiveDate IS NOT NULL OR   @ToContractReceiveDate IS NOT NULL) 
	BEGIN
		IF @Mode = 1 ---NTD
		BEGIN 
			SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR, D11.ContractReceiveDate, 112) BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromContractReceiveDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToContractReceiveDate, 112),'A')+''' '
		END
		ELSE
		BEGIN ---NTM
			SET @sWhere = @sWhere + '
	 AND CONVERT(VARCHAR, D10.ContractReceiveDate, 112) BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromContractReceiveDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToContractReceiveDate, 112),'A')+''' '
		END

	 END
	
	IF @IsPrinted IS NOT NULL AND ISNULL(@IsTypePrint,0) = 1
	BEGIN
		IF @IsPrinted=0 SET @sWhere = @sWhere + ' AND D81.ContractNo IS NULL' 
		ELSE SET @sWhere = @sWhere + ' AND D81.ContractNo IS NOT NULL' 
	END
	IF @PhoneNumber IS NOT NULL 
		IF @Mode = 1 ---NTD
		BEGIN 	
			SET @sWhere = @sWhere + 
	' AND (D11.ComEmail LIKE ''%'+@PhoneNumber+'%'' OR D11.HomeEmail LIKE ''%'+@PhoneNumber+'%'' OR D11.MobiPhone01 LIKE ''%'+@PhoneNumber+'%''
		OR D11.MobiPhone02 LIKE ''%'+@PhoneNumber+'%'' OR D11.ComPhone01 LIKE ''%'+@PhoneNumber+'%'' OR D11.ComPhone02 LIKE ''%'+@PhoneNumber+'%''
		OR D11.HomePhone01 LIKE ''%'+@PhoneNumber+'%'' OR D11.HomePhone02 LIKE ''%'+@PhoneNumber+'%'')'	
		END
		ELSE
		BEGIN 	---NTM
			SET @sWhere = @sWhere + 
	' AND (D10.ComEmail LIKE ''%'+@PhoneNumber+'%'' OR D10.HomeEmail LIKE ''%'+@PhoneNumber+'%'' OR D10.MobiPhone01 LIKE ''%'+@PhoneNumber+'%''
		OR D10.MobiPhone02 LIKE ''%'+@PhoneNumber+'%'' OR D10.ComPhone01 LIKE ''%'+@PhoneNumber+'%'' OR D10.ComPhone02 LIKE ''%'+@PhoneNumber+'%''
		OR D10.HomePhone01 LIKE ''%'+@PhoneNumber+'%'' OR D10.HomePhone02 LIKE ''%'+@PhoneNumber+'%'')'	
		END

	IF ISNULL(@ContractGroupID,'%') <> '%' 
	BEGIN
		IF @Mode = 1 ---NTD
		BEGIN 
			SET @sWhere = @sWhere + 
	' AND D11.ContractGroupID = '''+@ContractGroupID+''' '
		END
		ELSE
		BEGIN ---NTM
			SET @sWhere = @sWhere + '
	 AND D10.ContractGroupID = '''+@ContractGroupID+''' '
		END
	END

	IF @IsNew IS NOT NULL SET @sWhere = @sWhere + '
	 AND (CASE WHEN D10.TranMonth = '+STR(@TranMonth)+' AND D10.TranYear = '+STR(@TranYear)+' THEN 1 ELSE 0 END) LIKE '+STR(@IsNew)+' '
	IF ISNULL(@DispathTypeID,'%') <> '%'
	BEGIN
		IF @DispathTypeID = 0 
		BEGIN
			IF @Mode = 1 ---NTD
			BEGIN 
				SET @sWhere = @sWhere + '
	 AND ISNULL(D11.IsSendXR, 0) <> 1'
			END
			ELSE
			BEGIN ---NTM
				SET @sWhere = @sWhere + '
	 AND ISNULL(D10.IsSendXR, 0) <> 1'
			END
		END

		IF @DispathTypeID = 1 
		BEGIN
			IF @Mode = 1 ---NTD
			BEGIN 
				SET @sWhere = @sWhere + '
	 AND ISNULL(D11.IsSendXR, 0) = 1'
			END
			ELSE
			BEGIN ---NTM
				SET @sWhere = @sWhere + '
	 AND ISNULL(D10.IsSendXR, 0) = 1'
			END
		END
		
		IF @DispathTypeID = 2 
		BEGIN
			IF @Mode = 1 ---NTD
			BEGIN 
				SET @sWhere = @sWhere + '
	 AND ISNULL(D11.IsSendVPL, 0) = 1'
			END
			ELSE
			BEGIN ---NTM
				SET @sWhere = @sWhere + '
	 AND ISNULL(D10.IsSendVPL, 0) = 1'
			END
		END
		
	END
END
IF ISNULL(@IsCheckAll,0) = 0 
BEGIN
	SET @ContractNoList=REPLACE(ISNULL(@ContractNoList,''),',',''',''')
	
	SET @sWhere = @sWhere + '
	AND D10.ContractNo IN ('''+@ContractNoList+''')'
END

IF @IsTypePrint<>1 AND @Mode <> 1
BEGIN
	IF (@FromNextActionDate IS NOT NULL OR @ToNextActionDate IS NOT NULL) SET @sWhere = @sWhere + '
		AND ISNULL(CONVERT(VARCHAR, D20.NextActionDate, 112),'''') BETWEEN '''+ISNULL(CONVERT(VARCHAR, @FromNextActionDate, 112),'')+''' AND '''+ISNULL(CONVERT(VARCHAR, @ToNextActionDate, 112),'A')+''' '

	IF ISNULL(@NextActionID,'%') <> '%'
	BEGIN
		IF ISNULL(@NextActionID,'%') = 'CLV'
			SET @sWhere = @sWhere + '
		AND D10.ContractNo NOT IN (SELECT DISTINCT ContractNo FROM DRT2020 WITH (NOLOCK))'
		ELSE 
			SET @sWhere = @sWhere + '
		AND ISNULL(D20.NextActionID, '''') = '''+@NextActionID+''' '

	END
END

---->>>>Phân quyền theo trạng thái truy cập

SET @sSQL = N'
SELECT CustomerID 
INTO #CustomerID_DRP2018
FROM DRT1031 WITH (NOLOCK)
WHERE DivisionID = '''+@DivisionID+'''
AND PortID = '''+@PortID+'''
AND (SELECT ISNULL([Disabled],0) FROM DRT1030 WITH (NOLOCK) WHERE PortID = '''+@PortID+''' ) = 0
AND GroupID IN (SELECT DISTINCT GroupID FROM AT1402 WITH (NOLOCK)
			  WHERE DivisionID = '''+@DivisionID+'''
			  AND UserID = '''+@UserID+''') '

----<<<<

IF 	@IsTypePrint=1
BEGIN
	IF @Mode = 1 --Nợ tiêu dùng
	BEGIN
		DECLARE @sWhere1 NVARCHAR(MAX) = N''
		IF ISNULL(@NextActionID,'%') <> '%' 
		BEGIN
			IF ISNULL(@NextActionID,'%') = 'CLV' SET @sWhere1 = @sWhere1+ N'
			AND NOT EXISTS (SELECT TOP 1 1 FROM DRT2020 WITH (NOLOCK) WHERE Temp.ContractNo = DRT2020.ContractNo)'
			ELSE SET @sWhere1 = @sWhere1+ N'
			AND ISNULL(Temp.NextActionID, '''') = '''+@NextActionID+''' '
		END
		
		IF ISNULL(@FromNextActionDate,'') <> ''  SET @sWhere1 = @sWhere1+ N'
			AND ISNULL(Temp.NextActionDate,'''') >=  '''+ISNULL(CONVERT(VARCHAR(50), @FromNextActionDate, 120),'')+''' '
		
		IF ISNULL(@ToNextActionDate,'') <> '' SET @sWhere1 = @sWhere1+ N'
		AND ISNULL(Temp.NextActionDate,'''') <='''+ISNULL(CONVERT(VARCHAR(50), @ToNextActionDate, 112),'')+''' '

		SET @sSQL1 = N'
		SELECT A.*
		INTO #DRP2018
		FROM
		(
			SELECT D10.APK, D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D11.DebtorName,
			D11.ContractReceiveDate, D10.BankAccount, D11.IdentifyCardNo, D11.Birthday, D11.WorkPlace, D11.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal, D10.PaidAmount,
			CONVERT(DATETIME,'''',120) AS NearPaidDate_THTT, 0 AS NearPaidAmount_THTT, 
			CASE WHEN ISNULL(D10.FirstUnPaidAmount,'''') <> '''' THEN CONVERT(DECIMAL(28,8),REPLACE(D10.FirstUnPaidAmount,'','','''')) ELSE 0 END AS RemainAmount_THTT, 
			0 AS PaidAmount_THTT, D10.OverDueDate, D10.OverDueDays, D10.Note, D10.ContractEndDate, D12.UnPaidAmount, D11.ContractStatus, 
			D11.New01 PhoneNumber,CASE WHEN ISNULL(D11.IsSendXR, 0) NOT IN (0,1,3,5,7) THEN 2 ELSE ISNULL(D11.IsSendVPL, 0) END AS IsSendVPL,
			CASE WHEN ISNULL(D11.IsSendVPL, 0) NOT IN (0,1,3,5,7) THEN 2 ELSE ISNULL(D11.IsSendXR, 0) END AS IsSendXR,
			D91.[Description] IsSendXRName, D92.[Description] IsSendVPLName,
			SUBSTRING((SELECT TOP 5 CHAR(10) + ST1.ProcessNote FROM DRT2020 ST1 WITH (NOLOCK) 
						WHERE ST1.ContractNo = D10.ContractNo ORDER BY ST1.CreateDate DESC FOR XML PATH ('''')), 2, 10000) ProcessNote,			
			D10.DebtPeriod, D12.UnPaidElse, D10.UnPaidPeriodTotal, D10.FirstUnPaidAmount,
			(SELECT SUM(ISNULL(PaidAmount,0)) FROM DRT2030 WITH (NOLOCK) WHERE ContractNo = D10.ContractNo AND DeleteFlag = 0 AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+') MonthTotalAmount,
			D10.NewStatus
		FROM DRT2010 D10 WITH (NOLOCK)
			LEFT JOIN DRT2110 D11 WITH (NOLOCK) ON D10.DebtorID = D11.DebtorID
			LEFT JOIN DRT1010 D010 WITH (NOLOCK) ON D010.CustomerID = D10.CustomerID
			LEFT JOIN DRT2012 D12 WITH (NOLOCK) ON D12.ContractNo = D10.ContractNo AND D12.TranMonth = '+STR(@TranMonth)+' AND D12.TranYear = '+STR(@TranYear)+'
			LEFT JOIN AT0010 A10 WITH (NOLOCK) ON A10.AdminUserID = D12.TeamID AND A10.UserID = '''+@UserID+''' --Phân quyền xem dữ liệu người khác
			LEFT JOIN HT1101 H01 WITH (NOLOCK) ON H01.TeamID = D12.TeamID
			--LEFT JOIN #DRV2018 D20 WITH (NOLOCK) ON D20.ContractNo = D10.ContractNo	
			LEFT JOIN DRT2081 D81 WITH (NOLOCK) ON D81.ContractNo = D10.ContractNo AND D81.DispathTypeID = ''XR1''
			LEFT JOIN DRT0099 D92 WITH (NOLOCK) ON D92.ID = ISNULL(D11.IsSendVPL,0) AND D92.CodeMaster = ''Dispath''
			LEFT JOIN DRT0099 D91 WITH (NOLOCK) ON D91.ID = ISNULL(D11.IsSendXR,0) AND D91.CodeMaster = ''Dispath''
			INNER JOIN #CustomerID_DRP2018 ON D10.CustomerID = #CustomerID_DRP2018.CustomerID'
		
		SET @sSQL2 = N'
		WHERE D10.DivisionID = '''+@DivisionID+'''  '+@sWhere+'
		AND ISNULL(A10.UserID, '''') <> '''' --Phân quyền xem dữ liệu người khác
		GROUP BY D10.APK, D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D11.DebtorName,
			D11.ContractReceiveDate, D11.ContractGroupID,D10.FirstUnPaidAmount,
			D10.BankAccount, D11.IdentifyCardNo, D11.Birthday, D11.WorkPlace, D11.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.PaidAmount, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal ,D10.OverDueDate, D10.OverDueDays, D10.Note, 
			D10.ContractEndDate, D12.UnPaidAmount, D11.ContractStatus, D11.New01 ,D10.DebtPeriod, D12.UnPaidElse, D10.UnPaidPeriodTotal, D11.IsSendVPL,
			D11.IsSendXR, D91.[Description], D92.[Description],
			D10.NewStatus
		)A
			
	SELECT D12.ContractNo, D11.DebtorID, D11.AddressID AS NextAddressID, D11.[Address] AS NextAddress, D11.Ward AS NextWard, D11.Note AS AddressNote, AT12.CityName AS NextCity,
	AT13.DistrictName AS NextDistrict
	INTO #DRT2011
	FROM DRT2011 D11 WITH (NOLOCK)
	INNER JOIN #DRP2018 D12 WITH (NOLOCK) ON D12.DebtorID = D11.DebtorID
	LEFT JOIN AT1002 AT12 WITH (NOLOCK) ON  AT12.CityID = D11.City
	LEFT JOIN AT1013 AT13 WITH (NOLOCK) ON  AT13.DistrictID = D11.District AND AT13.CityID=AT12.CityID
	WHERE ISNULL(D11.Address,'''') <> '''' AND ISNULL(D11.Address,'''') <> ''0''
	'
	SET @sSQL3 = N'
	SELECT *
	INTO #DRV2018
	FROM
	(
		SELECT D21.ContractNo, D11.DebtorID, D20.ActionID, D20.ActionDate, D20.NextActionID, D20.NextActionDate, D20.ActionAddressID, D20.NextPaidAmount, 1 [Status], D20.NextActionAddressID,
		D11.NextAddressID, D11.NextAddress, D11.NextCity, D11.NextDistrict, D11.NextWard, D11.AddressNote
		FROM 
		(
			SELECT DRT2020.ContractNo, MAX(DRT2020.CreateDate) CreateDate FROM DRT2020 WITH (NOLOCK)
			INNER JOIN #DRP2018 T2 ON DRT2020.ContractNo = T2.ContractNo GROUP BY DRT2020.ContractNo
		) D21
		--LEFT JOIN DRT2020 D22 WITH (NOLOCK) ON D22.ContractNo = D21.ContractNo AND D22.CreateDate = D21.CreateDate 
		LEFT JOIN 
		(
			SELECT DRT2020.ActionID, DRT2020.ActionDate, DRT2020.NextActionID, DRT2020.NextActionDate, DRT2020.ContractNo, DRT2020.ActionAddressID, DRT2020.NextActionAddressID, DRT2020.CreateDate, DRT2020.NextPaidAmount
				FROM DRT2020 WITH (NOLOCK) INNER JOIN #DRP2018 T2 ON DRT2020.ContractNo = T2.ContractNo WHERE NextActionAddressID IS NOT NULL
			UNION ALL
			SELECT DRT2020.ActionID, DRT2020.ActionDate, DRT2020.NextActionID, DRT2020.NextActionDate, DRT2020.ContractNo, DRT2020.ActionAddressID, DRT2020.NextActionAddressID2 AS NextActionAddressID, DRT2020.CreateDate, DRT2020.NextPaidAmount
				FROM DRT2020 WITH (NOLOCK) INNER JOIN #DRP2018 T2 ON DRT2020.ContractNo = T2.ContractNo WHERE NextActionAddressID2 IS NOT NULL
			UNION ALL
			SELECT DRT2020.ActionID, DRT2020.ActionDate, DRT2020.NextActionID, DRT2020.NextActionDate, DRT2020.ContractNo, DRT2020.ActionAddressID, DRT2020.NextActionAddressID3 AS NextActionAddressID, DRT2020.CreateDate, DRT2020.NextPaidAmount
				FROM DRT2020 WITH (NOLOCK) INNER JOIN #DRP2018 T2 ON DRT2020.ContractNo = T2.ContractNo WHERE NextActionAddressID3 IS NOT NULL				
		) D20 ON D20.ContractNo = D21.ContractNo AND D20.CreateDate = D21.CreateDate
		LEFT JOIN #DRT2011 D11 ON D21.ContractNo = D11.ContractNo AND D11.NextAddressID = D20.NextActionAddressID
		WHERE D20.NextActionAddressID IS NOT NULL
	
		UNION ALL -- lay tat ca dia chi NTD neu lan xu ly moi nhat khong co dia chi di tiep theo
		
		SELECT D21.ContractNo, D11.DebtorID, D22.ActionID, D22.ActionDate, D22.NextActionID, D22.NextActionDate, D22.ActionAddressID, D22.NextPaidAmount,2 [Status], D22.NextActionAddressID,
		D11.NextAddressID, D11.NextAddress, D11.NextCity, D11.NextDistrict, D11.NextWard, D11.AddressNote
		FROM (SELECT ContractNo, MAX(CreateDate) CreateDate FROM DRT2020 WITH (NOLOCK) GROUP BY ContractNo) D21
		INNER JOIN #DRP2018 T2 ON D21.ContractNo = T2.ContractNo
		LEFT JOIN #DRT2011 D11 ON D21.ContractNo = D11.ContractNo
		LEFT JOIN DRT2020 D22 WITH (NOLOCK) ON D22.ContractNo = D21.ContractNo AND D22.CreateDate = D21.CreateDate
		WHERE ISNULL(D22.NextActionAddressID,'''') = '''' AND ISNULL(D22.NextActionAddressID2,'''') = '''' AND ISNULL(D22.NextActionAddressID2,'''') = ''''
		
		UNION ALL -- lay tat ca dia chi neu ho so (no tieu dung) chua duoc xu ly hang ngay		
		SELECT D11.ContractNo,D11.DebtorID, NULL ActionID, NULL ActionDate, NULL NextActionID, NULL NextActionDate, NULL ActionAddressID, NULL NextPaidAmount,2 [Status], NULL AS NextActionAddressID,
		D11.NextAddressID, D11.NextAddress, D11.NextCity, D11.NextDistrict, D11.NextWard, D11.AddressNote
		FROM #DRT2011 D11 WITH (NOLOCK)
		INNER JOIN #DRP2018 T2 ON D11.ContractNo = T2.ContractNo
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM DRT2020 WITH (NOLOCK) WHERE DRT2020.ContractNo = D11.ContractNo)	
	)Temp
	WHERE EXISTS (SELECT TOP 1 1 FROM DRT2011 WITH (NOLOCK) WHERE DebtorID = Temp.DebtorID AND ISNULL(District,'''') LIKE N''%'+ISNULL(@District,'')+'%''
									AND ISNULL(Ward,'''') LIKE N''%'+ISNULL(@Ward,'')+'%''
									AND ISNULL(City,'''') LIKE N''%'+ISNULL(@City,'')+'%''
									AND ISNULL(Address,'''') LIKE N''%'+ISNULL(@Street,'')+'%'')
	'+@sWhere1+'
	'
	
	SET @sSQL4 = N'
		SELECT  D10.APK, D10.TeamID, D10.BranchID, D10.ContractNo, D10.CustomerID, D10.CustomerName, D10.DebtorID, D10.DebtorName,
		D10.ContractReceiveDate, CONVERT(DATETIME,'''',120) AS NearPaidDate_THTT, 0 AS NearPaidAmount_THTT, 0 AS PaidAmount_THTT,
		CASE WHEN ISNULL(D10.FirstUnPaidAmount,'''') <> '''' THEN CONVERT(DECIMAL(28,8),REPLACE(D10.FirstUnPaidAmount,'','','''')) ELSE 0 END AS RemainAmount_THTT, 
		D10.BankAccount, D10.IdentifyCardNo, D10.Birthday, D10.WorkPlace, D10.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
		D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D10.PunishFee, D10.OverDueProfit, D10.LoanBeginDate,D20.Status,
		D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal, D10.PaidAmount, D20.ActionDate, D20.NextActionDate, D20.NextActionID, D20.NextPaidAmount,
		D10.OverDueDate, D10.OverDueDays, D10.Note, D10.ContractEndDate, D10.UnPaidAmount, D10.ContractStatus, 
		D10.PhoneNumber, D10.IsSendVPL, D10.IsSendXR, D10.IsSendXRName, D10.IsSendVPLName, D10.ProcessNote,	D10.DebtPeriod, D10.UnPaidElse, D10.UnPaidPeriodTotal, D10.FirstUnPaidAmount, D10.MonthTotalAmount,D10.NewStatus,
		CASE WHEN D20.Status = 1 THEN D20.NextAddressID ELSE NULL END AS NextAddressID, CASE WHEN D20.Status = 1 THEN D20.NextAddress ELSE NULL END AS NextAddress,
		CASE WHEN D20.Status = 1 THEN D20.NextWard ELSE NULL END AS NextWard, CASE WHEN D20.Status = 1 THEN D20.NextCity ELSE NULL END AS NextCity,
		CASE WHEN D20.Status = 1 THEN D20.NextDistrict ELSE NULL END AS NextDistrict, CASE WHEN D20.Status = 1 THEN D20.AddressNote ELSE NULL END AS AddressNote,
		CASE WHEN D20.Status = 2 THEN D20.NextAddressID ELSE NULL END AS AddressID, CASE WHEN D20.Status = 2 THEN D20.NextAddress ELSE NULL END AS Address,
		CASE WHEN D20.Status = 2 THEN D20.NextWard ELSE NULL END AS Ward, CASE WHEN D20.Status = 2 THEN D20.NextCity ELSE NULL END AS City,
		CASE WHEN D20.Status = 2 THEN D20.NextDistrict ELSE NULL END AS District, CASE WHEN D20.Status = 2 THEN D20.AddressNote ELSE NULL END AS Note1
		INTO #Table
		FROM #DRP2018 D10 
		INNER JOIN #DRV2018 D20 ON D20.ContractNo = D10.ContractNo
		WHERE ISNULL((SELECT TOP 1 1 FROM DRT2011 WITH (NOLOCK) WHERE DRT2011.DebtorID = D10.DebtorID AND ISNULL(DRT2011.District,'''') LIKE N''%'+ISNULL(@District,'')+'%''
									AND ISNULL(DRT2011.Ward,'''') LIKE N''%'+ISNULL(@Ward,'')+'%''
									AND ISNULL(DRT2011.City,'''') LIKE N''%'+ISNULL(@City,'')+'%''
									AND ISNULL(DRT2011.Address,'''') LIKE N''%'+ISNULL(@Street,'')+'%''), 0) = 1
		 '

		 SET @sSQL5 = N'
	UPDATE T1
	SET T1.NearPaidDate_THTT = BT.PaidDate
	FROM #Table T1 
	INNER JOIN (SELECT ContractNo, MAX(D30.PaidDate) AS PaidDate 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #Table WHERE #Table.ContractNo = D30.ContractNo) GROUP BY ContractNo
	) BT ON T1.ContractNo = BT.ContractNo
	
	UPDATE T1
	SET T1.NearPaidAmount_THTT = BT.PaidAmount,
		T1.RemainAmount_THTT = BT.UnPaidAmount
	FROM #Table T1 
	INNER JOIN (SELECT ContractNo, PaidDate, SUM(D30.PaidAmount) PaidAmount, SUM(D30.UnPaidAmount) UnPaidAmount 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #Table WHERE #Table.ContractNo = D30.ContractNo) GROUP BY ContractNo, PaidDate
	) BT ON BT.ContractNo = T1.ContractNo
	WHERE T1.NearPaidDate_THTT = BT.PaidDate
	
	UPDATE T1
	SET T1.PaidAmount_THTT = BT.PaidAmount
	FROM #Table T1 
	INNER JOIN (SELECT ContractNo, SUM(D30.PaidAmount) PaidAmount 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #Table WHERE #Table.ContractNo = D30.ContractNo) GROUP BY ContractNo
	) BT ON BT.ContractNo = T1.ContractNo
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+',NextAddressID,AddressID) AS RowNum, *
	FROM (SELECT DISTINCT * FROM #Table)A ORDER BY RowNum
	
	DROP TABLE #CustomerID_DRP2018
	DROP TABLE #DRP2018
	--DROP TABLE #DRP2011
	DROP TABLE #Table'
	END
	ELSE
	BEGIN ---Nợ thương mại
		SET @sSQL1 = N'
		SELECT A.*
		INTO #DRP2018
		FROM
		(
			SELECT DISTINCT D10.APK, D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D10.DebtorName,
			D10.ContractReceiveDate, D20.ActionDate, D20.NextActionDate, D10.ContractGroupID, D20.NextActionID,
			D10.BankAccount, D10.IdentifyCardNo, D10.Birthday, D10.WorkPlace, D10.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal, D10.PaidAmount,
			CONVERT(DATETIME,'''',120) AS NearPaidDate_THTT, 0 AS NearPaidAmount_THTT, 
			CASE WHEN ISNULL(D10.FirstUnPaidAmount,'''') <>  '''' THEN CONVERT(DECIMAL(28,8),REPLACE(D10.FirstUnPaidAmount,'','','''')) ELSE 0 END AS RemainAmount_THTT, 
			0 AS PaidAmount_THTT, D10.OverDueDate, D10.OverDueDays, D10.Note, D10.ContractEndDate, D12.UnPaidAmount, D10.ContractStatus, 
			D10.New01 PhoneNumber,CASE WHEN ISNULL(D10.IsSendXR, 0) NOT IN (0,1,3,5,7) THEN 2 ELSE ISNULL(D10.IsSendVPL, 0) END AS IsSendVPL,
			CASE WHEN ISNULL(D10.IsSendVPL, 0) NOT IN (0,1,3,5,7) THEN 2 ELSE ISNULL(D10.IsSendXR, 0) END AS IsSendXR,
			D91.[Description] IsSendXRName, D92.[Description] IsSendVPLName,
			SUBSTRING((SELECT TOP 5 CHAR(10) + ST1.ProcessNote FROM DRT2020 ST1 WITH (NOLOCK) 
						WHERE ST1.ContractNo = D10.ContractNo ORDER BY ST1.CreateDate DESC FOR XML PATH ('''')), 2, 10000) ProcessNote,
			CASE WHEN D20.Status = 1 THEN D20.NextCity ELSE NULL END NextCity,
			CASE WHEN D20.Status = 1 THEN D20.NextAddressID ELSE NULL END NextAddressID,
			CASE WHEN D20.Status = 1 THEN D20.NextAddress ELSE NULL END NextAddress,
			CASE WHEN D20.Status = 1 THEN D20.NextDistrict ELSE NULL END NextDistrict,
			CASE WHEN D20.Status = 1 THEN D20.NextWard ELSE NULL END NextWard,
			CASE WHEN D20.Status = 1 THEN D20.AddressNote ELSE NULL END AddressNote,
			D10.FirstUnPaidAmount,
			CASE WHEN D20.Status = 2 THEN D20.NextCity ELSE NULL END City,
			CASE WHEN D20.Status = 2 THEN D20.NextDistrict ELSE NULL END District,
			CASE WHEN D20.Status = 2 THEN D20.NextWard ELSE NULL END Ward,
			CASE WHEN D20.Status = 2 THEN D20.AddressNote ELSE NULL END Note1,
			CASE WHEN D20.Status = 2 THEN D20.NextAddressID ELSE NULL END AddressID,
			CASE WHEN D20.Status = 2 THEN D20.NextAddress ELSE NULL END Address,
			D10.DebtPeriod, D12.UnPaidElse, D10.UnPaidPeriodTotal, D20.NextPaidAmount,
			(SELECT SUM(ISNULL(PaidAmount,0)) FROM DRT2030 WITH (NOLOCK) WHERE ContractNo = D10.ContractNo AND DeleteFlag = 0 AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+') MonthTotalAmount                                                                         
		FROM DRT2000 D10 WITH (NOLOCK)
			LEFT JOIN DRT1010 D010 WITH (NOLOCK) ON D010.CustomerID = D10.CustomerID
			LEFT JOIN DRT2012 D12 WITH (NOLOCK) ON D12.ContractNo = D10.ContractNo AND D12.TranMonth = '+STR(@TranMonth)+' AND D12.TranYear = '+STR(@TranYear)+'
			LEFT JOIN AT0010 A10 WITH (NOLOCK) ON A10.AdminUserID = D12.TeamID AND A10.UserID = '''+@UserID+''' --Phân quyền xem dữ liệu người khác
			LEFT JOIN HT1101 H01 WITH (NOLOCK) ON H01.TeamID = D12.TeamID
			LEFT JOIN DRV2018 D20 WITH (NOLOCK) ON D20.ContractNo = D10.ContractNo	
			LEFT JOIN DRT2081 D81 WITH (NOLOCK) ON D81.ContractNo = D10.ContractNo AND D81.DispathTypeID = ''XR1''
			LEFT JOIN DRT0099 D92 WITH (NOLOCK) ON D92.ID = ISNULL(D10.IsSendVPL,0) AND D92.CodeMaster = ''Dispath''
			LEFT JOIN DRT0099 D91 WITH (NOLOCK) ON D91.ID = ISNULL(D10.IsSendXR,0) AND D91.CodeMaster = ''Dispath''
			INNER JOIN #CustomerID_DRP2018 ON D10.CustomerID = #CustomerID_DRP2018.CustomerID'
		
		SET @sSQL2 = N'
		WHERE D10.DivisionID = '''+@DivisionID+''' '+@sWhere+'
		AND ISNULL(A10.UserID, '''') <> '''' --Phân quyền xem dữ liệu người khác
		GROUP BY D10.APK, D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D10.DebtorName,
			D10.ContractReceiveDate, D20.ActionDate, D20.NextActionDate, D10.ContractGroupID, D20.NextActionID,
			D10.BankAccount, D10.IdentifyCardNo, D10.Birthday, D10.WorkPlace, D10.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.PaidAmount, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal ,D10.OverDueDate, D10.OverDueDays, D10.Note, 
			D10.ContractEndDate, D12.UnPaidAmount, D10.ContractStatus, D10.New01 ,D10.DebtPeriod, D12.UnPaidElse, D10.UnPaidPeriodTotal, D20.NextPaidAmount,
			D20.Status,D20.NextAddress, D20.NextCity, D20.NextDistrict, D20.NextWard,D20.AddressNote, D10.FirstUnPaidAmount, D20.NextAddressID, D10.IsSendVPL,
			D10.IsSendXR, D91.[Description], D92.[Description]
		)A
		WHERE ISNULL((SELECT TOP 1 1 FROM DRT2011 WITH (NOLOCK) WHERE ContractNo = A.ContractNo AND ISNULL(District,'''') LIKE N''%'+ISNULL(@District,'')+'%''
									AND ISNULL(Ward,'''') LIKE N''%'+ISNULL(@Ward,'')+'%''
									AND ISNULL(City,'''') LIKE N''%'+ISNULL(@City,'')+'%''
									AND ISNULL(Address,'''') LIKE N''%'+ISNULL(@Street,'')+'%''), 0) = 1
		 '

	SET @sSQL3 = N'
	UPDATE T1
	SET T1.NearPaidDate_THTT = BT.PaidDate
	FROM #DRP2018 T1 
	INNER JOIN (SELECT ContractNo, MAX(D30.PaidDate) AS PaidDate 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #DRP2018 WHERE #DRP2018.ContractNo = D30.ContractNo) GROUP BY ContractNo
	) BT ON T1.ContractNo = BT.ContractNo
	
	UPDATE T1
	SET T1.NearPaidAmount_THTT = BT.PaidAmount,
		T1.RemainAmount_THTT = BT.UnPaidAmount
	FROM #DRP2018 T1 
	INNER JOIN (SELECT ContractNo, PaidDate, SUM(D30.PaidAmount) PaidAmount, SUM(D30.UnPaidAmount) UnPaidAmount 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #DRP2018 WHERE #DRP2018.ContractNo = D30.ContractNo) GROUP BY ContractNo, PaidDate
	) BT ON BT.ContractNo = T1.ContractNo
	WHERE T1.NearPaidDate_THTT = BT.PaidDate
	
	UPDATE T1
	SET T1.PaidAmount_THTT = BT.PaidAmount
	FROM #DRP2018 T1 
	INNER JOIN (SELECT ContractNo, SUM(D30.PaidAmount) PaidAmount 
				FROM DRT2030 D30 WITH (NOLOCK) WHERE EXISTS (SELECT TOP 1 1 FROM #DRP2018 WHERE #DRP2018.ContractNo = D30.ContractNo) GROUP BY ContractNo
	) BT ON BT.ContractNo = T1.ContractNo
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+',NextAddressID,AddressID) AS RowNum, *
	FROM #DRP2018 ORDER BY RowNum
	
	DROP TABLE #CustomerID_DRP2018
	DROP TABLE #DRP2018'

	END
END
ELSE ---In dạng 2
BEGIN
	IF @Mode = 1 --Nợ tiêu dùng
	BEGIN
		SET @sSQL1 = '
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, A.*
		FROM
		(
			SELECT DISTINCT D20.APK,  D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D11.DebtorName,
			D11.ContractReceiveDate, D11.ContractGroupID, D20.NextActionID,
			D10.BankAccount, D11.IdentifyCardNo, D11.Birthday, D11.WorkPlace, D11.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal, D10.PaidAmount,
			D10.OverDueDate, D10.OverDueDays, D10.Note, D10.ContractEndDate, D12.UnPaidAmount, D11.ContractStatus,
			D11.New01 PhoneNumber,D10.FirstUnPaidAmount,D20.ProcessingID,D20.ActionDate,D20.ActionID,D120.VDescription ActionName,
			D20.ActionObjectID, D1201.VDescription ActionObjectName,D20.ReasonID,D1202.VDescription ReasonName,D20.NextActionDate,D20.NextPaidAmount,
			D20.ProcessNote,RIGHT(CONVERT(NVARCHAR(MAX),D11.WorkHistory),32767) WorkHistory,D20.ResultID,D120.VDescription ResultName,
			D111.Address01,D111.Ward01,D111.District01,D111.City01,D111.City01Name,D111.District01Name,
			D112.Address02,D112.Ward02,D112.District02,D112.City02,D112.City02Name,D112.District02Name,
			D113.Address03,D113.Ward03,D113.District03,D113.City03,D113.City03Name,D113.District03Name,
			D114.Address04,D114.Ward04,D114.District04,D114.City04,D114.City04Name,D114.District04Name,
			D115.Address05,D115.Ward05,D115.District05,D115.City05,D115.City05Name,D115.District05Name,
			D11.MobiPhone01,D11.MobiPhone02,D11.ComPhone01,D11.ComPhone02,D11.HomePhone01,D11.HomePhone02
		FROM DRT2010 D10 WITH (NOLOCK)
			LEFT JOIN DRT2110 D11 WITH (NOLOCK) ON D10.DebtorID = D11.DebtorID
			LEFT JOIN DRT1010 D010 WITH (NOLOCK) ON D010.CustomerID = D10.CustomerID
			LEFT JOIN DRT2012 D12 WITH (NOLOCK) ON D12.ContractNo = D10.ContractNo AND D12.TranMonth = '+STR(@TranMonth)+' AND D12.TranYear = '+STR(@TranYear)+'
			LEFT JOIN AT0010 A10 WITH (NOLOCK) ON A10.AdminUserID = D12.TeamID AND A10.UserID = '''+@UserID+''' --Phân quyền xem dữ liệu người khác
			LEFT JOIN HT1101 H01 WITH (NOLOCK) ON H01.TeamID = D12.TeamID
			LEFT JOIN DRT2020 D20 WITH (NOLOCK) ON D20.ContractNo = D10.ContractNo	
			LEFT JOIN DRT1020 D120 WITH (NOLOCK) ON D120.InfoID = D20.ActionID AND D120.InfoTypeID =''Action''
			LEFT JOIN DRT1020 D1201 WITH (NOLOCK) ON D1201.InfoID = D20.ActionObjectID AND D1201.InfoTypeID =''ActionObject''
			LEFT JOIN DRT1020 D1202 WITH (NOLOCK) ON D1202.InfoID = D20.ReasonID AND D1202.InfoTypeID =''Reason''
			LEFT JOIN DRT1020 D1203 WITH (NOLOCK) ON D1202.InfoID = D20.ResultID AND D1202.InfoTypeID =''Result'' 
			INNER JOIN #CustomerID_DRP2018 ON D10.CustomerID = #CustomerID_DRP2018.CustomerID'
		SET @sSQL2='
			LEFT JOIN (SELECT D11.DebtorID, [Address] Address01, Ward Ward01, District District01, City City01
						,A2.CityName City01Name,A3.DistrictName District01Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD01'')D111 ON D111.DebtorID = D10.DebtorID
			LEFT JOIN (SELECT D11.DebtorID, [Address] Address02, Ward Ward02, District District02, City City02
						,A2.CityName City02Name,A3.DistrictName District02Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD02'')D112 ON D112.DebtorID = D10.DebtorID
			LEFT JOIN (SELECT DebtorID , [Address] Address03, Ward Ward03, District District03, City City03
						,A2.CityName City03Name,A3.DistrictName District03Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD03'')D113 ON D113.DebtorID = D10.DebtorID
			LEFT JOIN (SELECT DebtorID , [Address] Address04, Ward Ward04, District District04, City City04
						,A2.CityName City04Name,A3.DistrictName District04Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD04'')D114 ON D114.DebtorID = D10.DebtorID
			LEFT JOIN (SELECT DebtorID , [Address] Address05, Ward Ward05, District District05, City City05
						,A2.CityName City05Name,A3.DistrictName District05Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD05'')D115 ON D115.DebtorID = D10.DebtorID
		WHERE D10.DivisionID = '''+@DivisionID+''' '+@sWhere+'
		AND ISNULL(A10.UserID, '''') <> '''' --Phân quyền xem dữ liệu người khác
		--AND ISNULL(D20.ProcessingID,'''') <>''''
		)A
		WHERE ISNULL((SELECT TOP 1 1 FROM DRT2011 WITH (NOLOCK) WHERE DebtorID = A.DebtorID AND ISNULL(District,'''') LIKE N''%'+ISNULL(@District,'')+'%''
									AND ISNULL(Ward,'''') LIKE N''%'+ISNULL(@Ward,'')+'%''
									AND ISNULL(City,'''') LIKE N''%'+ISNULL(@City,'')+'%''
									AND ISNULL(Address,'''') LIKE N''%'+ISNULL(@Street,'')+'%''), 0) = 1
		
		ORDER BY '+@OrderBy+' 
		DROP TABLE #CustomerID_DRP2018'
	END
	ELSE --Nợ thương mại
	BEGIN
		SET @sSQL1 = '
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, A.*
		FROM
		(
			SELECT DISTINCT D20.APK,  D12.TeamID, H01.BranchID, D10.ContractNo, D10.CustomerID, D010.CustomerName, D10.DebtorID, D10.DebtorName,
			D10.ContractReceiveDate, D10.ContractGroupID, D20.NextActionID,
			D10.BankAccount, D10.IdentifyCardNo, D10.Birthday, D10.WorkPlace, D10.WorkNote, D10.DebtAmount, D10.Asset, D10.BikeName,
			D10.NumberPlate, D10.CavetStatus, D10.BikePrice, D10.PrePaid, D12.PunishFee, D12.OverDueProfit, D10.LoanBeginDate,
			D10.LoanEndDate, D10.PaidPerMonth, D10.DebtDate, D10.NearPaidDate, D10.NearPaidAmount, D10.PaidPeriodTotal, D10.PaidAmount,
			D10.OverDueDate, D10.OverDueDays, D10.Note, D10.ContractEndDate, D12.UnPaidAmount, D10.ContractStatus,
			D10.New01 PhoneNumber,D10.FirstUnPaidAmount,D20.ProcessingID,D20.ActionDate,D20.ActionID,D120.VDescription ActionName,
			D20.ActionObjectID, D1201.VDescription ActionObjectName,D20.ReasonID,D1202.VDescription ReasonName,D20.NextActionDate,D20.NextPaidAmount,
			D20.ProcessNote,RIGHT(D10.WorkHistory,32767) WorkHistory,D20.ResultID,D120.VDescription ResultName,
			D111.Address01,D111.Ward01,D111.District01,D111.City01,D111.City01Name,D111.District01Name,
			D112.Address02,D112.Ward02,D112.District02,D112.City02,D112.City02Name,D112.District02Name,
			D113.Address03,D113.Ward03,D113.District03,D113.City03,D113.City03Name,D113.District03Name,
			D114.Address04,D114.Ward04,D114.District04,D114.City04,D114.City04Name,D114.District04Name,
			D115.Address05,D115.Ward05,D115.District05,D115.City05,D115.City05Name,D115.District05Name,
			D10.MobiPhone01,D10.MobiPhone02,D10.ComPhone01,D10.ComPhone02,D10.HomePhone01,D10.HomePhone02
		FROM DRT2000 D10 WITH (NOLOCK)
			LEFT JOIN DRT1010 D010 WITH (NOLOCK) ON D010.CustomerID = D10.CustomerID
			LEFT JOIN DRT2012 D12 WITH (NOLOCK) ON D12.ContractNo = D10.ContractNo AND D12.TranMonth = '+STR(@TranMonth)+' AND D12.TranYear = '+STR(@TranYear)+'
			LEFT JOIN AT0010 A10 WITH (NOLOCK) ON A10.AdminUserID = D12.TeamID AND A10.UserID = '''+@UserID+''' --Phân quyền xem dữ liệu người khác
			LEFT JOIN HT1101 H01 WITH (NOLOCK) ON H01.TeamID = D12.TeamID
			LEFT JOIN DRT2020 D20 WITH (NOLOCK) ON D20.ContractNo = D10.ContractNo	
			LEFT JOIN DRT1020 D120 WITH (NOLOCK) ON D120.InfoID = D20.ActionID AND D120.InfoTypeID =''Action''
			LEFT JOIN DRT1020 D1201 WITH (NOLOCK) ON D1201.InfoID = D20.ActionObjectID AND D1201.InfoTypeID =''ActionObject''
			LEFT JOIN DRT1020 D1202 WITH (NOLOCK) ON D1202.InfoID = D20.ReasonID AND D1202.InfoTypeID =''Reason''
			LEFT JOIN DRT1020 D1203 WITH (NOLOCK) ON D1202.InfoID = D20.ResultID AND D1202.InfoTypeID =''Result'' 
			INNER JOIN #CustomerID_DRP2018 ON D10.CustomerID = #CustomerID_DRP2018.CustomerID'
		SET @sSQL2='
			LEFT JOIN (SELECT ContractNo , [Address] Address01, Ward Ward01, District District01, City City01
						,A2.CityName City01Name,A3.DistrictName District01Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD01'')D111 ON D111.ContractNo = D10.ContractNo
			LEFT JOIN (SELECT ContractNo , [Address] Address02, Ward Ward02, District District02, City City02
						,A2.CityName City02Name,A3.DistrictName District02Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD02'')D112 ON D112.ContractNo = D10.ContractNo
			LEFT JOIN (SELECT ContractNo , [Address] Address03, Ward Ward03, District District03, City City03
						,A2.CityName City03Name,A3.DistrictName District03Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD03'')D113 ON D113.ContractNo = D10.ContractNo
			LEFT JOIN (SELECT ContractNo , [Address] Address04, Ward Ward04, District District04, City City04
						,A2.CityName City04Name,A3.DistrictName District04Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD04'')D114 ON D114.ContractNo = D10.ContractNo
			LEFT JOIN (SELECT ContractNo , [Address] Address05, Ward Ward05, District District05, City City05
						,A2.CityName City05Name,A3.DistrictName District05Name
						FROM DRT2011 D11 WITH (NOLOCK)
						LEFT JOIN AT1002 A2 WITH (NOLOCK) ON A2.CityID=D11.City
						LEFT JOIN AT1013 A3 WITH (NOLOCK) ON A3.DistrictID=D11.District
						WHERE D11.AddressID=''AD05'')D115 ON D115.ContractNo = D10.ContractNo
		WHERE D10.DivisionID = '''+@DivisionID+''' '+@sWhere+'
		AND ISNULL(A10.UserID, '''') <> '''' --Phân quyền xem dữ liệu người khác
		--AND ISNULL(D20.ProcessingID,'''') <>''''
		)A
		WHERE ISNULL((SELECT TOP 1 1 FROM DRT2011 WITH (NOLOCK) WHERE ContractNo = A.ContractNo AND ISNULL(District,'''') LIKE N''%'+ISNULL(@District,'')+'%''
									AND ISNULL(Ward,'''') LIKE N''%'+ISNULL(@Ward,'')+'%''
									AND ISNULL(City,'''') LIKE N''%'+ISNULL(@City,'')+'%''
									AND ISNULL(Address,'''') LIKE N''%'+ISNULL(@Street,'')+'%''), 0) = 1
		
		ORDER BY '+@OrderBy+' 
		DROP TABLE #CustomerID_DRP2018'
	END
END

--PRINT (@sSQL)
--PRINT (@sSQL1)
--PRINT (@sSQL2)
--PRINT (@sSQL3)
--PRINT (@sSQL4)
--PRINT (@sSQL5)

EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
