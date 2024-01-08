IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0138]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0138]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra mặt hàng nhập kho đã có trong bảng giá chưa và giá có khác so với giá nhập trước gần nhất
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 27/07/2017
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
-- <Example> EXEC WP0138 'AS', 'PHUONG', XML

CREATE PROCEDURE WP0138 ( 
	@DivisionID varchar(50),
	@UserID Varchar(50),
	@XML XML
	) 
AS 
DECLARE @Cur CURSOR,
		@InventoryID VARCHAR(50),
		@UnitPrice Decimal(28,8),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX),
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
If @CustomerName = 79 --Customize MINH SANG
BEGIN
Create Table #AT2006
(
	InventoryID NVARCHAR(50),
	UnitPrice Decimal(28,8),
	Status TINYINT,
	ErrorColumn NVARCHAR(MAX) NULL,
	ErrorMessage NVARCHAR(MAX) NULL
)	
INSERT INTO #AT2006(InventoryID, UnitPrice,Status,  ErrorColumn, ErrorMessage)												
SELECT	X.Data.query('InventoryID').value('.','NVARCHAR(50)') AS InventoryID,
		X.Data.query('UnitPrice').value('.', 'DECIMAL(28,8)') AS UnitPrice, 0,
		'',''
FROM @XML.nodes('//Data') AS X (Data)
--------------Test dữ liệu import---------------------------------------------------
Declare @AT2006temp table (
						Status tinyint,
						ErrorColumn varchar(100) NULL,
						ErrorMessage varchar(4000) NULL)
Insert into @AT2006temp (	Status, ErrorMessage, ErrorColumn) 
							Select 1 as Status, 'WFML000234' as ErrorMessage, null as ErrorColumn
							union all
							Select 2 as Status, 'WFML000234' as ErrorMessage, null as ErrorColumn
SET @ErrorMessage =''
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT InventoryID, UnitPrice FROM #AT2006 
	
OPEN @Cur
FETCH NEXT FROM @Cur INTO @InventoryID, @UnitPrice
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra không tồn tại trong bảng giá
	IF NOT EXISTS (Select Top 1 1 From OT1302 D WITH (NOLOCK) INNER JOIN OT1301 M WITH (NOLOCK) ON M.ID = D.ID WHERE D.InventoryID =@InventoryID  )		
	BEGIN
	SET @ErrorFlag = 1
	UPDATE @AT2006temp SET ErrorColumn = isnull(ErrorColumn,'') + @InventoryID + ', '

		WHERE ErrorMessage = 'WFML000234' and Status =1
	END
	
	
---Kiểm tra Giá nhập khác so với giá nhập gần nhất
	If Exists (SELECT TOP 1 1 FROM AT1302 M WITH (NOLOCK) LEFT JOIN
					( SELECT TB.DivisionID,TB.InventoryID, TB.UnitPrice FROM 
						(
						 SELECT A.DivisionID,A.InventoryID, ISNULL(A.UnitPrice, 0) UnitPrice,
						 ROW_NUMBER() OVER (PARTITION BY A.InventoryID ORDER BY VoucherDate DESC) rn
						 FROM AT2007 A WITH (NOLOCK) 
						 INNER JOIN AT2006 B WITH (NOLOCK) ON A.DivisionID = B.DivisionID AND A.VoucherID = B.VoucherID
						 WHERE B.DivisionID =@DivisionID AND B.KindVoucherID= 1 AND A.InventoryID = @InventoryID
						) TB
						WHERE rn = 1
					)B ON  M.DivisionID IN ('@@@', B.DivisionID) AND M.InventoryID = B.InventoryID
					LEFT JOIN ( SELECT TB.InventoryID, TB.UnitPrice FROM 
						(
						 SELECT A.InventoryID, isnull(A.UnitPrice, 0) UnitPrice,
						 ROW_NUMBER() OVER (PARTITION BY A.InventoryID ORDER BY VoucherDate DESC) rn
						 FROM AT2017 A WITH (NOLOCK) 
						 INNER JOIN AT2016 B WITH (NOLOCK) ON A.DivisionID = B.DivisionID and A.VoucherID = B.VoucherID
						 WHERE B.DivisionID = @DivisionID  AND A.InventoryID = @InventoryID
						) TB
						WHERE rn = 1)C On M.InventoryID = C.InventoryID
					where M.InventoryID = @InventoryID and isnull(B.UnitPrice,C.UnitPrice) != @UnitPrice )
	BEGIN			
		SET @ErrorFlag = 1
		UPDATE @AT2006temp SET ErrorColumn =  isnull(ErrorColumn,'') + @InventoryID+ ', '
							
		WHERE ErrorMessage = 'WFML000234' and Status = 2
	END 

	FETCH NEXT FROM @Cur INTO @InventoryID, @UnitPrice
END
CLOSE @Cur
EndMessage:;
SELECT Status, LEFT(ErrorColumn,LEN(ErrorColumn) - 1) ErrorColumn, ErrorMessage FROM @AT2006temp 
WHERE  ErrorColumn is not null
ORDER BY Status
Drop table #AT2006
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
