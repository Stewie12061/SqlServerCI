IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MV1003]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[MV1003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----Created by: Vo Thanh Huong, date: 02/12/2005
---purpose: View chet, loc ra cac lenh san xuat cho combo 
---- Modified by Bảo Thy on 23/05/2017: Sửa ALTER => CREATE

CREATE VIEW [dbo].[MV1003] as 
Select T00.DivisionID, TranMonth, TranYear, PlanID, VoucherTypeID, VoucherDate, VoucherNo, SOderID,  Description, PlanStatus, 
	T00.EmployeeID, FullName
From MT2001 T00 --left join AT1102  T01 on T00.DepartmentID = T01.DepartmentID
	left join AT1103 T02 on T02.EmployeeID = T00.EmployeeID

GO


