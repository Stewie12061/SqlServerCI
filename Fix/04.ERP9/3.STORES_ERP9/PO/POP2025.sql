IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Tính số lượng đặt hàng cho kế hoạch mua hàng dự trữ khi kế thừa đơn đặt hàng từ khách sỉ và cửa hàng (Customize ATTOM)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 16/07/2018
-- <Example>
---- exec POP2025 'AT', 'ASOFTADMIN', '0000000002', 50, '10/08/2018', '0C477CBF-404F-481E-B32F-01C2C2101000'
CREATE PROCEDURE POP2025
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@InventoryID NVARCHAR(50),
		@Quantity DECIMAL(28,8),
		@RequireDate DATETIME,
		@SO_APK VARCHAR(50)
) 
AS 
DECLARE @BeginQuantity DECIMAL(28,8),
		@ExpectQuantity DECIMAL(28,8),
		@PQuantity DECIMAL(28,8),
		@OrderQuantity DECIMAL(28,8),
		@Notes NVARCHAR(250) = '',
		@sSQL NVARCHAR(MAX)
		
---- Lấy số lượng tồn kho thực tế
SET  @BeginQuantity =  (SELECT SUM(Isnull(SignQuantity,0))
						FROM AV7000
						WHERE DivisionID = @DivisionID AND InventoryID = @InventoryID
							AND VoucherDate <= GETDATE())

---- Lấy số lượng tồn kho dự kiến
SET  @ExpectQuantity  = (SELECT SUM(Isnull(P18.OrderQuantity,0)) 
							FROM POT2017 P17 WITH (NOLOCK)
							LEFT JOIN POT2018 P18 WITH (NOLOCK) ON P18.DivisionID = P17.DivisionID AND P17.APK = P18.APK_Master
							WHERE P18.DivisionID = @DivisionID AND P18.InventoryID = @InventoryID
								AND P18.ExpectDate >= GETDATE() AND P18.ExpectDate <= @RequireDate	)
	
---- Lấy số lượng đã đặt mua hàng dự trữ
SET @sSQL = '
IF NOT EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME=''POP2025_Temp'' AND xtype=''U'')
	CREATE Table POP2025_Temp (OrderQuantity DECIMAL(28,8))

INSERT INTO POP2025_Temp (OrderQuantity)
SELECT SUM(Isnull(P16.OrderQuantity,0))  OrderQuantity
FROM POT2016 P16 WITH (NOLOCK)
LEFT JOIN POT2015 P15 WITH (NOLOCK) ON P15.DivisionID = P16.DivisionID AND P15.APK = P16.APK_Master
LEFT JOIN POT2018 P18 WITH (NOLOCK) ON P18.DivisionID = P16.DivisionID AND P18.InheritTransactionID = P16.APK AND P18.InheritTableID = ''POT2016''
WHERE P15.DivisionID = '''+@DivisionID+''' AND P16.InventoryID = '''+@InventoryID+'''
	AND ISNULL(P18.InventoryID,'''') = '''' AND CONVERT(NVARCHAR(10),P16.ScheduleDate,120) <= '''+CONVERT(NVARCHAR(10),@RequireDate,120) +'''
	AND P16.APK <> '''+@SO_APK+'''
'
EXEC (@sSQL)
--PRINT @sSQL
CREATE Table #Temp (OrderQuantity DECIMAL(28,8))
INSERT #Temp 
EXEC ('SELECT OrderQuantity FROM POP2025_Temp')

SET @PQuantity = (SELECT TOP 1 OrderQuantity FROM #Temp)

EXEC ('DELETE FROM POP2025_Temp')
	
IF isnull(@Quantity,0) - (Isnull(@BeginQuantity,0) + Isnull(@ExpectQuantity,0) - Isnull(@PQuantity,0)) <= 0
BEGIN
	SET @OrderQuantity = 0
	SET @Notes = N'Dự kiến giao đủ số lượng'
END
ELSE
	BEGIN
		SET @OrderQuantity = isnull(@Quantity,0) - (Isnull(@BeginQuantity,0) + Isnull(@ExpectQuantity,0) - Isnull(@PQuantity,0))
		SET @Notes = N'Dự kiến mua'
	END	

SELECT @InventoryID, @OrderQuantity, @Notes

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
