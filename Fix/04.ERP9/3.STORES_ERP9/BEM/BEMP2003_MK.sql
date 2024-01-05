IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2003_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2003_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load grid Kế thừa phiếu mua hàng / bút toán tổng hợp (khách hàng MEIKO).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
---- Create by Trọng Kiên on 01/06/2020
---- Modified by Trọng Kiên on 11/06/2020: Kiểm tra nếu Đối tượng là rỗng thì trả về danh sách rỗng
---- Modified by Trọng Kiên on 22/06/2020: Bổ sung tính toán Số tiền còn lại
---- Modified by Vĩnh Tâm on 18/11/2020: Bổ sung điều kiện loại các Phiếu đề nghị đã bị xóa
---- Modified by Vĩnh Tâm on 11/12/2020: Load bổ sung cột Tài khoản có và Nhóm tài khoản tương ứng từ BTTH/PMH
---- Modified by Vĩnh Tâm on 03/02/2021: Load bổ sung cột Tỉ giá của phiếu công nợ - PaymentExchangeRate
---- Modified by Đình Ly on 25/03/2021: Load bổ sung cột Số PO - OrderID
---- Modified by Nhựt Trường on 22/06/2021: Cải tiến tốc độ.
---- Modified by Nhựt Trường on 25/06/2021: Bỏ trường Description do khách hàng nhập 2 diễn giải hóa đơn nên ko sum được số tiền cùng chứng từ.
---- Modified by Huỳnh Thử on 29/06/2021: Load bổ sung cột Số Số Hóa Đơn - InvoiceNo
---- Modified by Huỳnh Thử on 12/07/2021: Bổ sung load thêm TransactionType = T00
---- Modified by Huỳnh Thử on 12/07/2021: Bổ sung cột APK
---- Modified by Huỳnh Thử on 23/07/2021: select Top 1 APK, Bỏ Group BY APK
---- Modified by Nhựt Trường on 23/08/2021: Bổ sung điều kiện check status <> 2.
---- Modified by Nhựt Trường on 15/09/2021: [2021/09/IS/0086] - Fix lỗi sai số tiền còn lại.
---- Modified by Thu Hoài on 02/03/2022:[2022/02/IS/0134] Bổ sung điều kiện AccountID 
---- Modified by Văn Tài  on 05/05/2022:[2022/01/IS/0194] Trường hợp MAX sau khi group AT0404 để tránh double dòng.
---- Modified by Nhật Thanh  on 29/08/2022: Bổ sung điều kiện order by theo số chứng từ
---- Modified by Nhựt Trường on 20/12/2022:[2022/12/IS/0121] Fix lỗi bị lặp dữ liệu khi làm đề nghị thanh toán nhiều lần.
---- Modified by Kiều Nga on 28/02/2023:[2023/02/TA/0108] Customize MEIKO - Bổ sung điều kiện load theo mã phòng ban khi kế thừa dữ liệu tại màn hình 'Đề nghị thanh toán - BEM'.
/* <Example>
	EXEC [BEMP2003]
		@DivisionID = N'MK', @DivisionIDList = N'', @IsDate = 0, @FromDate = NULL, @ToDate = NULL,
		@FromMonth = 8, @FromYear = 2020, @ToMonth = 11, @ToYear = 2020, @ObjectID = N'VD39',
		@VoucherNo = N'', @CurrencyID = N'', @VoucherTypeInheritID = N'', @PageNumber = 1, @PageSize = 25
 */
