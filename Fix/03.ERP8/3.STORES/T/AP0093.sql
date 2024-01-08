IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Truy vấn hóa đơn bán hàng thay cho AV3066
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 23/09/2013 by Khanh Van
---- 
---- Modified on 05/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 13/06/2014 by Le Thi Thu Hien : Bỏ where TableID
---- Modified on 01/07/2014 by Le Thi Thu Hien : Bổ sung 1 số thông tin
---- Modified on 05/05/2015 by Thanh Sơn : Bổ sung  Order by
---- Modified on 17/11/2015 by Quốc Tuấn : Sửa lại tính số lần in
---- Modified by Tiểu Mai on 18/01/2016: Bổ sung columns DiscountPercentSOrder, DiscountAmountSOrder
---- Modified by Phương Thảo on 02/03/2016 : Bỏ group theo tỷ giá (vì 1 hóa đơn có thể có nhiều tỷ giá)
---- Modified by Tiểu Mai	 on 14/03/2016: Bổ sung cloumns Ana01ID --> Ana10ID, RefInfor
---- Modified by Bảo Thy	 on 25/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai	 on 30/05/2016: Fix double dòng màn hình truy vấn
---- Modified by Phương Thảo on 13/06/2016: Customize KH Thành Công (CustomerIndex = 65) : Order by ưu tiên theo loại phiếu
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Phương Thảo on 13/06/2016: Lấy thêm dữ liệu đơn hàng bán (xử lý nối chuỗi nếu kế thừa nhiều đơn hàng) 
---- Modified by Hải Long	 on 30/08/2017: Bổ sung 10 tham số trên Master
---- Modified by Hải Long	 on 17/10/2017: Fix lỗi bị double dòng khi đối tượng hóa đơn và đối tượng VAT khác nhau
---- Modified by Bảo Anh	 on 08/01/2018: Fix lỗi không đủ chiều dài khi update OrderID
---- Modified by Bảo Anh	 on 11/01/2018: Bổ sung store customize Phúc Long
---- Modified by Kim Thư	 on 16/04/2019: Lấy top 1 mã phân tích, ko lấy Max (ko làm cho Mạnh Phương - 69, siêu thanh - 16, godrej - 74)
---- Modified by Kim Thư	 on 22/05/2019: Lấy Ana02ID và Ana05ID cho KOYO (52)
---- Modified by Huỳnh Thử	 on 17/10/2019: Group by 2 dòng thuế thành 1 cho SAVI (44)
---- Modified by Văn Tài	 on 16/12/2019: Fix lỗi bổ sung dấu , sai vị trí và không đủ trường hợp.
---- Modified by Văn Minh	 on 10/03/2020: Customize SONG BÌNH.
---- Modified by Hoài Phong  on 05/10/2020: Không load hóa đơn theo bộ trong bán hàng
---- Modified by Văn Tài	 on 26/11/2020: Điều chỉnh thứ tự câu lệnh @sSQLPer sau sSQLFrom.
---- Modified by Đức Thông on 05/01/2021: [Phúc Long] 2021/01/IS/0024: Bổ sung lọc theo mã hàng trên lưới detail
---- Modified by Huỳnh Thử on 19/01/2021: Cải tiến tốc độ: Đưa vào bảng tạm rồi truy vấn vào bản tạm, trách tình trạng subquery trực tiếp vào bảng AT9000
---- Modified by Xuân Nguyên on 19/04/2022:  [2022/04/IS/0117] Bổ sung cột ReVoucherNo
---- Modified by Xuân Nguyên on 28/04/2022:  [VIMEC][2022/04/IS/0214] Lấy diễn giải từ BDescription
---- Modified by Nhựt Trường on 28/06/2022: [2022/06/IS/0181] - Điều chỉnh lại tên bảng khi gọi trường ReVoucherNo.
---- Modified by Nhưt Trường on 17/08/2022: [2022/08/IS/0137] - Bổ sung thêm điều kiện DivisionID khi join các bảng dùng chung.
---- Modified by Đức Tuyên on 13/10/2022: Bổ sung lấy mã số thuế cho khách hàng vãng lai.
---- Modified by Thành Sang on 07/11/2022: Bổ sung kiều kiện DivisionID khi JOIN bảng AT1011.
---- Modified by Thành Sang on 08/02/2023: Bỏ qua điều kiện lọc theo Kỳ khi truy vấn

