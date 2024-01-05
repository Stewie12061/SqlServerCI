IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----- Created by Như Hàn
---- Created Date 05/11/2018
---- Purpose: Xem chi tiết/sửa kế hoạch thu chi - Master
---- Modified on ... by ...
/*
EXEC FNP2001 '', '', '8', '2018'
EXEC FNP2001 @DivisionID, @APK, @TranMonth, @TranYear, @LanguageID, @IsViewDetail, @PageNumber, @PageSize
*/

CREATE PROCEDURE [dbo].[FNP2001] 	
				@DivisionID VARCHAR(50),
				@APK VARCHAR(50), 
				@LanguageID VARCHAR(50),
				@Mode INT = 0, ---- 0 Xem kế hoạch thu chi, 1 Xem phiếu điều chỉnh
				@APKMaster VARCHAR(50) = '',
				@Type VARCHAR(50) = ''

AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@Swhere  Nvarchar(max) = '',
		@i INT = 1, @s VARCHAR(2),
		@OrderBy NVARCHAR(500),
		@TotalRow VARCHAR(50)


IF ISNULL(@Type, '') = 'KHTC' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T20.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(ApproveLevel) FROM FNT2001 T1 WITH (NOLOCK) WHERE T1.APKMaster_9000 = @APKMaster
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND T20.APK = '''+@APK+''''
SELECT @Level = MAX(ApproveLevel) FROM FNT2001 T1 WITH (NOLOCK) INNER JOIN FNT2000 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK AND T2.APK = @APK AND T1.DivisionID = @DivisionID
END

--SET @Level=2
--SET @Level=ISNULL((SELECT MAX(LEVELS) FROM ST0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND TypeID ='KHTC'),0)




	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

IF ISNULL(@Type, '') = 'KHTC' 
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T20.APKMaster_9000)= '''+@APKMaster+''''
ELSE 
SET @Swhere = @Swhere + 'AND T20.APK = '''+@APK+''''

IF ISNULL(@Mode,0) = 0 
BEGIN
	SET @sSQL = '
	SELECT TOP 1
	ISNULL(F11.InheritFNF2007,0) As InheritFNF2007
	,T20.APK
	,T20.APKMaster_9000
	,T20.DivisionID
	,T20.TranMonth
	,T20.TranYear
	,T20.VoucherTypeID
	,T20.VoucherNo
	,T20.VoucherDate
	,T20.EmployeeID
	,T03.FullName As EmployeeName
	,T20.PayMentTypeID
	,T05.PaymentName AS PayMentName
	,T20.PayMentPlanDate
	,T20.TransactionType As TransactionTypeID
	,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T29.[Description] ELSE T29.DescriptionE END AS TransactionType
	,T20.CurrencyID
	,T04.CurrencyName
	,T20.ExchangeRate
	,T20.Descriptions
	,T20.PriorityID
	,T10.PriorityName
	,T20.Status
	,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T09.[Description] ELSE T09.DescriptionE END AS StatusName
	,T20.TypeID
	,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS TypeName
	,T20.CreateUserID
	,T20.CreateDate
	,T20.LastModifyUserID
	,T20.LastModifyDate 
	,T21.ApproveLevel
	'+@sSQLSL+'
	FROM	FNT2000 T20 WITH (NOLOCK)'
	SET @sSQL1 = '
	LEFT JOIN (SELECT DISTINCT APKMaster, ApproveLevel FROM FNT2001 T21 WITH (NOLOCK)) T21 ON T21.APKMaster = T20.APK
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T20.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON T03.EmployeeID = T20.EmployeeID
	LEFT JOIN FNT1020 T10 WITH (NOLOCK) ON T10.PriorityID = T20.PriorityID
	LEFT JOIN AT1205 T05 WITH (NOLOCK) ON T05.PayMentID = T20.PayMentTypeID
	LEFT JOIN FNT0099 T29 WITH (NOLOCK) ON T29.ID = T20.TransactionType AND T29.CodeMaster = ''TransactionType''
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.DivisionID = T20.DivisionID AND T04.CurrencyID = T20.CurrencyID
	LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T09.ID = T20.Status AND T09.CodeMaster = ''Status''
	LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T20.TypeID AND T19.CodeMaster = ''TypeID''
	'+@sSQLJon+'
	LEFT JOIN	(Select 1 As InheritFNF2007, TH.DivisionID, TH.InheritVoucherID, TH.APKMaster
				From FNT2001 TH WITH (NOLOCK) 
				INNER JOIN FNT2001 PB WITH (NOLOCK) ON TH.DivisionID = PB.DivisionID 
				AND ISNULL(TH.InheritVoucherID,''00000000-0000-0000-0000-000000000000'') = CONVERT(VARCHAR(255),PB.APKMaster)
				AND ISNULL (TH.InheritTransactionID, ''00000000-0000-0000-0000-000000000000'') = CONVERT(VARCHAR(255),PB.APK)
				AND TH.InheritTableID = ''FNT2000''
				Where TH.DivisionID = ''' + @DivisionID + '''
				Group by TH.DivisionID, TH.InheritVoucherID, TH.APKMaster
				) F11 ON F11.DivisionID = T20.DivisionID And CONVERT(VARCHAR(255), T20.APK)   = ISNULL(F11.APKMaster,''00000000-0000-0000-0000-000000000000'') 
	WHERE T20.DeleteFlag= 0
	AND T20.DivisionID = '''+@DivisionID+'''
	'+@Swhere+'
	'
END
ELSE IF ISNULL(@Mode,0) = 1
BEGIN
	SET @sSQL = '
	SELECT TOP 1
	T20.FNT2000APK AS APK
	,T20.APK APK_DC
	,T20.DivisionID
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
	,T20.Status
	,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T09.[Description] ELSE T09.DescriptionE END AS StatusName
	,T20.TypeID
	,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS TypeName
	,T20.CreateUserID
	,T20.CreateDate
	,T20.LastModifyUserID
	,T20.LastModifyDate'

	SET @sSQL1 = '
	FROM	FNT2000_DC T20 WITH (NOLOCK)
	LEFT JOIN AT1103 T03 WITH (NOLOCK) ON T03.EmployeeID = T20.EmployeeID
	LEFT JOIN FNT1020 T10 WITH (NOLOCK) ON T10.PriorityID = T20.PriorityID
	LEFT JOIN FNT0099 T99 WITH (NOLOCK) ON T99.ID = T20.TransactionType AND T99.CodeMaster = ''TransactionType''
	LEFT JOIN AT1205 T05 WITH (NOLOCK) ON T05.PayMentID = T20.PayMentTypeID
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T04.DivisionID = T20.DivisionID AND T04.CurrencyID = T20.CurrencyID
	LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T09.ID = T20.Status AND T09.CodeMaster = ''Status''
	LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T20.TypeID AND T19.CodeMaster = ''TypeID''
	WHERE T20.DeleteFlag= 0 AND	T20.APK = '''+@APK+'''
	AND T20.DivisionID = '''+@DivisionID+''''

	
END
	PRINT @sSQL
	PRINT @sSQL1

EXEC (@sSQL+@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
