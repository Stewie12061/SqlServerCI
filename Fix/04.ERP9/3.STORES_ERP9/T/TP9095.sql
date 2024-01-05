IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9095]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9095]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
---- Load Form khi xem/ sửa - Detail
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 30/10/2018
---- Modified by ... on ...:
----<Example>
/*
	EXEC TP9095 'BS', '359B3973-3E52-4C92-85CB-2B603A6D3F93', 0, 1, 25
	EXEC TP9095 @DivisionID, @APK, @IsViewDetail, @PageNumber, @PageSize
*/
CREATE PROCEDURE [dbo].[TP9095] 	
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50), 
	@IsViewDetail TINYINT = 0,	--- 0: màn hình edit, 1: màn hình view
	@PageNumber INT,
	@PageSize INT,
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@sSQL2 NVARCHAR(MAX) = '',
		@Swhere  Nvarchar(max) = '',
		@i INT = 1, @s VARCHAR(2),
		@TotalRow VARCHAR(50) = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @Level=ISNULL((SELECT MAX(Levels) FROM ST0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND TypeID ='NS'),0)
--SET @Level=2

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
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE T21.APK END = T21.APK'
		SET @i = @i + 1		
	END	

	IF ISNULL(@Type, '') = 'NS' 
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T21.APKMaster_9000)= '''+@APKMaster+''''
	ELSE 
	SET @Swhere = @Swhere + 'AND T21.APKMaster = '''+ISNULL(@APK,'')+''''

SET @sSQL = @sSQL+'
SELECT
'+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T21.Orders) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
T21.APK 
,T21.APKMaster
,T21.APKMaster_9000
,T21.DivisionID
,T21.OriginalAmount
,T21.ConvertedAmount
,T21.ApprovalOAmount As OAmount
,T21.ApprovalCAmount As CAmount
,T21.ApprovalAccountNotes
,T21.Ana01ID
,T01.AnaName As Ana01Name
,T21.Ana02ID
,T02.AnaName As Ana02Name
,T21.Ana03ID
,T03.AnaName As Ana03Name
,T21.Ana04ID
,T04.AnaName As Ana04Name
,T21.Ana05ID
,T05.AnaName As Ana05Name
,T21.Ana06ID
,T06.AnaName As Ana06Name
,T21.Ana07ID
,T07.AnaName As Ana07Name
,T21.Ana08ID
,T08.AnaName As Ana08Name
,T21.Ana09ID
,T09.AnaName As Ana09Name
,T21.Ana10ID
,T10.AnaName As Ana10Name
,T21.Notes
,T21.DeleteFlag
'+@sSQLSL+'
FROM TT2101 T21 WITH (NOLOCK)
LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T21.APKMaster_9000 = OOT90.APK
LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T21.Ana01ID = T01.AnaID AND T01.AnaTypeID = ''A01''
LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T21.Ana02ID = T02.AnaID AND T02.AnaTypeID = ''A02''
LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T21.Ana03ID = T03.AnaID AND T03.AnaTypeID = ''A03''
LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T21.Ana04ID = T04.AnaID AND T04.AnaTypeID = ''A04''
LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T21.Ana05ID = T05.AnaID AND T05.AnaTypeID = ''A05''
LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T21.Ana06ID = T06.AnaID AND T06.AnaTypeID = ''A06''
LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T21.Ana07ID = T07.AnaID AND T07.AnaTypeID = ''A07''
LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T21.Ana08ID = T08.AnaID AND T08.AnaTypeID = ''A08''
LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T21.Ana09ID = T09.AnaID AND T07.AnaTypeID = ''A09''
LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T21.Ana10ID = T10.AnaID AND T08.AnaTypeID = ''A10''
'+@sSQLJon+'
WHERE T21.DeleteFlag = 0 AND T21.DivisionID = '''+@DivisionID+'''
	'+@Swhere+'
'

IF @IsViewDetail = 1
	BEGIN
		SET @sSQL = @sSQL+'
		ORDER BY T21.Orders
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

