IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[ADMV0020]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[ADMV0020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lưu danh sách các loại control của FW ERP9.9
-- <History>
---- Create on 23/04/2020 Tấn Lộc

CREATE VIEW [dbo].[ADMV0020] AS

SELECT 1 AS sysFieldTypeID, N'TextBox' AS sysFieldTypeName,N'TextBox' AS sysDataViewID
UNION ALL
SELECT 2 AS sysFieldTypeID, N'CheckBox' AS sysFieldTypeName,N'CheckBox' AS sysDataViewID
UNION ALL
SELECT 3 AS sysFieldTypeID, N'ComboBox' AS sysFieldTypeName,N'ComboBox' AS sysDataViewID
UNION ALL
SELECT 4 AS sysFieldTypeID, N'ComboCheckList' AS sysFieldTypeName,N'ComboCheckList' AS sysDataViewID
UNION ALL
SELECT 5 AS sysFieldTypeID, N'DateTimePicker' AS sysFieldTypeName,N'DateTimePicker' AS sysDataViewID
UNION ALL
SELECT 6 AS sysFieldTypeID, N'SpecialControl' AS sysFieldTypeName,N'SpecialControl' AS sysDataViewID
UNION ALL
SELECT 7 AS sysFieldTypeID, N'LongDateTimePicker' AS sysFieldTypeName,N'LongDateTimePicker' AS sysDataViewID
UNION ALL
SELECT 8 AS sysFieldTypeID, N'Uploader' AS sysFieldTypeName,N'Uploader' AS sysDataViewID
UNION ALL
SELECT 9 AS sysFieldTypeID, N'RadioButton' AS sysFieldTypeName,N'RadioButton' AS sysDataViewID
UNION ALL
SELECT 10 AS sysFieldTypeID, N'AutoComplete' AS sysFieldTypeName,N'AutoComplete' AS sysDataViewID
UNION ALL
SELECT 11 AS sysFieldTypeID, N'TimePicker' AS sysFieldTypeName,N'TimePicker' AS sysDataViewID
UNION ALL
SELECT 12 AS sysFieldTypeID, N'Spinner' AS sysFieldTypeName,N'Spinner' AS sysDataViewID
UNION ALL
SELECT 13 AS sysFieldTypeID, N'TextArea' AS sysFieldTypeName,N'TextArea' AS sysDataViewID
UNION ALL
SELECT 14 AS sysFieldTypeID, N'StarVote' AS sysFieldTypeName,N'StarVote' AS sysDataViewID
UNION ALL
SELECT 15 AS sysFieldTypeID, N'ComboBoxMultiSelect' AS sysFieldTypeName,N'ComboBoxMultiSelect' AS sysDataViewID
UNION ALL
SELECT 16 AS sysFieldTypeID, N'SelectObject' AS sysFieldTypeName,N'SelectObject' AS sysDataViewID
UNION ALL
SELECT 17 AS sysFieldTypeID, N'Attach' AS sysFieldTypeName,N'Attach' AS sysDataViewID
UNION ALL
SELECT 18 AS sysFieldTypeID, N'MultiSelectObject' AS sysFieldTypeName,N'MultiSelectObject' AS sysDataViewID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
