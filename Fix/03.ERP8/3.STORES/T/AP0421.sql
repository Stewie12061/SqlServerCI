IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0421]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0421]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load truy vấn nghiệp vụ khoản thu lô đất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Kiều Nga, Date: 05/04/2022
-- <Example>
---- 
/*-- <Example>
		EXEC AP0421 @DivisionID = 'CBD', @UserID = 'ASOFTADMIN', @BlockID = '%',@StoreID='',@CostTypeID='DIEN',@ObjectID = '%',@ContractType = '%',@TranferID = '%',@TranMonth = '2',@TranYear= '2019'

		AP0421 @DivisionID,@UserID,@BlockID,@StoreID,@CostTypeID,@ObjectID,@ContractType,@TranferID,@TranMonth,@TranYear
----*/

CREATE PROCEDURE AP0421 ( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @CostTypeID VARCHAR(4000),
	 @ObjectID VARCHAR(50),
	 @ContractNo VARCHAR (50),
	 @TranMonth AS INT,
     @TranYear AS INT 
	 
)
AS 
Begin

	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sWhere NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(500) = N''
		
  
	SET @OrderBy = ' ORDER BY T1.ObjectID,T1.ContractNo,T1.CostTypeID'
		IF ISNULL(@ContractNo, '') != '' 
				SET @sWhere = @sWhere + N' AND T1.ContractNo LIKE N'''+@ContractNo+''''
		IF ISNULL(@ObjectID,'') != ''
				SET @sWhere = @sWhere + N' AND T1.ObjectID LIKE N'''+@ObjectID+''' '	
		IF ISNULL(@CostTypeID,'') != ''
				SET @sWhere = @sWhere + N' AND T1.CostTypeID IN ('''+@CostTypeID+''') '	
		

	SET @sSQL = @sSQL + N'
			SELECT T1.*
			, T2.ObjectName
			, T3.Description as CostTypeName
			FROM AT0420 T1 WITH (NOLOCK)
			LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.ObjectID = T1.ObjectID
			LEFT JOIN AT0099 T3 WITH (NOLOCK) ON T3.CodeMaster = ''CostTypeID'' AND T1.CostTypeID = T3.ID AND T3.Disabled =0
			WHERE T1.DivisionID = ''' + @DivisionID + '''
			AND T1.TranMonth = ' + STR(@TranMonth) + ' 
			AND T1.TranYear = ' + STR(@TranYear) + '
			 '+@sWhere + @OrderBy +' 
		'
	
END




EXEC (@sSQL)
PRINT(@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
