IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1304]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP1304]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---Created by: Vo Thanh Huong, date: 06/12/2004
---purpose: Quan ly lich su cong tac
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [30/07/2010]
'**************************************************************/
---- Modified by Phuong Thao on 05/01/2015: Bo sung Ban, Cong doan (Customize Meiko)
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Anh on 10/01/2019: Bổ sung khu vực trước và sau khi thuyên chuyển

CREATE PROCEDURE [dbo].[HP1304] @DivisionID nvarchar(50),				
				@EmployeeID nvarchar(50)			
AS
DECLARE @sSQL nvarchar(4000) 
Set @sSQL = 'Select  HistoryID,  T00.DivisionID, T00.DepartmentID, T00.TeamID, T00.EmployeeID, V00.FullName,T00.IsPast, T00.IsBeforeTranfer, 
	T00.FromMonth, T00.FromYear, T00.ToMonth, T00.ToYear, T00.FromDate, T00.ToDate,  T00.DutyID, Works, 
	case when IsPast = 1 then T00.DivisionName else T01.DivisionName end as DivisionName,  
	case when IsPast = 1  then T00.DepartmentName else T02.DepartmentName end as DepartmentName, 
	case when IsPast = 1  then T00.TeamName else T03.TeamName end as TeamName,
	case when IsPast = 1 then T00.DutyName else T04.DutyName end as DutyName,
	T00.SalaryAmounts, T00.SalaryCoefficient, T00.Description, T00.Notes, 
	T00.DivisionIDOld, T00.DepartmentIDOld,	T00.TeamIDOld, T00.DutyIDOld, T00.WorksOld,
	T00.ContactTelephone, T00.Contactor, T00.ContactAddress,
	T00.SectionIDOld, T00.SectionID, T00.ProcessIDOld, T00.ProcessID,
	T00.ProvinceOld, T00.Province
From HT1302 T00 left join AT1101 T01 on T00.DivisionID = T01.DivisionID
left join AT1102  T02 on T02.DepartmentID = T00.DepartmentID
left join HT1101 T03 on T03.DivisionID = T00.DivisionID and T03.DepartmentID = T00.DepartmentID and  T03.TeamID = T00.TeamID
left join  HT1102 T04 on T04.DutyID = T00.DutyID and T04.DivisionID = T00.DivisionID
inner join HV1400 V00 on V00.EmployeeID = T00.EmployeeID and V00.DivisionID = T00.DivisionID
Where T00.DivisionID = '''+@DivisionID+''' '

if exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV1304')
	Drop view HV1304
EXEC('Create view HV1304 ---tao boi HP1304
			as ' + @sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

