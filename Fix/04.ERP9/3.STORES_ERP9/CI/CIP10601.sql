IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP10601]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP10601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form CIP10601 : In Danh mục tỉnh- thành phố
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date: 09/06/2016
-- <Example>
---- 
/*
   EXEC CIP10601 'AS','','','','1'
*/

CREATE PROCEDURE CIP10601
( 
	@DivisionID VARCHAR(50),
	@CityID VARCHAR(50),
	@CityName NVARCHAR(250),
	@Disabled nvarchar(100),
    @IsCommon nvarchar(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)
                
SET @sWhere = ''
SET @OrderBy = 'A00.DivisionID, A00.CityID'
	--Check DivisionIDList null then get DivisionID 
	IF Isnull(@CityID,'') != '' 
		SET @sWhere = @sWhere + ' AND A00.CityID LIKE ''%'+@CityID+'%'' '
	IF Isnull(@CityName,'') != ''  
	SET @sWhere = @sWhere + 'AND A00.CityName LIKE N''%'+@CityName+'%'' '
	IF Isnull(@Disabled, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A00.Disabled,0) ='+@Disabled
	IF isnull(@IsCommon, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A00.IsCommon,0) = '+@IsCommon

SET @sSQL = '
SELECT 
Case when A00.IsCommon = 1 then '''' else A00.DivisionID end as DivisionID,
	A00.CityID,A00.CityName, A00.[Disabled],  A01.Description  as DisabledName, A00.IsCommon ,A02.Description  as IsCommonName  
FROM AT1002 A00 WITH (NOLOCK)
left join AT0099 A01 on A01.ID =A00.[Disabled] and  A01.CodeMaster =''AT00000004''
left join AT0099 A02 on A02.ID =A00.IsCommon and  A02.CodeMaster =''AT00000004''
WHERE 1=1 '+@sWhere+'
ORDER BY '+@OrderBy

EXEC (@sSQL)
PRINT @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
