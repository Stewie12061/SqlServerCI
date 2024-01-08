IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[POP2063]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[POP2063];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

-- <Summary>
---- Kiểm tra âm số lượng mặt hàng khi Book Cont
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 06/08/2003 by Nguyễn Văn Tài
---- 
---- Modified on [dd/MM/yyyy] by [Name]: 
---- Modified on [14/01/2020] by [Văn Tài]: Điều chỉnh Left Join cho trường hợp mặt hàng không sử dụng quy cách.
---- Modified on [24/02/2020] by [Văn Tài]: Bổ sung vòng lặp while bị thiếu cho trường hợp edit.
---- Modified on [25/02/2020] by [Văn Tài]: Bổ sung Set giá trị 0 trong vòng lặp while.
---
/*  exec POP2063
	 @DivisionID=N'TT'
	,@UserID=N'ASOFTADMIN'
	,@APK=N'G00001'
	,@InventoryList=N'P00001'
*/

CREATE PROCEDURE [dbo].[POP2063]
    @DivisionID NVARCHAR(50),
    @UserID NVARCHAR(50),
    @APK NVARCHAR(50),
    @InventoryList AS XML
AS
BEGIN
    -- Xử lý dữ liệu XML
    CREATE TABLE #TBL_Invent2062
    (
        Orders INT NULL,
        SOrderID NVARCHAR(50) NULL,
        SOVoucherNo NVARCHAR(50) NULL,
        InventoryID NVARCHAR(50) NULL,
        InventoryName NVARCHAR(250) NULL,
        Quantity DECIMAL(28, 8) NULL,
        S01ID VARCHAR(50) NULL,
        S02ID VARCHAR(50) NULL,
        S03ID VARCHAR(50) NULL,
        S04ID VARCHAR(50) NULL,
        S05ID VARCHAR(50) NULL,
        S06ID VARCHAR(50) NULL,
        S07ID VARCHAR(50) NULL,
        S08ID VARCHAR(50) NULL,
        S09ID VARCHAR(50) NULL,
        S10ID VARCHAR(50) NULL,
        S11ID VARCHAR(50) NULL,
        S12ID VARCHAR(50) NULL,
        S13ID VARCHAR(50) NULL,
        S14ID VARCHAR(50) NULL,
        S15ID VARCHAR(50) NULL,
        S16ID VARCHAR(50) NULL,
        S17ID VARCHAR(50) NULL,
        S18ID VARCHAR(50) NULL,
        S19ID VARCHAR(50) NULL,
        S20ID VARCHAR(50) NULL
    );

    -- Xoa du lieu hien tai
    DELETE #TBL_Invent2062;

    --- Đổ dữ liệu mới
    INSERT INTO #TBL_Invent2062
    SELECT X.Data.query('Orders').value('.', 'INT') AS Orders,
           X.Data.query('SOrderID').value('.', 'NVARCHAR(50)') AS SOrderID,
           X.Data.query('SOVoucherNo').value('.', 'NVARCHAR(50)') AS SOVoucherNo,
           X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
           X.Data.query('InventoryName').value('.', 'NVARCHAR(150)') AS InventoryName,
           X.Data.query('Quantity').value('.', 'DECIMAL(28, 8)') AS Quantity,
           X.Data.query('S01ID').value('.', 'VARCHAR(50)') AS S01ID,
           X.Data.query('S02ID').value('.', 'VARCHAR(50)') AS S02ID,
           X.Data.query('S03ID').value('.', 'VARCHAR(50)') AS S03ID,
           X.Data.query('S04ID').value('.', 'VARCHAR(50)') AS S04ID,
           X.Data.query('S05ID').value('.', 'VARCHAR(50)') AS S05ID,
           X.Data.query('S06ID').value('.', 'VARCHAR(50)') AS S06ID,
           X.Data.query('S07ID').value('.', 'VARCHAR(50)') AS S07ID,
           X.Data.query('S08ID').value('.', 'VARCHAR(50)') AS S08ID,
           X.Data.query('S09ID').value('.', 'VARCHAR(50)') AS S09ID,
           X.Data.query('S10ID').value('.', 'VARCHAR(50)') AS S10ID,
           X.Data.query('S11ID').value('.', 'VARCHAR(50)') AS S11ID,
           X.Data.query('S12ID').value('.', 'VARCHAR(50)') AS S12ID,
           X.Data.query('S13ID').value('.', 'VARCHAR(50)') AS S13ID,
           X.Data.query('S14ID').value('.', 'VARCHAR(50)') AS S14ID,
           X.Data.query('S15ID').value('.', 'VARCHAR(50)') AS S15ID,
           X.Data.query('S16ID').value('.', 'VARCHAR(50)') AS S16ID,
           X.Data.query('S17ID').value('.', 'VARCHAR(50)') AS S17ID,
           X.Data.query('S18ID').value('.', 'VARCHAR(50)') AS S18ID,
           X.Data.query('S19ID').value('.', 'VARCHAR(50)') AS S19ID,
           X.Data.query('S20ID').value('.', 'VARCHAR(50)') AS S20ID
    FROM @InventoryList.nodes('//Data') AS X(Data);

    --- Bảng message lỗi
    CREATE TABLE #Errors
    (
        SOrderID VARCHAR(50) NULL,
        InventoryID VARCHAR(50) NULL,
		VoucherNo VARCHAR(50) NULL,
        Orders INT NULL,
        MessageID VARCHAR(50) NULL,
        Params NVARCHAR(150) NULL
    );

    DECLARE @Orders INT;
    DECLARE @SOrderID NVARCHAR(50);
    DECLARE @SOVoucherNo NVARCHAR(50);
    DECLARE @InventoryID NVARCHAR(50);
    DECLARE @InventoryName NVARCHAR(250);
    DECLARE @Quantity DECIMAL(28, 8);
    DECLARE @S01ID VARCHAR(50);
    DECLARE @S02ID VARCHAR(50);
    DECLARE @S03ID VARCHAR(50);
    DECLARE @S04ID VARCHAR(50);
    DECLARE @S05ID VARCHAR(50);
    DECLARE @S06ID VARCHAR(50);
    DECLARE @S07ID VARCHAR(50);
    DECLARE @S08ID VARCHAR(50);
    DECLARE @S09ID VARCHAR(50);
    DECLARE @S10ID VARCHAR(50);
    DECLARE @S11ID VARCHAR(50);
    DECLARE @S12ID VARCHAR(50);
    DECLARE @S13ID VARCHAR(50);
    DECLARE @S14ID VARCHAR(50);
    DECLARE @S15ID VARCHAR(50);
    DECLARE @S16ID VARCHAR(50);
    DECLARE @S17ID VARCHAR(50);
    DECLARE @S18ID VARCHAR(50);
    DECLARE @S19ID VARCHAR(50);
    DECLARE @S20ID VARCHAR(50);

    DECLARE @QuantityOT2002 DECIMAL(28, 8);
    DECLARE @QuantityPOT2062 DECIMAL(28, 8);

	-- SELECT * FROM #TBL_Invent2062

    -- Trường hợp thêm mới
    IF (ISNULL(@APK, '') = '')
    BEGIN
        WHILE (EXISTS (SELECT * FROM #TBL_Invent2062))
        BEGIN

			SET @Quantity = 0
			SET @QuantityOT2002 = 0
			SET @QuantityPOT2062 = 0

            SELECT TOP (1)
                   @Orders = T1.Orders,
                   @SOrderID = T1.SOrderID,
                   @SOVoucherNo = T1.SOVoucherNo,
                   @InventoryID = T1.InventoryID,
                   @InventoryName = T1.InventoryName,
                   @S01ID = T1.S01ID,
                   @S02ID = T1.S02ID,
                   @S03ID = T1.S03ID,
                   @S04ID = T1.S04ID,
                   @S05ID = T1.S05ID,
                   @S06ID = T1.S06ID,
                   @S07ID = T1.S07ID,
                   @S08ID = T1.S08ID,
                   @S09ID = T1.S09ID,
                   @S10ID = T1.S10ID,
                   @S11ID = T1.S11ID,
                   @S12ID = T1.S12ID,
                   @S13ID = T1.S13ID,
                   @S14ID = T1.S14ID,
                   @S15ID = T1.S15ID,
                   @S16ID = T1.S16ID,
                   @S17ID = T1.S17ID,
                   @S18ID = T1.S18ID,
                   @S19ID = T1.S19ID,
                   @S20ID = T1.S20ID
            FROM #TBL_Invent2062 T1
            ORDER BY T1.Orders;

            SELECT @Quantity = SUM(T1.Quantity)
            FROM #TBL_Invent2062 T1
            WHERE T1.SOrderID = @SOrderID
                  AND T1.SOVoucherNo = @SOVoucherNo
                  AND T1.InventoryID = @InventoryID
                  AND ISNULL(T1.S01ID, '') = ISNULL(@S01ID, '')
                  AND ISNULL(T1.S02ID, '') = ISNULL(@S02ID, '')
                  AND ISNULL(T1.S03ID, '') = ISNULL(@S03ID, '')
                  AND ISNULL(T1.S04ID, '') = ISNULL(@S04ID, '')
                  AND ISNULL(T1.S05ID, '') = ISNULL(@S05ID, '')
                  AND ISNULL(T1.S06ID, '') = ISNULL(@S06ID, '')
                  AND ISNULL(T1.S07ID, '') = ISNULL(@S07ID, '')
                  AND ISNULL(T1.S08ID, '') = ISNULL(@S08ID, '')
                  AND ISNULL(T1.S09ID, '') = ISNULL(@S09ID, '')
                  AND ISNULL(T1.S10ID, '') = ISNULL(@S10ID, '')
                  AND ISNULL(T1.S11ID, '') = ISNULL(@S11ID, '')
                  AND ISNULL(T1.S12ID, '') = ISNULL(@S12ID, '')
                  AND ISNULL(T1.S13ID, '') = ISNULL(@S13ID, '')
                  AND ISNULL(T1.S14ID, '') = ISNULL(@S14ID, '')
                  AND ISNULL(T1.S15ID, '') = ISNULL(@S15ID, '')
                  AND ISNULL(T1.S16ID, '') = ISNULL(@S16ID, '')
                  AND ISNULL(T1.S17ID, '') = ISNULL(@S17ID, '')
                  AND ISNULL(T1.S18ID, '') = ISNULL(@S18ID, '')
                  AND ISNULL(T1.S19ID, '') = ISNULL(@S19ID, '')
                  AND ISNULL(T1.S20ID, '') = ISNULL(@S20ID, '')
            GROUP BY T1.SOVoucherNo,
                     T1.InventoryID;

            SELECT @QuantityOT2002 = SUM(T2.OrderQuantity)
            FROM OT2002 T2 WITH (NOLOCK)
                LEFT JOIN OT8899 T99 WITH (NOLOCK)
                    ON T99.VoucherID = T2.SOrderID
                       AND T99.TransactionID = T2.TransactionID
            WHERE T2.DivisionID = @DivisionID
                  AND T2.SOrderID = @SOrderID
                  AND T2.InventoryID = @InventoryID
                  AND ISNULL(T99.S01ID, '') = ISNULL(@S01ID, '')
                  AND ISNULL(T99.S02ID, '') = ISNULL(@S02ID, '')
                  AND ISNULL(T99.S03ID, '') = ISNULL(@S03ID, '')
                  AND ISNULL(T99.S04ID, '') = ISNULL(@S04ID, '')
                  AND ISNULL(T99.S05ID, '') = ISNULL(@S05ID, '')
                  AND ISNULL(T99.S06ID, '') = ISNULL(@S06ID, '')
                  AND ISNULL(T99.S07ID, '') = ISNULL(@S07ID, '')
                  AND ISNULL(T99.S08ID, '') = ISNULL(@S08ID, '')
                  AND ISNULL(T99.S09ID, '') = ISNULL(@S09ID, '')
                  AND ISNULL(T99.S10ID, '') = ISNULL(@S10ID, '')
                  AND ISNULL(T99.S11ID, '') = ISNULL(@S11ID, '')
                  AND ISNULL(T99.S12ID, '') = ISNULL(@S12ID, '')
                  AND ISNULL(T99.S13ID, '') = ISNULL(@S13ID, '')
                  AND ISNULL(T99.S14ID, '') = ISNULL(@S14ID, '')
                  AND ISNULL(T99.S15ID, '') = ISNULL(@S15ID, '')
                  AND ISNULL(T99.S16ID, '') = ISNULL(@S16ID, '')
                  AND ISNULL(T99.S17ID, '') = ISNULL(@S17ID, '')
                  AND ISNULL(T99.S18ID, '') = ISNULL(@S18ID, '')
                  AND ISNULL(T99.S19ID, '') = ISNULL(@S19ID, '')
                  AND ISNULL(T99.S20ID, '') = ISNULL(@S20ID, '')
            GROUP BY T2.SOrderID;

            SELECT @QuantityPOT2062 = SUM(T2.Quantity)
            FROM dbo.POT2062 T2 WITH (NOLOCK)
			INNER JOIN dbo.POT2061 T61 WITH (NOLOCK) ON T61.DivisionID = T2.DivisionID
										AND T61.APK = T2.APKMaster
            WHERE T61.DeleteFlag = 0
				  AND T2.DivisionID = @DivisionID
                  AND T2.SOrderID = @SOrderID
                  AND T2.InventoryID = @InventoryID
                  AND ISNULL(T2.S01ID, '') = ISNULL(@S01ID, '')
                  AND ISNULL(T2.S02ID, '') = ISNULL(@S02ID, '')
                  AND ISNULL(T2.S03ID, '') = ISNULL(@S03ID, '')
                  AND ISNULL(T2.S04ID, '') = ISNULL(@S04ID, '')
                  AND ISNULL(T2.S05ID, '') = ISNULL(@S05ID, '')
                  AND ISNULL(T2.S06ID, '') = ISNULL(@S06ID, '')
                  AND ISNULL(T2.S07ID, '') = ISNULL(@S07ID, '')
                  AND ISNULL(T2.S08ID, '') = ISNULL(@S08ID, '')
                  AND ISNULL(T2.S09ID, '') = ISNULL(@S09ID, '')
                  AND ISNULL(T2.S10ID, '') = ISNULL(@S10ID, '')
                  AND ISNULL(T2.S11ID, '') = ISNULL(@S11ID, '')
                  AND ISNULL(T2.S12ID, '') = ISNULL(@S12ID, '')
                  AND ISNULL(T2.S13ID, '') = ISNULL(@S13ID, '')
                  AND ISNULL(T2.S14ID, '') = ISNULL(@S14ID, '')
                  AND ISNULL(T2.S15ID, '') = ISNULL(@S15ID, '')
                  AND ISNULL(T2.S16ID, '') = ISNULL(@S16ID, '')
                  AND ISNULL(T2.S17ID, '') = ISNULL(@S17ID, '')
                  AND ISNULL(T2.S18ID, '') = ISNULL(@S18ID, '')
                  AND ISNULL(T2.S19ID, '') = ISNULL(@S19ID, '')
                  AND ISNULL(T2.S20ID, '') = ISNULL(@S20ID, '')
            GROUP BY T2.SOrderID;

			PRINT(ISNULL(@QuantityOT2002, 0))
			PRINT(ISNULL(@QuantityPOT2062, 0))

            --- Không thể xuất vượt quá số lượng.
            IF (@Quantity > ISNULL(@QuantityOT2002, 0) - ISNULL(@QuantityPOT2062, 0))
            BEGIN
                INSERT #Errors
                (
                    SOrderID,
                    InventoryID,
					VoucherNo,
                    Orders,
                    MessageID,
                    Params
                )
                VALUES
                -- Sản phẩm {0} không thể có số lượng xuất khẩu vượt quá {1}.
                (@Orders, @InventoryID, @SOVoucherNo, @Orders, 'POFML000009', ISNULL(@QuantityOT2002, 0) - ISNULL(@QuantityPOT2062, 0));
            END;
			
            --- Mặt hàng đã tính toán
            DELETE #TBL_Invent2062
            WHERE SOrderID = @SOrderID
                  AND SOVoucherNo = @SOVoucherNo
                  AND InventoryID = @InventoryID
                  AND InventoryName = @InventoryName
                  AND ISNULL(S01ID, '') = ISNULL(@S01ID, '')
                  AND ISNULL(S02ID, '') = ISNULL(@S02ID, '')
                  AND ISNULL(S03ID, '') = ISNULL(@S03ID, '')
                  AND ISNULL(S04ID, '') = ISNULL(@S04ID, '')
                  AND ISNULL(S05ID, '') = ISNULL(@S05ID, '')
                  AND ISNULL(S06ID, '') = ISNULL(@S06ID, '')
                  AND ISNULL(S07ID, '') = ISNULL(@S07ID, '')
                  AND ISNULL(S08ID, '') = ISNULL(@S08ID, '')
                  AND ISNULL(S09ID, '') = ISNULL(@S09ID, '')
                  AND ISNULL(S10ID, '') = ISNULL(@S10ID, '')
                  AND ISNULL(S11ID, '') = ISNULL(@S11ID, '')
                  AND ISNULL(S12ID, '') = ISNULL(@S12ID, '')
                  AND ISNULL(S13ID, '') = ISNULL(@S13ID, '')
                  AND ISNULL(S14ID, '') = ISNULL(@S14ID, '')
                  AND ISNULL(S15ID, '') = ISNULL(@S15ID, '')
                  AND ISNULL(S16ID, '') = ISNULL(@S16ID, '')
                  AND ISNULL(S17ID, '') = ISNULL(@S17ID, '')
                  AND ISNULL(S18ID, '') = ISNULL(@S18ID, '')
                  AND ISNULL(S19ID, '') = ISNULL(@S19ID, '')
                  AND ISNULL(S20ID, '') = ISNULL(@S20ID, '');

            --- Lấy thông tin mặt hàng mới
            SELECT TOP (1)
                   @Orders = T1.Orders,
                   @SOrderID = T1.SOrderID,
                   @SOVoucherNo = T1.SOVoucherNo,
                   @InventoryID = T1.InventoryID,
                   @InventoryName = T1.InventoryName,
                   @S01ID = T1.S01ID,
                   @S02ID = T1.S02ID,
                   @S03ID = T1.S03ID,
                   @S04ID = T1.S04ID,
                   @S05ID = T1.S05ID,
                   @S06ID = T1.S06ID,
                   @S07ID = T1.S07ID,
                   @S08ID = T1.S08ID,
                   @S09ID = T1.S09ID,
                   @S10ID = T1.S10ID,
                   @S11ID = T1.S11ID,
                   @S12ID = T1.S12ID,
                   @S13ID = T1.S13ID,
                   @S14ID = T1.S14ID,
                   @S15ID = T1.S15ID,
                   @S16ID = T1.S16ID,
                   @S17ID = T1.S17ID,
                   @S18ID = T1.S18ID,
                   @S19ID = T1.S19ID,
                   @S20ID = T1.S20ID
            FROM #TBL_Invent2062 T1
            ORDER BY T1.Orders;

            SELECT @Quantity = SUM(T1.Quantity)
            FROM #TBL_Invent2062 T1
            WHERE T1.SOrderID = @SOrderID
                  AND T1.SOVoucherNo = @SOVoucherNo
                  AND T1.InventoryID = @InventoryID
                  AND T1.InventoryName = @InventoryName
                  AND ISNULL(T1.S01ID, '') = ISNULL(@S01ID, '')
                  AND ISNULL(T1.S02ID, '') = ISNULL(@S02ID, '')
                  AND ISNULL(T1.S03ID, '') = ISNULL(@S03ID, '')
                  AND ISNULL(T1.S04ID, '') = ISNULL(@S04ID, '')
                  AND ISNULL(T1.S05ID, '') = ISNULL(@S05ID, '')
                  AND ISNULL(T1.S06ID, '') = ISNULL(@S06ID, '')
                  AND ISNULL(T1.S07ID, '') = ISNULL(@S07ID, '')
                  AND ISNULL(T1.S08ID, '') = ISNULL(@S08ID, '')
                  AND ISNULL(T1.S09ID, '') = ISNULL(@S09ID, '')
                  AND ISNULL(T1.S10ID, '') = ISNULL(@S10ID, '')
                  AND ISNULL(T1.S11ID, '') = ISNULL(@S11ID, '')
                  AND ISNULL(T1.S12ID, '') = ISNULL(@S12ID, '')
                  AND ISNULL(T1.S13ID, '') = ISNULL(@S13ID, '')
                  AND ISNULL(T1.S14ID, '') = ISNULL(@S14ID, '')
                  AND ISNULL(T1.S15ID, '') = ISNULL(@S15ID, '')
                  AND ISNULL(T1.S16ID, '') = ISNULL(@S16ID, '')
                  AND ISNULL(T1.S17ID, '') = ISNULL(@S17ID, '')
                  AND ISNULL(T1.S18ID, '') = ISNULL(@S18ID, '')
                  AND ISNULL(T1.S19ID, '') = ISNULL(@S19ID, '')
                  AND ISNULL(T1.S20ID, '') = ISNULL(@S20ID, '')
            GROUP BY T1.SOVoucherNo,
                     T1.InventoryID;
        END;
    END;
    ELSE
    BEGIN

		WHILE (EXISTS (SELECT * FROM #TBL_Invent2062))
			BEGIN

			SET @Quantity = 0
			SET @QuantityOT2002 = 0
			SET @QuantityPOT2062 = 0
			
			SELECT TOP (1)
					   @Orders = T1.Orders,
					   @SOrderID = T1.SOrderID,
					   @SOVoucherNo = T1.SOVoucherNo,
					   @InventoryID = T1.InventoryID,
					   @InventoryName = T1.InventoryName,
					   @S01ID = T1.S01ID,
					   @S02ID = T1.S02ID,
					   @S03ID = T1.S03ID,
					   @S04ID = T1.S04ID,
					   @S05ID = T1.S05ID,
					   @S06ID = T1.S06ID,
					   @S07ID = T1.S07ID,
					   @S08ID = T1.S08ID,
					   @S09ID = T1.S09ID,
					   @S10ID = T1.S10ID,
					   @S11ID = T1.S11ID,
					   @S12ID = T1.S12ID,
					   @S13ID = T1.S13ID,
					   @S14ID = T1.S14ID,
					   @S15ID = T1.S15ID,
					   @S16ID = T1.S16ID,
					   @S17ID = T1.S17ID,
					   @S18ID = T1.S18ID,
					   @S19ID = T1.S19ID,
					   @S20ID = T1.S20ID
			FROM #TBL_Invent2062 T1
			ORDER BY T1.Orders;

			SELECT @Quantity = SUM(T1.Quantity)
			FROM #TBL_Invent2062 T1
			WHERE T1.SOrderID = @SOrderID
					AND T1.SOVoucherNo = @SOVoucherNo
					AND T1.InventoryID = @InventoryID
					AND ISNULL(T1.S01ID, '') = ISNULL(@S01ID, '')
					AND ISNULL(T1.S02ID, '') = ISNULL(@S02ID, '')
					AND ISNULL(T1.S03ID, '') = ISNULL(@S03ID, '')
					AND ISNULL(T1.S04ID, '') = ISNULL(@S04ID, '')
					AND ISNULL(T1.S05ID, '') = ISNULL(@S05ID, '')
					AND ISNULL(T1.S06ID, '') = ISNULL(@S06ID, '')
					AND ISNULL(T1.S07ID, '') = ISNULL(@S07ID, '')
					AND ISNULL(T1.S08ID, '') = ISNULL(@S08ID, '')
					AND ISNULL(T1.S09ID, '') = ISNULL(@S09ID, '')
					AND ISNULL(T1.S10ID, '') = ISNULL(@S10ID, '')
					AND ISNULL(T1.S11ID, '') = ISNULL(@S11ID, '')
					AND ISNULL(T1.S12ID, '') = ISNULL(@S12ID, '')
					AND ISNULL(T1.S13ID, '') = ISNULL(@S13ID, '')
					AND ISNULL(T1.S14ID, '') = ISNULL(@S14ID, '')
					AND ISNULL(T1.S15ID, '') = ISNULL(@S15ID, '')
					AND ISNULL(T1.S16ID, '') = ISNULL(@S16ID, '')
					AND ISNULL(T1.S17ID, '') = ISNULL(@S17ID, '')
					AND ISNULL(T1.S18ID, '') = ISNULL(@S18ID, '')
					AND ISNULL(T1.S19ID, '') = ISNULL(@S19ID, '')
					AND ISNULL(T1.S20ID, '') = ISNULL(@S20ID, '')
			GROUP BY T1.SOVoucherNo,
						T1.InventoryID;

			SELECT @QuantityOT2002 = SUM(ISNULL(T2.OrderQuantity,0))
			FROM OT2002 T2 WITH (NOLOCK)
				LEFT JOIN OT8899 T99 WITH(NOLOCK)
					ON T99.VoucherID = T2.SOrderID
					   AND T99.TransactionID = T2.TransactionID
			WHERE T2.DivisionID = @DivisionID
				  AND T2.SOrderID = @SOrderID
				  AND T2.InventoryID = @InventoryID
				  AND ISNULL(T99.S01ID, '') = ISNULL(@S01ID, '')
				  AND ISNULL(T99.S02ID, '') = ISNULL(@S02ID, '')
				  AND ISNULL(T99.S03ID, '') = ISNULL(@S03ID, '')
				  AND ISNULL(T99.S04ID, '') = ISNULL(@S04ID, '')
				  AND ISNULL(T99.S05ID, '') = ISNULL(@S05ID, '')
				  AND ISNULL(T99.S06ID, '') = ISNULL(@S06ID, '')
				  AND ISNULL(T99.S07ID, '') = ISNULL(@S07ID, '')
				  AND ISNULL(T99.S08ID, '') = ISNULL(@S08ID, '')
				  AND ISNULL(T99.S09ID, '') = ISNULL(@S09ID, '')
				  AND ISNULL(T99.S10ID, '') = ISNULL(@S10ID, '')
				  AND ISNULL(T99.S11ID, '') = ISNULL(@S11ID, '')
				  AND ISNULL(T99.S12ID, '') = ISNULL(@S12ID, '')
				  AND ISNULL(T99.S13ID, '') = ISNULL(@S13ID, '')
				  AND ISNULL(T99.S14ID, '') = ISNULL(@S14ID, '')
				  AND ISNULL(T99.S15ID, '') = ISNULL(@S15ID, '')
				  AND ISNULL(T99.S16ID, '') = ISNULL(@S16ID, '')
				  AND ISNULL(T99.S17ID, '') = ISNULL(@S17ID, '')
				  AND ISNULL(T99.S18ID, '') = ISNULL(@S18ID, '')
				  AND ISNULL(T99.S19ID, '') = ISNULL(@S19ID, '')
				  AND ISNULL(T99.S20ID, '') = ISNULL(@S20ID, '')
			GROUP BY T2.SOrderID;

			--- Lấy tổng Quantity và loại trừ phiếu đang Edit bằng APK
			SELECT @QuantityPOT2062 = SUM(ISNULL(T2.Quantity, 0))
			FROM dbo.POT2062 T2 WITH (NOLOCK)
			INNER JOIN dbo.POT2061 T61 WITH (NOLOCK) ON T61.DivisionID = T2.DivisionID
										AND T61.APK = T2.APKMaster
			WHERE T61.DeleteFlag = 0
				  AND T2.DivisionID = @DivisionID
				  AND T2.APKMaster <> @APK
				  AND T2.SOrderID = @SOrderID
				  AND T2.InventoryID = @InventoryID
				  AND ISNULL(T2.S01ID, '') = ISNULL(@S01ID, '')
				  AND ISNULL(T2.S02ID, '') = ISNULL(@S02ID, '')
				  AND ISNULL(T2.S03ID, '') = ISNULL(@S03ID, '')
				  AND ISNULL(T2.S04ID, '') = ISNULL(@S04ID, '')
				  AND ISNULL(T2.S05ID, '') = ISNULL(@S05ID, '')
				  AND ISNULL(T2.S06ID, '') = ISNULL(@S06ID, '')
				  AND ISNULL(T2.S07ID, '') = ISNULL(@S07ID, '')
				  AND ISNULL(T2.S08ID, '') = ISNULL(@S08ID, '')
				  AND ISNULL(T2.S09ID, '') = ISNULL(@S09ID, '')
				  AND ISNULL(T2.S10ID, '') = ISNULL(@S10ID, '')
				  AND ISNULL(T2.S11ID, '') = ISNULL(@S11ID, '')
				  AND ISNULL(T2.S12ID, '') = ISNULL(@S12ID, '')
				  AND ISNULL(T2.S13ID, '') = ISNULL(@S13ID, '')
				  AND ISNULL(T2.S14ID, '') = ISNULL(@S14ID, '')
				  AND ISNULL(T2.S15ID, '') = ISNULL(@S15ID, '')
				  AND ISNULL(T2.S16ID, '') = ISNULL(@S16ID, '')
				  AND ISNULL(T2.S17ID, '') = ISNULL(@S17ID, '')
				  AND ISNULL(T2.S18ID, '') = ISNULL(@S18ID, '')
				  AND ISNULL(T2.S19ID, '') = ISNULL(@S19ID, '')
				  AND ISNULL(T2.S20ID, '') = ISNULL(@S20ID, '')
			GROUP BY T2.SOrderID;

			IF(ISNULL(@QuantityOT2002 , 0) = 0)
				SET @QuantityOT2002 = 0

			IF(ISNULL(@QuantityPOT2062, 0) = 0)
				SET @QuantityPOT2062 = 0
		
			PRINT(@QuantityOT2002)
			PRINT(@QuantityPOT2062)		

			--- Không thể xuất vượt quá số lượng {0}.
			IF (@Quantity > @QuantityOT2002 - @QuantityPOT2062)
			BEGIN
				INSERT #Errors
				(
					SOrderID,
					InventoryID,
					VoucherNo,
					Orders,
					MessageID,
					Params
				)
				VALUES
				-- Sản phẩm {0} không thể có số lượng xuất khẩu vượt quá {1}.
				(@Orders, @InventoryID, @SOVoucherNo, @Orders, 'POFML000009', ISNULL(@QuantityOT2002 - @QuantityPOT2062, 0));
			END;
						
			--- Mặt hàng đã tính toán
			DELETE #TBL_Invent2062
			WHERE SOrderID = @SOrderID
				  AND SOVoucherNo = @SOVoucherNo
				  AND InventoryID = @InventoryID
				  AND InventoryName = @InventoryName
				  AND ISNULL(S01ID, '') = ISNULL(@S01ID, '')
				  AND ISNULL(S02ID, '') = ISNULL(@S02ID, '')
				  AND ISNULL(S03ID, '') = ISNULL(@S03ID, '')
				  AND ISNULL(S04ID, '') = ISNULL(@S04ID, '')
				  AND ISNULL(S05ID, '') = ISNULL(@S05ID, '')
				  AND ISNULL(S06ID, '') = ISNULL(@S06ID, '')
				  AND ISNULL(S07ID, '') = ISNULL(@S07ID, '')
				  AND ISNULL(S08ID, '') = ISNULL(@S08ID, '')
				  AND ISNULL(S09ID, '') = ISNULL(@S09ID, '')
				  AND ISNULL(S10ID, '') = ISNULL(@S10ID, '')
				  AND ISNULL(S11ID, '') = ISNULL(@S11ID, '')
				  AND ISNULL(S12ID, '') = ISNULL(@S12ID, '')
				  AND ISNULL(S13ID, '') = ISNULL(@S13ID, '')
				  AND ISNULL(S14ID, '') = ISNULL(@S14ID, '')
				  AND ISNULL(S15ID, '') = ISNULL(@S15ID, '')
				  AND ISNULL(S16ID, '') = ISNULL(@S16ID, '')
				  AND ISNULL(S17ID, '') = ISNULL(@S17ID, '')
				  AND ISNULL(S18ID, '') = ISNULL(@S18ID, '')
				  AND ISNULL(S19ID, '') = ISNULL(@S19ID, '')
				  AND ISNULL(S20ID, '') = ISNULL(@S20ID, '');

			--- Lấy thông tin mặt hàng mới
			SELECT TOP (1)
				   @Orders = T1.Orders,
				   @SOrderID = T1.SOrderID,
				   @SOVoucherNo = T1.SOVoucherNo,
				   @InventoryID = T1.InventoryID,
				   @InventoryName = T1.InventoryName,
				   @S01ID = T1.S01ID,
				   @S02ID = T1.S02ID,
				   @S03ID = T1.S03ID,
				   @S04ID = T1.S04ID,
				   @S05ID = T1.S05ID,
				   @S06ID = T1.S06ID,
				   @S07ID = T1.S07ID,
				   @S08ID = T1.S08ID,
				   @S09ID = T1.S09ID,
				   @S10ID = T1.S10ID,
				   @S11ID = T1.S11ID,
				   @S12ID = T1.S12ID,
				   @S13ID = T1.S13ID,
				   @S14ID = T1.S14ID,
				   @S15ID = T1.S15ID,
				   @S16ID = T1.S16ID,
				   @S17ID = T1.S17ID,
				   @S18ID = T1.S18ID,
				   @S19ID = T1.S19ID,
				   @S20ID = T1.S20ID
			FROM #TBL_Invent2062 T1
			ORDER BY T1.Orders;

			SELECT @Quantity = SUM(T1.Quantity)
			FROM #TBL_Invent2062 T1
			WHERE T1.SOrderID = @SOrderID
				  AND T1.SOVoucherNo = @SOVoucherNo
				  AND T1.InventoryID = @InventoryID
				  AND T1.InventoryName = @InventoryName
				  AND ISNULL(T1.S01ID, '') = ISNULL(@S01ID, '')
				  AND ISNULL(T1.S02ID, '') = ISNULL(@S02ID, '')
				  AND ISNULL(T1.S03ID, '') = ISNULL(@S03ID, '')
				  AND ISNULL(T1.S04ID, '') = ISNULL(@S04ID, '')
				  AND ISNULL(T1.S05ID, '') = ISNULL(@S05ID, '')
				  AND ISNULL(T1.S06ID, '') = ISNULL(@S06ID, '')
				  AND ISNULL(T1.S07ID, '') = ISNULL(@S07ID, '')
				  AND ISNULL(T1.S08ID, '') = ISNULL(@S08ID, '')
				  AND ISNULL(T1.S09ID, '') = ISNULL(@S09ID, '')
				  AND ISNULL(T1.S10ID, '') = ISNULL(@S10ID, '')
				  AND ISNULL(T1.S11ID, '') = ISNULL(@S11ID, '')
				  AND ISNULL(T1.S12ID, '') = ISNULL(@S12ID, '')
				  AND ISNULL(T1.S13ID, '') = ISNULL(@S13ID, '')
				  AND ISNULL(T1.S14ID, '') = ISNULL(@S14ID, '')
				  AND ISNULL(T1.S15ID, '') = ISNULL(@S15ID, '')
				  AND ISNULL(T1.S16ID, '') = ISNULL(@S16ID, '')
				  AND ISNULL(T1.S17ID, '') = ISNULL(@S17ID, '')
				  AND ISNULL(T1.S18ID, '') = ISNULL(@S18ID, '')
				  AND ISNULL(T1.S19ID, '') = ISNULL(@S19ID, '')
				  AND ISNULL(T1.S20ID, '') = ISNULL(@S20ID, '')
			GROUP BY T1.SOVoucherNo,
					 T1.InventoryID;

		END
    END;

    SELECT T1.SOrderID,
           T1.InventoryID,
           T1.VoucherNo,
           T1.Orders,
           T1.MessageID,
           T1.MessageID AS Message,
           T1.Params
    FROM #Errors T1;

END;


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
