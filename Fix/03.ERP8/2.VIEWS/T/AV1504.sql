IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1504]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-------  Created by Nguyen Van Nhan, Date 06/10/2003.
----- Purpose: La mot view chet, Dung de hien thi cac but toan khau hao
---- Edited by Nguyen Quoc Huy, Data: 28/03/2007
---- Last Edit : Thuy Tuyen 14/07/2008
---- Edit by B.Anh, date 26/05/2010	Sua loi gia tri con lai len sai
---- Modifile on 03/10/2013 by Le Thi Thu Hien : Tinh lai gia tri nguyen gia ban dau theo gia tri phan bo roi (0021535 )
---- Edit - 29/09/2014 [Tấn Phú]: Bổ sung điều kiện Join AT1503 và AT1504 DebitAccountID
--- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
--- Modify on 01/09/2016 by Phương Thảo: Bổ sung nhóm TK phân bổ số 6
---- Modified by Tiểu Mai on 13/09/2016: Bổ sung kiểm tra TK
---- Modified by Phương Thảo on 16/05/2017: Sửa danh mục dùng chung
---- Modify on 23/01/2018 by Bảo Anh: Sửa cách lấy giá trị còn lại
---- Modify on 18/06/2018 by Bảo Anh: Sửa lỗi không lên được mã và tên TS nếu TK phân bổ bị thay đổi khác với danh mục
---- Modified on 02/07/2019 by Kim Thư: Tính lại nguyên giá và giá trị còn lại theo tỷ lệ nếu 1 TS khấu hao nhiều lần trong tháng cho nhiều phòng ban
---- Modified on 01/10/2019 by Văn Tài: Format sql và mẫu số bằng 1 cho trường hợp tổng DepAmount trong kỳ bằng 0
---- Modified on 01/10/2019 by Văn Tài: Bỏ kiểm tra đối với các AnaID
---- Modified on 15/12/2020 by Hoài Phong: Sửa lỗi  Sai TSCD  sum theo DepAmount và lấy nguyên giá thay đổi ResidualNewValue
---- Modified on 08/01/2021 by Đức Thông:  [NADECO] 2021/01/IS/0095: Kéo thêm DepreciationID ở bảng AT1504 (chi tiết khấu hao) dùng cho xử lí xóa ở màn hình truy vấn Chi tiết khấu hao tài sản cố định
---- Modified on 19/05/2021 by Nhựt Trường: Điều chỉnh lại cách tính giá trị còn lại(RemainAmount).
---- Modified on 18/03/2022 by Nhựt Trường: [2022/03/IS/0157] - Bổ sung điều kiện DivisionID khi join bảng.
---- Modified on 05/04/2022 by Xuân Nguyên: [Angel] - Bổ sung select PeriodID và InventoryID
---- Modified on 08/08/2022 by Kiều Nga: Bổ sung lấy mã phân tích
---- Modified on 01/11/2022 by Nhựt Trường: [2022/10/IS/0206] - Điều chỉnh lại cách tính giá trị còn lại(RemainAmount), lấy AT1506.ConvertedNewAmount thay cho AT1506.ResidualNewValue.

