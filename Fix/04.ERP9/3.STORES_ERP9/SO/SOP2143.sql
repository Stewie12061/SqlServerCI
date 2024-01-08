IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2143]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2143]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Kiều Nga, date: 10/08/2021
----purpose: In don hang ban 
---- exec SOP2143 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@Orderid=N'SO1/01/2016/170'

CREATE PROCEDURE [dbo].[SOP2143] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

Declare @sSQL AS nvarchar(max) ='';

SET @sSQL= 'SELECT T1.APK,T1.DivisionID,T1.InvestorID, T2.ObjectName as InvestorName,T1.GeneralContractorID,T3.FullName as GeneralContractorName,
T1.ContractID, T1.AppendixContractID,T1.EmployeeID,T4.FullName as EmployeeName,T1.ProjectManagementID,T5.FullName as ProjectManagementName,
T1.ClerkID,T6.FullName as ClerkName,T1.RevenueExcludingVAT,T1.Revenue,T1.TotalCostOfGoodsSold,T1.ProfitBeforeTax
FROM SOT2140 T1 WITH (NOLOCK)
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.InvestorID = T2.ObjectID 
LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID IN (''@@@'',T1.DivisionID) AND T1.GeneralContractorID = T3.EmployeeID 
LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID IN (''@@@'',T1.DivisionID) AND T1.EmployeeID = T4.EmployeeID  
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID IN (''@@@'',T1.DivisionID) AND T1.ProjectManagementID = T5.EmployeeID  
LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID IN (''@@@'',T1.DivisionID) AND T1.ClerkID = T6.EmployeeID  
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APK = '''+ @APK+'''

SELECT  T1.APK,T1.DivisionID,ISNULL(T1.Notes,'''') +ISNULL(T1.Specification,'''') as Notes,T1.UnitID,T2.UnitName,T1.Quantity,
T1.CostPrice, T1.Coefficient, T1.UnitPrice,T1.Profit,T1.TotalCostPrice,T1.CostPriceRate,T1.Revenue,T1.TotalProfit   
FROM SOT2141 T1 WITH (NOLOCK)
LEFT JOIN AT1304 T2 WITH (NOLOCK) ON T2.DivisionID IN (''@@@'',T1.DivisionID) AND T1.UnitID = T2.UnitID 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APKMaster = '''+ @APK+'''
'

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
