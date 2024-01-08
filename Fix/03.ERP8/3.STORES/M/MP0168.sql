IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0168]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0168]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Customize Angel: Lấy danh sách các phiếu KHSX tổng hợp công đoạn chưa được kế thừa hoặc kế thừa chưa hết
---- Created by Bảo Anh, Date: 25/02/2016
---- Modified by Tiểu Mai on 30/11/2016: Sửa lại truy lưu vết từ OT2202_AG
---- MP0168 'CTY',9,2013,'%'

CREATE PROCEDURE [dbo].[MP0168] 
    @DivisionID NVARCHAR(50),
	@TranMonth int,
	@TranYear int,
	@TeamID NVARCHAR(50),
    @VoucherID AS NVARCHAR(50) = ''
AS

--- Lọc ra các KHSX tổng hợp công đoạn chưa kế thừa hoặc kế thừa chưa hết
SELECT EstimateID, TransactionID, (MaterialQuantity - Isnull(ProductQuantity,0)) as EndQuantity
INTO #TAM
FROM	(
	Select OT03.EstimateID, TransactionID, Isnull(MaterialQuantity,0) as MaterialQuantity, Isnull(ProductQuantity,0) as ProductQuantity
	From OT2203 OT03
	Left join	(Select DivisionID, InheritVoucherID, InheritTransactionID, sum(Quantity) as ProductQuantity From OT2202_AG
				Where DivisionID = @DivisionID And Isnull(InheritTransactionID,'') <> ''
				Group by DivisionID, InheritVoucherID, InheritTransactionID
				) OT02 
	On OT03.DivisionID = OT02.DivisionID And OT03.EstimateID = OT02.InheritVoucherID and OT03.TransactionID = OT02.InheritTransactionID
	Inner join OT2201 OT01 On OT03.DivisionID = OT01.DivisionID And OT03.EstimateID = OT01.EstimateID
	Where OT03.DivisionID = @DivisionID and OT03.TranMonth = @TranMonth and OT03.TranYear = @TranYear
	And ExpenseID = 'COST001' And Isnull(OT01.TeamID,'') like @TeamID
) A
WHERE MaterialQuantity - Isnull(ProductQuantity,0) > 0

--- Trả dữ liệu
IF isnull(@VoucherID,'')<> ''	--- khi load edit
	SELECT cast(1 as BIT) as IsChecked, EstimateID as VoucherID, VoucherNo, VoucherDate, Description, OT2201.TeamID, HT1101.TeamName
	FROM OT2201
	LEFT JOIN HT1101 On OT2201.DivisionID = HT1101.DivisionID and OT2201.TeamID = HT1101.TeamID
	WHERE OT2201.DivisionID = @DivisionID
	AND exists (Select top 1 1 From OT2202 Where DivisionID = @DivisionID And InheritTableID = 'OT2203' And EstimateID =  @VoucherID and Isnull(InheritVoucherID,'') = OT2201.EstimateID)

	UNION ALL
	SELECT cast(0 as BIT) as IsChecked, EstimateID as VoucherID, VoucherNo, VoucherDate, Description, OT2201.TeamID, HT1101.TeamName
	FROM OT2201
	LEFT JOIN HT1101 On OT2201.DivisionID = HT1101.DivisionID and OT2201.TeamID = HT1101.TeamID
	WHERE OT2201.DivisionID = @DivisionID and TranMonth = @TranMonth and TranYear = @TranYear
	And exists (Select top 1 1 From #TAM Where EstimateID = OT2201.EstimateID)
	And not exists (Select top 1 1 From OT2202 Where DivisionID = @DivisionID And InheritTableID = 'OT2203' And EstimateID =  @VoucherID and Isnull(InheritVoucherID,'') = OT2201.EstimateID)

	ORDER BY VoucherDate, VoucherNo
	
ELSE --- khi load addnew
	SELECT cast(0 as BIT) as IsChecked, EstimateID as VoucherID, VoucherNo, VoucherDate, Description, OT2201.TeamID, HT1101.TeamName
	FROM OT2201
	LEFT JOIN HT1101 On OT2201.DivisionID = HT1101.DivisionID and OT2201.TeamID = HT1101.TeamID
	WHERE OT2201.DivisionID = @DivisionID and TranMonth = @TranMonth and TranYear = @TranYear
	And exists (Select top 1 1 From #TAM Where EstimateID = OT2201.EstimateID)
	ORDER BY VoucherDate, VoucherNo

DROP TABLE #TAM


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