CREATE VIEW [dbo].[AV1504]
AS
SELECT AT1503.AssetID,
       AT1503.AssetName,
       --AT1503.ConvertedAmount,
       ROUND(
                (CASE
                     WHEN EXISTS
                          (
                              SELECT TOP 1
                                     AssetID
                              FROM AT1506 WITH (NOLOCK)
                              WHERE AT1506.AssetID = AT1504.AssetID
                                    AND AT1506.DivisionID = AT1504.DivisionID
                                    AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + 100
                                                                                    * AT1504.TranYear
                          ) THEN
                     (
                         SELECT TOP 1
                                AT1506.ConvertedNewAmount
                         FROM AT1506 WITH (NOLOCK)
                         WHERE AT1506.AssetID = AT1504.AssetID
                               AND AT1506.DivisionID = AT1504.DivisionID
                               AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + 100 * AT1504.TranYear
                         ORDER BY AT1506.Tranyear DESC,
                                  AT1506.Tranmonth DESC
                     )
                     ELSE
                         AT1503.ConvertedAmount
                 END
                ) * AT1504.DepAmount /
                (
                    SELECT CASE WHEN SUM(DepAmount) = 0 THEN 1 ELSE SUM(DepAmount) END
                    FROM AT1504 A1 WITH (NOLOCK)
                    WHERE A1.DivisionID = AT1504.DivisionID
                          AND A1.AssetID = AT1504.AssetID
                          AND A1.TranMonth = AT1504.TranMonth
                          AND A1.TranYear = AT1504.TranYear
                ),
                0
            ) AS ConvertedAmount,

       --AT1503.DepPercent,
       (CASE
            WHEN EXISTS
                 (
                     SELECT TOP 1
                            AssetID
                     FROM AT1506 WITH (NOLOCK)
                     WHERE AT1506.AssetID = AT1504.AssetID
                           AND AT1506.DivisionID = AT1504.DivisionID
                           AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + 100 * AT1504.TranYear
                 ) THEN
            (
                SELECT TOP 1
                       AT1506.DepNewPercent
                FROM AT1506 WITH (NOLOCK)
                WHERE AT1506.AssetID = AT1504.AssetID
                      AND AT1506.DivisionID = AT1504.DivisionID
                      AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + 100 * AT1504.TranYear
                ORDER BY AT1506.Tranyear DESC,
                         AT1506.Tranmonth DESC
            )
            ELSE
                AT1503.DepPercent
        END
       ) AS DepPercent,
       DepartmentName,     
       AT1504.VoucherDate,
       AT1504.VoucherTypeID,
       AT1504.VoucherNo,
       AT1504.DebitAccountID,
       T01.AccountName AS DebitAccountName,
       AT1504.CreditAccountID,
       T02.AccountName AS CreditAccountName,
       AT1504.DepAmount,
       AT1504.ObjectID,
       AT1504.BDescription,
       (CASE
            WHEN AT1503.BeginMonth < 10 THEN
                '0'
            ELSE
                ''
        END
       ) + LTRIM(RTRIM(STR(AT1503.BeginMonth))) + '/' + LTRIM(RTRIM(STR((AT1503.BeginYear)))) AS BeginMonthYear, 
       AT1504.Status,
       AT1504.TranMonth,
       AT1504.TranYear,
	   AT1504.DepreciationID,
       AT1504.DivisionID,
       --AT1504.CreateUserID,
       --AT1504.CreateDate,
       --AT1504.LastModifyUserID,
       --AT1504.LastModifyDate,

	   ROUND(
	   Case When  
				  EXISTS ( SELECT TOP 1 AssetID FROM AT1506 WITH (NOLOCK)
												WHERE AT1506.AssetID = AT1504.AssetID
													AND AT1506.DivisionID = AT1504.DivisionID
													AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + AT1504.TranYear * 100
                         )
	   THEN 
				  (SELECT TOP 1 AT1506.ConvertedNewAmount FROM AT1506 WITH (NOLOCK)
												  WHERE AT1506.AssetID = AT1504.AssetID
														AND AT1506.DivisionID = AT1504.DivisionID
														AND AT1506.Tranmonth + 100 * AT1506.Tranyear <= AT1504.TranMonth + AT1504.TranYear * 100
												  ORDER BY AT1506.Tranyear DESC,AT1506.Tranmonth DESC)
	   ELSE AT1503.ResidualValue 
	   END 
	   *
	   --- Lấy deppercent của từng tài khoản
	   CASE WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID1,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID1,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID1,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID1,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID1,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID1,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID1,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID1,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID1,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID1,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent1/100 

	   WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID2,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID2,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID2,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID2,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID2,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID2,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID2,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID2,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID2,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID2,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent2/100

	   WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID3,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID3,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID3,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID3,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID3,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID3,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID3,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID3,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID3,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID3,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent3/100

	   WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID4,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID4,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID4,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID4,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID4,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID4,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID4,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID4,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID4,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID4,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent4/100

	   WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID5,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID5,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID5,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID5,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID5,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID5,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID5,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID5,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID5,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID5,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent5/100

	   WHEN EXISTS (SELECT TOP 1 1 FROM AT1503 AT15031 WITH (NOLOCK)
										WHERE AT15031.AssetID = AT1504.AssetID
											  AND AT15031.DivisionID = AT1504.DivisionID
											  AND isnull(AT15031.Ana01ID6,'') = isnull(AT1504.Ana01ID,'')
											  AND isnull(AT15031.Ana02ID6,'') = isnull(AT1504.Ana02ID,'')
											  AND isnull(AT15031.Ana03ID6,'') = isnull(AT1504.Ana03ID,'')
											  AND isnull(AT15031.Ana04ID6,'') = isnull(AT1504.Ana04ID,'')
											  AND isnull(AT15031.Ana05ID6,'') = isnull(AT1504.Ana05ID,'')
											  AND isnull(AT15031.Ana06ID6,'') = isnull(AT1504.Ana06ID,'')
											  AND isnull(AT15031.Ana07ID6,'') = isnull(AT1504.Ana07ID,'')
											  AND isnull(AT15031.Ana08ID6,'') = isnull(AT1504.Ana08ID,'')
											  AND isnull(AT15031.Ana09ID6,'') = isnull(AT1504.Ana09ID,'')
											  AND isnull(AT15031.Ana10ID6,'') = isnull(AT1504.Ana10ID,'')
						)
	   THEN AT1503.DepPercent6/100 END

	   -- Lấy tỉ lệ giá trị khấu hao theo mpt 1 kỳ / giá trị phải khấu hao 1 kỳ
	   * AT1504.DepAmount /
	   (
         SELECT CASE WHEN SUM(DepAmount) = 0 THEN 1 ELSE SUM(DepAmount) END
         FROM AT1504 A1 WITH (NOLOCK)
         WHERE A1.DivisionID = AT1504.DivisionID
               AND A1.AssetID = AT1504.AssetID
			   AND A1.DepreciationID = AT1504.DepreciationID
               AND A1.TranMonth = AT1504.TranMonth
               AND A1.TranYear = AT1504.TranYear
        ) -
		-- Lấy giá trị hao mòn lũy kế đến thời điểm hiện tại theo mpt
		(
		  SELECT SUM(DepAmount)
		  FROM AT1504 BT1504 WITH (NOLOCK)
		  WHERE BT1504.AssetID = AT1504.AssetID
		        AND BT1504.DivisionID = AT1504.DivisionID
		        AND ISNULL(BT1504.DebitAccountID, '') = ISNULL(AT1504.DebitAccountID, '')
		        AND TranMonth + 100 * TranYear <= AT1504.TranMonth + 100 * AT1504.TranYear
			    AND BT1504.SourceID = AT1504.SourceID
			    AND isnull(BT1504.Ana01ID,'') = isnull(AT1504.Ana01ID,'') 
			    AND isnull(BT1504.Ana02ID,'') = isnull(AT1504.Ana02ID,'') 
			    AND isnull(BT1504.Ana03ID,'') = isnull(AT1504.Ana03ID,'') 
			    AND isnull(BT1504.Ana04ID,'') = isnull(AT1504.Ana04ID,'')
		)
		,0) AS RemainAmount,
       AT1504.PeriodID,AT1504.InventoryID
	   ,AT1504.Ana01ID
	   ,AT1504.Ana02ID 
	   ,AT1504.Ana03ID 
	   ,AT1504.Ana04ID 
	   ,AT1504.Ana05ID 
	   ,AT1504.Ana06ID 
	   ,AT1504.Ana07ID 
	   ,AT1504.Ana08ID 
	   ,AT1504.Ana09ID 
	   ,AT1504.Ana10ID
