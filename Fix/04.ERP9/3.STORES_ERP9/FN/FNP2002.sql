IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----- Created by Như Hàn
---- Created Date 05/11/2018
---- Purpose: Xem chi tiết/sửa kế hoạch thu chi Load Detail
---- Modified on 02/04/2019 by Như Hàn: Bổ sung lấy Nguồn vốn theo đợi chi (Ana10Name, nếu có)
---- Modified on 05/04/2019 by Như Hàn: Điều chỉnh duyệt kế hoạch thu chi
/*
EXEC FNP2002 'AIC', '163A0A82-10D3-4DD9-8BFD-14618AD4D1D0', '1', 1, 1, 25
EXEC FNP2002 @DivisionID, @APK, @TranMonth, @TranYear, @LanguageID, @IsViewDetail, @PageNumber, @PageSize
*/

CREATE PROCEDURE [dbo].[FNP2002] 	
				@DivisionID VARCHAR(50),
				@APK VARCHAR(50), 
				@LanguageID VARCHAR(50),
				@IsViewDetail TINYINT = 0,	--- 0: màn hình edit, 1: màn hình view
				@PageNumber INT,
				@PageSize INT,
				@Mode INT = 0, ---- 0 Xem kế hoạch thu chi, 1 Xem phiếu điều chỉnh
				@APKMaster VARCHAR(50) = '',
				@Type VARCHAR(50) = ''

AS

DECLARE @sSQL NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@Swhere  Nvarchar(max) = '',
		@i INT = 1, @s VARCHAR(2),
		@TotalRow VARCHAR(50)
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


