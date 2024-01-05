IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2078]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2078]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Danh sách những Giáo viên, Bảo mẫu đã được lập phiếu điều chuyển
---- Điều kiện là Ngày hiệu lực ở tương lại ( Ngày mai trở đi )
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Updated by:	Lương Mỹ	on	24/10/2019

-- <Example>
---- 
/*-- <Example>
	EDMP2078 @DivisionID = 'BE', @UserID = 'ASOFTADMIN'

	EDMP2078 @DivisionID, @UserID,@StudentID, @DateFrom,@DateTo, @Mode
----*/

CREATE PROCEDURE EDMP2078
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50)

)

AS 


	DECLARE @DateEffect DATETIME 
	SET @DateEffect =  DATEADD(DAY, 1, GETDATE()) --GETDATE()

		DECLARE @Result table (	VoucherNo VARCHAR(50), 
							DivisionID VARCHAR(50),
							TeacherID VARCHAR(50),
							GradeID VARCHAR(50),
							ClassID VARCHAR(50),
							GradeIDTo VARCHAR(50),
							ClassIDTo VARCHAR(50),
							Type VARCHAR(50)	-- School: Chuyển trường
												-- Class: Chuyển lớp
	)

	-- Danh sách Giáo viên chuyển trường
	INSERT INTO	@Result(VoucherNo,DivisionID,TeacherID,GradeID,ClassID,GradeIDTo,ClassIDTo, Type)
	SELECT T1.VoucherNo, T1.DivisionID, T2.TeacherID, T2.GradeIDFrom AS GradeID, T2.ClassIDFrom AS ClassID, T2.GradeIDTo, T2.ClassIDTo, 'School'
	FROM dbo.EDMT2070 T1 WITH (NOLOCK)
	JOIN dbo.EDMT2071 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg = T1.DeleteFlg
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0
		AND T1.DecisionDate >= CONVERT(VARCHAR(10), CONVERT(DATE, @DateEffect,120), 126)
		AND T1.DivisionIDTo <> T1.DivisionID

	-- Danh sách Giáo viên chuyển lớp
	INSERT INTO	@Result(VoucherNo,DivisionID,TeacherID,GradeID,ClassID,GradeIDTo,ClassIDTo, Type)
	SELECT T1.VoucherNo, T1.DivisionID, T2.TeacherID, T2.GradeIDFrom AS GradeID, T2.ClassIDFrom AS ClassID, T2.GradeIDTo, T2.ClassIDTo, 'Class'
	FROM dbo.EDMT2070 T1 WITH (NOLOCK)
	JOIN dbo.EDMT2071 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg = T1.DeleteFlg
	WHERE T1.DivisionID = @DivisionID AND T1.DeleteFlg = 0
		AND T1.DecisionDate >= CONVERT(VARCHAR(10), CONVERT(DATE, @DateEffect,120), 126)
		AND T1.DivisionIDTo = T1.DivisionID
 
	
	-- Tổng kết
	SELECT * FROM @Result









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