FROM (SELECT DivisionID,  AssetID, VoucherNo, VoucherTypeID, VoucherDate, BDescription,TranMonth, TranYear, SourceID, CreditAccountID, DebitAccountID,
			 SUM(DepAmount) AS DepAmount , DepPercent, DepType, Status, ObjectID, PeriodID,  CoefficientID, MaterialTypeID, DepreciationID,
			 Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,InventoryID
	 FROM AT1504 WITH (NOLOCK)
	 GROUP BY DivisionID,  AssetID, VoucherNo, VoucherTypeID, VoucherDate, BDescription,TranMonth, TranYear, SourceID, CreditAccountID,
			  DebitAccountID, DepPercent, DepType, Status, ObjectID, PeriodID,  CoefficientID, MaterialTypeID, DepreciationID,
			  Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,InventoryID
	) AT1504
    LEFT JOIN AT1503 WITH (NOLOCK)
        ON AT1503.DivisionID = AT1504.DivisionID AND AT1503.AssetID = AT1504.AssetID
    LEFT JOIN AT1102 WITH (NOLOCK)
        ON AT1102.DivisionID = AT1504.DivisionID AND AT1503.DepartmentID = AT1102.DepartmentID
    LEFT JOIN AT1005 T01 WITH (NOLOCK)
        ON T01.DivisionID = AT1504.DivisionID AND T01.AccountID = AT1504.DebitAccountID
    LEFT JOIN AT1005 T02 WITH (NOLOCK)
        ON T02.DivisionID = AT1504.DivisionID AND T02.AccountID = AT1504.CreditAccountID
    LEFT JOIN AT1506 WITH (NOLOCK)
        ON AT1506.DivisionID = AT1504.DivisionID
		   AND AT1506.AssetID = AT1504.AssetID
           AND AT1506.Tranmonth = AT1504.TranMonth
           AND AT1506.Tranyear = AT1504.TranYear
WHERE ISNULL(AT1504.AssetID, '') <> '';

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;