IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created BY Như Hàn
---- Created date 20/12/2018
---- Purpose: Đổ nguồn lưới kế thừa Kế hoạch thu chi phòng ban
/********************************************
EXEC FNP2007 'AIC', 11, 2018, 11, 2018, '2018-02-01 00:00:00.000', '2018-02-01 00:00:00.000', 1, '%', '', 1, 25
EXEC FNP2007 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @PriorityID, @Mode, @PageNumber, @PageSize, @APKList, @APK

'********************************************/
---- Modified by Như Hàn on 09/04/2019: Bổ sung điều kiện duyệt mới lên dữ liệu
---- Modified by .. on .. 

CREATE PROCEDURE [dbo].[FNP2007]
    @DivisionID AS NVARCHAR(50), 
    @FromMonth			INT,
	@FromYear			INT,
	@ToMonth			INT,
	@ToYear				INT,
	@FromDate			DATETIME,
	@ToDate				DATETIME,
	@IsDate				TINYINT, ----0 theo kỳ, 1 theo ngày
	@PriorityID			VARCHAR(50),
	@Mode				INT, ---0 Master, 1 Detail
	@PageNumber			INT,
	@PageSize			INT,
	@LanguageID			VARCHAR(50),
	@APKList			nVARCHAR(max), 
	@APK				VARCHAR(100) = null --Trường hợp sửa

AS

DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'', 
		@BeginDate DATETIME,	
		@EndDate DATETIME,
		@TotalRow VARCHAR(50)

--CREATE TABLE #FNP2007A (APK VARCHAR(50))
--INSERT INTO #FNP2007A (APK)
--SELECT X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS APK
--FROM @APKList.nodes('//Data') AS X (Data)

CREATE TABLE #FNP2007B (InheritVoucherID VARCHAR(50))
INSERT INTO #FNP2007B
SELECT DISTINCT InheritVoucherID 
FROM FNT2001 T1 WITH (NOLOCK)
WHERE T1.APKMaster = @APK

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

--SET @PeriodFrom = @FromMonth+@FromYear*100
--SET @PeriodTo = @ToMonth+@ToYear*100

SELECT @BeginDate = BeginDate FROM AV9999 WHERE TranMonth = @FromMonth AND TranYear = @FromYear

SELECT @EndDate = EndDate FROM AV9999 WHERE TranMonth = @ToMonth AND TranYear = @ToYear


SET @sWhere = @sWhere + ' AND T20.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@PriorityID,'') <> ''
SET @sWhere = @sWhere + '
				AND T20.PriorityID IN ('''+ISNULL(@PriorityID,'')+''')'	

IF @IsDate = 1
	BEGIN	
		IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T20.VoucherDate , 112) >= '''+CONVERT(VARCHAR(10),@FromDate,112)+''' '
		IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T20.VoucherDate , 112) <= '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T20.VoucherDate , 112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+'''  '
	END
ELSE	
	BEGIN
		SET @sWhere = @sWhere + '
			AND CONVERT(VARCHAR(10),T20.VoucherDate , 112) BETWEEN '''+CONVERT(VARCHAR(10),@BeginDate,112)+''' AND '''+CONVERT(VARCHAR(10),@EndDate,112)+'''  '
	END


