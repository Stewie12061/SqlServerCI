IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP30081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP30081]
GO
/****** Object:  StoredProcedure [dbo].[QCP30081]    Script Date: 11/13/2020 3:01:26 PM ******/
-- <Summary>
---- Lấy dữ liệu in tem
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 17/11/2020 by TAN TAI
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP30081]
		@DivisionID = N'VNP',
		@UserID = N'',
		@APK =N'1E56892F-0FCF-49B4-8D99-6EB502A86E0D'',''D3E71422-B544-4877-81AA-84BE29A923AA'
----*/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP30081]
( 
	 @DivisionID  NVARCHAR(50),
	 @UserID  NVARCHAR(50),
	 @LstAPK XML = null
)
AS 
BEGIN
IF @LstAPK IS NULL
BEGIN
	select QCT2001.APK,QCT2001.APKMaster, QCT2001.InventoryID, QCT2001.BatchNo,  QCT2001.BatchNo + ' - ' + AT1302.InventoryName AS InventoryName  
	from QCT2001 QCT2001  
	JOIN QCT2000 QCT2000 ON QCT2001.APKMaster = QCT2000.APK  
	left join AT1302 AT1302 on AT1302.InventoryID = QCT2001.InventoryID  
	WHERE QCT2001.DeleteFlg = 0 AND QCT2000.DeleteFlg = 0  
	ORDER BY InventoryName
END
ELSE
BEGIN
	---bảng mặt hàng từ XML
	Create TABLE #APKTable (APK nvarchar(50) primary key) 
	INSERT INTO	#APKTable		
	SELECT	X.Data.value('.', 'VARCHAR(50)') AS APK
	FROM	@LstAPK.nodes('//Data') AS X (Data)

	select QCT2001.APK,QCT2001.APKMaster, QCT2001.InventoryID, QCT2001.BatchNo,  QCT2001.BatchNo + ' - ' + AT1302.InventoryName AS InventoryName  
	from QCT2001 QCT2001  
	JOIN QCT2000 QCT2000 ON QCT2001.APKMaster = QCT2000.APK  
	LEFT JOIN AT1302 AT1302 on AT1302.InventoryID = QCT2001.InventoryID  
	WHERE QCT2001.DeleteFlg = 0 AND QCT2000.DeleteFlg = 0 AND EXISTS (SELECT TOP 1 1 FROM #APKTable WHERE APK = QCT2001.APK) 
	ORDER BY InventoryName
END
END



		