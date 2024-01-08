/****** Object:  View [dbo].[MV8888]    Script Date: 12/16/2010 15:41:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Created by: Vo Thanh Huong, date: 13/06/2005
--Purpose: Quan ly bao cao (view chet)

ALTER VIEW [dbo].[MV8888] 
AS
Select 'G01' as GroupID, 'MFML000247'  as GroupName, DivisionID --'Chi ph� pha�t sinh'
FROM AT1101

UNION
Select 'G02' as GroupID,  'MFML000248' as GroupName, DivisionID --'Pha�n bo�'
FROM AT1101

UNION
Select 'G03' as GroupID,  'MFML000249' as GroupName, DivisionID --'Gia� tha�nh sa�n pha�m'
FROM AT1101

UNION
Select 'G08' as GroupID, 'MFML000250' as GroupName, DivisionID --'Ke�t qua� sa�n xua�t' 
FROM AT1101

UNION
Select 'G09' as GroupID, 'MFML000251' as GroupName, DivisionID --'Qua�n ly� sa�n xua�t' 
FROM AT1101

UNION
Select 'G99' as GroupID, 'MFML000252' as GroupName, DivisionID --'Kha�c' 
FROM AT1101


GO


