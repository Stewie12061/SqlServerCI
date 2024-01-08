IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình Yêu cầu báo giá nhà cung cấp
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Như Hàn on: 14/03/2019
---- Modified by Trọng Kiên on 21/10/2020: Bổ sung load tên người tạo và người sửa
---- Modified by Anh Đô on 21/03/2023: Select thêm cột CurrencyName và VoucherTypeName; Fix lỗi phân trang
---- Modified by Anh Đô on 31/03/2023: Order theo InventoryID cho lưới detail
---- Modified by Thanh Lượng on 26/12/2023: Bổ sung trường PONumber
---- Modified by ... on...
-- <Example>
/*
	EXEC POP2041 'HD', '','HDVNS-H1506023', '', 'YCMH'
	EXEC POP2041 @DivisionID, @APK, @Mode, @IsViewDetail, @PageNumber, @PageSize
*/

CREATE PROCEDURE POP2041
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@Mode INT, ---- 0:Master, 1:Detail
	@IsViewDetail INT, ---- 0:Edit, 1:View
	@PageNumber INT = 1,
	@PageSize INT = 25,
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @SSQL Nvarchar(max) ='', 
		@TotalRow VARCHAR(50),
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

SET @TotalRow = ''
SET @TotalRow = 'COUNT(*) OVER ()'

IF ISNULL(@Mode,0) = 0
	BEGIN

	IF ISNULL(@Type, '') = 'BGNCC' 
	BEGIN
		SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T21.APKMaster_9000)= '''+@APKMaster+''''
		SELECT  @Level = MAX(ApproveLevel) FROM POT2022 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
		END
	ELSE 
		BEGIN
		SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T21.APK) = '''+@APK+''''
		SELECT  @Level = MAX(ApproveLevel) FROM POT2022 WITH (NOLOCK) WHERE APKMaster = @APK AND DivisionID = @DivisionID
		END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status,ApprovePerson'+@s+'StatusName,ApprovePerson'+@s+'Note'
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

	SET @SSQL = @SSQL+'
	SELECT Top 1 T21.APK, T21.DivisionID, T21.TranMonth, T21.TranYear, T21.VoucherTypeID, T21.VoucherNo, T21.VoucherDate, T21.OverDate, 
	T21.ObjectID, T12.ObjectName,
	T21.CurrencyID, T21.ExchangeRate, T21.EmployeeID,T13.FullName As EmployeeName,T21.Description, A1.FullName as CreateUserID
	, T21.CreateDate, A2.FullName as LastModifyUserID, T21.LastModifyDate,T21.APKMaster_9000
	'+@sSQLSL+'
	, A3.CurrencyName
	, A4.VoucherTypeName

	FROM POT2021 T21 WITH (NOLOCK)
	LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectID = T12.ObjectID
	LEFT JOIN AT1103 T13 WITH (NOLOCK) ON T21.EmployeeID = T13.EmployeeID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T21.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = T21.CreateUserID
    LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = T21.LastModifyUserID
	LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.CurrencyID = T21.CurrencyID
	LEFT JOIN AT1007 A4 WITH (NOLOCK) ON A4.VoucherTypeID = T21.VoucherTypeID
	'+@sSQLJon+'
	WHERE T21.DivisionID ='''+@DivisionID+''' ' +@Swhere+''
	EXEC (@SSQL)
	print @sSQLJon
	END
