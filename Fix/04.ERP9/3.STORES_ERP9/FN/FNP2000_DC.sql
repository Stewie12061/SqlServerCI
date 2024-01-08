IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2000_DC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2000_DC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Lịch sử điều chỉnh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 11/10/2018
-- <Example>
---- 
/*-- <Example>
EXEC FNP2000_DC @DivisionID, @VoucherNo, @PageNumber, @PageSize
----*/


CREATE PROCEDURE FNP2000_DC
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 

SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY ModifyNo)) AS RowNum, COUNT(*) OVER () AS TotalRow,
APK, ModifyNo, DivisionID, VoucherNo, LastModifyUserID, LastModifyDate FROM FNT2000_DC WITH (NOLOCK)
WHERE FNT2000APK = @APK
ORDER BY ModifyNo
OFFSET (@PageNumber-1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

