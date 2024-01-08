IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP1001]
GO

/****** Object:  StoredProcedure [dbo].[QCP1001]    Script Date: 30/07/2020 14:05:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- <Summary>
---- Load Detail Cập nhật tiêu chuẩn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Thi on 12/10/2020
---- Modify on 04/06/2021 by Đình Hòa - Load bổ sung Loại của bảng tính giá(MECI)

-- <Example> EXEC QCP1001 @DivisionID = 'VNP', @UserID = 'ASOFTADMIN ', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'

CREATE PROCEDURE [dbo].[QCP1001]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 
	SELECT T1.APK, T1.DivisionID, T1.StandardID, T1.StandardName, T1.StandardNameE, T1.UnitID
		 , T1.Description, T1.Disabled, T1.IsCommon, T1.IsDefault, T1.IsVisible, T1.TypeID, T1.ParentID
		 , T1.DataType, T2.Description AS TypeName, T2.DescriptionE As TypeNameE, T1.CalculateType, T1.CreateDate
		 , T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID, T1.Specification, T1.Recipe, T1.PhaseID, A1.PhaseName
		 , M1.Description AS SpecificationName, Q1.Description AS DataTypeName, T1.DeclareSO, T1.DisplayName, T1.UsingMaterialID, T1.TypeSpreadsheetID
	FROM QCT1000 T1 WITH (NOLOCK) 
		LEFT JOIN QCT0099 T2 WITH (NOLOCK) ON ISNULL(T2.Disabled, 0)= 0 AND T2.ID = T1.TypeID
		LEFT JOIN QCT0099 Q1 WITH (NOLOCK) ON Q1.CodeMaster = 'DataType' AND ISNULL(Q1.Disabled, 0)= 0 AND Q1.ID = T1.DataType
		LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.CodeMaster = 'Specification' AND ISNULL(M1.Disabled, 0)= 0 AND M1.ID = T1.Specification
		LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = T1.PhaseID
	WHERE T1.APK = @APK
	ORDER BY T1.StandardName

GO