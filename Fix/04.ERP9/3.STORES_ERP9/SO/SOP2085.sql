IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2085]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2085]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load master Thông tin sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Ly on: 10/12/2020
---- Updated by: Trọng Kiên on: 12/01/2021: Bổ sung load tên phương pháp in và loại sản phẩm
---- Updated by: Trọng Kiên on: 14/01/2021: Xử lý trả dữ liệu cho màn hình duyệt
---- Updated by: Trọng Kiên on: 19/01/2021: Xử lý trả dữ liệu duyệt (Cắt cuộn, sóng, trạng thái phiếu) cho màn hình xem chi tiết
---- Updated by: Kiều Nga on: 24/05/2021: Fix lỗi không load được ý kiến người duyệt

-- <Example>
/*
	EXEC SOP2085 'DTI', '2977ed14-c8b7-478f-abf8-ede2ff241a94', 'b964c015-c496-494b-8cb8-33818d32a7ca', 'PBG'
*/

CREATE PROCEDURE SOP2085
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMASter VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max) ='', 
		@Swhere  Nvarchar(max) = '',
		@query AS NVARCHAR(MAX)='',
	    @cols AS NVARCHAR(MAX)= '',
		@Level INT = 0,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'TTSX' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),SOT2080.APKMaster_9000)= '''+@APKMASter+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMASter = @APKMASter
END
ELSE 
BEGIN
	SET @Swhere = @Swhere + 'AND (SOT2080.APK = '''+@APK+''' OR SOT2080.APKMaster_9000 = '''+@APK+''')'
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN SOT2080 ON OOT9001.APKMASter = SOT2080.APKMaster_9000  WHERE (SOT2080.APK = @APK OR SOT2080.APKMaster_9000 = @APK)
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID
						  , APP'+@s+'.ApprovePerson'+@s+'Name
						  , APP'+@s+'.ApprovePerson'+@s+'Status AS Status
						  , APP'+@s+'.ApprovePerson'+@s+'StatusName
						  , APP'+@s+'.ApprovePerson'+@s+'Note'
	SET @sSQLJon = @sSQLJon+ '
		LEFT JOIN (
					SELECT ApprovePersonID ApprovePerson' + @s + 'ID
							, OOT1.APKMASter
							, OOT1.DivisionID
							, OOT1.Status
							, HT14.FullName AS ApprovePerson' + @s + 'Name
							, OOT1.Status ApprovePerson' + @s + 'Status
							, O99.Description ApprovePerson' + @s + 'StatusName
							, OOT1.Note ApprovePerson' + @s + 'Note
		FROM OOT9001 OOT1 WITH (NOLOCK)
		INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (''@@@'', OOT1.DivisionID) AND HT14.EmployeeID = OOT1.ApprovePersonID
		LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status, 0) AND O99.CodeMASter = ''Status''
		WHERE OOT1.Level=' + STR(@i) + ') APP' + @s + ' ON APP' + @s + '.DivisionID= OOT90.DivisionID  AND APP' + @s + '.APKMASter=OOT90.APK'
	SET @i = @i + 1		
END	

SELECT @cols = @cols + QUOTENAME(AnaID) + ',' FROM 
(
	SELECT 'I03_'+ CRMT2112.AnaID AS AnaID
	FROM CRMT2112 WITH (NOLOCK)
	INNER JOIN SOT2080 WITH (NOLOCK) ON CRMT2112.APKMASter = SOT2080.APK
	WHERE CONVERT(VARCHAR(50),APKMASter) = @APK OR CONVERT(VARCHAR(50),SOT2080.APKMaster_9000) = @APKMASter
) AS tmp

SELECT @cols = substring(@cols, 0, len(@cols))

SET @query = @query +'LEFT JOIN (
	SELECT * from 
	(
		SELECT CRMT2112.APKMASter AS APKCRMT2112
				, ''I03_''+ CRMT2112.AnaID AS AnaID
				, CRMT2112.[Value] 
		FROM CRMT2112 WITH (NOLOCK)
		INNER JOIN SOT2080 WITH (NOLOCK) ON CRMT2112.APKMASter = SOT2080.APK
		WHERE CONVERT(VARCHAR(50),APKMASter) = ''' + @APK + ''' OR CONVERT(VARCHAR(50),SOT2080.APKMaster_9000) = ''' + @APKMASter + '''
	) src	
	PIVOT 
	(
		MAX(Value) FOR AnaID in (' + @cols + ')
	) piv
) AS P ON P.APKCRMT2112 = SOT2080.APK'

print @cols

IF ISNULL(@cols, '') <> '' 
BEGIN
	 SET @sSQLJon = @sSQLJon + @query
	 SET @sSQLSL = @sSQLSL+ ',P.*'
END

SET @Ssql = @Ssql + N' 
SELECT DISTINCT SOT2080.APK
		      , SOT2080.DivisionID
		      , SOT2080.VoucherTypeID
		      , SOT2080.VoucherDate
		      , SOT2080.VoucherNo
			  , SOT2080.PaperTypeID
			  , C5.[Description]	AS PaperTypeName
		      , SOT2080.InventoryID
		      , AT1302.InventoryName
			  , SOT2080.SemiProduct
		      , SOT2080.ObjectID
		      , AT1202.ObjectName
		      , SOT2080.DeliveryAddressName
		      , SOT2080.DeliveryTime
			  , SOT2080.DeliveryNotes
			  , SOT2080.StatusID
			  , C2.Description AS StatusVoucher
			  , SOT2080.ApproveCutRollStatusID
			  , C3.Description AS ApproveCutRollStatusName
			  , SOT2080.ApproveWaveStatusID
			  , C4.Description AS ApproveWaveStatusName
			  , T3.UserName AS CreateUserID
			  , SOT2080.CreateDate
			  , T4.UserName AS LastModifyUserID
			  , SOT2080.LastModifyDate
			  , SOT2080.APKMaster_9000
			  , SOT2080.Assemble AS AssembleValue
			  , SOT2080.APKInherit
			  , SOT2080.PrintTypeID
			  , C6.[Description]	AS	PrintTypeName
			  , SOT2080.ActualQuantity
			  , SOT2080.Length
			  , SOT2080.Width
			  , SOT2080.Height
			  , SOT2080.Notes
	' + @sSQLSL + '
	FROM SOT2080 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON SOT2080.APKMaster_9000 = OOT90.APK
		LEFT JOIN AT1405 T3 WITH (NOLOCK) ON SOT2080.DivisionID = T3.DivisionID AND SOT2080.CreateUserID = T3.UserID
		LEFT JOIN AT1405 T4 WITH (NOLOCK) ON SOT2080.DivisionID = T4.DivisionID AND SOT2080.LAStModifyUserID = T4.UserID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''@@@'',SOT2080.DivisionID) AND SOT2080.ObjectID = AT1202.ObjectID
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', SOT2080.DivisionID) AND SOT2080.InventoryID = AT1302.InventoryID
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = ''OffsetStatus_SOT2080'' AND ISNULL(C2.Disabled, 0) = 0 AND C2.ID = SOT2080.StatusID
		LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.CodeMaster = ''OffsetStatus_SOT2080'' AND ISNULL(C3.Disabled, 0) = 0 AND C3.ID = SOT2080.ApproveCutRollStatusID
		LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.CodeMaster = ''OffsetStatus_SOT2080'' AND ISNULL(C4.Disabled, 0) = 0 AND C4.ID = SOT2080.ApproveWaveStatusID
		LEFT JOIN CRMT0099 C5 WITH (NOLOCK) ON C5.CodeMaster = ''CRMT00000022''
													AND ISNULL(C5.[Disabled], 0) = 0
													AND C5.ID = SOT2080.PaperTypeID
		LEFT JOIN CRMT0099 C6 WITH (NOLOCK) ON C6.CodeMaster = ''CRMF2111.PrintType''
													AND ISNULL(C6.[Disabled], 0) = 0
													AND C6.ID = SOT2080.PrintTypeID
	' + @sSQLJon 
	+ ' WHERE SOT2080.DivisionID = ''' + @DivisionID + ''' ' + @Swhere + ''

EXEC (@Ssql )
PRINT (@Ssql)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
