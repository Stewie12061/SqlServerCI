IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


  
-- <Summary>  
---- Chay but toan phan bo.  
-- <Param>  
----   
-- <Return>  
----   
-- <Reference>  
----   
-- <History>  
------ Created By Hải Long.  
------ Date 13.09.2016.  
------ Purpose: Truy vấn mã đơn hàng với tham số (ANPHAT) 
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>  
  
CREATE PROCEDURE [dbo].[OP0086]  
(   
       @DivisionID nvarchar(50),  
       @FromMonth AS int,
       @ToMonth AS int,
       @FromYear AS int,
       @ToYear AS int,
       @FromDate AS datetime,
       @ToDate AS DATETIME,
       @IsDate AS tinyint
)         
AS  
SET NOCOUNT ON  

IF @IsDate = 0
BEGIN
	SELECT SorderID, OT2001.ObjectID, AT1202.ObjectName, OT2001.Notes AS [Description]
	FROM OT2001 WITH (NOLOCK)
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND OT2001.ObjectID = AT1202.ObjectID
	WHERE OT2001.DivisionID = @DivisionID AND OrderType = 0
	AND OT2001.TranYear*12 + OT2001.TranMonth BETWEEN @FromYear*12+@FromMonth AND @ToYear*12+@ToMonth
END 
ELSE
	BEGIN
		SELECT SorderID, OT2001.ObjectID, AT1202.ObjectName, OT2001.Notes AS [Description]
		FROM OT2001 WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND OT2001.ObjectID = AT1202.ObjectID
		WHERE OT2001.DivisionID = @DivisionID AND OrderType = 0
		AND OrderDate BETWEEN CONVERT(NVARCHAR(20), @FromDate, 101) AND CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'	
	END

		
SET NOCOUNT OFF  


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
