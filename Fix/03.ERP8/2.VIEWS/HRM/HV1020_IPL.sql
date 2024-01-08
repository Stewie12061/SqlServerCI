IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV1020_IPL]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV1020_IPL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- Create on 26/07/2016
-- Purpose: View chet tra ve thong tin ca lam viec (Customize cho IPL)

CREATE VIEW [dbo].[HV1020_IPL]
AS
SELECT     HT1020.ShiftID, HT1020.DivisionID, HT1020.ShiftName, HT1020.BeginTime, HT1020.EndTime, HT1020.WorkingTime, HT1020.Notes, 
                      HT1021.AbsentTypeID, Min(HT1021.FromMinute) AS FromMinute, Max(HT1021.ToMinute) AS ToMinute, 
					  HT1021.IsNextDay AS IsNextDay, 
					  Max(HT1021.IsOvertime) AS IsOvertime, Max(HT1021.RestrictID) AS RestrictID, 
                      Max(HT1021.Orders) AS Orders, HT1021.DateTypeID, HT1013.TypeID
FROM       HT1020 INNER JOIN HT1021 ON HT1020.ShiftID = HT1021.ShiftID and HT1020.DivisionID = HT1021.DivisionID
                  LEFT JOIN HT1013 On HT1021.DivisionID = HT1013.DivisionID And HT1021.AbsentTypeID = HT1013.AbsentTypeID

GROUP BY HT1020.ShiftID, HT1020.DivisionID, HT1020.ShiftName, HT1020.BeginTime, HT1020.EndTime, HT1020.WorkingTime, HT1020.Notes, 
         HT1021.AbsentTypeID, HT1021.IsNextDay, HT1021.DateTypeID, HT1013.TypeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