ELSE IF ISNULL(@Mode,0) = 1
	BEGIN

	IF ISNULL(@Type, '') = 'BGNCC' 
		BEGIN
		SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T22.APKMaster_9000)= '''+@APKMaster+''''
		SELECT  @Level = MAX(ApproveLevel) FROM POT2022 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
		END
	ELSE 
		BEGIN
		SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),T22.APKMaster) = '''+@APK+''''
		SELECT  @Level = MAX(ApproveLevel) FROM POT2022 WITH (NOLOCK) WHERE APKMaster = @APK AND DivisionID = @DivisionID
		END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APK9001'+@s+', Status'+@s+', Approvel'+@s+'Note, ApprovalDate'+@s+''
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT OOT1.APK APK9001'+@s+', OOT1.APKMaster,OOT1.DivisionID, T94.APKDetail APK2001,
						OOT1.Status Status'+@s+',
						O99.Description StatusName'+@s+',
						T94.Note Approvel'+@s+'Note,
						T94.ApprovalDate ApprovalDate'+@s+'
						FROM OOT9001 OOT1 WITH (NOLOCK)
						LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND T94.DeleteFlag = 0
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(T94.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK 
						AND CASE WHEN ISNULL(CONVERT(Varchar (50),APP'+@s+'.APK2001),'''') <> '''' THEN APP'+@s+'.APK2001 ELSE T22.APK END = T22.APK '
		SET @i = @i + 1		
	END	

	SET @SSQL = @SSQL+'
	SELECT '+CASE WHEN @IsViewDetail = 1 THEN ' ROW_NUMBER() OVER (ORDER BY T22.InventoryID) AS RowNum, '+@TotalRow+' AS TotalRow, ' ELSE '' END +'
	T22.APK, T22.APKMaster, T22.DivisionID, T22.OrderID, T22.InventoryID, T02.InventoryName, T22.Quantity, T22.UnitPrice, T22.RequestPrice, T02.Specification as TechnicalSpecifications,
	 T22.Notes, T22.InheritTableID, T22.InheritAPK, T22.InheritAPKDetail,T22.APKMaster_9000,
	 T22.UnitPrice - (SELECT TOP 1 ISNULL(UnitPrice,0) FROM POT2022 T1 WITH (NOLOCK) LEFT JOIN POT2021 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
		WHERE T2.ObjectID = T21.ObjectID AND T1.InventoryID = T22.InventoryID AND T2.VoucherDate <= T21.VoucherDate AND T21.APK <> T2.APK
		ORDER BY VoucherDate DESC) as UnitPriceDifference
	, T22.UnitID, A04.UnitName, T22.ConvertedQuantity, T22.ConvertedUnitPrice
	, OT99.S01ID, OT99.S02ID, OT99.S03ID, OT99.S04ID, OT99.S05ID, OT99.S06ID, OT99.S07ID, OT99.S08ID, OT99.S09ID, OT99.S10ID
	, OT99.S11ID, OT99.S12ID, OT99.S13ID, OT99.S14ID, OT99.S15ID, OT99.S16ID, OT99.S17ID, OT99.S18ID, OT99.S19ID, OT99.S20ID
	, T22.Parameter01, T22.Parameter02, T22.Parameter03, T22.Parameter04, T22.Parameter05
	, T22.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes, T22.PONumber
	'+@sSQLSL+'
	FROM POT2022 T22 WITH (NOLOCK) 
	LEFT JOIN POT2021 T21 WITH (NOLOCK) ON T21.APK = T22.APKMaster
	LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T22.InventoryID = T02.InventoryID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T22.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = T22.UnitID
	LEFT JOIN OT8899 OT99 WITH (NOLOCK) ON OT99.DivisionID = T22.DivisionID AND OT99.VoucherID = CONVERT(VARCHAR(50), T22.APKMaster) AND OT99.TransactionID = CONVERT(VARCHAR(50), T22.APK)
	LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (T22.DivisionID, ''@@@'') 
													AND WQ09.InventoryID = T22.InventoryID
													AND WQ09.ConvertedUnitID = T22.ConvertedUnitID
													--AND (WQ09.S01ID = OT99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(OT99.S01ID, '''')))
													--AND (WQ09.S02ID = OT99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(OT99.S02ID, '''')))
													--AND (WQ09.S03ID = OT99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(OT99.S03ID, '''')))
													--AND (WQ09.S04ID = OT99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(OT99.S04ID, '''')))
													--AND (WQ09.S05ID = OT99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(OT99.S05ID, '''')))
													--AND (WQ09.S06ID = OT99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(OT99.S06ID, '''')))
													--AND (WQ09.S07ID = OT99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(OT99.S07ID, '''')))
													--AND (WQ09.S08ID = OT99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(OT99.S08ID, '''')))
													--AND (WQ09.S09ID = OT99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(OT99.S09ID, '''')))
													--AND (WQ09.S10ID = OT99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(OT99.S10ID, '''')))
													--AND (WQ09.S11ID = OT99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(OT99.S11ID, '''')))
													--AND (WQ09.S12ID = OT99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(OT99.S12ID, '''')))
													--AND (WQ09.S13ID = OT99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(OT99.S13ID, '''')))
													--AND (WQ09.S14ID = OT99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(OT99.S14ID, '''')))
													--AND (WQ09.S15ID = OT99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(OT99.S15ID, '''')))
													--AND (WQ09.S16ID = OT99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(OT99.S16ID, '''')))
													--AND (WQ09.S17ID = OT99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(OT99.S17ID, '''')))
													--AND (WQ09.S18ID = OT99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(OT99.S18ID, '''')))
													--AND (WQ09.S19ID = OT99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(OT99.S19ID, '''')))
													--AND (WQ09.S20ID = OT99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(OT99.S20ID, '''')))
	'+@sSQLJon+'
	WHERE T22.DivisionID = '''+@DivisionID+''' '+ @Swhere+'
	ORDER BY InventoryID
	'
	IF @IsViewDetail = 1
	BEGIN
		SET @SSQL = @SSQL+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END

	print @SSQL
	EXEC (@SSQL)
	END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