IF @Mode = 0 --- Lưới Master
	BEGIN 
	SET @OrderBy = 'VoucherNo' 
	SET @sSQL = @sSQL +N' SELECT
	DISTINCT T20.APK                   
	,T20.DivisionID            
	,T20.TranMonth             
	,T20.TranYear              
	,T20.VoucherTypeID         
	,T20.VoucherNo             
	,T20.VoucherDate           
	,T20.EmployeeID   
	,T03.FullName         
	,T20.TransactionType       
	,T20.PayMentTypeID         
	,T20.PayMentPlanDate       
	,T20.CurrencyID            
	,T20.ExchangeRate          
	,T20.Descriptions          
	,T20.PriorityID            
	,T20.Status                
	,T20.TypeID                
	,T20.ApprovalDate          
	--,T20.ApprovalDescriptions  
	,T20.CreateUserID          
	,T20.CreateDate            
	,T20.LastModifyUserID      
	,T20.LastModifyDate        
	,T20.DeleteFlag       
	INTO  #FNT2000A
	FROM  FNT2000 T20 WITH (NOLOCK)
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON  T03.DivisionID = T20.DivisionID AND T03.EmployeeID = T20.EmployeeID
	INNER JOIN FNT2001 T21 WITH (NOLOCK) ON T20.APK = T21.APKMaster
	AND T21.APK NOT IN (SELECT FNT2001.InheritTransactionID FROM FNT2001 WITH (NOLOCK) WHERE FNT2001.InheritTableID = ''FNT2000'')
	WHERE T20.DeleteFlag = 0 AND T20.Status = 1 AND T20.TypeID = ''PB''
	'+@sWhere+''

	SET @sSQL = @sSQL +N'
	SELECT 
	T20.APK                   
	,T20.DivisionID            
	,T20.TranMonth             
	,T20.TranYear              
	,T20.VoucherTypeID         
	,T20.VoucherNo             
	,T20.VoucherDate           
	,T20.EmployeeID   
	,T03.FullName         
	,T20.TransactionType       
	,T20.PayMentTypeID         
	,T20.PayMentPlanDate       
	,T20.CurrencyID            
	,T20.ExchangeRate          
	,T20.Descriptions          
	,T20.PriorityID            
	,T20.Status                
	,T20.TypeID                
	,T20.ApprovalDate          
	--,T20.ApprovalDescriptions  
	,T20.CreateUserID          
	,T20.CreateDate            
	,T20.LastModifyUserID      
	,T20.LastModifyDate        
	,T20.DeleteFlag       
	INTO  #FNT2000B
	FROM  FNT2000 T20 WITH (NOLOCK)
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON  T03.DivisionID = T20.DivisionID AND T03.EmployeeID = T20.EmployeeID
	WHERE T20.DeleteFlag = 0 AND T20.Status = 1 AND T20.TypeID = ''PB''
	AND T20.APK IN (SELECT InheritVoucherID FROM #FNP2007B)'

	SET @sSQL = @sSQL +N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow,
	A.* FROM 
	(SELECT * FROM #FNT2000B
	UNION ALL
	SELECT * FROM #FNT2000A) A
	ORDER BY '+@OrderBy+' 
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
	'
	EXEC (@sSQL)
	--PRINT (@sSQL)
	END

ELSE IF @Mode = 1 --- Lưới Detail
BEGIN
	SET @sWhere1 = @sWhere1 + N'
	AND T21.APKMaster IN ('''+@APKList+''')'

	SET @OrderBy = 'Orders' 
	SET @sSQL = @sSQL +N'
		SELECT
		T21.APK                 
		,T21.APKMaster           
		,T21.DivisionID          
		,T21.Orders              
		,T21.JobName    
		, ISNULL(T21.OriginalAmount,0) - ISNULL(A.OAmount,0) OriginalAmount       
		, ISNULL(T21.ConvertedAmount,0) - ISNULL(A.CAmount,0) ConvertedAmount
		,T21.ApprovalOAmount     
		,T21.ApprovalCAmount     
		,T21.StatusDetail        
		,T21.ApprovalNotes       
		,T21.ObjectTransferID    
		,T22.ObjectName As ObjectTransferName
		,T21.ObjectBeneficiaryID 
		,T02.ObjectName As ObjectBeneficiaryName
		,T21.NormID      
		,T00.NormName        
		,T21.ResponsibleID       
		,T21.ObjectProposalID    
		,T12.ObjectName As ObjectProposalName
		,T21.Ana01ID             
		,T21.Ana02ID             
		,T21.Ana03ID             
		,T21.Ana04ID             
		,T21.Ana05ID             
		,T21.Ana06ID             
		,T21.Ana07ID             
		,T21.Ana08ID             
		,T21.Ana09ID             
		,T21.Ana10ID      
		,A11.AnaName AS Ana01Name
		,A12.AnaName AS Ana02Name
		,A13.AnaName AS Ana03Name
		,A14.AnaName AS Ana04Name
		,A15.AnaName AS Ana05Name
		,A16.AnaName AS Ana06Name
		,A17.AnaName AS Ana07Name
		,A18.AnaName AS Ana08Name
		,A19.AnaName AS Ana09Name
		,A20.AnaName AS Ana10Name     
		,T21.ContractAmount      
		,T21.Accumulated         
		,T21.ExtantPayment       
		,T21.ProvinceID          
		,T21.Notes               
		,T21.OverdueID    
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS OverdueName       
		,T21.OverdueDay          
		,T21.DateHaveFile        
		,T21.StatusFileID        
		,T21.AmountApproval      
		,T21.AmountEstimation    
		,T21.Delegacy            
		,T21.WeekNo              
		,T21.AmountApprovalBOD   
		,T21.ApprovalDes         
		,T21.TCKTDebt            
		,T21.TCKTExpired         
		,T21.TCKTDisbursement    
		,T21.TCKTGeneral         
		,T21.TCKTGuarantee       
		,T21.TCKTAmountApproval  
		,T21.TCKTApprovalDes     
		,T21.DeleteFlag          
		,T21.InheritTableID      
		,T21.InheritVoucherID    
		,T21.InheritTransactionID
		INTO #FNT2001A
		FROM FNT2001 T21 WITH (NOLOCK)
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T21.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T21.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T21.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T21.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T21.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
		LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T21.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
		LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T21.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
		LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T21.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
		LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T21.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
		LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T21.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
		LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T21.ObjectBeneficiaryID = T02.ObjectID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectProposalID = T12.ObjectID
		LEFT JOIN AT1202 T22 WITH (NOLOCK) ON T21.ObjectTransferID = T22.ObjectID
		LEFT JOIN FNT1000 T00 WITH (NOLOCK) ON T00.NormID = T21.NormID
		LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T21.OverdueID AND T19.CodeMaster = ''OverdueID''
		LEFT JOIN (
				SELECT PB.DivisionID, PB.InheritTransactionID, SUM(PB.OriginalAmount) OAmount, SUM(ConvertedAmount) CAmount 
				FROM FNT2001 PB WITH (NOLOCK)
				WHERE PB.DivisionID IN ('''+@DivisionID+''', ''@@@'')  AND ISNULL(InheritTransactionID,'''') <> ''''
				GROUP BY PB.DivisionID, PB.InheritTransactionID
				) A ON A.DivisionID = T21.DivisionID AND T21.APK = A.InheritTransactionID
		WHERE T21.DeleteFlag = 0 AND T21.Status = 1
		AND ISNULL(T21.OriginalAmount,0) - ISNULL(A.OAmount,0) > 0
		--AND T21.APK NOT IN (SELECT FNT2001.InheritTransactionID FROM FNT2001 WITH (NOLOCK) WHERE FNT2001.InheritTableID = ''FNT2000'')
	'+@sWhere1 +''

	SET @sSQL1 = @sSQL1 +N'
	SELECT
		T21.APK                 
		,T21.APKMaster           
		,T21.DivisionID          
		,T21.Orders              
		,T21.JobName             
		,T21.OriginalAmount      
		,T21.ConvertedAmount     
		,T21.ApprovalOAmount     
		,T21.ApprovalCAmount     
		,T21.StatusDetail        
		,T21.ApprovalNotes       
		,T21.ObjectTransferID    
		,T22.ObjectName As ObjectTransferName
		,T21.ObjectBeneficiaryID 
		,T02.ObjectName As ObjectBeneficiaryName
		,T21.NormID      
		,T00.NormName        
		,T21.ResponsibleID       
		,T21.ObjectProposalID    
		,T12.ObjectName As ObjectProposalName
		,T21.Ana01ID             
		,T21.Ana02ID             
		,T21.Ana03ID             
		,T21.Ana04ID             
		,T21.Ana05ID             
		,T21.Ana06ID             
		,T21.Ana07ID             
		,T21.Ana08ID             
		,T21.Ana09ID             
		,T21.Ana10ID      
		,A11.AnaName AS Ana01Name
		,A12.AnaName AS Ana02Name
		,A13.AnaName AS Ana03Name
		,A14.AnaName AS Ana04Name
		,A15.AnaName AS Ana05Name
		,A16.AnaName AS Ana06Name
		,A17.AnaName AS Ana07Name
		,A18.AnaName AS Ana08Name
		,A19.AnaName AS Ana09Name
		,A20.AnaName AS Ana10Name     
		,T21.ContractAmount      
		,T21.Accumulated         
		,T21.ExtantPayment       
		,T21.ProvinceID          
		,T21.Notes               
		,T21.OverdueID    
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS OverdueName       
		,T21.OverdueDay          
		,T21.DateHaveFile        
		,T21.StatusFileID        
		,T21.AmountApproval      
		,T21.AmountEstimation    
		,T21.Delegacy            
		,T21.WeekNo              
		,T21.AmountApprovalBOD   
		,T21.ApprovalDes         
		,T21.TCKTDebt            
		,T21.TCKTExpired         
		,T21.TCKTDisbursement    
		,T21.TCKTGeneral         
		,T21.TCKTGuarantee       
		,T21.TCKTAmountApproval  
		,T21.TCKTApprovalDes     
		,T21.DeleteFlag          
		,T21.InheritTableID      
		,T21.InheritVoucherID    
		,T21.InheritTransactionID
		INTO #FNT2001B
		FROM FNT2001 T21 WITH (NOLOCK)
		LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T21.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
		LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T21.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
		LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T21.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
		LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T21.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
		LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T21.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
		LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T21.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
		LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T21.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
		LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T21.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
		LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T21.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
		LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T21.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
		LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T21.ObjectBeneficiaryID = T02.ObjectID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectProposalID = T12.ObjectID
		LEFT JOIN AT1202 T22 WITH (NOLOCK) ON T21.ObjectTransferID = T22.ObjectID
		LEFT JOIN FNT1000 T00 WITH (NOLOCK) ON T00.NormID = T21.NormID
		LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T21.OverdueID AND T19.CodeMaster = ''OverdueID''
		WHERE T21.DeleteFlag = 0 AND T21.Status = 1
		AND APKMaster IN (SELECT InheritVoucherID FROM #FNP2007B)
		'
		SET @sSQL1 = @sSQL1 +N'
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' As TotalRow,
		A.* FROM 
		(SELECT * FROM #FNT2001B
		UNION ALL
		SELECT * FROM #FNT2001A) A
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY 
		'

	EXEC (@sSQL+@sSQL1)
--PRINT @sSQL
--PRINT @sSQL1
		END

DROP TABLE #FNP2007B
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
