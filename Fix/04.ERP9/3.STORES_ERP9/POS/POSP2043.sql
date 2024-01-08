IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu truy vấn đóng ca làm việc
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
CREATE PROCEDURE POSP2043
( 
		@DivisionID AS NVARCHAR(50),
		@ShopID NVARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@ID UNIQUEIDENTIFIER
) 
AS 

SELECT P33.*, A05.UserName AS EmployeeName1, A06.UserID AS EmployeeName2
FROM POST2033 P33 WITH (NOLOCK)
LEFT JOIN POST2034 P34 WITH (NOLOCK) ON P33.DivisionID = P34.DivisionID AND P33.ShopID = P34.ShopID 
LEFT JOIN AT1405 A05 WITH (NOLOCK) ON A05.DivisionID = P33.DivisionID AND A05.UserID = P33.EmployeeID1
LEFT JOIN AT1405 A06 WITH (NOLOCK) ON A06.DivisionID = P33.DivisionID AND A06.UserID = P33.EmployeeID2
WHERE P33.DivisionID  = @DivisionID AND P33.ShopID = @ShopID AND P33.TranMonth = @TranMonth AND P33.TranYear = @TranYear
 	AND P33.APK = @ID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
