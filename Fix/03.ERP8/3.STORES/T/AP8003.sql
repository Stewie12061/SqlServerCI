IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Kiem tra truoc khi xuat kho Mat hang xuat dich danh
----- Created by Nguyen Van Nhan,Date 18/06/2003
---- Edit by B.Anh, date 01/06/2010	Sua loi canh bao sai khi dung DVT quy doi
---- Modified by Bảo Thy on 04/07/2017: bổ sung cảnh báo vượt số lượng tồn theo chứng từ nhập từ Yêu cầu xuất kho và Phiếu xuất kho (Customize EIMSKIP)
---- Modified by Bảo Thy on 21/07/2017: sửa cách lấy dữ liệu trường hợp xuất kho nhưng kế thừa chưa hết (EIMSKIP)
---- Modified by Bảo Thy on 25/07/2017: Bổ sung @ScreenID
---- Edit by B.Anh, date 03/01/2018	Kiểm tra tồn kho an toàn
---- Modified on 17/07/2018 by Bảo Anh: Sửa lỗi cảnh báo chưa đúng đối với EIMSKIP
---- Modified on 17/9/2018 by Kim Thư: Đưa tất cả mặt hàng cần kiểm tra vào biến XML (cải thiện tốc độ check tồn kho)
---- Modified on 23/10/2018 by Kim Thư: Thay đổi insert table WT8003 check xuất đích danh
---- Modified by Kim Thư on 07/12/2018: Bổ sung cột IsNegativeStock vào bảng báo lỗi -> phân biệt loại message
---- Modified by Văn Tài on 26/11/2019: Fix lỗi kiểm tra cột ReOrderQuantity, ISNULL = 0
---- Modified by Huỳnh Thử on 10/06/2020: Thêm trường hợp lệch xuất kho kế thừa yêu cầu xuất kho
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/
CREATE PROCEDURE [dbo].[AP8003] 	
					@UserID as nvarchar(50),					
					@DivisionID as nvarchar(50),
					@TranMonth as int,
					@TranYear as int, 
					@WareHouseID as nvarchar(50),
					@ScreenID VARCHAR(50) = ''		
AS

Set Nocount on 
	
Delete AT8003 Where UserID =@UserID AND DivisionID = @DivisionID
Delete AT7777 Where UserID =@UserID AND DivisionID = @DivisionID
Delete AT7778 Where UserID =@UserID AND DivisionID = @DivisionID

INSERT INTO AT8003 (DivisionID, UserID, ReVoucherID, ReTransactionID,  NewQuantity, OldQuantity)
SELECT @DivisionID, @UserID, ReNewVoucherID,  ReNewTransactionID,  NewQuantity, OldQuantity FROM WT8003
WHERE ReOldVoucherID = ReNewVoucherID and ReOldTransactionID = ReNewTransactionID
and UserID =@UserID AND DivisionID = @DivisionID
	
UPDATE T1
Set T1.EndQuantity = ISNULL((Select sum(EndQuantity) From AT0114 WITH (NOLOCK)
									Where 	DivisionID = @DivisionID 
										AND WareHouseID = @WareHouseID 
										AND InventoryID = T2.InventoryID 
										AND ReVoucherID = T2.ReNewVoucherID 
										AND ReTransactionID =T2.ReNewTransactionID),0)
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID AND T1.DivisionID = T2.DivisionID AND T1.UserID = T2.UserID			
WHERE T2.ReOldVoucherID = T2.ReNewVoucherID and T2.ReOldTransactionID = T2.ReNewTransactionID
and T1.UserID =@UserID AND T1.DivisionID = @DivisionID
-----------------------------------------------------	
--- Truong hop Edit chon lai phieu nhap khac voi phieu truoc do
INSERT INTO AT8003 (DivisionID, UserID, ReVoucherID, ReTransactionID,  NewQuantity, OldQuantity )
SELECT @DivisionID, @UserID, ReNewVoucherID,  ReNewTransactionID,  NewQuantity, 0 FROM WT8003
WHERE NOT(ReOldVoucherID = ReNewVoucherID and ReOldTransactionID = ReNewTransactionID)
and UserID =@UserID AND DivisionID = @DivisionID

UPDATE T1
Set T1.EndQuantity = Isnull((Select sum(EndQuantity) From AT0114 WITH (NOLOCK)
									Where 	DivisionID =@DivisionID and
											WareHouseID =@WareHouseID and
											InventoryID = T2.InventoryID and
											ReVoucherID =T2.ReNewVoucherID and
											ReTransactionID =T2.ReNewTransactionID),0)
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID 
											AND T1.ReTransactionID = T2.ReNewTransactionID 
											AND T1.DivisionID = T2.DivisionID 
											AND T1.UserID = T2.UserID
