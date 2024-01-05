IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2044]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2044]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin lưới cập nhật chia cổ tức (Khi thêm mới)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng vũ , Date: 23/10/2018
-- <Example> EXEC SHMP2044 'BS', '', '2019-10-26'

CREATE PROCEDURE SHMP2044  
(	
	 @DivisionID varchar(50),
	 @UserID varchar(50),
	 @VoucherDate Datetime
)  
AS  
BEGIN  
	SELECT A02.ObjectID, A02.ObjectName, Sum(Isnull(D.IncrementQuantity, 0)) - Sum(Isnull(D.DecrementQuantity, 0)) as HoldQuantity
	FROM AT1202 A02 WITH (NOLOCK) Inner join SHMT2010 M WITH (NOLOCK) ON M.ObjectID = A02.ObjectID
								  Inner join SHMT2011 D WITH (NOLOCK) ON M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg and M.DeleteFlg = 0
	WHERE A02.DivisionID IN (@DivisionID,'@@@') AND A02.Disabled=0 and D.TransactionDate <= @VoucherDate
	Group by A02.ObjectID, A02.ObjectName
	Having Sum(Isnull(D.IncrementQuantity, 0)) - Sum(Isnull(D.DecrementQuantity, 0)) > 0
	Order by A02.ObjectID, A02.ObjectName	
	
END  
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

