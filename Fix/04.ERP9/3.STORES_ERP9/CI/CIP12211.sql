IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP12211]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP12211]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
----- Kết thúc chương trình khuyến mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Nhat Thanh on 19/10/2023

-- <Example> EXEC CIP12211 @DivisionID = 'GREE', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'
----
CREATE PROCEDURE CIP12211
( 
	 @DivisionID VARCHAR(50),
	 @PromoteID VARCHAR(50)				
) 
AS 
DECLARE @TypeID VARCHAR(50) = (SELECT TOP 1 TypeID FROM AT0005 WITH (NOLOCK)
      		WHERE DivisionID = @DivisionID and TypeID like 'O%' and status = 1)

SELECT ObjectID From  AT9000 WITH (NOLOCK) 
				    Where (TransactionTypeID in ('T01','T02','T11')    
					or ( TransactionTypeID ='T21' and CreditAccountID like '111%') )  ---- Chi qua ngan hang     
					and AT9000.DivisionID = @DivisionID and Ana01ID = @PromoteID

SELECT C21.DivisionID, C20.PromoteID, C21.ConditionID, ConditionName, C21.ToolID,C21.DiscountUnitID, PayMentID, MathID, ObjectCustomID, C20.OID, AnChorID, 
	Level, ISNULL(SpendingLevel,0) SpendingLevel, C22.UnitID, Target,C22.TargetType, TargetQuantity, ToTargetQuantity, PaymentMethod, InventoryGiftID, A13.InventoryName InventoryGiftName, 
	InventoryGiftQuantity, Value, ReturnGifeDate, PromotionID, Notes, A13.UnitID GiftUnitID
    FROM CIT1220 C20
    left join CIT1221 C21 on C20.PromoteID = C21.PromoteID
    inner join CIT1222 C22 on C21.APK = C22.APKMaster
	--left join CIT1510 C15 on C15.ToolID = C21.ToolID
	left join AT1302 A13 on C22.InventoryGiftID = A13.InventoryID
    WHERE C20.DivisionID = @DivisionID AND C21.PromoteID = @PromoteID 
    and  PayMentID = 'TK'
    ORDER BY C21.ConditionID, C22.Orders
	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

