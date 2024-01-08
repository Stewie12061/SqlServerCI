IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load cập nhật lũy kế chi cho phòng ban
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN\ Nghiệp vụ \ Kết quả thu chi thực tế\ Cập nhật - Gọi Store
-- <History>
----Created by: Như Hàn, Date: 03/01/2019
-- <Example>
---- 
/*-- <Example>
	FNP2008 @DivisionID = 'AIC', @APK = '557C7835-7D69-48FB-8DAE-466E4D8D71D3'

	FNP2008 @DivisionID, @APK
----*/

CREATE PROCEDURE FNP2008
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 

 ---- APK Các phiếu tổng hợp đã tạo kế hoạch thu chi thực tế
 SELECT InheritAPK AS APKTH, APK As APKTT, ActualOAmount
 INTO #APKFNT2001
 FROM FNT2011 WITH (NOLOCK)  WHERE APKMaster = @APK


 ---- APK Các phiếu kế hoạch thu chi đã tạo phiếu tông hợp
 SELECT  InheritTransactionID AS APKKH , APKTH, T02.ActualOAmount
 INTO #FNT2001
 FROM FNT2001 T01 WITH (NOLOCK) 
 INNER JOIN #APKFNT2001 T02 ON T01.APK = T02.APKTH

 ---- Cập nhật lại lũy kế chi cho kế hoạch thu chi
 UPDATE T1
 SET Accumulated = T2.ActualOAmount
 FROM FNT2001 T1
 INNER JOIN #FNT2001 T2 ON T1.APK = T2.APKKH
 INNER JOIN #APKFNT2001  T3 ON T2.APKTH = T3.APKTH




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
