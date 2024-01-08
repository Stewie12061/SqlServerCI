IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP1605_TN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP1605_TN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Create By : Dang Le Bao Quynh; Date: 12/08/2008
--Purpose: Tra ra ket qua ke thua ket qua san xuat de tao bo he so
--Modified by Bảo Thy on 22/05/2017: Sửa ALTER => CREATE
--Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
--Modified by Xuân Nguyên on 04/01/2023: Bổ sung load giá trị theo bộ hệ số
/********************************************
'* Edited by: [GS] [Tố Oanh] [30/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[MP1605_TN] 
	@PeriodID As nvarchar(50),
	@Unfinished As TinyInt,
	@CoefficientID As nvarchar(50) = ''
AS

If @Unfinished =  1
	Select Distinct ProductID As InventoryID, AT13.InventoryName As InventoryName,ISNULL(AT16.CoValue,'1') As CoValue
	From MT1001 MT10 
	Inner Join MT0810 MT08 On MT10.VoucherID = MT08.VoucherID
	Left Join AT1302 AT13 On MT10.ProductID = AT13.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@')
	Left Join MT1605 AT16 On MT10.ProductID = AT16.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@') and ISNULL(CoefficientID,'')=@CoefficientID
	Where MT08.PeriodID =  @PeriodID
Else
	Select Distinct ProductID As InventoryID, AT13.InventoryName As InventoryName, ISNULL(AT16.CoValue,'1') As CoValue
	From MT1001 MT10 
	Inner Join MT0810 MT08 On MT10.VoucherID = MT08.VoucherID
	Left Join AT1302 AT13 On MT10.ProductID = AT13.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@')
	Left Join MT1605 AT16 On MT10.ProductID = AT16.InventoryID AND AT13.DivisionID IN (MT10.DivisionID,'@@@') and ISNULL(CoefficientID,'')=@CoefficientID
	Where MT08.PeriodID =  @PeriodID And ResultTypeID = 'R01'

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

