IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP90000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP90000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra @KeyValues (@ID hoặc @APK) đã sử dụng trước khi xóa/sửa
----Do ERP9 đã xử lý trường hợp dùng chung không bắn qua DivisionID và khi insert kiểm tra Mã duy nhất nên không kiểm tra DivisionID
----Store này nếu kiểm tra Danh mục thì không truyền DivisionID, nếu kiểm tra nghiệp vụ thì truyền DivisionID
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Phan Thanh Hoàng Vũ, Date: 11/08/2017
----<Edited by>: Phan Thanh Hoàng Vũ, Date: 10/01/2017: Bổ sung check xóa danh mục đã sử dụng trong nghiệp vụ, nhưng khi xóa thì chưa bỏ chặn xóa nghiệp vụ đã bị xóa
----<Edited by>: Khâu Vĩnh Tâm, Date: 22/02/2020: Bổ sung check xóa dữ liệu Chỉ tiêu KPI và Nhóm chỉ tiêu
----<Example>
/*
	DECLARE @Status TINYINT
	EXEC KPIP90000 'KC', 'AT1010', 'T01',@Status  OUTPUT
	SELECT @Status
*/
CREATE PROCEDURE KPIP90000 (
				@DivisionID VARCHAR(50),
				@TableID  NVARCHAR(50) = NULL,
				@KeyValues VARCHAR(MAX) = NULL,
				@Status  TINYINT OUTPUT
			)
AS
	IF @TableID = 'KPIT10601' -- Danh mục đợt đánh giá KPI/DGNL
	BEGIN 
		IF EXISTS (SELECT TOP 1 1 FROM KPIT10102 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT10502 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT10701 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20001 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT10103 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT10201 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT20001 WITH (NOLOCK) WHERE EvaluationPhaseID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   )
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END
	END

	IF @TableID = 'KPIT10101' -- Danh mục nhóm chỉ tiêu KPI/DGNL
	BEGIN 
		IF EXISTS (SELECT TOP 1 1 FROM KPIT10502 WITH (NOLOCK) WHERE TargetsGroupID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT10702 WITH (NOLOCK) WHERE TargetsGroupID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20002 WITH (NOLOCK) WHERE TargetsGroupID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT10103 WITH (NOLOCK) WHERE AppraisalGroupID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT10202 WITH (NOLOCK) WHERE AppraisalGroupID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM PAT20002 WITH (NOLOCK) WHERE AppraisalGroupID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   -- Detail của màn hình Thiết lập đánh giá công việc/dự án
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT0050 WITH (NOLOCK) WHERE TargetsGroupID = @KeyValues
				   -- Master của màn hình Thiết lập đánh giá công việc/dự án
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT0051 WITH (NOLOCK) WHERE TargetsGroupID = @KeyValues
				   -- Dữ liệu đánh giá công việc
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT2130 O1 WITH (NOLOCK)
						INNER JOIN OOT2110 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APK AND ISNULL(O2.DeleteFlg, 0) = 0
				   WHERE TargetsGroupID = @KeyValues
				   )
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END
	END

	IF @TableID = 'KPIT10301' -- Danh mục nguồn đo KPI
		IF EXISTS (SELECT TOP 1 1 FROM KPIT10501 WITH (NOLOCK) WHERE SourceID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT10702 WITH (NOLOCK) WHERE SourceID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20002 WITH (NOLOCK) WHERE SourceID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
					)
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END

	IF @TableID = 'KPIT10401' -- Danh mục đơn vị tính KPI
		IF EXISTS (SELECT TOP 1 1 FROM KPIT10501 WITH (NOLOCK) WHERE UnitKpiID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT10702 WITH (NOLOCK) WHERE UnitKpiID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20002 WITH (NOLOCK) WHERE UnitKpiID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   )
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END

	IF @TableID = 'KPIT10501' -- Danh mục chỉ tiêu KPI
		IF EXISTS (SELECT TOP 1 1 FROM KPIT10702 WITH (NOLOCK) WHERE TargetsID = @KeyValues
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20002 WITH (NOLOCK) WHERE TargetsID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   -- Mẫu công việc
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT1060 WITH (NOLOCK) WHERE TargetTypeID = @KeyValues
				   -- Mẫu công việc trong Bước quy trình
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT1031 WITH (NOLOCK) WHERE TargetTypeID = @KeyValues
				   -- Mẫu công việc trong Quy trình
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT1021 WITH (NOLOCK) WHERE TargetTypeID = @KeyValues
				   -- Mẫu công việc trong Mẫu dự án
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT1051 WITH (NOLOCK) WHERE TargetTypeID = @KeyValues
				   -- Công việc
				   UNION ALL
				   SELECT TOP 1 1 FROM OOT2110 WITH (NOLOCK) WHERE TargetTypeID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0)
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END
	
	IF @TableID = 'KPIT10701' -- Danh mục thiết lập bảng đánh giá KPI
		IF EXISTS (SELECT TOP 1 1 FROM KPIT20001 WITH (NOLOCK) WHERE EvaluationSETID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0
				   UNION ALL
				   SELECT TOP 1 1 FROM KPIT20102 WITH (NOLOCK) WHERE EvaluationSETID = @KeyValues AND ISNULL(DeleteFlg, 0) = 0)
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END

	IF @TableID = 'KPIT20001' -- Danh mục ca nhân tự đánh giá KPI
		IF EXISTS (SELECT TOP 1 1 FROM KPIT20102 WITH (NOLOCK) WHERE Cast(APKMInherited as varchar(100)) = @KeyValues AND ISNULL(DeleteFlg, 0) = 0)
		BEGIN 
			SET @Status = 1
			GOTO Mess
		END
Mess:


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