WHERE NOT(T2.ReOldVoucherID = T2.ReNewVoucherID and T2.ReOldTransactionID = T2.ReNewTransactionID)
and T1.UserID =@UserID AND T1.DivisionID = @DivisionID
-----------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 70) AND @ScreenID IN ('WF0096','WMF2007') ---kiểm tra tại Yêu cầu xuất kho cho EIMSKIP
BEGIN
	---trường hợp chua xuất kho
	SELECT WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID, 
	SUM(ISNULL(WT0096.ActualQuantity,0)) - ( 
					SELECT SUM(ISNULL(A27.ActualQuantity,0)) FROM AT2007 A27 WITH (NOLOCK)
					INNER JOIN AT2006 A26 WITH (NOLOCK) ON A27.DivisionID = A26.DivisionID AND A27.VoucherID = A26.VoucherID
					WHERE  A27.DivisionID = @DivisionID
					AND A26.WareHouseID = @WareHouseID AND KindVoucherID IN (2,4,6,8,10) AND A27.InheritTransactionID IN (SELECT wt2002.TransactionID FROM wt2002
					LEFT JOIN WT2001 ON WT2001.VoucherID = WT2002.VoucherID
					WHERE KindVoucherID = 2 
					AND ReTransactionID = WT0096.ReTransactionID)) AS ActualQuantity
	INTO #BT
	FROM WT0096 WITH (NOLOCK) 
	INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
	INNER JOIN WT8003 WITH (NOLOCK) ON WT0096.InventoryID = WT8003.InventoryID AND WT0096.ReTransactionID = WT8003.ReNewTransactionID
	WHERE WT0096.DivisionID = @DivisionID
	AND WT0095.WareHouseID = @WareHouseID --AND WT0096.InventoryID = @InventoryID
	AND NOT EXISTS (SELECT TOP 1 1 FROM AT2007 A27 WITH (NOLOCK)
					INNER JOIN AT2006 A26 WITH (NOLOCK) ON A27.DivisionID = A26.DivisionID AND A27.VoucherID = A26.VoucherID
					INNER JOIN WT8003 A1 WITH (NOLOCK) ON A27.InventoryID = A1.InventoryID
					WHERE A27.DivisionID = WT0096.DivisionID AND A27.InheritTransactionID = WT0096.TransactionID AND A27.ReTransactionID = WT0096.ReTransactionID
					AND A27.DivisionID = @DivisionID
					AND A26.WareHouseID = @WareHouseID AND A27.InventoryID = A1.InventoryID AND KindVoucherID IN (2,4,6,8,10))
	AND WT0095.KindVoucherID IN (2,4,6,8,10)
	GROUP BY WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID

	---trường hợp xuất kho nhưng kế thừa chưa hết
	SELECT WT0096.TransactionID, temp.InheritTransactionID,  WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID, 
	SUM(ISNULL(WT0096.ActualQuantity,0)) - SUM(ISNULL(Temp.ActualQuantity,0)) AS ActualQuantity
	INTO #BT1
	FROM WT0096 WITH (NOLOCK) 
	INNER JOIN WT0095 WITH (NOLOCK) ON WT0096.DivisionID = WT0095.DivisionID AND WT0096.VoucherID = WT0095.VoucherID
	INNER JOIN WT8003 WITH (NOLOCK) ON WT0096.InventoryID = WT8003.InventoryID AND WT0096.ReTransactionID = WT8003.ReNewTransactionID
	INNER JOIN 
	(SELECT A27.DivisionID, A27.InheritTransactionID, A27.ReTransactionID, SUM(A27.ActualQuantity) AS ActualQuantity
	 FROM AT2007 A27 WITH (NOLOCK) 
	 INNER JOIN AT2006 A26 WITH (NOLOCK) ON A27.DivisionID = A26.DivisionID AND A27.VoucherID = A26.VoucherID
	 INNER JOIN WT8003 A1 WITH (NOLOCK) ON A27.InventoryID = A1.InventoryID
	 AND A27.DivisionID = @DivisionID
	 AND A26.WareHouseID = @WareHouseID AND A27.InventoryID = A1.InventoryID AND KindVoucherID IN (2,4,6,8,10)
	 GROUP BY A27.DivisionID, A27.InheritTransactionID, A27.ReTransactionID
	)Temp ON Temp.DivisionID = WT0096.DivisionID AND Temp.InheritTransactionID = WT0096.TransactionID AND Temp.ReTransactionID = WT0096.ReTransactionID
	WHERE WT0096.DivisionID = @DivisionID
	AND WT0095.WareHouseID = @WareHouseID
	AND WT0095.KindVoucherID IN (2,4,6,8,10)
	GROUP BY  WT0096.TransactionID, temp.InheritTransactionID,WT0096.DivisionID, WT0096.ReVoucherID, WT0096.ReTransactionID
	HAVING SUM(ISNULL(WT0096.ActualQuantity,0)) - SUM(ISNULL(Temp.ActualQuantity,0)) > 0

	UPDATE T1
	SET T1.EndQuantity = T1.EndQuantity - ISNULL(T2.ActualQuantity,0) - ISNULL(T3.ActualQuantity,0) 
	From AT8003 T1 WITH (NOLOCK)
	LEFT JOIN #BT T2 ON T1.ReVoucherID = T2.ReVoucherID AND T1.ReTransactionID = T2.ReTransactionID AND T1.DivisionID = T2.DivisionID
	LEFT JOIN #BT1 T3 ON T1.ReVoucherID = T3.ReVoucherID AND T1.ReTransactionID = T3.ReTransactionID AND T1.DivisionID = T3.DivisionID

	DROP TABLE #BT
	DROP TABLE #BT1

