IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ADMV0010]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[ADMV0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lưu danh sách các Kiểu dữ liệu của FW ERP9.9
-- <History>
---- Create on 22/04/2020 Vĩnh Tâm

CREATE VIEW [dbo].[ADMV0010] AS

SELECT 1 AS sysDataTypeID, N'Khóa chính kiểu APK' AS sysDataTypeName,17 AS sysDataViewID, N'PK_APK' AS DataTypeID
UNION ALL
SELECT 2 AS sysDataTypeID, N'Khóa chính tự tăng kiểu số nguyên' AS sysDataTypeName,3 AS sysDataViewID, N'PK_Int' AS DataTypeID
UNION ALL
SELECT 3 AS sysDataTypeID, N'Khóa chính kiểu chuỗi' AS sysDataTypeName,14 AS sysDataViewID, N'PK_String' AS DataTypeID
UNION ALL
SELECT 4 AS sysDataTypeID, N'Số nguyên lớn' AS sysDataTypeName,7 AS sysDataViewID, N'BigInt' AS DataTypeID
UNION ALL
SELECT 5 AS sysDataTypeID, N'Số nguyên' AS sysDataTypeName,3 AS sysDataViewID, N'Int' AS DataTypeID
UNION ALL
SELECT 6 AS sysDataTypeID, N'Số nguyên nhỏ' AS sysDataTypeName,1 AS sysDataViewID, N'TinyInt' AS DataTypeID
UNION ALL
SELECT 7 AS sysDataTypeID, N'Chuỗi kí tự' AS sysDataTypeName,14 AS sysDataViewID, N'String' AS DataTypeID
UNION ALL
SELECT 8 AS sysDataTypeID, N'Số thập phân' AS sysDataTypeName,15 AS sysDataViewID, N'Decimal' AS DataTypeID
UNION ALL
SELECT 9 AS sysDataTypeID, N'Ngày' AS sysDataTypeName,16 AS sysDataViewID, N'Date' AS DataTypeID
UNION ALL
SELECT 10 AS sysDataTypeID, N'Luận lý' AS sysDataTypeName,12 AS sysDataViewID, N'Bool' AS DataTypeID
UNION ALL
SELECT 11 AS sysDataTypeID, N'Giờ' AS sysDataTypeName,16 AS sysDataViewID, N'Time' AS DataTypeID
UNION ALL
SELECT 12 AS sysDataTypeID, N'Đoạn văn' AS sysDataTypeName,14 AS sysDataViewID, N'Text' AS DataTypeID
UNION ALL
SELECT 13 AS sysDataTypeID, N'Ngày giờ' AS sysDataTypeName,16 AS sysDataViewID, N'DateTime' AS DataTypeID
UNION ALL
SELECT 14 AS sysDataTypeID, N'Images' AS sysDataTypeName,18 AS sysDataViewID, N'Binary' AS DataTypeID
UNION ALL
SELECT 15 AS sysDataTypeID, N'File' AS sysDataTypeName,19 AS sysDataViewID, N'File' AS DataTypeID
UNION ALL
SELECT 16 AS sysDataTypeID, N'TimeInt' AS sysDataTypeName,20 AS sysDataViewID, N'TimeInt' AS DataTypeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
