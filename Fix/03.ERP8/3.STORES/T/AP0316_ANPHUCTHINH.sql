IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0316_ANPHUCTHINH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0316_ANPHUCTHINH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In bao cao cong no theo tuoi no
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 31/05/2004 by Nguyen Thi Ngoc Minh
---- 
---- Last Edit: Thuy Tuyen  03/06/2008,06/08/2008
---- Edit by Nguyen Quoc Huy, Date 26/08/2008
---- Edit Thuy Tuyen, Them Group by  AV0327.VoucherID trong view AV0326, date 29/05/2010
---- Modified on 11/01/2012 by Le Thi Thu Hien : Sua dieu kien loc theo ngay
---- Modified on 16/01/2012 by Le Thi Thu Hien : Sua loi GROUP BY
---- Modified on 05/03/2012 by Le Thi Thu Hien : Chinh sua Cách xử lý @IsBefore
---- Modified on 03/04/2012 by Le Thi Thu Hien : Viết lại
---- Modified on 17/07/2012 by Bao Anh : Sửa cho trường hợp in theo ngày không phân biệt trở về trước hay sau
---- Modified on 06/03/2013 by Khanh Van: Bo sung tu tai khoan den tai khoan cho Sieu Thanh
---- Modified on 05/05/2014 by Mai Duyen: Fix loi tinh tuoi no chua dung(trương hop nac thang cuoi cung, bo siung AV0327.BatchID)  ( Kh PrintTech)
---- Modified on 19/01/2016 by Hoàng vũ: CustomizeIndex = 13 (Tiên tiến) mốc điều kiện thứ 3  đổi thành giống mốc thứ 1 và bổ sung thêm điều kiện ngày chứng từ nhỏ hơn ngày mốc truyền xuống.
---- Modified on 28/04/2016 by Kim Vũ: Bổ sung lấy thêm các trường BankAccountNo, BankName, LicenseNo, LegalCapital
---- Modified on 13/12/2016 by Hải Long: Bổ sung lấy thêm các trường ReDueDays, GivedConvertedAmount cho ANGEL
---- Modified on 13/12/2016 by Hải Long: Lấy thành tiền thuế TransactionTypeID = T14 cho TIÊN TIẾN (CustomizeIndex = 13)
---- Modified on 29/12/2016 by Hải Long: Lấy I01ID, I01Name theo yêu cầu của khách hàng TIÊN TIẾN (CustomizeIndex = 13)
---- Modified on 25/04/2017 by Phương Thảo: Chỉnh sửa cách nối chuỗi, fix bug convert về kiểu int khi so sánh nấc thang tuổi nợ
---- Modified on 05/05/2017 by Bảo Thy: Fix lỗi Báo cáo nợ phải thu theo tuổi nợ không lên cột chưa đến hạn
---- Modified on 10/05/2017 by Bảo Thy: Bổ sung O01ID, O02ID, O03ID, O04ID, O05ID, O01Name, O02Name, O03Name, O04Name, O05Name lên view AV0316 (ReportID ='CNTN002') (GODREJ)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 18/05/2017 by Bảo Anh: Sửa lỗi tiền quá hạn lên sai đối với trường hợp 90 ngày (KOYO)
---- Modified on 22/09/2017 by Bảo Thy: CustomizeIndex = 13 (Tiên tiến) fix điều kiện ngày chứng từ nhỏ hơn ngày mốc truyền xuống
---- Modified on 24/12/2018 by Kim Thư: Lấy số tiền công nợ loại trừ khoản chiết khấu T64
---- Modified on 22/04/2021 by Huỳnh Thử: Tách Store [An Phúc Thịnh]
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
---- 
CREATE PROCEDURE [dbo].[AP0316_ANPHUCTHINH]
( 
				@DivisionID AS nvarchar(50), 
				@ReportCode AS nvarchar(50), 
				@FromObjectID  AS nvarchar(50),  
				@ToObjectID  AS nvarchar(50),  
				@FromAccountID  AS nvarchar(50),  
				@ToAccountID  AS nvarchar(50),  
				@CurrencyID AS nvarchar(50),	
				@Filter1IDFrom AS nvarchar(50),
				@Filter1IDTo AS nvarchar(50),
				@Filter2IDFrom AS nvarchar(50),
				@Filter2IDTo AS nvarchar(50),
				@Filter3IDFrom AS nvarchar(50),
				@Filter3IDTo AS nvarchar(50),
				@ReportDate AS Datetime,
				@IsBefore AS TINYINT,
				@IsType AS TINYINT
) 
AS 
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@FromPeriod AS int,
		@ToPeriod AS int,
		@SQLwhere AS nvarchar(MAX),
		@sSELECT AS nvarchar(MAX),
		@sSELECT1 AS nvarchar(MAX),
		@sSELECT2 AS nvarchar(MAX)='',
		@sFROM AS nvarchar(MAX),
		@sWHERE AS nvarchar(MAX),
		@sGROUPBY AS nvarchar(MAX),
		@sGROUPBY1 AS nvarchar(MAX),
		@DateType AS nvarchar(50),
		@IsReceivable AS tinyint,
		@IsDetail AS tinyint,
		@GetColumnTitle AS tinyint,
		@DebtAgeStepID AS nvarchar(50),
		@ReportName1 AS nvarchar(250),
		@ReportName2 AS nvarchar(250),
		@GroupName1 AS nvarchar(250),
		@GroupName2 AS nvarchar(250),
		@GroupName3 AS nvarchar(250),
		@Group1ID AS nvarchar(50),
		@Group2ID AS nvarchar(50),
		@Group3ID AS nvarchar(50),
		@Field1ID AS nvarchar(50),
		@Field2ID AS nvarchar(50),
		@Field3ID AS nvarchar(50),
		@Filter1 AS nvarchar(50),
		@Filter2 AS nvarchar(50),
		@Filter3 AS nvarchar(50),
		@AT1206Cursor AS cursor,
		@Description AS nvarchar(250),
		@Orders AS tinyint,
		@FromDay AS int,
		@ToDay AS int,
		@Title AS nvarchar(250),
		@ColumnCount AS int,
		@MaxDate AS int,
		@MinDate AS int,
		@TableTemp AS nvarchar(50),
		@Voucher AS nvarchar(50),
		@D_C AS nvarchar(500),
		@Selection01ID AS nvarchar(50),
		@Selection02ID AS nvarchar(50),
		@Selection03ID AS nvarchar(50),
		@SelectionName1 AS nvarchar(250),
		@SelectionName2 AS nvarchar(250),
		@SelectionName3 AS nvarchar(250),
		@Days AS INT,
		@CustomerName INT,
		@SelectTH Nvarchar(4000),
		@SelectQH Nvarchar(4000)

	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
	
	IF @CustomerName = 16 --- Customize Sieu Thanh
		EXEC AP0316_ST @DivisionID, @ReportCode,@FromObjectID,  @ToObjectID ,@FromAccountID ,  
					@ToAccountID, @CurrencyID,@Filter1IDFrom ,@Filter1IDTo ,@Filter2IDFrom ,
					@Filter2IDTo ,@Filter3IDFrom ,@Filter3IDTo,@ReportDate ,@IsBefore,@IsType
	ELSE
	Begin
		SET @sWHERE = ''
		SET @sSELECT = ''
		SET @sSELECT1 = ''
		SET @sGROUPBY = ''
		SET @sGROUPBY1 = ''
		SET @sFROM = ''
		SET @Voucher = ''
		SET @D_C = ''

		--Lay thong tin thiet lap bao cao tu bang AT4710
		SELECT TOP 1	@ReportName1 = replace(ReportName1,'''',''''''), 
						@ReportName2 = replace(ReportName2,'''',''''''), 
						@DateType = (Case DateType
									When 0 THEN 'VoucherDate'
									When 1 THEN 'InvoiceDate'
									When 2 THEN 'DueDate' end),
						@IsReceivable = IsReceivable,
						@IsDetail = IsDetail,
						@GetColumnTitle = GetColumnTitle,
						@DebtAgeStepID = replace(DebtAgeStepID,'''',''''''),
						@Group1ID =ISNULL(Group1ID,''),
						@Group2ID = ISNULL(Group2ID,''),
						@Group3ID = ISNULL(Group3ID,''),
						@Selection01ID = ISNULL(Selection01ID,''),
						@Selection02ID = ISNULL(Selection02ID,''),
						@Selection03ID = ISNULL(Selection03ID,'')
		FROM	AT4710
		WHERE	ReportCode =  @ReportCode 
				AND DivisionID = @DivisionID

		--Tao view lay so thanh toan cong no
		If @IsReceivable = 1 
			SET @sSQL = ' 
				SELECT 	DISTINCT AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, 
						AT0303.DebitVoucherID  AS VoucherID, 
						AT0303.DebitBatchID AS BatchID,
						SUM(ISNULL(AT0303.OriginalAmount,0)) AS GivedOriginalAmount,
						SUM(ISNULL(AT0303.ConvertedAmount,0)) AS GivedConvertedAmount,
						AT0303.DivisionID
				FROM AT0303 LEFT JOIN (	SELECT	DISTINCT DivisionID, VoucherID, BatchID, TableID,ObjectID,VoucherDate
							FROM AV0302
							) AS  AV0302 
					ON  AV0302.DivisionID = AT0303.DivisionID AND  AV0302.VoucherID = AT0303.CreditVoucherID 
						AND AV0302.TableID = AT0303.CreditTableID 
						AND AV0302.ObjectID = AT0303.ObjectID  AND  AV0302.BatchID = AT0303.DebitBatchID
				WHERE	AT0303.DivisionID = ''' + @DivisionID + ''' AND
						AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND 
						CONVERT(DATETIME,CONVERT(VARCHAR(10),ISNULL(AT0303.CreditVoucherDate,''01/01/1900''),101), 101)  <= '''+CONVERT(nvarchar(10),@ReportDate,101)+''' 
				GROUP BY AT0303.ObjectID, AT0303.AccountID, AT0303.CurrencyID, AT0303.DebitVoucherID, 
							AT0303.DebitBatchID, AT0303.DivisionID'

		Else   --Cong no phai tra da giai tru
			SET @sSQL = ' 
				SELECT DISTINCT AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, 
						AT0404.CreditVoucherID AS VoucherID, 
						AT0404.CreditBatchID AS BatchID,
						SUM(ISNULL(AT0404.OriginalAmount,0)) AS GivedOriginalAmount,
						SUM(ISNULL(AT0404.ConvertedAmount,0)) AS GivedConvertedAmount,
						AT0404.DivisionID
				FROM AT0404
				LEFT JOIN  (SELECT DISTINCT DivisionID, VoucherID, BatchID, TableID,ObjectID,VoucherDate 
							FROM	AV0402
							) AS  AV0402 
					ON		AV0402.DivisionID = AT0404.DivisionID AND  AV0402.VoucherID = AT0404.DebitVoucherID 
							AND AV0402.TableID = AT0404.DebitTableID AND AV0402.ObjectID = AT0404.ObjectID AND AV0402.BatchID = AT0404.CreditBatchID
				WHERE	AT0404.DivisionID = ''' + @DivisionID + ''' AND
						AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND
						CONVERT(DATETIME,CONVERT(VARCHAR(10),ISNULL(AT0404.DebitVoucherDate,''01/01/1900''),101), 101)  <='''+CONVERT(nvarchar(10),@ReportDate,101)+''' 
				GROUP BY	AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, AT0404.CreditVoucherID, 
							AT0404.CreditBatchID, AT0404.DivisionID'

		IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0317]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			EXEC ('  CREATE VIEW AV0317 	---CREATED BY AP0316
						AS ' + @sSQL)
		ELSE
			EXEC ('  ALTER VIEW AV0317   	---CREATED BY AP0316
						AS ' + @sSQL)
		-- print @sSQL
		--Tao view AV0327 de lay du lieu len bao cao
		SET @sSQL = ' 
		SELECT	AV4301.DivisionID, AV4301.ObjectID, AV4301.AccountID, AV4301.CorAccountID, AV4301.VoucherTypeID, 
				AV4301.CurrencyID, AV4301.VoucherID, 
				AV4301.TransactionTypeID,	
				ISNULL(GivedOriginalAmount,0) AS GivedOriginalAmount,
				ISNULL(GivedConvertedAmount,0) AS GivedConvertedAmount,
				AV4301.BatchID, AV4301.TransactionID, AV4301.D_C, AV4301.Quantity,
				AV4301.ConvertedAmount, AV4301.OriginalAmount, AV4301.OriginalAmountCN,
				(SELECT OriginalAmount FROM AV4301 A1 WHERE A1.VoucherID = AV4301.VoucherID AND A1.TransactionTypeID=''T64'' AND A1.D_C = AV4301.D_C) AS DiscountOriginalAmount,
				(SELECT ConvertedAmount FROM AV4301 A1 WHERE A1.VoucherID = AV4301.VoucherID AND A1.TransactionTypeID=''T64'' AND A1.D_C = AV4301.D_C) AS DiscountConvertedAmount,
				AV4301.CurrencyIDCN, AV4301.ExchangeRate, 
				AV4301.TranMonth, AV4301.TranYear, AV4301.VoucherNo, AV4301.VoucherDate, 
				AV4301.Serial, AV4301.InvoiceNo, AV4301.InvoiceDate, AV4301.DueDate,
				AV4301.Description, AV4301.VDescription, AV4301.BDescription, AV4301.InventoryID, 
				AV4301.O01ID, AV4301.O02ID, AV4301.O03ID, AV4301.O04ID, AV4301.O05ID, 
				AV4301.I01ID, AV4301.I02ID, AV4301.I03ID, AV4301.I04ID, AV4301.I05ID, 
				AV4301.CO1ID, AV4301.CO2ID, AV4301.CO3ID, 
				AV4301.CI1ID, AV4301.CI2ID, AV4301.CI3ID,
				AV4301.Ana01ID,	AV4301.AnaName01, 
				AV4301.Ana02ID,	AV4301.AnaName02,
				AV4301.Ana03ID,	AV4301.AnaName03,
				AV4301.Ana04ID,	AV4301.AnaName04,
				AV4301.Ana05ID,	AV4301.AnaName05,
				AV4301.O01Name, AV4301.O02Name, AV4301.O03Name, AV4301.O04Name, AV4301.O05Name
				' + CASE WHEN @CustomerName = 13 THEN ', AT1015.AnaName AS I01Name' ELSE '' END + '
		FROM	AV4301
		' + CASE WHEN @CustomerName = 13 THEN 'LEFT JOIN AT1015 WITH (NOLOCK) ON AT1015.AnaID = AV4301.I01ID AND AT1015.AnaTypeID = ''I01''' ELSE '' END + '
		LEFT JOIN (	SELECT	DivisionID, SUM(ISNULL(AV0317.GivedOriginalAmount,0)) AS GivedOriginalAmount,
							SUM(ISNULL(AV0317.GivedConvertedAmount,0)) AS GivedConvertedAmount,
							VoucherID,  BatchID, ObjectID, AccountID, CurrencyID
					FROM	AV0317 
           			GROUP BY DivisionID, VoucherID,  BatchID, ObjectID, AccountID, CurrencyID) AS A
			  ON 	AV4301.DivisionID = A.DivisionID AND AV4301.VoucherID = A.VoucherID AND
					AV4301.BatchID = A.BatchID AND
					AV4301.ObjectID = A.ObjectID AND
					AV4301.AccountID = A.AccountID AND
					AV4301.CurrencyIDCN =A.CurrencyID	
		WHERE	AV4301.DivisionID = ''' + @DivisionID + ''' AND
				AV4301.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+'''  AND 
				AV4301.ObjectID between '''+@FromObjectID+''' AND '''+@ToObjectID+'''  AND
				AV4301.TransactionTypeID <> ''T64'' '

		IF @IsReceivable = 1   --Cong No phai thu
  			SET @sSQL = @sSQL +'  AND (D_C=''D'') ' 
		ELSE
			SET @sSQL = @sSQL +'  AND (D_C=''C'') ' 

		IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0327]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			EXEC ('  CREATE VIEW AV0327 	---CREATED BY AP0316
						as ' + @sSQL)
		ELSE
			EXEC ('  ALTER VIEW AV0327   	---CREATED BY AP0316
						as ' + @sSQL)

		--Cong no phai thu hay phai tra
		If @IsReceivable = 1 
			BEGIN
				SET @TableTemp = 'AT0303'
				SET @Voucher = 'Debit'	--phieu no (tang) trong bang giai tru
						---lay so du no no phai thu hay lay phat sinh co
			END
		ELSE
			BEGIN
				SET @TableTemp = 'AT0404'
				SET @Voucher = 'Credit'	--phieu co (tang) trong bang giai tru
				---lay so du co no phai tra hay lay phat sinh no
		   END

		--Xu ly nhom du lieu
		If @Group1ID != ''
			BEGIN
				Exec AP4700  @Group1ID,@GroupName1 OUTPUT
				SET @sSELECT1 = @sSELECT1 + ' 
					AV0327.' + @GroupName1 + ' AS Group1, V1.SelectionName AS Group1Name,'
				SET @sFROM = @sFROM + '
						LEFT JOIN AV6666 V1 on V1.DivisionID = AV0327.DivisionID AND V1.SelectionType = ''' + @Group1ID + ''' AND V1.SelectionID = AV0327.' + @GroupName1
				SET @sGROUPBY = @sGROUPBY +', AV0327.' + @GroupName1 + ', V1.SelectionName'   
				SET @sGROUPBY1 = @sGROUPBY1 +', AV0326.Group1, Group1Name'   
			END

		If @Group2ID != ''
			Begin
				Exec AP4700  @Group2ID,	@GroupName2 OUTPUT
				SET @sSELECT1 = @sSELECT1 +' 
					AV0327.' + @GroupName2 + ' AS Group2, V2.SelectionName AS Group2Name,'
				SET @sFROM = @sFROM + '
						left join AV6666 V2 on V2.DivisionID = AV0327.DivisionID AND V2.SelectionType = ''' + @Group2ID + ''' AND V2.SelectionID = AV0327.' + @GroupName2
				SET @sGROUPBY = @sGROUPBY +', AV0327.' + @GroupName2 + ', V2.SelectionName' 
				SET @sGROUPBY1 = @sGROUPBY1 +', AV0326.Group2, Group2Name'
			End

		If @Group3ID != ''
			Begin
				Exec AP4700  @Group3ID,	@GroupName3 OUTPUT
				SET @sSELECT1 = @sSELECT1 +' 
					AV0327.' + @GroupName3 + ' AS Group3, V3.SelectionName AS Group3Name,'
				SET @sFROM = @sFROM + '
						left join AV6666 V3 on V3.DivisionID = AV0327.DivisionID AND V3.SelectionType = ''' + @Group3ID + ''' AND V3.SelectionID = AV0327.' + @GroupName3
				SET @sGROUPBY = @sGROUPBY +', AV0327.' + @GroupName3 + ', V3.SelectionName'   
				SET @sGROUPBY1 = @sGROUPBY1 +', AV0326.Group3, Group3Name'
			End

		--Xu ly loc du lieu
		If @Selection01ID != ''
			Begin
				Exec AP4700  @Selection01ID, @SelectionName1  OUTPUT
				SET @sWHERE = @sWHERE + ' AND 
					(AV0327.' + @SelectionName1 + ' between ''' + @Filter1IDFrom + ''' AND ''' + @Filter1IDTo + '''' + CASE WHEN @CustomerName = 13 THEN ' OR AV0327.TransactionTypeID = ''T14''' ELSE '' END + ') '
			End

		If @Selection02ID != ''
			Begin
				Exec AP4700  @Selection02ID, 	@SelectionName2  OUTPUT
				SET @sWHERE = @sWHERE + ' AND 
					(AV0327.' + @SelectionName2 + ' between ''' + @Filter2IDFrom + ''' AND ''' + @Filter2IDTo + '''' + CASE WHEN @CustomerName = 13 THEN ' OR AV0327.TransactionTypeID = ''T14''' ELSE '' END + ') '
			End

		If @Selection03ID != ''
			Begin
				Exec AP4700  @Selection03ID,	@SelectionName3  OUTPUT
				SET @sWHERE = @sWHERE + ' AND 
					(AV0327.' + @SelectionName3 + ' between ''' + @Filter3IDFrom + ''' AND ''' + @Filter3IDTo + '''' + CASE WHEN @CustomerName = 13 THEN ' OR AV0327.TransactionTypeID = ''T14''' ELSE '' END + ') '
			End

		--Xu ly lay du lieu tu moc tro ve truoc hay tro ve sau
		SET @MaxDate =  CASE WHEN ISNULL((	SELECT TOP 1 ToDay
											FROM	AT1206 
											WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
													DivisionID IN (@DivisionID, '@@@') AND
													Orders = (	SELECT	Max(Orders)
																FROM	AT1206 
																WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND AT1206.DivisionID IN (@DivisionID, '@@@'))),0) <> - 1 
							THEN ISNULL((	SELECT TOP 1 ToDay
											FROM	AT1206 
											WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
													DivisionID IN (@DivisionID, '@@@') AND
													Orders = (	SELECT	Max(Orders)
																FROM	AT1206 
																WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND AT1206.DivisionID IN (@DivisionID, '@@@'))),0)
							ELSE 10000 END
		
		IF @MaxDate > 10000 
			SET @MaxDate = 10000
			SET @MinDate =  CASE WHEN ISNULL((	SELECT TOP 1 ToDay
												FROM	AT1206 
												WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
														DivisionID IN (@DivisionID, '@@@') AND
														Orders = (	SELECT	Min(Orders)
																	FROM	AT1206 
																	WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
																			AT1206.DivisionID IN (@DivisionID, '@@@'))),0) <> - 1 
								THEN ISNULL((	SELECT TOP 1 ToDay
												FROM	AT1206 
												WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
														DivisionID IN (@DivisionID, '@@@') AND
														Orders = (	SELECT	Min(Orders)
																	FROM	AT1206 
																	WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
																			AT1206.DivisionID IN (@DivisionID, '@@@'))),0)
								ELSE -10000 END

		IF @MinDate < -10000 
			SET @MinDate = -10000

		SET @SelectTH = 
				'Convert(int, CONVERT(DATETIME,(''' + CONVERT(nvarchar(10),@ReportDate,101) + '''),101) - CONVERT (DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101))'
		
		SET @SelectQH = 
				'Convert(int, CONVERT(DATETIME,(''' + CONVERT(nvarchar(10),@ReportDate,101) + '''),101) - CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101))'
	

		IF @IsBefore = 0 AND @IsType = 1 -- Trước hạn
			BEGIN
				
				SET @sWHERE = @sWHERE + '  AND 
					CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101) >= ''' + CONVERT(nvarchar(10),@ReportDate,101) + 
						(CASE WHEN @MaxDate = 0 THEN '''' ELSE 
					''' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101) <= ''' + CONVERT(nvarchar(10),@ReportDate + @MaxDate,101) + '''' end)
			END
			--print @sWHERE
		IF @IsBefore = 1 AND @IsType = 1 -- Quá hạn
			BEGIN				

				SET @sWHERE =@sWHERE + '  AND 
						CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.'+ltrim(Rtrim(@DateType))+',101),101) <= ''' + CONVERT(nvarchar(10),@ReportDate,101) + 
							(CASE WHEN @MaxDate = 0 THEN '''' ELSE 
							''' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101) >= ''' + CONVERT(nvarchar(10),@ReportDate - @MaxDate,101) + '''' end)
			END

		IF @IsType = 2 -- Trước hạn và quá hạn
			BEGIN
				IF @CustomerName = 13
					SET @sWHERE = @sWHERE + ' And AV0327.VoucherDate <= '''+ CONVERT(VARCHAR(10),@ReportDate,120)+''' '  --' And Year(AV0327.VoucherDate) <= '+ Cast(Year(@ReportDate) as nvarchar(50)) 
					--+ '  And Convert(Varchar(20), AV0327.VoucherDate, 101) <= ''' + CONVERT(nvarchar(10),@ReportDate,101) 
					--+ ''' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) + ',101),101) >= ''' 
					--+ CONVERT(nvarchar(10),@ReportDate,101) 
					--+ (CASE WHEN @MaxDate = 0 THEN '''' ELSE ''' AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV0327.' + ltrim(Rtrim(@DateType)) 
					--+ ',101),101) <= ''' + CONVERT(nvarchar(10),@ReportDate + @MaxDate,101) + '''' end)
				Else
					SET @sWHERE =@sWHERE 
			END

		--Xu ly lay chi tiet chung tu hay tong hop theo doi tuong
		IF @IsDetail = 1
	    BEGIN
				SET @sSELECT1 = @sSELECT1 + ' 
					AV0327.VoucherDate, AV0327.VoucherNo, 
					DATEDIFF (day, AV0327.' + ltrim(Rtrim(@DateType)) + ' , ''' + CONVERT(nvarchar(10),@ReportDate,101) + ''') AS Days,
					AV0327.Serial, AV0327.InvoiceNo, AV0327.InvoiceDate, AV0327.DueDate, AV0327.VDescription, 
					MAX(AV0327.BDescription) AS BDescription, AV0327.VoucherID,  
					MAX(AV0327.Ana01ID) AS Ana01ID,	MAX(AV0327.AnaName01) AS AnaName01,	
					MAX(AV0327.Ana02ID) AS Ana02ID,	MAX(AV0327.AnaName02) AS AnaName02,
					MAX(AV0327.Ana03ID) AS Ana03ID,	MAX(AV0327.AnaName03) AS AnaName03,	
					MAX(AV0327.Ana04ID) AS Ana04ID,	MAX(AV0327.AnaName04) AS AnaName04,
					MAX(AV0327.Ana05ID) AS Ana05ID,	MAX(AV0327.AnaName05) AS AnaName05,
					MAX(AV0327.O01ID) AS O01ID, MAX(AV0327.O01Name) AS O01Name,
					MAX(AV0327.O02ID) AS O02ID, MAX(AV0327.O02Name) As O02Name,
					MAX(AV0327.O03ID) AS O03ID, MAX(AV0327.O03Name) AS O03Name,
					MAX(AV0327.O04ID) AS O04ID, MAX(AV0327.O04Name) AS O04Name,
					MAX(AV0327.O05ID) AS O05ID, MAX(AV0327.O05Name) AS O05Name,'
				SET @sGROUPBY = @sGROUPBY + ',
					AV0327.VoucherID, AV0327.VoucherDate, AV0327.VoucherNo, AV0327.InvoiceDate, AV0327.Serial, 
					AV0327.DueDate, AV0327.InvoiceNo, AV0327.VDescription'
				SET @sGROUPBY1 = @sGROUPBY1 + ',
					AV0326.VoucherID, AV0326.VoucherDate, AV0326.VoucherNo, AV0326.InvoiceDate, AV0326.Serial, 
					AV0326.DueDate, AV0326.InvoiceNo, AV0326.VDescription'
		 END
		 ELSE
 			BEGIN
 				SET @sSELECT1 = @sSELECT1 + '  0 AS Days, '
				SET @sGROUPBY = @sGROUPBY + ',
					AV0327.VoucherID, AV0327.VoucherDate, AV0327.VoucherNo, AV0327.InvoiceDate, AV0327.Serial, 
					AV0327.DueDate, AV0327.InvoiceNo, AV0327.VDescription'	
 			END
		
		--Lay du lieu
		SET @ColumnCount = (SELECT	Count(Orders)
							FROM	AT1206 
							WHERE	replace(DebtAgeStepID,'''','''''') =  @DebtAgeStepID 
									AND	AT1206.DivisionID in  (@DivisionID,'@@@') )
		IF @ColumnCount < 10
		   BEGIN
				DECLARE @i AS tinyint
				SET @i = @ColumnCount
				WHILE @i < 10
					BEGIN
						SET @i = @i + 1
						SET @sSELECT1 = @sSELECT1 + '
								N'''' AS Title' + ltrim(str(@i)) + ', 
								0 AS OriginalAmount' + ltrim(str(@i)) + ', 
								0 AS ConvertedAmount' + ltrim(str(@i)) + ','
					END
		   END

		SET @AT1206Cursor = CURSOR SCROLL KEYSET FOR
				SELECT	Description, Orders, FromDay, ToDay, replace(Title,'''','''''') AS Title
				FROM	AT1206 
				WHERE	replace(DebtAgeStepID,'''','''''') = @DebtAgeStepID AND
						AT1206.DivisionID in  (@DivisionID,'@@@')								
				ORDER BY Orders
		OPEN @AT1206Cursor
		FETCH NEXT FROM @AT1206Cursor INTO  @Description, @Orders, @FromDay, @ToDay, @Title
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @ToDay = -1
			BEGIN	
			   IF (@IsBefore = 0 AND @IsType = 1) 
					SET @sSELECT2 = @sSELECT2 +
							(CASE WHEN @GetColumnTitle = 0 THEN  'N''>= ' + ltrim(str(@FromDay))  + N' ngày'' AS Title' + ltrim(str(@Orders)) + ','
							else 'N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', ' end) + '
							( CASE WHEN '+ @SelectTH + ' + 1 >= ' + ltrim(str(@FromDay)) + ' 
								THEN SUM(ISNULL(AV0327.OriginalAmountCN,0)) - ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end)
								as OriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+ @SelectTH + ' + 1 >= ' + ltrim(str(@FromDay)) + '	
								THEN SUM(ISNULL(AV0327.ConvertedAmount,0)) - ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) 
								as ConvertedAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+ @SelectTH +' + 1 >= ' + ltrim(str(@FromDay)) + '	
								THEN ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) AS GivedOriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+@SelectTH + ' + 1 >= ' + ltrim(str(@FromDay)) + '	
								THEN ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) AS GivedConvertedAmount' + ltrim(str(@Orders)) + ', '
				
				IF (@IsBefore = 1 AND @IsType = 1) OR @IsType = 2
					BEGIN
					IF @CustomerName = 26 OR @CustomerName=38 --PrintTech Or BBL
						SET @sSELECT2 = @sSELECT2 +
							(CASE WHEN @GetColumnTitle = 0 THEN  'N''>= ' + ltrim(str(@FromDay))  + N' ngày'' AS Title' + ltrim(str(@Orders)) + ','
							else 'N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', ' end) + '
							( CASE WHEN '+ @SelectQH + '>= ' + ltrim(str(@FromDay)) + ' 
								THEN SUM(ISNULL(AV0327.OriginalAmountCN,0)) -  ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end)	as OriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN ' + @SelectQH + ' >= ' + ltrim(str(@FromDay)) + '
								THEN SUM(ISNULL(AV0327.ConvertedAmount,0)) - ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) 	as ConvertedAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+ @SelectQH + ' >= ' + ltrim(str(@FromDay)) + '	
								THEN ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) AS GivedOriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+@SelectQH+ ' >= ' + ltrim(str(@FromDay)) + '
								THEN ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) AS GivedConvertedAmount' + ltrim(str(@Orders)) + ', '
					ELSE
						SET @sSELECT2 = @sSELECT2 +
							(CASE WHEN @GetColumnTitle = 0 THEN  'N''>= ' + ltrim(str(@FromDay))  + N' ngày'' AS Title' + ltrim(str(@Orders)) + ','
							else 'N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', ' end) + '
							( CASE WHEN '+@SelectQH+ ' >= ' + ltrim(str(@FromDay)) + ' 
								THEN SUM(ISNULL(AV0327.OriginalAmountCN,0))  -  ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end)	as OriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+@SelectQH+ ' >= ' + ltrim(str(@FromDay)) + '
								THEN SUM(ISNULL(AV0327.ConvertedAmount,0)) - ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) 	as ConvertedAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+ @SelectQH +' >= ' + ltrim(str(@FromDay)) + '	
								THEN ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) AS GivedOriginalAmount' + ltrim(str(@Orders)) + ',
							( CASE WHEN '+ @SelectQH +' >= ' + ltrim(str(@FromDay)) + '
								THEN ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) AS GivedConvertedAmount' + ltrim(str(@Orders)) + ', '
					END
			END
			ELSE ---(@ToDay = -1)
			BEGIN
				IF( @IsBefore = 0 AND @IsType = 1) ---OR @IsType = 2
					Set @sSELECT2 = @sSELECT2 + 
						(CASE WHEN @GetColumnTitle = 0 THEN  '
							N''' + ltrim(str(@FromDay)) + ' - ' + ltrim(str(@ToDay)) + N' ngày'' AS Title' + ltrim(str(@Orders)) + ','
						else '
							N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', ' end) + '
						( CASE WHEN '+ @SelectTH+ ' >= ' + ltrim(str(@FromDay)) + ' AND ' + @SelectTH+ ' < ' + ltrim(str(@ToDay)) + '
							THEN SUM(ISNULL(AV0327.OriginalAmountCN,0)) - ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) 
							as OriginalAmount' + ltrim(str(@Orders)) + ',
						( CASE WHEN '+@SelectTH +' >= ' + ltrim(str(@FromDay)) + ' AND '+ @SelectTH +' < ' + ltrim(str(@ToDay)) + '
							THEN SUM(ISNULL(AV0327.ConvertedAmount,0))  - ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) 
							as ConvertedAmount' + ltrim(str(@Orders)) + ', 
						( CASE WHEN '+@SelectTH +' >= ' + ltrim(str(@FromDay)) + ' AND ' + @SelectTH + ' < ' + ltrim(str(@ToDay)) + '
							THEN ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) AS GivedOriginalAmount' + ltrim(str(@Orders)) + ',
						( CASE WHEN '+ @SelectTH + ' >= ' + ltrim(str(@FromDay)) + ' AND ' + @SelectTH+ ' < ' + ltrim(str(@ToDay)) + '
							THEN ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) AS GivedConvertedAmount' + ltrim(str(@Orders)) + ', '

			   IF (@IsBefore = 1 AND @IsType = 1 ) OR @IsType = 2
				Begin					
					SET @sSELECT2 = @sSELECT2 + 
						(CASE WHEN @GetColumnTitle = 0 THEN  'N''' + ltrim(str(@FromDay)) + ' - ' + ltrim(str(@ToDay)) + N' ngày'' AS Title' + ltrim(str(@Orders)) + ','
						else '
						N''' + ltrim(rtrim(@Title)) + ''' AS Title' + ltrim(str(@Orders)) + ', ' end) + '
					( CASE WHEN '+@SelectQH+ ' >= ' + ltrim(str(@FromDay)) + ' AND ' + @SelectQH + ' < ' + ltrim(str(@ToDay)) + '
						THEN SUM(ISNULL(AV0327.OriginalAmountCN,0)) - ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) 
						as OriginalAmount' + ltrim(str(@Orders)) + ',
					( CASE WHEN '+ @SelectQH + ' >= ' + ltrim(str(@FromDay)) + ' AND '+ @SelectQH +' < ' + ltrim(str(@ToDay)) + '
						THEN SUM(ISNULL(AV0327.ConvertedAmount,0)) - ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) 
						as ConvertedAmount' + ltrim(str(@Orders)) + ', 
					( CASE WHEN '+@SelectQH+' >= ' + ltrim(str(@FromDay)) + ' AND '+ @SelectQH + ' < ' + ltrim(str(@ToDay)) + '
						THEN ISNULL(AV0327.GivedOriginalAmount,0) ELSE 0 end) AS GivedOriginalAmount' + ltrim(str(@Orders)) + ',
					( CASE WHEN ' + @SelectQH +' >= ' + ltrim(str(@FromDay)) + 'AND ' + @SelectQH + ' < ' + ltrim(str(@ToDay)) + '
						THEN ISNULL(AV0327.GivedConvertedAmount,0) ELSE 0 end) AS GivedConvertedAmount' + ltrim(str(@Orders)) + ', '
				End
			END
		FETCH NEXT FROM @AT1206Cursor INTO  @Description, @Orders, @FromDay, @ToDay, @Title
	    END
		CLOSE @AT1206Cursor
		DEALLOCATE @AT1206Cursor 	
		--print @sSELECT1
		--------------------
		Set @sSQL1 = '
			SELECT	AV0327.DivisionID, 
					' + @sSELECT1 + '
					'
		Set @sSQL2=' 
		CurrencyIDCN,  AV0327.ObjectID, AT1202.ObjectName, 
					AT1202.Address , AT1202.Note, AT1202.Tel, AT1202.Note1,AV0327.CurrencyID, AV0327.BatchID,
					AT1202.BankAccountNo, AT1202.BankName, AT1202.LicenseNo, AT1202.LegalCapital, AT1202.ReDueDays, 
					ISNULL(AV0327.GivedConvertedAmount,0) AS GivedConvertedAmount' + CASE WHEN @CustomerName = 13 THEN ', MAX(AV0327.I01ID) AS I01ID, MAX(AV0327.I01Name) AS I01Name' ELSE '' END + '
			FROM	AV0327 
			LEFT JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV0327.ObjectID
			' + @sFROM + '
			WHERE 	(AV0327.ObjectID between  '''+@FromObjectID+''' AND '''+@ToObjectID + ''') AND
					AV0327.DivisionID = ''' + @DivisionID + ''' 	 AND 	
					AV0327.CurrencyIDCN like ''' + @CurrencyID + ''' AND
					AV0327.TransactionTypeID not in (''T09'',''T10'') AND
					(AV0327.AccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''' or AV0327.CorAccountID between '''+@FromAccountID+''' AND '''+@ToAccountID+''')  
					' + @sWHERE + '
			GROUP BY	AV0327.ObjectID, AT1202.ObjectName, AT1202.Address,  AT1202.Note,  
						AT1202.Tel, AT1202.Note1, AV0327.CurrencyID,
						AV0327.DivisionID ' + @sGROUPBY + ', 
						CurrencyIDCN, AV0327.GivedOriginalAmount, AV0327.GivedConvertedAmount, 
						AV0327.VoucherID, AV0327.BatchID, 
						AT1202.BankAccountNo, AT1202.BankName, AT1202.LicenseNo, AT1202.LegalCapital, AT1202.ReDueDays, AV0327.' + @DateType + ''
		
		--PRINT('--AV0326'+
		--@sSQL1)
		--PRINT(@sSELECT2)
		--PRINT(@sSQL2)
		--SELECT @sSQL1
		--SELECT @sSELECT2
		--SELECT @sSQL2
		IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0326]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			EXEC ('  CREATE VIEW AV0326 	---CREATED BY AP0316
					AS ' + @sSQL1 + @sSELECT2 + @sSQL2)
		ELSE
			EXEC ('  ALTER VIEW AV0326   	---CREATED BY AP0316
					AS ' + @sSQL1 + @sSELECT2 + @sSQL2)

		IF @IsDetail = 1
		Begin
			Set @sSQL = '
			SELECT	Days, AV0326.DivisionID
					' + @sGROUPBY1 + ', MAX(AV0326.BDescription) AS BDescription, 
					MAX(AV0326.Ana01ID) AS Ana01ID,	MAX(AV0326.AnaName01) AS AnaName01,	
					MAX(AV0326.Ana02ID) AS Ana02ID,	MAX(AV0326.AnaName02) AS AnaName02,
					MAX(AV0326.Ana03ID) AS Ana03ID,	MAX(AV0326.AnaName03) AS AnaName03,	
					MAX(AV0326.Ana04ID) AS Ana04ID,	MAX(AV0326.AnaName04) AS AnaName04,
					MAX(AV0326.Ana05ID) AS Ana05ID,	MAX(AV0326.AnaName05) AS AnaName05,
					MAX(AV0326.O01ID) AS O01ID, MAX(AV0326.O01Name) AS O01Name,
					MAX(AV0326.O02ID) AS O02ID, MAX(AV0326.O02Name) As O02Name,
					MAX(AV0326.O03ID) AS O03ID, MAX(AV0326.O03Name) AS O03Name,
					MAX(AV0326.O04ID) AS O04ID, MAX(AV0326.O04Name) AS O04Name,
					MAX(AV0326.O05ID) AS O05ID, MAX(AV0326.O05Name) AS O05Name,
					AV0326.Title1, SUM(AV0326.ConvertedAmount1) AS ConvertedAmount1, SUM(AV0326.OriginalAmount1) AS OriginalAmount1, 
					AV0326.Title2, SUM(AV0326.ConvertedAmount2) AS ConvertedAmount2, SUM(AV0326.OriginalAmount2) AS OriginalAmount2,
					AV0326.Title3, SUM(AV0326.ConvertedAmount3) AS ConvertedAmount3, SUM(AV0326.OriginalAmount3) AS OriginalAmount3,
					AV0326.Title4, SUM(AV0326.ConvertedAmount4) AS ConvertedAmount4, SUM(AV0326.OriginalAmount4) AS OriginalAmount4,
					AV0326.Title5, SUM(AV0326.ConvertedAmount5) AS ConvertedAmount5, SUM(AV0326.OriginalAmount5) AS OriginalAmount5,	
					AV0326.Title6, SUM(AV0326.ConvertedAmount6) AS ConvertedAmount6, SUM(AV0326.OriginalAmount6) AS OriginalAmount6, 
					AV0326.Title7, SUM(AV0326.ConvertedAmount7) AS ConvertedAmount7, SUM(AV0326.OriginalAmount7) AS OriginalAmount7,
					AV0326.Title8, SUM(AV0326.ConvertedAmount8) AS ConvertedAmount8, SUM(AV0326.OriginalAmount8) AS OriginalAmount8,
					AV0326.Title9, SUM(AV0326.ConvertedAmount9) AS ConvertedAmount9, SUM(AV0326.OriginalAmount9) AS OriginalAmount9,
					AV0326.Title10, SUM(AV0326.ConvertedAmount10) AS ConvertedAmount10, SUM(AV0326.OriginalAmount10) AS OriginalAmount10,	
					ObjectID, ObjectName, Address,  Note,  Tel, Note1,AV0326.CurrencyID,
					BankAccountNo, BankName, LicenseNo, LegalCapital, ReDueDays, SUM(GivedConvertedAmount) AS GivedConvertedAmount' + CASE WHEN @CustomerName = 13 THEN ', MAX(AV0326.I01ID) AS I01ID, MAX(AV0326.I01Name) AS I01Name' ELSE '' END + '
			FROM	AV0326 
		    WHERE	ConvertedAmount1+ConvertedAmount2+ConvertedAmount3+ConvertedAmount4+ConvertedAmount5+
					ConvertedAmount6+ConvertedAmount7+ConvertedAmount8+ConvertedAmount9+ConvertedAmount10 <> 0 
			GROUP BY ObjectID, ObjectName, Address, Days, Note, Tel, Note1, AV0326.DivisionID ' + @sGROUPBY1 +',
					AV0326.Title1,AV0326.Title2,AV0326.Title3,AV0326.Title4,AV0326.Title5,
					AV0326.Title6,AV0326.Title7,AV0326.Title8,AV0326.Title9,AV0326.Title10,AV0326.CurrencyID,
					BankAccountNo, BankName, LicenseNo, LegalCapital, ReDueDays '
	   End
       Else
	   begin
			Set @sSQL = '
			SELECT	Days, AV0326.DivisionID,AV0326.CurrencyID
					' + @sGROUPBY1 + ',
					AV0326.Title1, SUM(AV0326.ConvertedAmount1) AS ConvertedAmount1, SUM(AV0326.OriginalAmount1) AS OriginalAmount1, 
					AV0326.Title2, SUM(AV0326.ConvertedAmount2) AS ConvertedAmount2, SUM(AV0326.OriginalAmount2) AS OriginalAmount2,
					AV0326.Title3, SUM(AV0326.ConvertedAmount3) AS ConvertedAmount3, SUM(AV0326.OriginalAmount3) AS OriginalAmount3,
					AV0326.Title4, SUM(AV0326.ConvertedAmount4) AS ConvertedAmount4, SUM(AV0326.OriginalAmount4) AS OriginalAmount4,
					AV0326.Title5, SUM(AV0326.ConvertedAmount5) AS ConvertedAmount5, SUM(AV0326.OriginalAmount5) AS OriginalAmount5,	
					AV0326.Title6, SUM(AV0326.ConvertedAmount6) AS ConvertedAmount6, SUM(AV0326.OriginalAmount6) AS OriginalAmount6, 
					AV0326.Title7, SUM(AV0326.ConvertedAmount7) AS ConvertedAmount7, SUM(AV0326.OriginalAmount7) AS OriginalAmount7,
					AV0326.Title8, SUM(AV0326.ConvertedAmount8) AS ConvertedAmount8, SUM(AV0326.OriginalAmount8) AS OriginalAmount8,
					AV0326.Title9, SUM(AV0326.ConvertedAmount9) AS ConvertedAmount9, SUM(AV0326.OriginalAmount9) AS OriginalAmount9,
					AV0326.Title10, SUM(AV0326.ConvertedAmount10) AS ConvertedAmount10, SUM(AV0326.OriginalAmount10) AS OriginalAmount10,	
					ObjectID, ObjectName, Address,  Note,  Tel, Note1,
					BankAccountNo, BankName, LicenseNo, LegalCapital, ReDueDays, SUM(GivedConvertedAmount) AS GivedConvertedAmount' + CASE WHEN @CustomerName = 13 THEN ', MAX(AV0326.I01ID) AS I01ID, MAX(AV0326.I01Name) AS I01Name' ELSE '' END + '
			FROM	AV0326 
			WHERE	ConvertedAmount1+ConvertedAmount2+ConvertedAmount3+ConvertedAmount4+ConvertedAmount5+
					ConvertedAmount6+ConvertedAmount7+ConvertedAmount8+ConvertedAmount9+ConvertedAmount10 <> 0 
			GROUP BY ObjectID, ObjectName, Address, Days, Note, Tel, Note1, AV0326.DivisionID ' + @sGROUPBY1 +',
					AV0326.Title1,AV0326.Title2,AV0326.Title3,AV0326.Title4,AV0326.Title5,
					AV0326.Title6,AV0326.Title7,AV0326.Title8,AV0326.Title9,AV0326.Title10,AV0326.CurrencyID,
					BankAccountNo, BankName, LicenseNo, LegalCapital, ReDueDays '
		end
		--print @sSQL
		IF NOT EXISTS (SELECT NAME FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0316]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1)
			EXEC ('  CREATE VIEW AV0316 	---CREATED BY AP0316
					AS ' + @sSQL)
		ELSE
			EXEC ('  ALTER VIEW AV0316   	---CREATED BY AP0316
					AS ' + @sSQL)
	END
	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
