IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form add new so tinh tien cho (master)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Tra Giang on 21/09/2018
-- <Example>
---- 
/*-- <Example>
	NMP2042 @DivisionID = 'BS', @UserID = 'ASOFTADMIN', @InvestigateVoucherNo = ''
	
	NMP2042 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE NMP2042
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @InvestigateVoucherNo VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''


SET @sSQL = @sSQL + N'
	 select TOP 1  N30.InvestigateVoucherDate, N30.QuotaUnitPrice,N30.RealityStudent, X.SurplusDay as SurplusDay
  from NMT2030 N30 inner join  NMT2032 N32 WITH (NOLOCK) on N30.APK=N32.APKMaster
  inner join NMT2033 N33 WITH (NOLOCK) on N30.APK=N33.APKMaster
  inner join 
  ( select N30.APK, ((IsNull(N30.RealityStudent,0) * IsNull(N30.RealityUnitPrice,0))- SUM(ISNULL(N32.Amount,0)) + SUM(ISNULL(N33.PeopleUnitPrice,0))) as SurplusDay 
  from NMT2030 N30 inner join  NMT2032 N32 WITH (NOLOCK) on N30.APK=N32.APKMaster
  inner join NMT2033 N33 WITH (NOLOCK) on N30.APK=N33.APKMaster
   group by N30.APK,N30.RealityStudent,N30.RealityUnitPrice
  ) X on X.APK= N30.APK
  WHERE  N30.DivisionID='''+@DivisionID+''' and N30.InvestigateVoucherNo = '''+@InvestigateVoucherNo+''' 
   group by N30.InvestigateVoucherDate,N30.QuotaUnitPrice,N30.RealityStudent,X.SurplusDay
   order by N30.InvestigateVoucherDate DESC


	
'
EXEC (@sSQL)
--PRINT(@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO





     