IF ISNULL(@Type, '') = 'KHTC' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T20.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(ApproveLevel) FROM FNT2001 T1 WITH (NOLOCK) WHERE T1.APKMaster_9000 = @APKMaster
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND T20.APK = '''+ISNULL(@APK,'')+''''
SELECT @Level = MAX(ApproveLevel) FROM FNT2001 T1 WITH (NOLOCK) INNER JOIN FNT2000 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK AND T2.APK = @APK AND T1.DivisionID = @DivisionID
END


	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APK9001'+@s+', Status'+@s+', Approvel'+@s+'Note, ApprovalOAmount'+@s+', ApprovalCAmount'+@s+', ApprovalDate'+@s+''
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT OOT1.APK APK9001'+@s+', OOT1.APKMaster,OOT1.DivisionID, T94.APKDetail APK2001,
						T94.Status Status'+@s+',
						O99.Description StatusName'+@s+',
						T94.Note Approvel'+@s+'Note,
						T94.ApprovalOAmount ApprovalOAmount'+@s+',
						T94.ApprovalCAmount ApprovalCAmount'+@s+',
						T94.ApprovalDate ApprovalDate'+@s+'
						FROM OOT9001 OOT1 WITH (NOLOCK)
						LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND T94.DeleteFlag = 0
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(T94.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE T21.APK END = T21.APK'
		SET @i = @i + 1		
	END	

IF ISNULL(@Type, '') = 'KHTC' 
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T20.APKMaster_9000)= '''+@APKMaster+''''
ELSE 
SET @Swhere = @Swhere + 'AND T20.APK = '''+ISNULL(@APK,'')+''''


IF ISNULL(@Mode,0) = 0
BEGIN
SET @sSQL = @sSQL+'
SELECT	'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T21.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
		T20.DivisionID
		,T20.APK APKMaster
		,T20.APKMaster_9000
		,T20.TranMonth
		,T20.TranYear
		,T20.VoucherTypeID
		,T20.VoucherNo
		,T20.VoucherDate
		,T20.EmployeeID
		,T03.FullName
		,T20.PayMentTypeID
		,T05.PaymentName AS PaymentTypeName
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T99.[Description] ELSE T99.DescriptionE END AS TransactionType
		,T20.PayMentPlanDate
		,T20.CurrencyID
		,T04.CurrencyName
		,T20.ExchangeRate
		,T20.Descriptions
		,T20.PriorityID
		,T10.PriorityName
		,T20.ApprovalDate
		, T21.APK 
		, T21.DivisionID
		, T21.Orders
		, T21.JobName
		, T21.OriginalAmount
		, T21.ConvertedAmount
		, T21.ApprovalOAmount
		, T21.ApprovalCAmount
		, T21.StatusDetail
		, T21.ApprovalNotes
		, T21.ObjectTransferID
		, T22.ObjectName As ObjectTransferName
		, T21.ObjectBeneficiaryID
		, T02.ObjectName As ObjectBeneficiaryName
		, T21.NormID
		, T00.NormName
		, T21.ResponsibleID
		, T33.FullName As ReponsibleName
		, T21.ObjectProposalID
		, T12.AnaName As ObjectProposalName
		, T21.Ana01ID
		, A11.AnaName AS Ana01Name
		, T21.Ana02ID
		, A12.AnaName AS Ana02Name
		, T21.Ana03ID
		, A13.AnaName AS Ana03Name
		, T21.Ana04ID
		, A14.AnaName AS Ana04Name
		, T21.Ana05ID
		, A15.AnaName AS Ana05Name
		, T21.Ana06ID
		, A16.AnaName AS Ana06Name
		, T21.Ana07ID
		, A17.AnaName AS Ana07Name
		, T21.Ana08ID
		, A18.AnaName AS Ana08Name
		, T21.Ana09ID
		, A19.AnaName AS Ana09Name
		, T21.Ana10ID
		, ISNULL(A20.AnaName,AnaNameList) AS Ana10Name
		, T21.ContractAmount
		, T21.Accumulated
		, T21.ExtantPayment
		, T21.ProvinceID
		, A21.AnaName AS ProvinceName
		, T21.Notes
		, T21.OverdueID
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS OverdueName
		, T21.OverdueDay
		, T21.DateHaveFile
		, T21.StatusFileID
		, T21.AmountApproval
		, T21.AmountEstimation
		, T21.Delegacy
		, T21.WeekNo
		, T21.AmountApprovalBOD
		, T21.ApprovalDes
		, T21.DeleteFlag
		, T21.InheritTableID
		, T21.InheritVoucherID
		, T21.InheritTransactionID
		, T21.TCKTDebt
		, T21.TCKTExpired
		, T21.TCKTDisbursement
		, T21.TCKTGeneral
		, T21.TCKTGuarantee
		, T21.TCKTAmountApproval
		, T21.TCKTApprovalDes
		, T21.PaymentDate
		, T21.POAmount
		, T21.PCAmount
		,T21.Status, T09.Description As StatusName,
		T21.ApproveLevel, T21.ApprovingLevel
		'+@sSQLSL+'
	FROM	FNT2000 T20 WITH (NOLOCK)'
SET @sSQL1 = @sSQL1+'INNER JOIN FNT2001 T21 WITH (NOLOCK) ON T20.APK = T21.APKMaster AND T20.DivisionID = T21.DivisionID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T20.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON  T03.EmployeeID = T20.EmployeeID
	LEFT JOIN AT1103 T33 WITH (NOLOCK) ON  T33.EmployeeID = T20.EmployeeID
	LEFT JOIN FNT1020 T10 WITH (NOLOCK) ON T10.PriorityID = T20.PriorityID
	LEFT JOIN FNT1000 T00 WITH (NOLOCK) ON T00.NormID = T21.NormID
	LEFT JOIN FNT0099 T99 WITH (NOLOCK) ON T99.ID = T20.TransactionType AND T99.CodeMaster = ''TransactionType''
	LEFT JOIN AT1205 T05 WITH (NOLOCK) ON T05.PayMentID = T20.PayMentTypeID
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.CurrencyID = T20.CurrencyID
	LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T09.ID = T20.Status AND T09.CodeMaster = ''Status''
	LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T21.OverdueID AND T09.CodeMaster = ''OverdueID''
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
	LEFT JOIN AT1015 A21 WITH (NOLOCK) ON T21.ProvinceID = A21.AnaID AND A21.AnaTypeID = ''O01''
	LEFT JOIN AT1202 T02 WITH (NOLOCK) ON T21.ObjectBeneficiaryID = T02.ObjectID
	LEFT JOIN AT1011 T12 WITH (NOLOCK) ON T21.ObjectProposalID = T12.AnaID AND T12.AnaTypeID = ''A01''
	LEFT JOIN AT1202 T22 WITH (NOLOCK) ON T21.ObjectTransferID = T22.ObjectID
	LEFT JOIN (
		SELECT DISTINCT C2.APKMaster, 
		SUBSTRING(
		(
		SELECT '','' + T1.AnaName
		FROM FNT2008_AIC C1 WITH (NOLOCK)
		LEFT JOIN AT1011 T1 WITH (NOLOCK) ON C1.Ana10ID = T1.AnaID AND T1.AnaTypeID = ''A10''
		WHERE C1.APKMaster = C2.APKMaster
		ORDER BY C1.APKMaster
		FOR XML PATH ('''')
		), 2, 1000) AnaNameList
		FROM FNT2008_AIC C2
		) B ON B.APKMaster = T21.APK'

