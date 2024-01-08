IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0547]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0547]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <Param>
----	Xóa dữ liệu tính lương tổng hợp từ lương thời vụ.
-- <Return>
---- 
-- <Reference> HRM/Nghiep vu/ Tinh luong (PLUGIN NQH)
---- Bang phan ca
-- <History>
---- Modified [] on 22/12/2020:
-- <Example>
---- EXEC HP0547 'NQH', 12, 2020, 'F.03.01.PARTTIME'
CREATE PROCEDURE HP0547
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@EmployeeID VARCHAR(50)
)
AS
BEGIN

	DECLARE @SQL VARCHAR(MAX) = '',
			@CurSectionID VARCHAR(50) = ''
		
	-- Lấy mã chuyền trong hồ sơ lương.
	SET @CurSectionID = (
							SELECT TOP 1 SectionID 
							FROM HT3400 WITH (NOLOCK)
							WHERE DivisionID = @DivisionID
								AND	TranYear = @TranYear
								AND TranMonth = @TranMonth
								AND EmployeeID = @EmployeeID
						)

	-- Cập nhật tổng hợp cho bảng hồ sơ lương thời vụ.
	UPDATE HT0537
	SET IsCalculated = 0
	WHERE DivisionID = @DivisionID
			AND	TranYear = @TranYear
			AND TranMonth = @TranMonth
			AND SectionID = @CurSectionID

	-- Xóa dữ liệu tính lương.
	DELETE HT3400
	WHERE DivisionID = @DivisionID
			AND	TranYear = @TranYear
			AND TranMonth = @TranMonth			
			AND EmployeeID = @EmployeeID

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
