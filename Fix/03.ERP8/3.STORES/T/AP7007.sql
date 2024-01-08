IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Phuong Loan AND Van Nhan
---- Date 17/03/2005
---- Purpose: In bao cao phan tich hang ton kho
---- Edit by : Dang Le Bao Quynh; Date 22/07/2008
---- Purpose: Cho phep xu ly dieu kien like
---- Edit by Bao Anh, date 11/04/2010 Lay cac truong DVT quy doi
---- Modified by on 03/01/2013 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified by Tiểu Mai on 19/08/2016: Bổ sung trường ObjectID, ObjectName (theo yêu cầu An Nhơn)
---- Modified by Bảo Thy on 14/03/2017: Fix lỗi Cùng mặt hàng và cùng mã phân tích vị trí chưa sum lại thành 1 dòng
---- Modified by Phương Thảo on 11/04/2017: Bỏ các trường ObjectID, ObjectName (Chỉ bổ sung ở source An Phát)
---- Modified by Bảo Thy on 08/05/2017: Sửa danh mục dùng chung
---- Modified by Đình Định on 24/11/2023: SIEUTHANH - Bổ sung VoucherTypeID kiểm tra lấy các column theo thiết lập.
---- Modified by Đình Định on 03/01/2024: THIENNAM - Bỏ dấu phẩy dư trong Group by.
												  -- Dùng Subquery và bảng tạm thay cho View.
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [01/08/2010]
'********************************************/

CREATE PROCEDURE [dbo].[AP7007] 
	@DivisionID NVARCHAR(50), 
	@ReportCode NVARCHAR(50), 
	@FromMonth INT, 
	@FromYear INT, 
	@ToMonth INT, 
	@ToYear INT, 
	@FromDate DATETIME, 
	@ToDate DATETIME, 
	@IsDate TINYINT, 
	@Filter1IDFrom NVARCHAR(50), 
	@Filter1IDTo NVARCHAR(50), 
	@Filter2IDFrom NVARCHAR(50), 
	@Filter2IDTo NVARCHAR(50), 
	@Filter3IDFrom NVARCHAR(50), 
	@Filter3IDTo NVARCHAR(50), 
	@Filter4IDFrom NVARCHAR(50), 
	@Filter4IDTo NVARCHAR(50), 
	@Filter5IDFrom NVARCHAR(50), 
	@Filter5IDTo NVARCHAR(50),
	@StrDivisionID AS NVARCHAR(4000) = ''
AS

DECLARE 
	@AT4712_cur CURSOR, 
	@Count INT, 
	@ColumnID INT, 
	@CaculatedType NVARCHAR(2), 
	@ColumnName NVARCHAR(250), 
	@AmountType NVARCHAR(2), 
	@FilterType NVARCHAR(50), 
	@ConditionType NVARCHAR(2), 
	@ConditionFrom NVARCHAR(50), 
	@ConditionTo NVARCHAR(50), 
	@Condition NVARCHAR(50), 
	@Filter1ID NVARCHAR(50), 
	@Filter2ID NVARCHAR(50), 
	@Filter3ID NVARCHAR(50), 
	@Filter4ID NVARCHAR(50), 
	@Filter5ID NVARCHAR(50), 
	@GroupID NVARCHAR(50), 
	@LevelColumn NVARCHAR(50), 
	@ColumnAmount NVARCHAR(4000), 
	@strFilter NVARCHAR(4000), 
	@sSQL NVARCHAR(MAX), 
	@sSQL_1 NVARCHAR(MAX), 
	@sSQL_2 NVARCHAR(MAX), 
	@sSQL_3 NVARCHAR(MAX), 
	@sSQL_4 NVARCHAR(MAX), 
	@sSQL_5 NVARCHAR(MAX), 
	@strTime NVARCHAR(4000), 
	@FieldGroup NVARCHAR(50), 
	@FromMonthYearText NVARCHAR(20), 
	@ToMonthYearText NVARCHAR(20), 
	@FromDateText NVARCHAR(20), 
	@ToDateText NVARCHAR(20),
	@StrDivisionID_New AS NVARCHAR(4000), --------------->>>> Chuỗi DivisionID
	@CustomerName INT = (SELECT CustomerName FROM CustomerIndex WITH (NOLOCK))

	
IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = CASE WHEN @DivisionID = '%' THEN ' LIKE ''' + 
	@DivisionID + '''' ELSE ' IN (''' + replace(@DivisionID, ',',''',''')+ ''')' END

---------------------<<<<<<<<<< Chuỗi DivisionID

SET @FromMonthYearText = LTRIM(RTRIM(STR(@FromMonth + @FromYear * 100)))
SET @ToMonthYearText = LTRIM(RTRIM(STR(@ToMonth + @ToYear * 100)))
SET @FromDateText = LTRIM(RTRIM(CONVERT(NVARCHAR(20), @FromDate, 101)))
SET @ToDateText = LTRIM(RTRIM(CONVERT(NVARCHAR(20), @ToDate, 101))) + ' 23:59:59'

IF @IsDate =0 
	SET @strTime = '
WHERE (V7.TranMonth + 100 * V7.TranYear BETWEEN ' + @FromMonthYearText + ' AND ' + @ToMonthYearText + ' ) '
ELSE
	SET @strTime = '
WHERE (V7.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''' ) '

DECLARE ---- Cac Dieu kien cua cac cot
@strCol01 NVARCHAR(500), @strCol02 NVARCHAR(500), @strCol03 NVARCHAR(500), @strCol04 AS NVARCHAR(500), @strCol05 AS NVARCHAR(500), 
@strCol06 NVARCHAR(500), @strCol07 NVARCHAR(500), @strCol08 NVARCHAR(500), @strCol09 AS NVARCHAR(500), @strCol10 AS NVARCHAR(500), 
@strCol11 NVARCHAR(500), @strCol12 NVARCHAR(500), @strCol13 NVARCHAR(500), @strCol14 AS NVARCHAR(500), @strCol15 AS NVARCHAR(500), 
@strCol16 NVARCHAR(500), @strCol17 NVARCHAR(500), @strCol18 NVARCHAR(500), @strCol19 AS NVARCHAR(500), @strCol20 AS NVARCHAR(500)

--Print @strTime 
SELECT @Count = Max(ColumnID) FROM AT4712 WITH (NOLOCK) WHERE ReportCode = @ReportCode AND DivisionID = @DivisionID

SELECT 
@Filter1ID = Filter1ID, @Filter2ID = Filter2ID, @Filter3ID= Filter3ID, @Filter4ID = Filter4ID, @Filter5ID = Filter5ID, @GroupID = GroupID 
FROM AT4711 WITH (NOLOCK) WHERE ReportCode = @ReportCode AND DivisionID = @DivisionID

SET @strFilter = ''

IF ISNULL(@Filter1ID, '') <> ''
	BEGIN
		EXEC AP4700 @Filter1ID, @LevelColumn OUTPUT
		SET @strFilter = @strFilter + '
AND ( V7.' + @LevelColumn + ' BETWEEN N''' + @Filter1IDFrom + ''' AND N''' + @Filter1IDTo + ''') '
	END
	
IF ISNULL(@Filter2ID, '') <> ''
	BEGIN
		EXEC AP4700 @Filter2ID, @LevelColumn OUTPUT
		SET @strFilter = @strFilter + '
AND ( V7.' + @LevelColumn + ' BETWEEN N''' + @Filter2IDFrom + ''' AND N''' + @Filter2IDTo + ''') '
	END

IF ISNULL(@Filter3ID, '') <> ''
	BEGIN
		EXEC AP4700 @Filter3ID, @LevelColumn OUTPUT
		SET @strFilter = @strFilter + '
AND ( V7.' + @LevelColumn + ' BETWEEN N''' + @Filter3IDFrom + ''' AND N''' + @Filter3IDTo + ''') '
	END

IF ISNULL(@Filter4ID, '') <> ''
	BEGIN
		EXEC AP4700 @Filter4ID, @LevelColumn OUTPUT
		SET @strFilter = @strFilter + '
AND ( V7.' + @LevelColumn + ' BETWEEN N''' + @Filter4IDFrom + ''' AND N''' + @Filter4IDTo + ''') '
	END

IF ISNULL(@Filter5ID, '') <> ''
	BEGIN
		EXEC AP4700 @Filter5ID, @LevelColumn OUTPUT
		SET @strFilter = @strFilter + '
AND ( V7.' + @LevelColumn + ' BETWEEN N''' + @Filter5IDFrom + ''' AND N''' + @Filter5IDTo + ''') '
	END

