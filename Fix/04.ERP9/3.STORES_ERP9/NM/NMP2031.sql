IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab phiếu điều tra dinh dưỡng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by:Tra Giang  on 21/10/2018
-- <Example>
---- 
/*-- <Example>
	NMP2031 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '88E62B82-EE31-46FA-9870-10A7553FB4B0', @Mode= 0
	 
	NMP2031 @DivisionID, @UserID, @APK, @Mode
----*/
CREATE PROCEDURE NMP2031
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode int -- 0:master, 1:thành phần dinh dương, 2: thưc phẩm, 3: dịch vụ 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)
IF @Mode= 0 
		SET @sSQL = N'
				SELECT APK,DivisionID, InvestigateVoucherNo,  InvestigateVoucherDate,  MarketVoucherNo,MenuVoucherNo,Description,TotalStudent, RealityStudent,
			   QuotaUnitPrice, RealityUnitPrice,DifferenceAmount
			   FROM NMT2030 WITH (NOLOCK)  
				WHERE  DeleteFlg=0  and NMT2030.APK = '''+@APK+''' AND NMT2030.DivisionID = '''+@DivisionID+'''
			'
ELSE
IF @Mode= 1
	SET @sSQL = N'
	
 SELECT   N31.DivisionID,N31.APKMaster, N31.SystemID,N01.SystemName, N31.Ingredient, N31.QuotaStandard, N31.Ratio
 FROM NMT2031 N31 WITH (NOLOCK)
 LEFT JOIN NMT2030 N30 ON N31.APKMaster = N30.APK AND N31.DivisionID=N30.DivisionID
 LEFT JOIN NMT0001 N01 WITH (NOLOCK) ON N31.SystemID = N01.SystemID
 WHERE  N31.DeleteFlg=0  and N31.APKMaster = '''+@APK+''' AND N31.DivisionID = '''+@DivisionID+'''
	'
ELSE
IF @Mode= 2
			SET @sSQL = N'select N32.DivisionID,  N32.MaterialsID,A02.InventoryName as MaterialsName , N32.UnitID,A04.UnitName, N32.ActualQuantity, 
		 N32.ConvetedQuantity,N32.Thrown, N32.RealityQuantity, N32.UnitPrice,N32.Amount
		 FROM NMT2032 N32 WITH (NOLOCK)
		 LEFT JOIN NMT2030 N30 ON N32.APKMaster = N30.APK AND N32.DivisionID=N30.DivisionID
		 LEFT JOIN AT1302 A02 ON N32.MaterialsID = A02.InventoryID AND A02.DivisionID IN (N32.DivisionID,''@@@'')
		 LEFT JOIN AT1304 A04 ON  N32.UnitID= A04.UnitID AND A04.DivisionID IN (N32.DivisionID,''@@@'') 
		 WHERE  N32.DeleteFlg=0  and N32.APKMaster = '''+@APK+''' AND N32.DivisionID = '''+@DivisionID+'''
'
ELSE
		SET @sSQL = N'SELECT N33.DivisionID, N33.ServiceID,A02.InventoryName AS ServiceName,N33.PeopleUnitPrice
		 FROM NMT2033 N33 WITH (NOLOCK)
		 LEFT JOIN AT1302 A02 ON N33.ServiceID = A02.InventoryID AND A02.DivisionID IN (N33.DivisionID,''@@@'')
		 WHERE  N33.DeleteFlg=0  and N33.APKMaster = '''+@APK+''' AND N33.DivisionID = '''+@DivisionID+'''
'
 
 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

