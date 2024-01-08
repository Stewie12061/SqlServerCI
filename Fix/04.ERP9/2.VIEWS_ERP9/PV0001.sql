IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[PV0001]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[PV0001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lấy dữ liệu mệnh giá tiền tệ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 12/06/2018
-- <Example>
---- 
CREATE VIEW PV0001
AS
	SELECT N'VND' AS ID, 500000 AS FaceValue, N'Năm trăm nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 200000 AS FaceValue, N'Hai trăm nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 100000 AS FaceValue, N'Một trăm nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 50000 AS FaceValue, N'Năm mươi nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 20000 AS FaceValue, N'Hai mươi nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 10000 AS FaceValue, N'Mười nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 5000 AS FaceValue, N'Năm nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 2000 AS FaceValue, N'Hai nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 1000 AS FaceValue, N'Một nghìn đồng' AS FaceName
	UNION
	SELECT N'VND' AS ID, 500 AS FaceValue, N'Năm trăm đồng' AS FaceName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


