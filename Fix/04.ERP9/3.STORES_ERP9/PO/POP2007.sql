IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form Cập nhật tiến độ nhận hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 14/12/2018
----Modified by Như Hàn on 05/03/2019: Điều chỉnh lại cách tính ngày, bỏ truyền VoucherNo
-- <Example>
---- 
/*-- <Example>

POP2007 @DivisionID, @VoucherNo, @FormPlanID, @OrderDate

----*/

CREATE PROCEDURE POP2007
( 
	 @DivisionID VARCHAR(50),
	 @FormPlanID VARCHAR(50),
	 @OrderDate Datetime,
	 @APK VARCHAR(50) = Null,
	 @Mode INT = 0 ---- 0: Load lưới tiến độ nhận hàng, 1 Kiểm tra trước khi lưu edit tiến độ
)
AS 


--SELECT T10.FormPlanID, T11.PlanID, T01.PlanName, T11.NDay , (@OrderDate +  T11.NDay) As PlanReceivingDate
--FROM POT1010 T10 WITH (NOLOCK)
--INNER JOIN POT1011 T11 WITH (NOLOCK) ON T10.APK = T11.APKMaster
--INNER JOIN POT1001 T01 WITH (NOLOCK) ON T01.PlanID = T11.PlanID AND T01.DivisionID = T01.DivisionID
--WHERE T10.FormPlanID = @FormPlanID
IF ISNULL(@Mode,0) = 0
BEGIN 

	DECLARE @Max INT = 1, @Min INT = 1

	SET @Max = (SELECT TOP 1 ISNULL(OrderID,0) FROM POT1011 T1 WITH (NOLOCK) INNER JOIN POT1010 T2 WITH (NOLOCK)  ON T1.APKMaster = T2.APK WHERE T2.FormPlanID = @FormPlanID ORDER BY T1.OrderID DESC)
	SET @Min = (SELECT TOP 1 ISNULL(OrderID,0) FROM POT1011 T1 WITH (NOLOCK) INNER JOIN POT1010 T2 WITH (NOLOCK)  ON T1.APKMaster = T2.APK WHERE T2.FormPlanID = @FormPlanID ORDER BY T1.OrderID)

	SELECT T10.FormPlanID, T11.PlanID, T01.PlanName, T11.NDay, T11.OrderID, GETDATE() AS PlanReceivingDate
	INTO #TAM
	FROM POT1010 T10 WITH (NOLOCK)
	INNER JOIN POT1011 T11 WITH (NOLOCK) ON T10.APK = T11.APKMaster
	INNER JOIN POT1001 T01 WITH (NOLOCK) ON T01.PlanID = T11.PlanID AND T01.DivisionID = T01.DivisionID
	WHERE T10.FormPlanID = @FormPlanID
 
	WHILE @Min < = @Max

	BEGIN

	 UPDATE #TAM 
	 SET PlanReceivingDate = ((SELECT SUM(NDay) FROM #TAM WHERE ISNULL(OrderID,0) <= @Min) + @OrderDate)
	 WHERE ISNULL(OrderID,0) = @Min AND 1 =1 

	 SET @Min = @Min + 1

	END

	SELECT * FROM #TAM
	ORDER BY OrderID

END
ELSE IF ISNULL(@Mode,0) = 1
BEGIN 
	SELECT 1 As Islock, T11.APK, T11.PlanID FROM POT1011 T11  
	INNER JOIN POT1010 T10 WITH (NOLOCK) ON T10.APK = T11.APKMaster AND T10.FormPlanID = @FormPlanID
	INNER JOIN AT9000 T9 ON T9.PlanID = T11.PlanID AND T9.OrderID = @APK
	--WHERE T9.OrderID = @APK AND T10.FormPlanID = @FormPlanID
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