CREATE PROCEDURE [dbo].[BEMP2003_MK]
( 
    @DivisionID VARCHAR(50),
    @DivisionIDList NVARCHAR(MAX),
	@UserID VARCHAR(50),
    @IsDate TINYINT, ---- 0: Lọc theo ngày, 1: Lọc theo kỳ
    @FromDate DATETIME,
    @ToDate DATETIME,
    @FromMonth INT,
    @FromYear INT,
    @ToMonth INT,
    @ToYear INT,
    @ObjectID NVARCHAR(250),
    @VoucherNo NVARCHAR(250),
	@OrderID VARCHAR(MAX),
    @CurrencyID NVARCHAR(250),
    @InvoiceNo NVARCHAR(250),
    @VoucherTypeInheritID NVARCHAR(250),
    @PageNumber INT,
    @PageSize INT
)
AS
BEGIN
    DECLARE @sSQL NVARCHAR(MAX) = N'',
			@sSQL2 NVARCHAR(MAX) = N'',
			@sSQL3 NVARCHAR(MAX) = N'',
            @OrderBy NVARCHAR(MAX) = N'',
            @TotalRow NVARCHAR(50) = N'',
            @sWhere NVARCHAR(MAX),
			@sWhere_T03 NVARCHAR(MAX),
			@sWhere_T99 NVARCHAR(MAX),
            @sSQLPermission NVARCHAR(MAX),
            @FromDateText NVARCHAR(20),
            @ToDateText NVARCHAR(20),
			@DepartmentID NVARCHAR(50)

    SET @OrderBy = ' N.VoucherNo ASC'
    SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
    SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	SET @DepartmentID = (SELECT TOP 1 DepartmentID FROM AT1103 WHERE EmployeeID = @UserID)
	
    -- Check Para DivisionIDList null then get DivisionID
    IF ISNULL(@DivisionIDList, '') != ''
        SET @sWhere = ' A1.DivisionID IN (''' + @DivisionIDList + ''')'
    ELSE 
        SET @sWhere = ' A1.DivisionID IN (''' + @DivisionID + ''')'
	

    -- Check Para FromDate và ToDate
    IF @IsDate = 0 
    BEGIN
        SET @sWhere = @sWhere + N'AND A1.TranMonth + A1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
    END
    ELSE
    BEGIN
        IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (A1.VoucherDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 120) + '''
            OR A1.InvoiceDate BETWEEN ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''' AND ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''')'
        ELSE IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
            SET @sWhere = @sWhere + N'
            AND (A1.VoucherDate >= ''' + CONVERT(VARCHAR(10), @FromDate, 120) + '''
            OR A1.InvoiceDate >= ''' + CONVERT(VARCHAR(10), @FromDate, 120) + ''')'
        ELSE IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
            SET @sWhere = @sWhere + N'
            AND (A1.VoucherDate <= ''' + CONVERT(VARCHAR(10), @ToDate, 120) + '''
            OR A1.InvoiceDate <= ''' + CONVERT(VARCHAR(10), @ToDate, 120) + ''')'
    END
	    
        IF ISNULL(@VoucherNo, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(A1.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '		
			
        IF ISNULL(@OrderID, '') != ''
            SET @sWhere = @sWhere + ' AND (Case when isnull(A1.OrderID,'''')='''' then AT2007.OrderID else A1.OrderID end) LIKE N''%' + @OrderID + '%'' '	

        IF ISNULL(@VoucherTypeInheritID, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(A1.VoucherTypeID, '''') = ''' + @VoucherTypeInheritID + ''''

        IF ISNULL(@CurrencyID, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(A1.CurrencyID, '''') = ''' + @CurrencyID + ''''

		IF ISNULL(@InvoiceNo, '') != ''
            SET @sWhere = @sWhere + ' AND ISNULL(A1.InvoiceNo, '''') Like ''%' + @InvoiceNo + '%'''

		-- Phòng ban
		IF ISNULL(@DepartmentID, '') != ''
            SET @sWhere = @sWhere + ' AND (ISNULL(A1.DepartmentID, '''') = ''' + @DepartmentID + ''' OR ISNULL(A1.DepartmentID, '''') = '''')'

			-- Bổ sung điều kiện ObjectID không được NULL
		SET @sWhere_T03 = @sWhere + N' AND ISNULL(A1.ObjectID,'''') != '''' ' 
		SET @sWhere_T99 = @sWhere + N' AND ISNULL(A1.CreditObjectID,'''') != '''' ' 

		-- Khi Đối tượng khác rỗng thì thực hiện search theo các điều kiện trên màn hình
        IF ISNULL(@ObjectID, '') != ''
		  Begin
            SET @sWhere_T99 = @sWhere_T99 + ' AND ISNULL(A1.CreditObjectID, '''') = ''' + @ObjectID + ''''
			SET @sWhere_T03 = @sWhere_T03 + ' AND ISNULL(A1.ObjectID, '''') = ''' + @ObjectID + ''''            
		  End

    IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'

    SET @sSQL = @sSQL + N'
        SELECT A1.APK,A1.DivisionID, A1.VoucherNo, A1.VoucherDate, A1.ObjectID, ISNULL(A2.ObjectName, A1.ObjectID) AS ObjectName, A2.Address AS ObjectAddress
                , A1.InvoiceNo, A1.InvoiceDate, A1.Serial AS RingiNo, A1.CurrencyID, ISNULL(A3.CurrencyName, A1.CurrencyID) AS CurrencyName
                , A3.ExchangeRate, A1.ExchangeRate AS PaymentExchangeRate, A1.OriginalAmount
				--, A1.VDescription AS Description
				, A1.CreditAccountID, A4.GroupID, A1.CreateDate
                , A1.OriginalAmount
                    - SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 0, B1.RequestAmount, 0), 0))
                    - SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 1, B1.SpendAmount, 0), 0))
					--- Sum(ISNULL(K.OriginalAmountOffset,0))
                    AS RemainingAmount
				, STUFF(
				 (SELECT DISTINCT ''; '' + (Case when isnull(temp1.OrderID,'''')='''' then AT2007.OrderID else temp1.OrderID end)
				  FROM AT9000 temp1 WITH(NOLOCK)
				  LEFT JOIN  AT2007 WITH (NOLOCK) ON temp1.WTransactionID=At2007.TransactionID and AT2007.DivisionID=temp1.DivisionID
				  WHERE temp1.VoucherID = A1.VoucherID AND temp1.TransactionTypeID IN (''T03'', ''T23'', ''T00'')
				  FOR XML PATH (''''))
				  , 1, 1, '''') AS OrderID
				  , A1.VoucherID, A1.BatchID
				  , ISNULL(K.OriginalAmountOffset,0) AS OriginalAmountOffset
        INTO #Temp
        FROM AT9000 A1 WITH (NOLOCK)
            LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.DivisionID IN (A1.DivisionID, ''@@@'') AND A2.ObjectID = A1.ObjectID
            LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID, ''@@@'') AND A3.CurrencyID = A1.CurrencyID
			LEFT JOIN AT1005 A4 WITH (NOLOCK) ON A1.CreditAccountID = A4.AccountID AND A4.DivisionID IN (A1.DivisionID, ''@@@'') AND ISNULL(A4.Disabled, 0) = 0
			LEFT JOIN (
						SELECT APKDInherited, DeleteFlg, Status,
							   (ISNULL(IIF(ISNULL(Status, 0) = 0, SUM(RequestAmount), 0), 0)) AS RequestAmount,
							   (ISNULL(IIF(ISNULL(Status, 0) = 1, SUM(SpendAmount), 0), 0)) AS SpendAmount
						FROM BEMT2001 WITH(NOLOCK)
						WHERE ISNULL(DeleteFlg, 0) = 0 AND Status <> 2
						GROUP BY APKDInherited, DeleteFlg, Status
			) B1 ON B1.APKDInherited = A1.APK
			LEFT JOIN  AT2007 WITH (NOLOCK) ON A1.WTransactionID=At2007.TransactionID and AT2007.DivisionID=A1.DivisionID
			Left join 
		(
			Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
					sum(OriginalAmount) As OriginalAmountOffset, 
					sum(ConvertedAmount) As ConvertedAmountOffset
			From AT0404	with(nolock)	
			Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
		) K  on A1.DivisionID = K.DivisionID and A1.VoucherID = K.CreditVoucherID
				AND A1.BatchID = K.CreditBatchID AND A1.CreditAccountID = K.AccountID 
				and A1.TableID = K.CreditTableID AND A1.CurrencyID = K.CurrencyID
        WHERE ' + @sWhere_T03 + 'AND A1.TransactionTypeID IN (''T03'', ''T23'', ''T00'') AND A4.GroupID IN (''G04'') AND (A4.AccountID LIKE ''331%'' or A4.AccountID LIKE ''341%''
		or A4.AccountID LIKE ''333%'' or A4.AccountID LIKE ''334%'' or A4.AccountID LIKE ''338%'') --and (A1.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0
        GROUP BY A1.APK,A1.DivisionID, A1.VoucherNo, A1.VoucherDate, A1.ObjectID, A2.ObjectName, A2.Address
                , A1.InvoiceNo, A1.InvoiceDate, A1.Serial, A1.CurrencyID, A3.CurrencyName
                , A3.ExchangeRate, A1.ExchangeRate, A1.OriginalAmount
				--, A1.VDescription
				, A1.CreateDate
                , A1.OriginalAmount, A1.CreditAccountID, A4.GroupID, A1.VoucherID, A1.BatchID
				, K.OriginalAmountOffset

		SELECT * 
		INTO #TempBEMT2013 
		FROM #Temp 
		--WHERE OriginalAmount - OriginalAmountOffset > 0
				'
    SET @sSQL2 = N'
			SELECT A1.APK, A1.DivisionID, A1.VoucherNo, A1.VoucherDate, A1.CreditObjectID as ObjectID, ISNULL(A2.ObjectName, A1.CreditObjectID) AS ObjectName, A2.Address AS ObjectAddress
                , A1.InvoiceNo, A1.InvoiceDate, A1.Serial AS RingiNo, A1.CurrencyID, ISNULL(A3.CurrencyName, A1.CurrencyID) AS CurrencyName
                , A3.ExchangeRate, A1.ExchangeRate AS PaymentExchangeRate, SUM(A1.OriginalAmount) AS OriginalAmount
				--, A1.BDescription AS Description
				, A1.CreditAccountID, A4.GroupID, A1.CreateDate                
                , SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 0, B1.RequestAmount, 0), 0)) AS RequestAmount
                , SUM(ISNULL(IIF(ISNULL(B1.Status, 0) = 1, B1.SpendAmount, 0), 0)) AS SpendAmount
				, MAX(ISNULL(K.OriginalAmountOffset,0)) AS OriginalAmountOffset
				, STUFF(
				 (SELECT DISTINCT ''; '' + OrderID
				  FROM AT9000 temp2 WITH(NOLOCK)
				  WHERE temp2.VoucherID = A1.VoucherID AND temp2.TransactionTypeID IN (''T99'', ''T00'')
				  FOR XML PATH (''''))
				  , 1, 1, '''') AS OrderID
				, A1.VoucherID, A1.BatchID
		INTO #Temp1
        FROM AT9000 A1 WITH (NOLOCK)
            LEFT JOIN AT1202 A2 WITH (NOLOCK) ON A2.DivisionID IN (A1.DivisionID, ''@@@'') AND A2.ObjectID = A1.ObjectID
            LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID, ''@@@'') AND A3.CurrencyID = A1.CurrencyID
			LEFT JOIN AT1005 A4 WITH (NOLOCK) ON A1.CreditAccountID = A4.AccountID AND A4.DivisionID IN (A1.DivisionID, ''@@@'') AND ISNULL(A4.Disabled, 0) = 0
            LEFT JOIN (
						SELECT APKDInherited, DeleteFlg, Status,
							   (ISNULL(IIF(ISNULL(Status, 0) = 0, SUM(RequestAmount), 0), 0)) AS RequestAmount,
							   (ISNULL(IIF(ISNULL(Status, 0) = 1, SUM(SpendAmount), 0), 0)) AS SpendAmount
						FROM BEMT2001 WITH(NOLOCK)
						WHERE ISNULL(DeleteFlg, 0) = 0 AND Status <> 2
						GROUP BY APKDInherited, DeleteFlg, Status
			) B1 ON B1.APKDInherited = A1.APK
			LEFT JOIN  AT2007 WITH (NOLOCK) ON A1.WTransactionID=At2007.TransactionID and AT2007.DivisionID=A1.DivisionID
			Left join 
		(
			Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
					sum(OriginalAmount) As OriginalAmountOffset, 
					sum(ConvertedAmount) As ConvertedAmountOffset
			From AT0404	with(nolock)	
			Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
		) K  on A1.DivisionID = K.DivisionID and A1.VoucherID = K.CreditVoucherID
				AND A1.BatchID = K.CreditBatchID AND A1.CreditAccountID = K.AccountID 
				and A1.TableID = K.CreditTableID AND A1.CurrencyID = K.CurrencyID
        WHERE ' + @sWhere_T99 + 'AND A1.TransactionTypeID IN (''T99'', ''T00'') AND A4.GroupID IN (''G04'') AND (A4.AccountID LIKE ''331%'' or A4.AccountID LIKE ''341%''
		or A4.AccountID LIKE ''333%'' or A4.AccountID LIKE ''334%'' or A4.AccountID LIKE ''338%'') --and (A1.OriginalAmount - ISNULL(K.OriginalAmountOffset,0)) > 0
        
		GROUP BY A1.APK, A1.DivisionID, A1.VoucherNo, A1.VoucherDate, A1.CreditObjectID, A2.ObjectName, A2.Address
                , A1.InvoiceNo, A1.InvoiceDate, A1.Serial, A1.CurrencyID, A3.CurrencyName, A1.OrderID
                , A3.ExchangeRate, A1.ExchangeRate
				--, A1.BDescription
				, A1.CreateDate
                , A1.CreditAccountID, A4.GroupID, A1.VoucherID, A1.BatchID '

SET @sSQL3 = N'	
		INSERT INTO #TempBEMT2013
		SELECT 
				APK, DivisionID, VoucherNo
				, VoucherDate, ObjectID, ObjectName,ObjectAddress
				, InvoiceNo, InvoiceDate, RingiNo, CurrencyID, CurrencyName
				, ExchangeRate, PaymentExchangeRate, OriginalAmount
				, CreditAccountID, GroupID, CreateDate
				, OriginalAmount				
				  - RequestAmount
				  - SpendAmount
				  --- OriginalAmountOffset 
				  AS RemainingAmount
				, OrderID			  
				, VoucherID, BatchID
				, OriginalAmountOffset
		FROM
			(SELECT MAX(APK) AS APK, DivisionID, VoucherNo
				  , VoucherDate, ObjectID, ObjectName,ObjectAddress
				  , InvoiceNo, InvoiceDate, RingiNo, CurrencyID, CurrencyName
				  , ExchangeRate, PaymentExchangeRate, SUM(OriginalAmount) AS OriginalAmount
				  , CreditAccountID, GroupID, CreateDate
				  , RequestAmount
				  , SpendAmount
				  , OriginalAmountOffset
				  , OrderID			  
				  , VoucherID, BatchID
			FROM #Temp1
			GROUP BY DivisionID, VoucherNo
				  , VoucherDate, ObjectID, ObjectName,ObjectAddress
				  , InvoiceNo, InvoiceDate, RingiNo, CurrencyID, CurrencyName
				  , ExchangeRate, PaymentExchangeRate
				  , CreditAccountID, GroupID, CreateDate
				  , RequestAmount
				  , SpendAmount
				  , OriginalAmountOffset
				  , OrderID			  
				  , VoucherID, BatchID				  
			) A
		WHERE OriginalAmount - OriginalAmountOffset > 0

        DECLARE @Count INT
        SELECT @Count = COUNT (*) FROM #TempBEMT2013

	SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow
            , APK
			, N.VoucherNo, N.VoucherDate, N.ObjectID, N.ObjectName, N.ObjectAddress, N.InvoiceNo, N.InvoiceDate
            , N.RingiNo, N.CurrencyID, N.CurrencyName, N.ExchangeRate, N.PaymentExchangeRate
			, SUM(N.OriginalAmount) AS OriginalAmount, SUM(N.RemainingAmount)-ISNULL(MAX(OriginalAmountOffset),0) AS RemainingAmount
            , N.CreditAccountID, N.GroupID, N.OrderID, N.VoucherID, N.BatchID
	FROM (
		SELECT  MAX(M.APK) AS APK, M.DivisionID
			  , M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectName, M.ObjectAddress, M.InvoiceNo, M.InvoiceDate
              , M.RingiNo, M.CurrencyID, M.CurrencyName, M.ExchangeRate, M.PaymentExchangeRate, SUM(M.OriginalAmount) AS OriginalAmount, SUM(M.RemainingAmount) AS RemainingAmount
              , M.CreditAccountID, M.GroupID, M.OrderID, M.VoucherID, M.BatchID
        FROM #TempBEMT2013 M
        GROUP BY M.DivisionID, M.CurrencyID, M.VoucherNo, M.VoucherDate, M.ObjectID, M.ObjectName, M.ObjectAddress, M.InvoiceNo, M.InvoiceDate
              , M.RingiNo, M.CreateDate, M.CurrencyName, M.ExchangeRate, M.PaymentExchangeRate
			  , M.CreditAccountID, M.GroupID, M.OrderID, M.VoucherID, M.BatchID
		) N
	LEFT JOIN 
	(
		Select	AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID,
				sum(OriginalAmount) As OriginalAmountOffset, 
				sum(ConvertedAmount) As ConvertedAmountOffset
		From AT0404	with(nolock)	
		Group by AT0404.DivisionID, AT0404.CreditVoucherID, AT0404.CreditBatchID, AT0404.CreditTableID, AT0404.AccountID, AT0404.CurrencyID
	) K  on N.DivisionID = K.DivisionID and N.VoucherID = K.CreditVoucherID
			AND N.BatchID = K.CreditBatchID AND N.CreditAccountID = K.AccountID 
			AND N.CurrencyID = K.CurrencyID	
	GROUP BY  APK, N.DivisionID
			, N.VoucherNo, N.VoucherDate, N.ObjectID, N.ObjectName, N.ObjectAddress, N.InvoiceNo, N.InvoiceDate
            , N.RingiNo, N.CurrencyID, N.CurrencyName, N.ExchangeRate, N.PaymentExchangeRate
			, N.CreditAccountID, N.GroupID, N.OrderID, N.VoucherID, N.BatchID
		
		HAVING SUM(N.RemainingAmount)-ISNULL(SUM(OriginalAmountOffset),0) > 0
        ORDER BY ' + @OrderBy + '
        OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
        FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	PRINT(@sSQL)
	PRINT(@sSQL2)
	PRINT(@sSQL3)
    EXEC (@sSQL + @sSQL2 + @sSQL3)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
