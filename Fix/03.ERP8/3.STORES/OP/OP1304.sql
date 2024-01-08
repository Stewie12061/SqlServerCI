IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP1304]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP1304]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load bảng giá cho màn hình lập đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 15/09/2011 by Nguyễn Bình Minh
---- 
---- Modified on 22/08/2012 by Lê Thị Thu Hiền : Sửa điều kiện lọc theo ngày
---- Modified on 24/09/2012 by Lê Thị Thu Hiền : Bổ sung TypeID phân biệt giá mua hay giá bán
---- Modified on 28/12/2012 by Hải Long : Bỏ câu select rỗng khi else
---- Modified by Hải Long on 22/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tra Giang on 30/01/2019: Customize =105 (LIENQUAN) Load bảng giá được kế thừa cuối cùng 
---- Modified by Tra Giang on 30/01/2019: Customize =105 (LIENQUAN) Load trường hợp những bảng giá không kế thừa
---- Modified by Hoàng Vũ on 07/05/2019: Fix trường hợp không thiết lập dùng bảng giá thì trả ra Dataset theo yêu cầu
---- Modified by Bảo Toàn on 28/11/2019: Phân quyền load dữ liệu bảng giá cho PHIẾU BÁO GIÁ (customize DTI - 114)
---- Modified by Đức Thông on 24/11/2020: Chỉ load những bảng giá đã được duyệt (Dự án Liễn Quán)
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
---- Modified on 22/04/2021 by Đình Hòa : Bổ sung param @ConditionQuotationID từ fix dự án qua fix chuẩn
---- Modified on 14/08/2021	by Văn Tài  : Điều chỉnh trường hợp load bảng giá không quan tâm khách hàng.
---- Modified on 25/08/2021 by Kiều Nga : Fix lỗi không load bảng giá
---- Modified on 11/11/2021 by Kiều Nga : Bổ sung load thêm bảng giá theo nhóm hàng
---- Modified on 30/09/2022 by Thành Sang : Bổ sung load thêm bảng giá theo nhóm hàng trên erp 8
---- Modified on 15/11/2022 by Nhật Quang : Bổ sung thêm điều kiện kiểm tra trỗng O01ID -> O05ID
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Thành Sang on 17/03/2023: Load thêm bảng giá dùng chung trong hợp ObjectID có thiết lập OID ở AT1202 (CustomerIndex Bourbon)
---- Modified by Nhật Thanh on 05/05/2023: Cải tiến: Load những bảng giá dùng cho tất cả đối tượng
---- Modified by Hoàng Long on 10/07/2023: Cải tiến: Load bảng giá dự kiến
---- Modified by Hoàng Long on 28/07/2023: [2023/07/IS/0295] - GREE- Combobox Bảng giá mua khi tạo đơn hàng mua bị double dòng
---- Modified by Hồng Thắm on 23/10/2023: [2023/10/IS/0097] - GREE- Bị double mã bảng giá trong combobox Bảng giá khi tạo phiếu báo giá
-- <Example>
---- EXEC OP1304 N'AS', N'', '2011/09/01'

CREATE PROCEDURE OP1304
( 
	@DivisionID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@VoucherDate DATETIME,
	@TypeID AS INT = 0,	-- 0 : Giá bán
						-- 1 : Giá mua,
	@ScreenID VARCHAR(50)= '',
	@ConditionQuotationID VARCHAR(MAX) = '',
	@OpportunityID NVARCHAR(50) = ''
)
AS 
DECLARE @IsPriceControl AS TINYINT,
		@OTypeID AS NVARCHAR(50),
		@InventoryGroupAnaTypeID AS NVARCHAR(50),
		@CustomerName INT,
		@SQLString NVARCHAR(MAX),
		@sqlBourbon NVARCHAR(MAX) -- Load thêm trường hợp OT1301.OID tất cả dùng cho khách BBL
		
SELECT	@OTypeID = OPriceTypeID + 'ID',
		@IsPriceControl = IsPriceControl
