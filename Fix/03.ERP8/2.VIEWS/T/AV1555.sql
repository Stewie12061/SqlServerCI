IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1555]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1555]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-------- Created by Van Nhan.
---------Date 26/10/2007
-------- View chet, the hien so du va so phat sinh bao cao THTG TSCD
--------Last Edit Thuy Tuyen  , date 19/11/2007
----- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
---- Modified on 12/10/2018 by Kim Thư: Bổ sung trường hợp tính lại nguyên giá và giá còn lại khi có thay đổi nguyên giá
---- Modified on 18/06/2019 by Kim Thư: Sửa tính SignAmount còn lại sau thay đổi

CREATE VIEW [dbo].[AV1555] as 
----------------------------------- Lay nguyen gia ------------------------------
Select 	DivisionID, AssetID, AssetStatus, ConvertedAmount, ConvertedAmount  as SignAmount, 'CA' As DataTypeID,
	AssetAccountID as AccountID,
	--BeginMonth as TranMonth,
	---BeginYear as TranYear,
	Month (EstablishDate)as TranMonth , 
	Year(EstablishDate) as TranYear ,
	'D' as D_C,  --- BL
	isnull(CauseID,'MU') as  FromStatusID,  --- Cause
	Case when AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID,
	AssetGroupID 	--- Ung voi 
From AT1503 WITH (NOLOCK)
UNION ALL -- Nguyên giá sau thay đổi
Select 	A1.DivisionID, A1.AssetID, ISNULL(A1.AssetStatus,A2.AssetStatus) AS AssetStatus, A1.ConvertedNewAmount-A1.ConvertedOldAmount AS ConvertedAmount, 
A1.ConvertedNewAmount-A1.ConvertedOldAmount  as SignAmount, 'CA' As DataTypeID,
	AssetAccountID as AccountID,
	--BeginMonth as TranMonth,
	---BeginYear as TranYear,
	A1.TranMonth , 
	A1.TranYear ,
	'D' as D_C,  --- BL
	isnull(A2.CauseID,'MU') as  FromStatusID,  --- Cause
	Case when A1.AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID,
	A2.AssetGroupID 	--- Ung voi 
From AT1506 A1 INNER JOIN AT1503 A2 ON A1.DivisionID = A2.DivisionID AND A1.AssetID=A2.AssetID
----------------------------------- Lay ghi giam ------------------------------
UNION ALL
Select 	At1523.DivisionID, AT1523.AssetID, At1523.AssetStatus, AT1523.ConvertedAmount, -(At1523.ConvertedAmount)  as SignAmount, 'CA' As DataTypeID,
	AssetAccountID as AccountID,
	ReduceMonth as TranMonth,
	ReduceYear as TranYear,
	'C' as D_C,  --- BL
	isnull(CauseID,'MU') as  FromStatusID,  --- Cause
	Case when At1523.AssetStatus =2 then 'NB' Else 'TL' End as NowStatusID,
	AssetGroupID 	--- Ung voi 
From AT1523 WITH (NOLOCK)
	Inner Join AT1503 WITH (NOLOCK) on AT1503.AssetID = AT1523.AssetID




---------------------------------- Hao mon -----------------------------------------------------------
Union All
Select 	AT1504.DivisionID, AT1504.AssetID, ISNULL(AT1506.AssetStatus,AT1503.AssetStatus) as AssetStatus, AT1504.DepAmount as ConvertedAmount, -AT1504.DepAmount as SignAmount, 
'DE' As DataTypeID,
	CreditAccountID as AccountID,
	AT1504.TranMonth as TranMonth,
	AT1504.TranYear as TranYear,
	'C' as D_C,
	isnull(CauseID,'MU') as  FromStatusID,
	Case when ISNULL(AT1506.AssetStatus,AT1503.AssetStatus) =3 then 'DTL' Else 'DSD' End as NowStatusID 	,
	AssetGroupID
From AT1504 WITH (NOLOCK) inner join AT1503 WITH (NOLOCK) on AT1503.AssetID =AT1504.AssetID
LEFT JOIN AT1506 WITH (NOLOCK) ON AT1506.AssetID = AT1503.AssetID
Union All
Select 	DivisionID, AssetID, AssetStatus, ConvertedAmount-isnull(ResidualValue,0) as ConvertedAmount, -ConvertedAmount+isnull(ResidualValue,0) as SignAmount, 'DE' As DataTypeID,
	DepAccountID as AccountID,
	BeginMonth as TranMonth,
	BeginYear as TranYear,
	
	'C' as D_C,
	isnull(CauseID,'MU') as  FromStatusID,
	Case when AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID 	,
	AssetGroupID
From AT1503 WITH (NOLOCK)
Where isnull(ResidualValue,0)<>ConvertedAmount 

Union All ----- Gia tri con lai
Select 
AT1503.DivisionID, AT1503.AssetID, AT1503.AssetStatus,
AT1503.ConvertedAmount  as ConvertedAmount,  
AT1503.ConvertedAmount  as SignAmount, 'RE' As DataTypeID,
	DepAccountID as AccountID,
	---BeginMonth as TranMonth,
	---BeginYear as TranYear,
	Month (EstablishDate)as TranMonth , 
	Year(EstablishDate) as TranYear ,

	'C' as D_C,
	isnull(CauseID,'MU') as  FromStatusID,
	Case when AT1503.AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID 	,
	AssetGroupID
From AT1503 WITH (NOLOCK)
UNION ALL
Select -- Còn lại sau thay đổi
AT1506.DivisionID, AT1506.AssetID, ISNULL(AT1506.AssetStatus,AT1503.AssetStatus) AS AssetStatus,
AT1506.ConvertedNewAmount  as ConvertedAmount,  
--AT1506.ConvertedNewAmount as SignAmount, 
AT1506.ConvertedNewAmount - AT1506.ConvertedOldAmount  as SignAmount, 
'RE' As DataTypeID,
DepAccountID as AccountID,
 AT1506.TranMonth , 
 AT1506.TranYear ,
'C' as D_C,
isnull(AT1503.CauseID,'MU') as  FromStatusID,
Case when AT1506.AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID ,
AssetGroupID
From AT1503 WITH (NOLOCK)  LEFT JOIN AT1506 WITH (NOLOCK) ON AT1503.AssetID = AT1506.AssetID

Union All --giam  gia tri hao mon

Select 	AT1523.DivisionID, AT1523.AssetID, AT1503.AssetStatus, AT1523.AccuDepAmount as ConvertedAmount,  AT1523.AccuDepAmount  as SignAmount, 'DE' As DataTypeID,
	DepAccountID as AccountID,
	ReduceMonth as TranMonth,
	ReduceYear as TranYear,
	'D' as D_C,
	isnull(CauseID,'MU') as  FromStatusID,
	Case when AT1503.AssetStatus =3 then 'DTL' Else 'DSD' End as NowStatusID 	,
	AssetGroupID
From AT1523 WITH (NOLOCK) iNNER jOIN AT1503 WITH (NOLOCK) on AT1503.AssetID = AT1523.AssetID




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
