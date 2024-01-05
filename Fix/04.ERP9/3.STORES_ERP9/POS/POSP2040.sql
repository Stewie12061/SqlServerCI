IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP2040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Kiểm tra User đăng nhập có quyền vào ca làm việc tại POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 11/06/2018
-- <Example>
---- 
CREATE PROCEDURE POSP2040
( 
		@DivisionID AS NVARCHAR(50),
		@ShopID NVARCHAR(50),
		@ShiftID NVARCHAR(50),
		@UserID NVARCHAR(50),
		@Time DATETIME
) 
AS 

IF ISNULL(@ShiftID,'') <> ''
	SELECT TOP 1 1 FROM POST0069 P69 WITH (NOLOCK)
	LEFT JOIN POST0070 P70 WITH (NOLOCK) ON P70.DivisionID = P69.DivisionID AND P70.ShopID = P69.ShopID AND P70.ShiftID = P69.ShiftID
	WHERE P69.DivisionID = @DivisionID AND P69.ShopID = @ShopID AND P69.ShiftID = @ShiftID
	 AND P70.UserID = @UserID

ELSE 
	SELECT TOP 1 1 FROM POST0069 P69 WITH (NOLOCK)
	LEFT JOIN POST0070 P70 WITH (NOLOCK) ON P70.DivisionID = P69.DivisionID AND P70.ShopID = P69.ShopID AND P70.ShiftID = P69.ShiftID
	WHERE P69.DivisionID = @DivisionID AND P69.ShopID = @ShopID
	 AND P70.UserID = @UserID AND Convert(datetime,@Time,108) BETWEEN Convert(datetime,P69.FromTime,108) AND Convert(datetime,P69.ToTime,108)	
 	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