FROM	OT0000 WITH (NOLOCK) 
WHERE	DivisionID = @DivisionID

SET @CustomerName = (SELECT CustomerName FROM CustomerIndex) 

SET @sqlBourbon = (CASE WHEN @CustomerName = 38 THEN '%' ELSE '' END)
	
SELECT	@InventoryGroupAnaTypeID = InventoryGroupAnaTypeID
FROM	AT0000 WITH (NOLOCK) 
WHERE	DefDivisionID = @DivisionID


IF @IsPriceControl = 1
BEGIN
	IF @CustomerName =105 -- (LIENQUAN)
		BEGIN 
		SELECT		ID AS PriceListID, Description AS PriceListName
		FROM		OT1301		WITH (NOLOCK)			
		WHERE		ID NOT IN (SELECT InheritID FROM OT1301 WITH (NOLOCK) WHERE InheritID IS NOT NULL)
					AND	CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
					AND DivisionID = @DivisionID AND [Disabled] = 0
					AND  ObjectID = @ObjectID
					AND ISNULL(TypeID , 0 ) = @TypeID
					AND ISNULL(PriceListStatus, 0) = 1 -- Bảng giá đã được duyệt
		ORDER BY	ID			
	END
	ELSE
	BEGIN
		IF @CustomerName =114 -- (DUCTIN)
			BEGIN
				SET @SQLString = '
				SELECT		ID AS PriceListID, Description AS PriceListName
				FROM		OT1301	WITH (NOLOCK)				
				WHERE		
				CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, ''9999-01-01''),101)
	
							AND DivisionID = @DivisionID AND [Disabled] = 0								
				AND ISNULL(TypeID , 0 ) = @TypeID '
					
				IF Isnull(@ConditionQuotationID, '') != ''
					SET @SQLString = @SQLString + ' AND ISNULL(OT1301.CreateUserID,'''') in (N'''+@ConditionQuotationID+''' )'
				
				exec sp_executesql @SQLString
					,N'@VoucherDate DATETIME,@DivisionID NVARCHAR(50),@TypeID INT'
					,@VoucherDate=@VoucherDate,@DivisionID=@DivisionID,@TypeID=@TypeID
			END
			ELSE

			BEGIN
			IF @CustomerName =162 -- (GREE)
				BEGIN
					SELECT		ID AS PriceListID, Description AS PriceListName, N'1' as Type, N'Bảng giá' as TypeName, IsTaxIncluded
					FROM		OT1301	 WITH (NOLOCK) 				
					WHERE		
						CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
						AND DivisionID = @DivisionID 
						AND [Disabled] = 0
						AND (OID = '%' OR OID	IN ( + @sqlBourbon , (SELECT	DISTINCT
												CASE WHEN @OTypeID = 'O01ID' 
														THEN 
															CASE WHEN O01ID IS NULL OR O01ID = '' THEN '%'
															ELSE
																O01ID
														    END
												 WHEN @OTypeID = 'O02ID'
														THEN 
															CASE WHEN O02ID IS NULL OR O02ID = '' THEN '%'
															ELSE
																O02ID
														     END
												 WHEN @OTypeID = 'O03ID'
														THEN 
															CASE WHEN O03ID IS NULL OR O03ID = '' THEN '%'
															ELSE
																O03ID
														     END
												 WHEN @OTypeID = 'O04ID' 
														THEN 
															CASE WHEN O04ID IS NULL OR O04ID = '' THEN '%'
															ELSE
																O04ID
														     END
											ELSE 
													CASE WHEN O05ID IS NULL OR O05ID = '' THEN '%'
													ELSE
																O05ID
													 END							 
											END 
											FROM AT1202 WITH (NOLOCK) 
											WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE @ObjectID OR ISNULL(@OpportunityID, '') != ''
									)))
						AND ISNULL(TypeID , 0 ) = @TypeID
						AND ISNULL(IsInheritCost, 0) = '0'
					UNION

					SELECT ID AS PriceListID, Description AS PriceListName, N'1' AS Type, N'Bảng giá dự án' AS TypeName, IsTaxIncluded
					FROM OT1301 WITH (NOLOCK)
					WHERE CONVERT(datetime, @VoucherDate, 101) BETWEEN CONVERT(datetime, FromDate, 101) AND CONVERT(datetime, ISNULL(ToDate, '9999-01-01'), 101)
						AND DivisionID = @DivisionID
						AND [Disabled] = 0
						AND ISNULL(TypeID, 0) = @TypeID
						AND ISNULL(IsInheritCost, 0) = '1'

					UNION ALL

					SELECT ID AS PriceListID, Description AS PriceListName , N'2' as Type, N'Bảng giá theo nhóm hàng' as TypeName, IsTaxIncluded
					FROM CT0152	
						WHERE		
						CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
						AND DivisionID = @DivisionID 
						AND [Disabled] = 0
						AND (OID = '%' OR OID	IN ( + @sqlBourbon , (SELECT	DISTINCT
												CASE WHEN @OTypeID = 'O01ID' 
														THEN 
															CASE WHEN O01ID IS NULL OR O01ID = '' THEN '%'
															ELSE
																O01ID
														    END
												 WHEN @OTypeID = 'O02ID'
														THEN 
															CASE WHEN O02ID IS NULL OR O02ID = '' THEN '%'
															ELSE
																O02ID
														     END
												 WHEN @OTypeID = 'O03ID'
														THEN 
															CASE WHEN O03ID IS NULL OR O03ID = '' THEN '%'
															ELSE
																O03ID
														     END
												 WHEN @OTypeID = 'O04ID' 
														THEN 
															CASE WHEN O04ID IS NULL OR O04ID = '' THEN '%'
															ELSE
																O04ID
														     END
											ELSE 
													CASE WHEN O05ID IS NULL OR O05ID = '' THEN '%'
													ELSE
																O05ID
													 END							 
											END 
											FROM AT1202 WITH (NOLOCK) 
											WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE @ObjectID OR ISNULL(@OpportunityID, '') != ''
									)))
						AND ISNULL(TypeID , 0 ) = @TypeID		
					ORDER BY	ID
				END 
				ELSE
				IF(@ScreenID = 'SOF2001' OR (@ScreenID = 'OF0031' AND @InventoryGroupAnaTypeID IS NOT NULL) )
				BEGIN
					SELECT		ID AS PriceListID, Description AS PriceListName, N'1' as Type, N'Bảng giá' as TypeName, IsTaxIncluded
					FROM		OT1301	 WITH (NOLOCK) 				
					WHERE		
						CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
						AND DivisionID = @DivisionID 
						AND [Disabled] = 0
						AND (OID = '%' OR OID	IN ( + @sqlBourbon , (SELECT	DISTINCT
												CASE WHEN @OTypeID = 'O01ID' 
														THEN 
															CASE WHEN O01ID IS NULL OR O01ID = '' THEN '%'
															ELSE
																O01ID
														    END
												 WHEN @OTypeID = 'O02ID'
														THEN 
															CASE WHEN O02ID IS NULL OR O02ID = '' THEN '%'
															ELSE
																O02ID
														     END
												 WHEN @OTypeID = 'O03ID'
														THEN 
															CASE WHEN O03ID IS NULL OR O03ID = '' THEN '%'
															ELSE
																O03ID
														     END
												 WHEN @OTypeID = 'O04ID' 
														THEN 
															CASE WHEN O04ID IS NULL OR O04ID = '' THEN '%'
															ELSE
																O04ID
														     END
											ELSE 
													CASE WHEN O05ID IS NULL OR O05ID = '' THEN '%'
													ELSE
																O05ID
													 END							 
											END 
											FROM AT1202 WITH (NOLOCK) 
											WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE @ObjectID OR ISNULL(@OpportunityID, '') != ''
									)))
						AND ISNULL(TypeID , 0 ) = @TypeID					
					UNION ALL
					SELECT ID AS PriceListID, Description AS PriceListName , N'2' as Type, N'Bảng giá theo nhóm hàng' as TypeName, IsTaxIncluded
					FROM CT0152	
						WHERE		
						CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
						AND DivisionID = @DivisionID 
						AND [Disabled] = 0
						AND (OID = '%' OR OID	IN ( + @sqlBourbon , (SELECT	DISTINCT
												CASE WHEN @OTypeID = 'O01ID' 
														THEN 
															CASE WHEN O01ID IS NULL OR O01ID = '' THEN '%'
															ELSE
																O01ID
														    END
												 WHEN @OTypeID = 'O02ID'
														THEN 
															CASE WHEN O02ID IS NULL OR O02ID = '' THEN '%'
															ELSE
																O02ID
														     END
												 WHEN @OTypeID = 'O03ID'
														THEN 
															CASE WHEN O03ID IS NULL OR O03ID = '' THEN '%'
															ELSE
																O03ID
														     END
												 WHEN @OTypeID = 'O04ID' 
														THEN 
															CASE WHEN O04ID IS NULL OR O04ID = '' THEN '%'
															ELSE
																O04ID
														     END
											ELSE 
													CASE WHEN O05ID IS NULL OR O05ID = '' THEN '%'
													ELSE
																O05ID
													 END							 
											END 
											FROM AT1202 WITH (NOLOCK) 
											WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE @ObjectID OR ISNULL(@OpportunityID, '') != ''
									)))
						AND ISNULL(TypeID , 0 ) = @TypeID		
					ORDER BY	ID
				END
				ELSE
				BEGIN
					SELECT		ID AS PriceListID, Description AS PriceListName, N'1' as Type, N'Bảng giá' as TypeName, IsTaxIncluded
					FROM		OT1301	 WITH (NOLOCK) 				
					WHERE		
						CONVERT(datetime,@VoucherDate, 101) BETWEEN CONVERT(datetime,FromDate,101) AND CONVERT(datetime,ISNULL (ToDate, '9999-01-01'),101)
						AND DivisionID = @DivisionID 
						AND [Disabled] = 0
						AND (OID = '%' OR OID	IN ( + @sqlBourbon , (SELECT	DISTINCT
												CASE WHEN @OTypeID = 'O01ID' 
														THEN 
															CASE WHEN O01ID IS NULL OR O01ID = '' THEN '%'
															ELSE
																O01ID
														    END
												 WHEN @OTypeID = 'O02ID'
														THEN 
															CASE WHEN O02ID IS NULL OR O02ID = '' THEN '%'
															ELSE
																O02ID
														     END
												 WHEN @OTypeID = 'O03ID'
														THEN 
															CASE WHEN O03ID IS NULL OR O03ID = '' THEN '%'
															ELSE
																O03ID
														     END
												 WHEN @OTypeID = 'O04ID' 
														THEN 
															CASE WHEN O04ID IS NULL OR O04ID = '' THEN '%'
															ELSE
																O04ID
														     END
											ELSE 
													CASE WHEN O05ID IS NULL OR O05ID = '' THEN '%'
													ELSE
																O05ID
													 END							 
											END 
											FROM AT1202 WITH (NOLOCK) 
											WHERE DivisionID IN (@DivisionID, '@@@') AND ObjectID LIKE @ObjectID OR ISNULL(@OpportunityID, '') != ''
									)))
						AND ISNULL(TypeID , 0 ) = @TypeID
					ORDER BY	ID		
				END
			END
	END		
END
Begin
	Declare @TableOT1301 table
				( PriceListID Nvarchar(50),
					PriceListName Nvarchar(Max)
				)
	SELECT	PriceListID, PriceListName
	From @TableOT1301
End


-- SQL dùng để tạo dataset
/*
DROP TABLE OP1304Z

SELECT ID AS PriceListID, Description AS PriceListName
INTO OP1304Z
FROM OT1301	
*/



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