-- <Example>
---- 
-- <Summary>

CREATE PROCEDURE AP0093
    @DivisionID NVARCHAR(50),
    @TranMonth INT,
    @TranYear INT,
    @FromDate DATETIME,
    @ToDate DATETIME,
    @ConditionVT NVARCHAR(1000),
    @IsUsedConditionVT NVARCHAR(1000),
    @ConditionAC NVARCHAR(1000),
    @IsUsedConditionAC NVARCHAR(1000),
    @ConditionOB NVARCHAR(1000),
    @IsUsedConditionOB NVARCHAR(1000),
    @ObjectID NVARCHAR(50),
    @UserID VARCHAR(50) = '',
	@InventoryID NVARCHAR(250) = ''
AS
DECLARE @sSQL NVARCHAR(MAX),
        @sSQLFrom NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX),
        @sGroup NVARCHAR(MAX),
        @sSQL0 NVARCHAR(MAX),
        @sSQL1 NVARCHAR(MAX),
        @sSQL2 NVARCHAR(MAX),
		@sSQL_Thu NVARCHAR(Max)


----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
DECLARE @sSQLPer NVARCHAR(1000),
        @sWHEREPer NVARCHAR(1000),
        @CustomerIndex INT
SET @sSQLPer = ''
SET @sWHEREPer = ''
SET @sSQL2 = ''

CREATE TABLE #CustomerName
(
    CustomerName INT,
    ImportExcel INT
)
INSERT #CustomerName
EXEC AP4444
SET @CustomerIndex =
(
    SELECT TOP 1 CustomerName FROM #CustomerName
)

IF @CustomerIndex = 32
BEGIN
    EXEC AP0093_PL @DivisionID,
                   @TranMonth,
                   @TranYear,
                   @FromDate,
                   @ToDate,
                   @ConditionVT,
                   @IsUsedConditionVT,
                   @ConditionAC,
                   @IsUsedConditionAC,
                   @ConditionOB,
                   @IsUsedConditionOB,
                   @ObjectID,
                   @UserID,
				   @InventoryID
END
ELSE 
IF @CustomerIndex = 110
BEGIN
	EXEC AP0093_SONGBINH @DivisionID,
						 @TranMonth,
						 @TranYear,
						 @FromDate,
						 @ToDate,
						 @ConditionVT,
						 @IsUsedConditionVT,
						 @ConditionAC,
						 @IsUsedConditionAC,
						 @ConditionOB,
						 @IsUsedConditionOB,
						 @ObjectID,
						 @UserID
