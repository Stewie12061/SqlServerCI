/****** Object:  View [dbo].[HV1115]    Script Date: 12/16/2010 15:08:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

------Create Date: 22/09/2005
------Purpose: View chet, phuc vu thiet lap bao cao luong
------Edit by: Dang Le Bao Quynh
------Edit Date: 07/06/2006
ALTER VIEW [dbo].[HV1115]
AS
SELECT IncomeID AS CodeID, Caption AS Caption, 
	'IO'  AS Type, 'Thu nha�p' as Description
FROM HT0002
WHERE IsUsed = 1
UNION
SELECT CoefficientID  as CodeID,    Caption ,
	    'CO'  AS Type,  'He� so�' as Description
FROM HV1111
UNION
SELECT GeneralAbsentID    AS CodeID,   Description AS Caption,
	 'GA'  AS Type, 'Nga�y co�ng to�ng h��p' as Description
FROM HT5002
UNION
SELECT AbsentTypeID as CodeID, AbsentName as Caption, 
	'MA' AS Type, 'Nga�y co�ng tha�ng' as Description	
FROM HT1013 
WHERE IsMonth = 1
UNION
SELECT AbsentTypeID as CodeID, AbsentName as Caption, 
	'DA' AS Type, 'Nga�y co�ng nga�y' as Description	
FROM HT1013 
WHERE IsMonth <> 1
UNION
SELECT FieldID AS CodeID, Description AS Caption, 
    'SA'  AS Type, 'M��c l��ng' as Description
FROM HV1112
WHERE FOrders < 5
UNION
SELECT SubID AS CodeID, Caption, 
	'SU'  AS Type, 'Gia�m tr��' as Description
FROM HT0005
WHERE IsUsed = 1
UNION
SELECT     'S00' AS Code, 'Thue� thu nha�p' AS Caption, 'SU' AS Type, 'Gia�m tr��' AS Description
UNION
SELECT 'TA' AS CodeID, 'Thue thu nhap' AS Caption, 
	'TA'  AS Type, 'Thue� thu nha�p' as Description
UNION 
Select '' as Code, '' as Caption,
	'OT' as Type, 'Kha�c' as Description

GO