SET @sSQL2 = @sSQL2+'
	'+@sSQLJon+'
	WHERE T20.DeleteFlag= 0 
	AND T20.DivisionID = '''+@DivisionID+'''
	'+@Swhere+'
	ORDER BY T21.Orders
	'
END 
ELSE IF ISNULL(@Mode,0) = 1
BEGIN
	SET @sSQL = '
	SELECT	'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T21.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
			T20.DivisionID
			,T20.APK As APK_DC
			,T20.FNT2000APK As APKMaster
			,T20.TranMonth
			,T20.TranYear
			,T20.VoucherTypeID
			,T20.VoucherNo
			,T20.VoucherDate
			,T20.EmployeeID
			,T03.FullName
			,T20.PayMentTypeID
			,T05.PaymentName AS PaymentTypeName
			,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T99.[Description] ELSE T99.DescriptionE END AS TransactionType
			--,T99.Description As PayMentTypeName
			,T20.PayMentPlanDate
			,T20.CurrencyID
			,T04.CurrencyName
			,T20.ExchangeRate
			,T20.Descriptions
			,T20.PriorityID
			,T10.PriorityName
			--,T20.Status
			,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T09.[Description] ELSE T09.DescriptionE END AS Status
			--,T09.Description As Status
			,T20.ApprovalDate
			, T21.APK AS APKDetail_DC
			, T21.DivisionID
			, T21.Orders
			, T21.JobName
			, T21.OriginalAmount
			, T21.ConvertedAmount
			, T21.ApprovalOAmount
			, T21.ApprovalCAmount
			, T21.StatusDetail
			, T21.ApprovalNotes
			, T21.ObjectTransferID
			, T22.ObjectName As ObjectTransferName
			, T21.ObjectBeneficiaryID
			, T02.ObjectName As ObjectBeneficiaryName
			, T21.NormID
			, T00.NormName
			--, T21.FeeID
			, T21.ResponsibleID
			, T21.ObjectProposalID
			, T12.AnaName As ObjectProposalName
			, T21.Ana01ID
			, A11.AnaName AS Ana01Name
			, T21.Ana02ID
			, A12.AnaName AS Ana02Name
			, T21.Ana03ID
			, A13.AnaName AS Ana03Name
			, T21.Ana04ID
			, A14.AnaName AS Ana04Name
			, T21.Ana05ID
			, A15.AnaName AS Ana05Name
			, T21.Ana06ID
			, A16.AnaName AS Ana06Name
			, T21.Ana07ID
			, A17.AnaName AS Ana07Name
			, T21.Ana08ID
			, A18.AnaName AS Ana08Name
			, T21.Ana09ID
			, A19.AnaName AS Ana09Name
			, T21.Ana10ID
			, A20.AnaName AS Ana10Name
			, T21.ContractAmount
			, T21.Accumulated
			, T21.ExtantPayment
			, T21.ProvinceID
			, T21.Notes
			, T21.OverdueID
			, T21.OverdueDay
			, T21.DateHaveFile
			, T21.StatusFileID
			'
	SET @sSQL1 = '
	FROM	FNT2000_DC T20 WITH (NOLOCK)
	INNER JOIN FNT2001_DC T21 WITH (NOLOCK) ON T20.APK = T21.APKMaster AND T20.DivisionID = T21.DivisionID
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON  T03.EmployeeID = T20.EmployeeID
	LEFT JOIN FNT1020 T10 WITH (NOLOCK) ON T10.PriorityID = T20.PriorityID
	LEFT JOIN FNT1000 T00 WITH (NOLOCK) ON T00.NormID = T21.NormID
	LEFT JOIN FNT0099 T99 WITH (NOLOCK) ON T99.ID = T20.TransactionType AND T99.CodeMaster = ''TransactionType''
	LEFT JOIN AT1205 T05 WITH (NOLOCK) ON T05.PayMentID = T20.PayMentTypeID
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.CurrencyID = T20.CurrencyID
	LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T09.ID = T20.Status AND T09.CodeMaster = ''Status''
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
	LEFT JOIN AT1011 T12 WITH (NOLOCK) ON T21.ObjectProposalID = T12.AnaID AND T12.AnaTypeID = ''A01''
	LEFT JOIN AT1202 T22 WITH (NOLOCK) ON T21.ObjectTransferID = T22.ObjectID
	WHERE T20.DeleteFlag= 0 AND	CONVERT(Varchar(50),T20.APK) = '''+ISNULL(@APK,'')+'''
	AND T20.DivisionID = '''+@DivisionID+'''
	ORDER BY T21.Orders
	'
END


IF @IsViewDetail = 1
	BEGIN
		SET @sSQL2 = @sSQL2+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END


EXEC (@sSQL+@sSQL1+@sSQL2)
--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