END
ELSE
BEGIN
    IF EXISTS
    (
        SELECT TOP 1
               1
        FROM AT0000 WITH (NOLOCK)
        WHERE DefDivisionID = @DivisionID
              AND IsPermissionView = 1
    ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
    BEGIN
        SET @sSQLPer
            = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = A00.DivisionID 
												AND AT0010.AdminUserID = ''' + @UserID
              + ''' 
												AND AT0010.UserID = A00.CreateUserID '
        SET @sWHEREPer = ' AND (A00.CreateUserID = AT0010.UserID
									OR  A00.CreateUserID = ''' + @UserID + ''') '
    END
    -----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		
	SET @sSQL_Thu = N'
			SELECT  A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, A00.ObjectID, A00.TransactionTypeID, RefInfor,
	A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID, A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID
			INTO #Thu
			FROM AT9000 A00 WITH (NOLOCK)
			WHERE A00.TransactionTypeID IN (''T04'', ''T54'') AND A00.TableID <>''AT1326''  
			AND  A00.TableID <>''MT1603''  
			AND A00.DivisionID = ''' + @DivisionID + '''
			AND	(ISNULL(A00.VoucherTypeID,''#'') IN ' + @ConditionVT + ' OR ' + @IsUsedConditionVT
			  + ')
			AND	(ISNULL(A00.DebitAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
			  + ')
			AND	(ISNULL(A00.CreditAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
			  + ')
			AND	(ISNULL(A00.ObjectID,''#'')  IN ' + @ConditionOB + ' OR ' + @IsUsedConditionOB
			  + ')
			AND A00.VoucherDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 21) + ''' AND '''
			  + CONVERT(NVARCHAR(10), @ToDate, 21) + '''
			AND A00.ObjectID LIKE (''' + @ObjectID + ''')
			GROUP BY A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, A00.ObjectID, A00.TransactionTypeID, RefInfor,
	A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID, A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID
	'
    SET @sSQL
        = N'
	SELECT  A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, -- A00.BatchID, 
			A00.ReVoucherID, A00.ReTableID,
			A00.VoucherDate, A00.VoucherNo, A00.Serial, A00.InvoiceNo, (SELECT COUNT(VoucherID) FROM AT1112 A12 WITH (NOLOCK) WHERE A12.DivisionID=A00.DivisionID AND A12.VoucherID=A00.VoucherID) PrintedTimes,
			A00.VoucherTypeID, A00.VATTypeID, A00.InvoiceDate,'+ CASE
                WHEN @CustomerIndex IN ( 31 ) THEN
                    'A00.BDescription'
                ELSE 'A00.VDescription' end +' as VDescription, A00.CurrencyID, 
			MAX(A00.ExchangeRate) AS ExchangeRate,
			SUM(CASE WHEN A00.TransactionTypeID IN (''T04'') THEN OriginalAmount 
				ELSE CASE WHEN A00.TransactionTypeID IN (''T64'') THEN -OriginalAmount ELSE 0 END END) OriginalAmount,
			SUM(CASE WHEN TransactionTypeID IN (''T04'') THEN ConvertedAmount
				ELSE CASE WHEN TransactionTypeID IN (''T64'') THEN -ConvertedAmount ELSE 0 END END) ConvertedAmount,
			(SELECT TOP 1 ObjectID FROM #Thu AT90 WITH (NOLOCK) WHERE AT90.DivisionID = A00.DivisionID AND AT90.VoucherID = A00.VoucherID AND AT90.TransactionTypeID = ''T04'') AS ObjectID, 
			A02.ObjectName,
			CASE
				WHEN A02.IsUpdateName = 1 AND 154 = '+ LTRIM(@CustomerIndex)+' THEN A00.VATNo
				ELSE A02.VATNo
			END AS VATNo,
			A02.[Address], A02.CityID, AT1002.CityName,
			A00.VATObjectID, (CASE WHEN A.IsUpdateName = 0 THEN A.ObjectName ELSE A00.VATObjectName END) VATObjectName,
			A00.DueDate, Convert(Varchar(8000),'''') OrderID, ISNULL(A00.IsStock, 0) IsStock, 
			ISNULL((SELECT SUM(ConvertedAmount) FROM #Thu C WHERE C.VoucherID = A00.VoucherID AND C.TransactionTypeID =''T54''), 0) CommissionAmount,
			SUM(ISNULL(DiscountAmount, 0)) DiscountAmount, SUM(CASE WHEN TransactionTypeID = ''T14'' THEN ConvertedAmount ELSE 0 END) TaxAmount,
			SUM(CASE WHEN A00.TransactionTypeID = ''T14'' THEN OriginalAmount ELSE 0 END) TaxOriginalAmount, --Tiền thuế quy đổi 
			A06.WareHouseID, A00.CreateUserID,
			(SELECT TOP 1 ISNULL(A90.RefInfor,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.RefInfor,'''') <> '''') as RefInfor
			'
          + CASE
                WHEN @CustomerIndex IN ( 69, 16, 74 ) THEN
                    ''
                ELSE
                    CASE
                        WHEN @CustomerIndex IN ( 52 ) THEN
                            ',
					(SELECT TOP 1 ISNULL(A90.Ana02ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana02ID,'''') <> '''') as Ana02ID,
					(SELECT TOP 1 ISNULL(A90.Ana05ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana05ID,'''') <> '''') as Ana05ID'
                        ELSE
                            ',
					(SELECT TOP 1 ISNULL(A90.Ana01ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana01ID,'''') <> '''') as Ana01ID,
					(SELECT TOP 1 ISNULL(A90.Ana02ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana02ID,'''') <> '''') as Ana02ID,
					(SELECT TOP 1 ISNULL(A90.Ana03ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana03ID,'''') <> '''') as Ana03ID,
					(SELECT TOP 1 ISNULL(A90.Ana04ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana04ID,'''') <> '''') as Ana04ID,
					(SELECT TOP 1 ISNULL(A90.Ana05ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana05ID,'''') <> '''') as Ana05ID,
					(SELECT TOP 1 ISNULL(A90.Ana06ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana06ID,'''') <> '''') as Ana06ID,
					(SELECT TOP 1 ISNULL(A90.Ana07ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana07ID,'''') <> '''') as Ana07ID,
					(SELECT TOP 1 ISNULL(A90.Ana08ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana08ID,'''') <> '''') as Ana08ID,
					(SELECT TOP 1 ISNULL(A90.Ana09ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana09ID,'''') <> '''') as Ana09ID,
					(SELECT TOP 1 ISNULL(A90.Ana10ID,'''') FROM #Thu A90 WITH (NOLOCK) WHERE A90.VoucherID = A00.VoucherID and ISNULL(A90.Ana10ID,'''') <> '''') as Ana10ID'
                    END
            END + '
			'
          + CASE
                WHEN @CustomerIndex = 44 THEN
                    ''
                ELSE
                    +',
				A00.Parameter01, A00.Parameter02, A00.Parameter03, A00.Parameter04, A00.Parameter05,
				A00.Parameter06, A00.Parameter07, A00.Parameter08, A00.Parameter09, A00.Parameter10		
	'
            END + '
			INTO #TEMP'
    SET @sSQLFrom
        = '	
	FROM AT9000 A00 WITH (NOLOCK)
		LEFT JOIN AT2006 A06 WITH (NOLOCK) ON A06.DivisionID = A00.DivisionID AND A06.VoucherID = A00.VoucherID
		LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A02.ObjectID = (SELECT TOP 1 ObjectID FROM #Thu AT90 WITH (NOLOCK) WHERE AT90.DivisionID = A00.DivisionID AND AT90.VoucherID = A00.VoucherID AND AT90.TransactionTypeID = ''T04'')
		LEFT JOIN AT1202 A WITH (NOLOCK) ON A.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A.ObjectID = A00.VATObjectID  
		LEFT JOIN AT1002 WITH (NOLOCK) ON AT1002.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1002.CityID = A02.CityID  										
	'
    SET @sWhere
        = N'
	WHERE A00.TransactionTypeID IN (''T04'', ''T14'',''T64'') AND A00.TableID <>''AT1326''  
	    AND  A00.TableID <>''MT1603''  
		AND A00.DivisionID = ''' + @DivisionID + '''
		AND	(ISNULL(A00.VoucherTypeID,''#'') IN ' + @ConditionVT + ' OR ' + @IsUsedConditionVT
          + ')
		AND	(ISNULL(A00.DebitAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
          + ')
		AND	(ISNULL(A00.CreditAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
          + ')
		AND	(ISNULL(A00.ObjectID,''#'')  IN ' + @ConditionOB + ' OR ' + @IsUsedConditionOB
          + ')
		AND A00.VoucherDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 21) + ''' AND '''
          + CONVERT(NVARCHAR(10), @ToDate, 21) + '''
		AND A00.ObjectID LIKE (''' + @ObjectID + ''')
	' + @sWHEREPer + ''

    SET @sGroup
        = N'
	GROUP BY A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, -- A00.BatchID, 
		A00.ReVoucherID, A00.ReTableID,
		A00.VoucherDate, A00.VoucherNo, A00.Serial, A00.InvoiceNo, A00.VoucherTypeID, A00.VATTypeID, A00.InvoiceDate,A00.BDescription,
		A00.VDescription, A00.CurrencyID, -- A00.ExchangeRate, 
		A02.ObjectName,
		CASE
			WHEN A02.IsUpdateName = 1 AND 154 = '+ LTRIM(@CustomerIndex)+' THEN A00.VATNo
			ELSE A02.VATNo
		END,
		A02.[Address],
		A02.CityID, AT1002.CityNAme, A00.DueDate, A02.IsUpdateName, A00.VATObjectName, ISNULL(IsStock, 0),
		A00.VATObjectID, A.ObjectName, A.IsUpdateName, A00.CreateUserID, RefInfor, A06.WareHouseID'
          + CASE
                WHEN @CustomerIndex = 44 THEN
                    ''
                ELSE
                    +',
		A00.Parameter01, A00.Parameter02, A00.Parameter03, A00.Parameter04, A00.Parameter05,
		A00.Parameter06, A00.Parameter07, A00.Parameter08, A00.Parameter09, A00.Parameter10'
            END + '
	' + CASE
            WHEN @CustomerIndex = 65 THEN
                ' ORDER BY A00.DivisionID, A00.VoucherTypeID, A00.VoucherDate, A00.VoucherNo'
            ELSE
                ' ORDER BY A00.DivisionID, A00.VoucherDate, A00.VoucherTypeID, A00.VoucherNo'
        END

    --PRINT(@sSQL)
    --PRINT(@sSQLFrom)
    --PRINT(@sSQLPer)
    --PRINT(@sWhere)
    --PRINT(@sWHEREPer)
    --PRINT(@sGroup)
    SET @sSQL0
        = N'
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 T3 WITH(NOLOCK)  WHERE  T3.VoucherID IN (SELECT DISTINCT VoucherID FROM #TEMP ) AND ISNULL(T3.OrderID,'''') <> '''')
		BEGIN
			UPDATE	T1
			SET		T1.OrderID = T2.StrOrderID
			FROM	#TEMP T1
			INNER JOIN
			(
				SELECT	B.DivisionID, B.VoucherID,
						SUBSTRING(
									( SELECT OrderID + '', ''
									FROM
									(SELECT DISTINCT DivisionID, VoucherID, LTRIM(RTRIM(OrderID)) AS OrderID
									FROM AT9000 A WITH (NOLOCK)
									WHERE A.DivisionID = B.DivisionID  AND A.VoucherID = B.VoucherID ) A
									ORDER BY  A.DivisionID, A.VoucherID
									FOR XML PATH ('''')
									)
									,1,								
									LEN(( SELECT OrderID + '', ''
									FROM
									(SELECT DISTINCT DivisionID, VoucherID, LTRIM(RTRIM(OrderID)) AS OrderID
									FROM AT9000 A WITH (NOLOCK)
									WHERE A.DivisionID = B.DivisionID  AND A.VoucherID = B.VoucherID ) A
									ORDER BY  A.DivisionID, A.VoucherID
											FOR XML PATH ('''')
											)) - 1
								) AS StrOrderID
				FROM	#TEMP B WITH (NOLOCK)
				GROUP BY	DivisionID, VoucherID
			) T2 ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID 	
			WHERE EXISTS (SELECT TOP 1 1 FROM AT9000 T3 WITH(NOLOCK)  WHERE T1.VoucherID = T3.VoucherID AND ISNULL(T3.OrderID,'''') <> '''')
		END
	'


    SET @sSQL1
        = '
	SELECT  A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, -- A00.BatchID, 
			A00.ReVoucherID, A00.ReTableID,
			A00.VoucherDate, A00.VoucherNo, A00.Serial, A00.InvoiceNo, A00.PrintedTimes,
			A00.VoucherTypeID, A00.VATTypeID, A00.InvoiceDate, A00.VDescription, A00.CurrencyID, 
			A00.ExchangeRate,
			SUM(A00.OriginalAmount) as OriginalAmount,
			SUM(A00.ConvertedAmount) as ConvertedAmount,
			A00.ObjectID, A00.ObjectName, A00.VATNo, A00.[Address], A00.CityID, A00.CityName,
			A00.VATObjectID, A00.VATObjectName,
			A00.DueDate, A00.OrderID, A00.VoucherNo as ReVoucherNo, A00.IsStock, 
			SUM(A00.CommissionAmount) as CommissionAmount,
			SUM(A00.TaxAmount) as TaxAmount,
			SUM(A00.TaxOriginalAmount) as TaxOriginalAmount, --Tiền thuế quy đổi 
			A00.WareHouseID, A00.CreateUserID,
			A00.RefInfor
			'
          + CASE
                WHEN @CustomerIndex IN ( 69, 16, 74 ) THEN
                    ''
                ELSE
                    CASE
                        WHEN @CustomerIndex IN ( 52 ) THEN
                            ', A00.Ana02ID, A00.Ana05ID, ISNULL(A12.AnaName,'''') Ana02Name, ISNULL(A15.AnaName,'''') Ana05Name'
                        ELSE
                            ',
					A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID,
					A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID,
					ISNULL(A11.AnaName,'''') Ana01Name, ISNULL(A12.AnaName,'''') Ana02Name, ISNULL(A13.AnaName,'''') Ana03Name, ISNULL(A14.AnaName,'''') Ana04Name, ISNULL(A15.AnaName,'''') Ana05Name, 
					ISNULL(A16.AnaName,'''') Ana06Name, ISNULL(A17.AnaName,'''') Ana07Name, ISNULL(A18.AnaName,'''') Ana08Name, ISNULL(A19.AnaName,'''') Ana09Name, ISNULL(A20.AnaName,'''') Ana10Name'
                    END
            END + '
		  '
          + CASE
                WHEN @CustomerIndex = 44 THEN
                    ''
                ELSE
                    +',
			A00.Parameter01, A00.Parameter02, A00.Parameter03, A00.Parameter04, A00.Parameter05,
			A00.Parameter06, A00.Parameter07, A00.Parameter08, A00.Parameter09, A00.Parameter10			 
	 
		'
            END + '
		FROM #TEMP A00
		' + CASE
                WHEN @CustomerIndex IN ( 69, 16, 74 ) THEN
                    ''
                ELSE
                    CASE
                        WHEN @CustomerIndex IN ( 52 ) THEN
                            '
							
				LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.DivisionID = A00.DivisionID AND A12.AnaID = A00.Ana02ID AND A12. AnaTypeID = ''A02''
				LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.DivisionID = A00.DivisionID AND A15.AnaID = A00.Ana05ID AND A15. AnaTypeID = ''A05'' '
                        ELSE
                            'LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.DivisionID = A00.DivisionID AND A11.AnaID = A00.Ana01ID AND A11. AnaTypeID = ''A01'' 
				LEFT JOIN AT1011 A12 WITH (NOLOCK) ON A12.DivisionID = A00.DivisionID AND A12.AnaID = A00.Ana02ID AND A12. AnaTypeID = ''A02''
				LEFT JOIN AT1011 A13 WITH (NOLOCK) ON A13.DivisionID = A00.DivisionID AND A13.AnaID = A00.Ana03ID AND A13. AnaTypeID = ''A03''
				LEFT JOIN AT1011 A14 WITH (NOLOCK) ON A14.DivisionID = A00.DivisionID AND A14.AnaID = A00.Ana04ID AND A14. AnaTypeID = ''A04''
				LEFT JOIN AT1011 A15 WITH (NOLOCK) ON A15.DivisionID = A00.DivisionID AND A15.AnaID = A00.Ana05ID AND A15. AnaTypeID = ''A05''
				LEFT JOIN AT1011 A16 WITH (NOLOCK) ON A16.DivisionID = A00.DivisionID AND A16.AnaID = A00.Ana06ID AND A16. AnaTypeID = ''A06''
				LEFT JOIN AT1011 A17 WITH (NOLOCK) ON A17.DivisionID = A00.DivisionID AND A17.AnaID = A00.Ana07ID AND A17. AnaTypeID = ''A07''
				LEFT JOIN AT1011 A18 WITH (NOLOCK) ON A18.DivisionID = A00.DivisionID AND A18.AnaID = A00.Ana08ID AND A18. AnaTypeID = ''A08''
				LEFT JOIN AT1011 A19 WITH (NOLOCK) ON A19.DivisionID = A00.DivisionID AND A19.AnaID = A00.Ana09ID AND A19. AnaTypeID = ''A09''
				LEFT JOIN AT1011 A20 WITH (NOLOCK) ON A20.DivisionID = A00.DivisionID AND A20.AnaID = A00.Ana10ID AND A20. AnaTypeID = ''A10''
				LEFT JOIN OT2001 WITH (NOLOCK) ON A00.OrderID = OT2001.SOrderID'
                    END
            END + '
	'
    SET @sSQL2
        = '
	GROUP BY A00.DivisionID, A00.TranMonth, A00.TranYear, A00.VoucherID, -- A00.BatchID, 
			A00.ReVoucherID, A00.ReTableID,
			A00.VoucherDate, A00.VoucherNo, A00.Serial, A00.InvoiceNo, A00.PrintedTimes,
			A00.VoucherTypeID, A00.VATTypeID, A00.InvoiceDate, A00.VDescription, A00.CurrencyID, 
			A00.ExchangeRate, A00.VoucherNo,
			A00.ObjectID, A00.ObjectName, A00.VATNo, A00.[Address], A00.CityID, A00.CityName,
			A00.VATObjectID, A00.VATObjectName,
			A00.DueDate, A00.OrderID, A00.IsStock, 
			A00.WareHouseID, A00.CreateUserID,
			A00.RefInfor
			'
          + CASE
                WHEN @CustomerIndex IN ( 69, 16, 74 ) THEN
                    ''
                ELSE
                    CASE
                        WHEN @CustomerIndex IN ( 52 ) THEN
                            ', A00.Ana02ID, A00.Ana05ID, A12.AnaName, A15.AnaName'
                        ELSE
                            ',
						A00.Ana01ID, A00.Ana02ID, A00.Ana03ID, A00.Ana04ID, A00.Ana05ID,
						A00.Ana06ID, A00.Ana07ID, A00.Ana08ID, A00.Ana09ID, A00.Ana10ID,
						A11.AnaName, A12.AnaName, A13.AnaName, A14.AnaName, A15.AnaName,
						A16.AnaName, A17.AnaName, A18.AnaName, A19.AnaName, A20.AnaName'
                    END
            END
          + CASE
                WHEN @CustomerIndex = 44 THEN
                    ''
                ELSE
                    +',
			A00.Parameter01, A00.Parameter02, A00.Parameter03, A00.Parameter04, A00.Parameter05,
			A00.Parameter06, A00.Parameter07, A00.Parameter08, A00.Parameter09, A00.Parameter10		
			'
            END + CASE
                      WHEN @CustomerIndex = 65 THEN
                          ' ORDER BY A00.DivisionID, A00.VoucherTypeID, A00.VoucherDate, A00.VoucherNo'
                      ELSE
                          ' ORDER BY A00.DivisionID, A00.VoucherDate, A00.VoucherTypeID, A00.VoucherNo'
                  END

    PRINT @sSQL_Thu
    PRINT @sSQL
    PRINT @sSQLPer
    PRINT @sSQLFrom
    PRINT @sWhere
    PRINT @sGroup
    PRINT @sSQL0
    PRINT @sSQL1
    PRINT @sSQL2

    EXEC (@sSQL_Thu + @sSQL + @sSQLFrom + @sSQLPer  + @sWhere + @sGroup + @sSQL0 + @sSQL1 + @sSQL2)
END












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
