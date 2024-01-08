IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2043]
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
	NMP2043 @DivisionID = 'BS', @UserID = 'ASOFTADMIN', @InvestigateVoucherNo = ''
	
	NMP2043 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE NMP2043
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @InvestigateVoucherNo VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''


SET @sSQL = @sSQL + N'

select N32.MaterialsID,A02.InventoryName,N32.UnitID, A04.UnitName,N32.RealityQuantity, N32.UnitPrice
 from NMT2030 N30 WITH (NOLOCK) inner join  NMT2032 N32 WITH (NOLOCK) on N30.APK=N32.APKMaster
  inner join NMT2033 N33 WITH (NOLOCK) on N30.APK=N33.APKMaster
  left join AT1302 A02 WITH (NOLOCK) on  A02.InventoryID=N32.MaterialsID AND A02.DivisionID  IN (N33.DivisionID,''@@@'')
   left join AT1304 A04 WITH (NOLOCK) on A04.UnitID = N32.UnitID AND A04.DivisionID  IN (N33.DivisionID,''@@@'')
    WHERE N30.DivisionID = '''+@DivisionID+''' and N30.InvestigateVoucherNo = '''+@InvestigateVoucherNo+''' 
  
'
EXEC (@sSQL)
--PRINT(@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



     