END

UPDATE T1
SET T1.EndQuantity = T1.EndQuantity + T1.OldQuantity 
From AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID AND T1.DivisionID = T2.DivisionID AND T1.UserID = T2.UserID
Where T1.DivisionID = @DivisionID AND T1.UserID = @UserID

UPDATE AT8003
SET Status =1, Message =N'WFML000138'
WHERE NewQuantity > EndQuantity and UserID = @UserID AND DivisionID = @DivisionID
	
Insert AT7777 (DivisionID, UserID, Status, Message, Value1, Value2, Value3, IsNegativeStock)
SELECT @DivisionID, @UserID, T1.Status, T1.Message ,ltrim(str(T1.EndQuantity)), ltrim(str(T1.NewQuantity)), T2.InventoryID, 0 
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID
WHERE T1.Status =1 AND T1.Message =N'WFML000138' AND T1.DivisionID = @DivisionID AND T1.UserID = @UserID
----------------------------------------------------------
UPDATE AT8003
SET Status =0, Message =''
WHERE NOT(NewQuantity > EndQuantity) and UserID = @UserID AND DivisionID = @DivisionID
	
Insert AT7777 (DivisionID, UserID, Status, Message)
SELECT @DivisionID, @UserID, Status, Message FROM AT8003
WHERE Status =0 AND Message ='' AND UserID = @UserID AND DivisionID = @DivisionID

--- Kiem tra ton kho an toan
UPDATE T1
SET ReOrderQuantity = T3.ReOrderQuantity
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID AND T1.DivisionID = T2.DivisionID AND T1.UserID = T2.UserID
				INNER JOIN AT1314 T3 ON T3.InventoryID=T2.InventoryID
WHERE T1.DivisionID = @DivisionID AND T1.UserID = @UserID AND (case when T3.WareHouseID = '%' then @WareHouseID else T3.WareHouseID end) = @WareHouseID


UPDATE T1
SET T1.Status = 1, T1.Message =N'WFML000244'
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID AND T1.DivisionID = T2.DivisionID AND T1.UserID = T2.UserID
				INNER JOIN AT1302 T3 ON T3.DivisionID IN (@DivisionID,'@@@') And T3.InventoryID = T2.InventoryID
WHERE T1.EndQuantity - T1.NewQuantity <= ISNULL(T1.ReOrderQuantity, 0)
AND EXISTS (SELECT 1 FROM AT0011 WITH (NOLOCK) LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT0011.DivisionID AND AT1402.GroupID = AT0011.GroupID 
			WHERE AT0011.DivisionID = @DivisionID AND AT1402.UserID = @UserID AND WarningID = 3)
AND ISNULL(T3.IsMinQuantity,0)=1
AND T1.DivisionID = @DivisionID AND T1.UserID = @UserID
	
INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, Value1, Value2, IsNegativeStock)
Select @UserID, T1.Status, T1.Message, @DivisionID, T2.InventoryID, @WareHouseID as Value2, 0
FROM AT8003 T1 INNER JOIN WT8003 T2 ON T1.ReVoucherID = T2.ReNewVoucherID AND T1.ReTransactionID = T2.ReNewTransactionID AND T1.DivisionID = T2.DivisionID AND T1.UserID = T2.UserID
WHERE T1.Status = 1 AND T1.Message =N'WFML000244' AND T1.DivisionID = @DivisionID AND T1.UserID = @UserID


UPDATE AT8003		
SET Status =0, Message =''
WHERE NOT(Status = 1 AND Message =N'WFML000244') AND DivisionID = @DivisionID AND UserID = @UserID

INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID)
Select @UserID, Status, Message, @DivisionID FROM AT8003
WHERE Status =0 AND Message =''	 AND DivisionID = @DivisionID AND UserID = @UserID		

--DROP TABLE WT8003
SET NOCOUNT OFF
SELECT * FROM AT7777 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
SELECT * FROM AT7778 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