SET @sSQL = N'
SELECT	'''+@DivisionID +''' AS DivisionID, '+CASE WHEN @CustomerName = 16 THEN 'VoucherTypeID,' ELSE '' END +'
		InventoryID, InventoryName, UnitID, 
		S1, S2, S3, CI1ID, CI2ID, CI3ID, 
		S1Name, S2Name, S3Name, 
		I01ID, I02ID, I03ID, I04ID, I05ID, 
		InAnaName1, InAnaName2, InAnaName3, InAnaName4, InAnaName5, 
		Specification, Notes01, Notes02, Notes03,
		UnitName, CASE WHEN ISNULL(ConvertedUnitID, '''') = '''' THEN UnitID ELSE ConvertedUnitID END AS ConvertedUnitID, 
		CASE WHEN ISNULL(ConvertedUnitID, '''') = '''' THEN UnitName ELSE ConvertedUnitName END AS ConvertedUnitName '

IF ISNULL(@GroupID, '') <> ''
	BEGIN 
		EXEC AP4700 @GroupID, @FieldGroup OUTPUT
		SET @sSQL = @sSQL + ', V7.' + @FieldGroup + ' AS GroupID '
	END 
ELSE 
	BEGIN
		SET @FieldGroup =''
		SET @sSQL = @sSQL + ', '''' AS GroupID '
	END
	
SET @AT4712_cur = CURSOR SCROLL KEYSET FOR 
SELECT ColumnID, CaculatedType, ColumnName, AmountType, ConditionType, ISNULL(ConditionFrom, ''), ISNULL(ConditionTo, ''), FilterType, ISNULL(Condition, '%')
FROM AT4712 WITH (NOLOCK) WHERE ReportCode = @ReportCode AND DivisionID = @DivisionID

OPEN @AT4712_cur
FETCH NEXT FROM @AT4712_cur INTO @ColumnID, @CaculatedType, @ColumnName, @AmountType, @ConditionType, @ConditionFrom, @ConditionTo, @FilterType, @Condition

WHILE @@Fetch_Status = 0
	BEGIN 
		EXEC AP7006 @AmountType, @CaculatedType, @ColumnAmount OUTPUT, @ConditionType, @ConditionFrom, @ConditionTo, 
		@FromMonth, @FromYear, @ToMonth, @ToYear, @FromDate, @ToDate, @IsDate, @DivisionID, @FilterType, @Condition
		
		SET @sSQL = @sSQL + ',
' + @ColumnAmount + ' AS ColumnAmount' + (CASE WHEN @ColumnID < 10 then '0' ELSE '' END) + LTRIM(RTRIM(STR(@ColumnID))) 

		FETCH NEXT FROM @AT4712_cur INTO @ColumnID, @CaculatedType, @ColumnName, @AmountType, @ConditionType, @ConditionFrom, @ConditionTo, @FilterType, @Condition
	END
CLOSE @AT4712_cur

WHILE @Count + 1 <= 20
	BEGIN
		SET @sSQL = @sSQL + ',
0 AS ColumnAmount' + (CASE WHEN @Count + 1 <10 then '0' ELSE '' END ) + LTRIM(RTRIM(STR(@Count + 1)))
		SET @Count= @Count + 1
	END
	
SET @sSQL = @sSQL + N'
INTO #TEMP_AV7006
FROM (
SELECT D17.DivisionID, D16.WareHouseID, D17.InventoryID, D02.InventoryName, D02.UnitID, D04.UnitName, 
 	    D17.TranMonth, D17.TranYear, D16.VoucherTypeID, ''BD'' AS D_C, ActualQuantity, ConvertedAmount AS SignAmount, ActualQuantity AS SignQuantity, 
 	    D02.S1, D02.S2, D02.S3, 
 	    S1.SName AS S1Name, S2.SName AS S2Name, S3.SName AS S3Name,
 	    D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
 	    D17.Ana01ID, 
 	    D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification, 
 	    I1.AnaName AS InAnaName1, I2.AnaName AS InAnaName2, 
 	    I3.AnaName AS InAnaName3, I4.AnaName AS InAnaName4, I5.AnaName AS InAnaName5, 
 	    D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName,
 	    D17.Notes01, D17.Notes02, D17.Notes03'

SET @sSQL_1 = N'
   FROM AT2017 D17 WITH (NOLOCK)
  INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID in (''@@@'',D17.DivisionID) 
   LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID AND AT1202.DivisionID in (''@@@'',D17.DivisionID)
  INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.InventoryID = D17.InventoryID AND D02.DivisionID IN (D17.DivisionID,''@@@'')
   LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in (''@@@'',D17.DivisionID)
  INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID AND D03.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = ''I01'' AND S1.S = D02.S1 AND S1.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = ''I02'' AND S2.S = D02.S2 AND S2.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = ''I03'' AND S3.S = D02.S3 AND S3.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID AND I1.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID AND I2.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID AND I3.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID AND I4.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID AND I5.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I6 WITH (NOLOCK) ON I6.AnaTypeID = ''I06'' AND I6.AnaID = D02.I06ID AND I6.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I7 WITH (NOLOCK) ON I7.AnaTypeID = ''I07'' AND I7.AnaID = D02.I07ID AND I7.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I8 WITH (NOLOCK) ON I8.AnaTypeID = ''I08'' AND I8.AnaID = D02.I08ID AND I8.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I9 WITH (NOLOCK) ON I9.AnaTypeID = ''I09'' AND I9.AnaID = D02.I09ID AND I9.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I10 WITH (NOLOCK) ON I10.AnaTypeID = ''I10'' AND I10.AnaID = D02.I10ID AND I10.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1304 D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID AND D05.DivisionID in (''@@@'',D17.DivisionID)
  WHERE ISNULL(DebitAccountID,'''') <>''''	'

 SET @sSQL_2 = N'
  	UNION ALL --- So du co hang ton kho
 SELECT D17.DivisionID, D16.WareHouseID, D17.InventoryID, D02.InventoryName, D02.UnitID, D04.UnitName, D17.TranMonth, D17.TranYear,
		D16.VoucherTypeID, ''BC'' AS D_C, 	ActualQuantity, -ConvertedAmount AS SignAmount,	-ActualQuantity AS SignQuantity,  --- So du Co
	    D02.S1,	D02.S2, D02.S3,
		S1.SName AS S1Name,S2.SName AS S2Name,S3.SName AS S3Name,
	    D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	    D17.Ana01ID,
	    D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	    I1.AnaName AS InAnaName1, I2.AnaName AS InAnaName2, 
	    I3.AnaName AS InAnaName3, I4.AnaName AS InAnaName4, I5.AnaName AS InAnaName5, 
	    D17.ConvertedUnitID, D05.UnitName AS ConvertedUnitName,
	    D17.Notes01, D17.Notes02, D17.Notes03
   FROM AT2017 D17 WITH (NOLOCK) 
  INNER JOIN AT2016 D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID in (''@@@'',D17.DivisionID) 
   LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D16.ObjectID AND AT1202.DivisionID in (''@@@'',D17.DivisionID)
  INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.InventoryID = D17.InventoryID AND D02.DivisionID IN (D17.DivisionID,''@@@'')
   LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in (''@@@'',D17.DivisionID)
  INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID AND D03.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = ''I01'' AND S1.S = D02.S1 AND S1.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = ''I02'' AND S2.S = D02.S2 AND S2.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = ''I03'' AND S3.S = D02.S3 AND S3.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID AND I1.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID AND I2.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID AND I3.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID AND I4.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID AND I5.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I6 WITH (NOLOCK) ON I6.AnaTypeID = ''I06'' AND I6.AnaID = D02.I06ID AND I6.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I7 WITH (NOLOCK) ON I7.AnaTypeID = ''I07'' AND I7.AnaID = D02.I07ID AND I7.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I8 WITH (NOLOCK) ON I8.AnaTypeID = ''I08'' AND I8.AnaID = D02.I08ID AND I8.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I9 WITH (NOLOCK) ON I9.AnaTypeID = ''I09'' AND I9.AnaID = D02.I09ID AND I9.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1015 I10 WITH (NOLOCK) ON I10.AnaTypeID = ''I10'' AND I10.AnaID = D02.I10ID AND I10.DivisionID in (''@@@'',D17.DivisionID)
   LEFT JOIN AT1304 D05 WITH (NOLOCK) ON D05.UnitID = D17.ConvertedUnitID AND D05.DivisionID in (''@@@'',D17.DivisionID)
  WHERE ISNULL(CreditAccountID,'''') <>''''		'

SET @sSQL_3 = N'
  	UNION ALL  -- Nhap kho
 SELECT D07.DivisionID, D06.WareHouseID, D07.InventoryID, D02.InventoryName, D02.UnitID, D04.UnitName, D07.TranMonth, D07.TranYear,
		D06.VoucherTypeID, ''D'' AS D_C, ActualQuantity, ConvertedAmount AS SignAmount, ActualQuantity AS SignQuantity,  --- Phat sinh No
	    D02.S1,	D02.S2, D02.S3, 
		S1.SName AS S1Name, S2.SName AS S2Name, S3.SName AS S3Name,
	    D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	    D07.Ana01ID,
	    D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	    I1.AnaName AS InAnaName1, I2.AnaName AS InAnaName2, 
	    I3.AnaName AS InAnaName3, I4.AnaName AS InAnaName4, I5.AnaName AS InAnaName5, 
	    D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName,
	    D07.Notes01, D07.Notes02, D07.Notes03
   FROM AT2007 D07 WITH (NOLOCK)
  INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID AND AT1202.DivisionID in (''@@@'',D07.DivisionID)
  INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
   LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in (''@@@'',D07.DivisionID)
  INNER JOIN AT1303 D03 WITH (NOLOCK) ON D03.WareHouseID = D06.WareHouseID  AND D03.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1302 P02 WITH (NOLOCK) ON P02.DivisionID IN (D07.DivisionID,''@@@'') AND P02.InventoryID = D07.ProductID
   LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = ''I01'' AND S1.S = D02.S1  AND S1.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = ''I02'' AND S2.S = D02.S2  AND S2.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = ''I03'' AND S3.S = D02.S3  AND S3.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID AND I1.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID AND I2.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID AND I3.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID AND I4.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID AND I5.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I6 WITH (NOLOCK) ON I6.AnaTypeID = ''I06'' AND I6.AnaID = D02.I06ID AND I6.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I7 WITH (NOLOCK) ON I7.AnaTypeID = ''I07'' AND I7.AnaID = D02.I07ID AND I7.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I8 WITH (NOLOCK) ON I8.AnaTypeID = ''I08'' AND I8.AnaID = D02.I08ID AND I8.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I9 WITH (NOLOCK) ON I9.AnaTypeID = ''I09'' AND I9.AnaID = D02.I09ID AND I9.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I10 WITH (NOLOCK) ON I10.AnaTypeID = ''I10'' AND I10.AnaID = D02.I10ID AND I10.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1304 D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID AND D05.DivisionID in (''@@@'',D07.DivisionID)
  WHERE D06.KindVoucherID IN (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'''') <> ''AT0114'' ------- Phiếu nhập bù của ANGEL'
  
  SET @sSQL_4 = N'
	UNION ALL  -- xuat kho
 SELECT D07.DivisionID, D06.WareHouseID, D07.InventoryID, D02.InventoryName, D02.UnitID, D04.UnitName, D07.TranMonth, D07.TranYear,
		D06.VoucherTypeID, ''C'' AS D_C, ActualQuantity, -ConvertedAmount AS SignAmount, -ActualQuantity AS SignQuantity, 	 --- So du Co
		D02.S1, D02.S2, D02.S3, 
		S1.SName AS S1Name, S2.SName AS S2Name, S3.SName AS S3Name,
	    D02.S1 AS CI1ID, D02.S2 AS CI2ID, D02.S3 AS CI3ID, 
	    D07.Ana01ID,
	    D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.Specification,
	    I1.AnaName AS InAnaName1, I2.AnaName AS InAnaName2, I3.AnaName AS InAnaName3, 
	    I4.AnaName AS InAnaName4, I5.AnaName AS InAnaName5, 
	    D07.ConvertedUnitID, D05.UnitName AS ConvertedUnitName,
	    D07.Notes01, D07.Notes02, D07.Notes03
   FROM AT2007 D07 WITH (NOLOCK)
  INNER JOIN AT2006 D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = D06.ObjectID AND AT1202.DivisionID in (''@@@'',D07.DivisionID)
  INNER JOIN AT1302 D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
   LEFT JOIN AT1304 D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1310 S1 WITH (NOLOCK) ON S1.STypeID = ''I01'' AND S1.S = D02.S1 AND S1.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1310 S2 WITH (NOLOCK) ON S2.STypeID = ''I02'' AND S2.S = D02.S2 AND S2.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1310 S3 WITH (NOLOCK) ON S3.STypeID = ''I03'' AND S3.S = D02.S3 AND S3.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I1 WITH (NOLOCK) ON I1.AnaTypeID = ''I01'' AND I1.AnaID = D02.I01ID AND I1.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I2 WITH (NOLOCK) ON I2.AnaTypeID = ''I02'' AND I2.AnaID = D02.I02ID AND I2.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I3 WITH (NOLOCK) ON I3.AnaTypeID = ''I03'' AND I3.AnaID = D02.I03ID AND I3.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I4 WITH (NOLOCK) ON I4.AnaTypeID = ''I04'' AND I4.AnaID = D02.I04ID AND I4.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I5 WITH (NOLOCK) ON I5.AnaTypeID = ''I05'' AND I5.AnaID = D02.I05ID AND I5.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I6 WITH (NOLOCK) ON I6.AnaTypeID = ''I06'' AND I6.AnaID = D02.I06ID AND I6.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I7 WITH (NOLOCK) ON I7.AnaTypeID = ''I07'' AND I7.AnaID = D02.I07ID AND I7.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I8 WITH (NOLOCK) ON I8.AnaTypeID = ''I08'' AND I8.AnaID = D02.I08ID AND I8.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I9 WITH (NOLOCK) ON I9.AnaTypeID = ''I09'' AND I9.AnaID = D02.I09ID AND I9.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1015 I10 WITH (NOLOCK) ON I10.AnaTypeID = ''I10'' AND I10.AnaID = D02.I10ID AND I10.DivisionID in (''@@@'',D07.DivisionID)
   LEFT JOIN AT1304 D05 WITH (NOLOCK) ON D05.UnitID = D07.ConvertedUnitID  AND D05.DivisionID in (''@@@'',D07.DivisionID)
  WHERE D06.KindVoucherID IN (2,3,4,6,8,10,14,20)
  ) V7 
  WHERE V7.DivisionID '+@StrDivisionID_New+' '

IF @strFilter <> '' 
	SET @sSQL_4 = @sSQL_4 + ' ' + @strFilter 
	
SET @sSQL_4 = @sSQL_4 + N'
GROUP BY InventoryID, '+CASE WHEN @CustomerName = 16 THEN 'VoucherTypeID,' ELSE '' END +' InventoryName, UnitID, S1, S2, S3, CI1ID, CI2ID, CI3ID, S1Name, S2Name, S3Name, I01ID, I02ID, I03ID, I04ID, I05ID, 
		 InAnaName1, InAnaName2, InAnaName3, InAnaName4, InAnaName5, Specification, Notes01, Notes02, Notes03,VoucherTypeID, UnitName, 
		 CASE WHEN ISNULL(ConvertedUnitID, '''') = '''' THEN UnitID ELSE ConvertedUnitID END,
		 CASE WHEN ISNULL(ConvertedUnitID, '''') = '''' THEN UnitName ELSE ConvertedUnitName END '

IF @FieldGroup <> '' 
	SET @sSQL_4 = @sSQL_4 + ', ' + @FieldGroup

IF @FieldGroup <> ''
	SET @sSQL_5 = N'
SELECT V6.*, AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, V66.SelectionName AS GroupName
 FROM #TEMP_AV7006 V6 WITH (NOLOCK)
 LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = V6.InventoryID
 LEFT JOIN AV6666 V66 WITH (NOLOCK) ON V66.SelectionType = N''' + @GroupID + ''' AND V66.SelectionID = V6.GroupID AND V6.DivisionID IN (V66.DivisionID,''@@@'')	' 
ELSE
	SET @sSQL_5 = N'
SELECT V6.*, AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, '''' AS GroupName
  FROM #TEMP_AV7006 V6 WITH (NOLOCK)
  LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = V6.InventoryID	' 

--IF EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'AV7007')
--	DROP VIEW AV7007 
--EXEC('CREATE VIEW AV7007 -- tao boi AP7007
--	AS ' + @sSQL)

PRINT @sSQL	
PRINT @sSQL_1
PRINT @sSQL_2
PRINT @sSQL_3
PRINT @sSQL_4
PRINT @sSQL_5

EXEC (@sSQL + @sSQL_1 + @sSQL_2 + @sSQL_3 + @sSQL_4 + @sSQL_5) 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
