USE [master]
GO
/****** Object:  Database [ECommerce_10022017]    Script Date: 13-02-2017 12:48:35 ******/
CREATE DATABASE [ECommerce_10022017]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECommerce_10022017', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MAINSERVER\MSSQL\DATA\ECommerce_10022017.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ECommerce_10022017_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MAINSERVER\MSSQL\DATA\ECommerce_10022017_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ECommerce_10022017] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECommerce_10022017].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECommerce_10022017] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ECommerce_10022017] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECommerce_10022017] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECommerce_10022017] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ECommerce_10022017] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECommerce_10022017] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET RECOVERY FULL 
GO
ALTER DATABASE [ECommerce_10022017] SET  MULTI_USER 
GO
ALTER DATABASE [ECommerce_10022017] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECommerce_10022017] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECommerce_10022017] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECommerce_10022017] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ECommerce_10022017', N'ON'
GO
USE [ECommerce_10022017]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteCartItemsByID]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_DeleteCartItemsByID]
@ProductID int
AS
BEGIN
Delete from CartItemsList Where ProductID=@ProductID
END




GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteLocationWiseShipping]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create Procedure [dbo].[sp_DeleteLocationWiseShipping]
@LocationWiseShippingID int
As
Begin
Delete LocationWiseShipping where LocationWiseShippingID=@LocationWiseShippingID
End 

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteLocationWiseShippingFalse]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[sp_DeleteLocationWiseShippingFalse]
As
Begin
Delete LocationWiseShipping where COD='False'
End 

GO
/****** Object:  StoredProcedure [dbo].[sp_getLocationByCity]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getLocationByCity]

@CityID INT= 0
AS
BEGIN 
--Select
--	 LocationID
--	,LocationName
--	,PinCode
--	,l.StateID
--    ,l.CityID
--	,l.COD
--	,l.Status
--	,l.CreatedDate
--	,s.StateName
--	,c.CityName
--	FROM Location as l
--	Inner join State as s on l.StateID = s.StateID
--    Inner join City as c on l.CityID = c.CityID
--	--Inner Join LocationWiseShipping as lws on l.LocationID=lws.LocationTypeID
--	WHERE l.Deleted = 0 AND l.CityID=@CityID --AND lws.LocationTypeID !=  l.LocationID 
--	-- AND lws.COD='false'

Select
	 LocationID
	,LocationName
	,PinCode
	,l.StateID
    ,l.CityID
	,l.COD
	,lws.COD
	,l.Status
	,l.CreatedDate
	,s.StateName
	,c.CityName
	FROM Location as l
	Inner join State as s on l.StateID = s.StateID
    Inner join City as c on l.CityID = c.CityID
	left Join LocationWiseShipping as lws on l.LocationID=lws.LocationTypeID
	WHERE l.Deleted = 0  and lws.COD is null AND l.CityID=@CityID 
	--AND lws.LocationTypeID !=  l.LocationID 
END



GO
/****** Object:  StoredProcedure [dbo].[sp_ProductRewardRoint]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ProductRewardRoint]  
  
@ProductID INT  
AS  
BEGIN 
 
   
SELECT   
   ISNULL(PR.[ID],0) AS ID ,   
   ISNULL(PR.[ProductID],0) as ProductID,   
   ISNULL(CG.[CustomerGroupID],0) as CustomerGroupID,   
   ISNULL(PR.[RewardPoint],0) as RewardPoint,   
    CG.[CustomerGroupName]   
    FROM [dbo].[ProductRewardPoint] AS PR 
    RIGHT JOIN   [dbo].[CustomerGroup] AS CG  
    ON PR.[CustomerGroupID] = CG.[CustomerGroupID] and PR.[ProductID] = @ProductID  
     
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SearchAffiliates]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_SearchAffiliates]

@AffiliateID INT=0,
@EMail VARCHAR(50)='',
@CreatedDate VARCHAR(50)=''

AS
BEGIN

	DECLARE @SQL VARCHAR(MAX)

	SET @SQL = 'SELECT AffiliateID
	,FirstName
	,LastName
	,FirstName + '' ''+LastName AS ''Name''
    ,EMail,Telephone
	,Fax
	,Company
	,website
	,Status
	,CreatedDate

	FROM dbo.Affiliates WHERE Deleted = 0 '

	IF @AffiliateID <> 0
	BEGIN
	 SET @SQL = @SQL + ' AND AffiliateID  ='+CONVERT(VARCHAR(50),@AffiliateID)+'' 
	END

	IF @EMail !=''
	BEGIN
	SET @SQL = @SQL + ' AND (EMail LIKE ''%' + @EMail + '%'')'
	END
	IF @CreatedDate != ''
	BEGIN
	SET @SQL = @SQL + ' AND CONVERT(DATETIME,CreatedDate,103) = CONVERT(DATETIME,'''+ @CreatedDate +''',103)'
	END
	
	EXEC (@SQL)
	--PRINT @SQL
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SearchCustomer]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_SearchCustomer]

@CustomerID INT=0,
@CustomerGroupID INT,
@CreatedDate VARCHAR(50)=''

AS
BEGIN

	DECLARE @SQL VARCHAR(MAX)

	SET @SQL = 'SELECT C.[CustomerID]
	,C.[CustomerGroupID]
	,CG.[CustomerGroupName]
	,C.[Name]
	,C.[FirstName]
	--,C.[LastName]
	--,C.[FirstName] + '' ''+C.[LastName] AS ''Name''
    ,C.[EMail],C.[Telephone]
	,C.[Fax]
	,C.[Newsletter]
	,C.[Status]
	,C.[CreatedDate]
	,C.[Deleted]

	FROM Customer  C 
	Left JOIN CustomerGroup  CG ON C.CustomerGroupID = CG.CustomerGroupID
	where C.Deleted= 0'

	IF @CustomerID <>0
	BEGIN
	 SET @SQL = @SQL + ' AND C.CustomerID = '+CONVERT(VARCHAR(50),@CustomerID)+'' 
	END

	IF @CustomerGroupID <> 0
	BEGIN
	SET @SQL = @SQL + ' AND  CONVERT(VARCHAR(50),C.CustomerGroupID) = ' + CONVERT(VARCHAR(50),@CustomerGroupID) + ''
	END
	IF @CreatedDate != ''
	BEGIN
	SET @SQL = @SQL + ' AND CONVERT(DATETIME,C.CreatedDate,103) = CONVERT(DATETIME,'''+ @CreatedDate +''',103)'
	END
	
	EXEC (@SQL)
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SearchLocations]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_SearchLocations]

@StateID INT=0,
@CityID INT=0,
@PinCode VARCHAR(50)='',
@LocationName VARCHAR(50)=''

AS
BEGIN
	DECLARE @SQL VARCHAR(MAX)
	SET 
	@SQL = 'SELECT 
	 LocationID
	,LocationName
	,PinCode
	,l.StateID
    ,l.CityID
	,COD
	,Status
	,CreatedDate
	,s.StateName
	,c.CityName
	FROM Location as l
	Inner join State as s on l.StateID = s.StateID
    Inner join City as c on l.CityID = c.CityID
	WHERE l.Deleted = 0'

	IF @StateID <> 0
	BEGIN
	 SET @SQL = @SQL + ' AND l.StateID  ='+CONVERT(varchar(50),@StateID)+'' 
	END
	IF @CityID <> 0
	BEGIN
	 SET @SQL = @SQL + ' AND l.CityID  ='+CONVERT(varchar(50),@CityID)+'' 
	END
	IF @PinCode !=''
	BEGIN
	SET @SQL = @SQL + ' AND PinCode Like''%'+@PinCode+'%''' 
	END
	IF @LocationName != ''
	BEGIN
	 SET @SQL = @SQL + ' AND LocationName Like ''%'+@LocationName+'%''' 
	END

	EXEC (@SQL)
	PRINT @SQL
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SearchProduct]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_SearchProduct]
@ProductID VARCHAR(50)
,@Price VARCHAR(50)
,@ModelNo VARCHAR(50)
,@Quantity VARCHAR(50)
,@Status VARCHAR(50)

AS
BEGIN
	DECLARE @SQL VARCHAR(MAX)
	
	SET @SQL = '
			SELECT ProductID
				   ,Image
				   ,ProductName
				   ,ModelNo
				   ,Price
				   ,Quantity
				   ,Status
			FROM Product
			WHERE Deleted = 0 '
			
	IF @ProductID <> ''
	BEGIN
	SET @SQL = @SQL + ' AND ProductID = '+@ProductID+''
	END
	
	IF @ModelNo <> ''
	BEGIN
	SET @SQL = @SQL + ' AND ModelNo LIKE ''%' + @ModelNo + '%'''
	END

	IF @Price <> ''
	BEGIN
	SET @SQL = @SQL + ' AND Price = '+@Price+''
	END
	
	IF @Quantity <> 0
	BEGIN
	SET @SQL = @SQL + ' AND Quantity = ' + @Quantity + ''
	END
		
	IF @Status <> ''
	BEGIN
	SET @SQL = @SQL + ' AND Status = ' + @Status + ''
	END
	EXEC (@SQL)
	
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SearchUnitPrice]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_SearchUnitPrice]

@WeightID INT=0,
@Unit VARCHAR(50)='',
@UnitPrice VARCHAR(50)=''
AS
BEGIN
	DECLARE @SQL VARCHAR(MAX)
	SET 
	@SQL = 'SELECT 
	 ShippingPriceID
	,s.WeightID
	,s.Unit
	,s.UnitPrice
    ,wc.WeightTitle
	,wc.WeightUnit
	FROM ShippingPrice as s
	Inner join WeightClass as wc on s.WeightID = wc.WeightID
	WHERE s.Deleted = 0'

	IF @WeightID <> 0
	BEGIN
	 SET @SQL = @SQL + ' AND s.WeightID  ='+CONVERT(varchar(50),@WeightID)+'' 
	END
	IF @Unit !=''
	BEGIN
	SET @SQL = @SQL + ' AND s.Unit Like''%'+@Unit+'%''' 
	END
	IF @UnitPrice != ''
	BEGIN
	 SET @SQL = @SQL + ' AND s.UnitPrice Like ''%'+@UnitPrice+'%''' 
	END

	EXEC (@SQL)
	PRINT @SQL
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCartItems]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_SelectCartItems]
@CustomerID int
AS
BEGIN
SELECT [CartItemsID]
      ,[CustomerID]
      ,CL.[ProductID]
	  ,CL.[Image]
	  --,CL.[ModelNo]
      ,CL.[ModelNo]
      ,CL.[Price]
	  ,CL.[DiscountedPrice]
      ,CL.[Quantity]
      ,CL.[CreatedBy]
      ,CL.[UpdatedBy]
      ,CL.[CreatedDate]
      ,CL.[UpdatedDate]
      ,CL.[DeletedDate]
      ,CL.[Deleted]
	  ,P.ProductName
  FROM CartItemsList CL
  INNER JOIN Product P ON CL.ProductID=p.ProductID
  Where CustomerID=@CustomerID
END




GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCategories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectCategories]   
     
AS    
BEGIN    
    
    
WITH CTE(CategoriesID, CategoriesName,SortOrder,[Status], OrderString) AS    
(    
  SELECT     
    CategoriesID, cast(CategoriesName as varchar(max)),SortOrder,[Status],    
    cast(cast(CategoriesID as char(5)) as varchar(max)) OrderString    
  FROM     
    Categories     
  WHERE     
    parentid is null and Deleted=0    
  UNION ALL    
  SELECT     
    p.CategoriesID, cast(c.CategoriesName + '  >>  ' + p.CategoriesName as varchar(max)),p.SortOrder,p.[Status],    
    c.OrderString +  cast(cast(p.CategoriesID as char(5))as varchar(max))    
  FROM     
    Categories p     
  JOIN    
    CTE c ON c.CategoriesID = p.parentid where  p.Deleted=0    
)    
SELECT     
  *     
FROM     
  CTE     
ORDER BY     
  OrderString    
-- If the depth of the hierarchy is greater than 100 use OPTION    
-- to override the server-wide default recursion level    
-- OPTION (MAXRECURSION 0)    
END


GO
/****** Object:  StoredProcedure [dbo].[sp_SelectCategoriesWithLevels]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectCategoriesWithLevels]
	
AS
BEGIN
	--DECLARE @CategoriesID int

--SET @CategoriesID = 34;

WITH CTE_Table_1
(
  CategoriesID,
  CategoriesName,
  ParentID,
  TreeLevel
)
AS(
 SELECT 
  CategoriesID,
  CategoriesName,
  ISNULL(ParentID,0),
  0 AS TreeLevel
 FROM Categories
 WHERE ParentID IS NULL

UNION ALL

 SELECT 
  ISNULL(T.CategoriesID,0),
  T.CategoriesName,
  ISNULL(T.ParentID,0),
  ISNULL(TreeLevel + 1,0)
 FROM Categories T
 INNER JOIN CTE_Table_1 ON CTE_Table_1.CategoriesID = T.ParentID
)

SELECT * FROM CTE_Table_1
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectLocationWiseTypeAll]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[sp_SelectLocationWiseTypeAll]
As 
Begin

SELECT * ,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select LocationName+' -> '+CityName+' -> '+s.StateName from Location
inner join City  c on c.CityID = Location.CityID
inner join State s on s.StateID=c.StateID where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  (  Select StateName from [State] where StateID=x.LocationTypeID )  	
  WHEN LocationWiseType ='City' 
     THEN (Select CityName+' -> '+s.StateName from City c inner join State s on s.StateID=c.StateID where CityID=x.LocationTypeID)
	end  as LocationTypeName
,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select s.StateID from Location
inner join City  c on c.CityID = Location.CityID
inner join State s on s.StateID=c.StateID where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  0  	
  WHEN LocationWiseType ='City' 
     THEN (Select s.StateID from City c inner join State s on s.StateID=c.StateID where CityID=x.LocationTypeID)
	end  as StateID
	,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select c.CityID from Location
inner join City  c on c.CityID = Location.CityID
 where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  0  	
  WHEN LocationWiseType ='City' 
     THEN (Select c.CityID from City c where CityID=x.LocationTypeID)
	end  as CityID


FROM [LocationWiseShipping] x Where x.Deleted='false' AND x.COD='true' order by LocationWiseShippingID asc





End

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectLocationWiseTypeDataByID]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_SelectLocationWiseTypeDataByID]
@LocationWiseShippingID int
As 
Begin

SELECT * ,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select LocationName+' -> '+CityName+' -> '+s.StateName from Location
inner join City  c on c.CityID = Location.CityID
inner join State s on s.StateID=c.StateID where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  (  Select StateName from [State] where StateID=x.LocationTypeID )  	
  WHEN LocationWiseType ='City' 
     THEN (Select CityName+' -> '+s.StateName from City c inner join State s on s.StateID=c.StateID where CityID=x.LocationTypeID)
	end  as LocationTypeName
,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select s.StateID from Location
inner join City  c on c.CityID = Location.CityID
inner join State s on s.StateID=c.StateID where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  0  	
  WHEN LocationWiseType ='City' 
     THEN (Select s.StateID from City c inner join State s on s.StateID=c.StateID where CityID=x.LocationTypeID)
	end  as StateID
	,
CASE
  WHEN LocationWiseType ='Location' 
    THEN (Select c.CityID from Location
inner join City  c on c.CityID = Location.CityID
 where Location.LocationID=x.LocationTypeID)
  WHEN LocationWiseType ='State' 
	 THEN  0  	
  WHEN LocationWiseType ='City' 
     THEN (Select c.CityID from City c where CityID=x.LocationTypeID)
	end  as CityID


FROM [LocationWiseShipping] x where x.LocationWiseShippingID=@LocationWiseShippingID order by LocationWiseShippingID asc

End

GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProductCategories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectProductCategories]  
    
@ProductID int     
AS    
BEGIN    
     
    SELECT PC.[ID]    
      ,PC.[CategoriesID]    
      ,PC.[ProductID]     
      ,c.CategoriesName    
  FROM [ProductCategories] PC inner join Categories C on Pc.CategoriesID =c.CategoriesID    
  where PC.[ProductID]  =@ProductID    
END



GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProductFrontEnd]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SelectProductFrontEnd]         
        
 @CategoriesID int,        
 @OrderBy varchar(50),  
 @Filter varchar(max)        
AS        
BEGIN        
 Declare @SQL VARCHAR(MAX)        
Set @SQL ='SELECT DISTINCT PD.[ProductID]        
      ,PD.[ProductName]        
      ,PD.[Description]        
      ,PD.[MetaTagTitle]        
      ,PD.[MetaTagKeywords]        
      ,PD.[MetaTagDescription]        
      ,PD.[SEOKeywords]        
      ,PD.[ProductTags]        
      ,PD.[Image]        
      ,PD.[ModelNo]        
      ,PD.[SKU]        
      ,PD.[UPC]        
      ,PD.[EAN]        
      ,PD.[JAN]        
      ,PD.[ISBN]        
      ,PD.[MPN]        
      ,PD.[Location]        
      ,PD.[Price]        
      ,PD.[TaxID]        
      ,PD.[Quantity]        
      ,PD.[MinimumQuantity]        
      ,PD.[SubtractStock]        
      ,PD.[StockStatusID]        
      ,PD.[RequiresShipping]        
      ,PD.[DateAvailable]        
      ,PD.[Length]        
      ,PD.[Width]        
      ,PD.[Height]        
      ,PD.[LengthID]        
      ,PD.[Weight]        
      ,PD.[WeightID]        
      ,PD.[Status]        
      ,PD.[SortOrder]        
      ,PD.[ManufacturerID]        
      ,PD.[CreatedBy]        
      ,PD.[UpdatedBy]        
      ,PD.[CreatedDate]       
      ,PD.[UpdatedDate]        
      ,PD.[DeletedDate]        
      ,PD.[Deleted]
	  --,(select P.[ProductID] as ProductID, P.[Quantity] as DiscountedQuantity, P.[Price] as DiscountedPrice, P.[WSaler] as WSaler from dbo.ProductDiscount P where  PD.ProductID=P.ProductID) as DicountOnProduct 
      ,(select COUNT(RW.ReviewID) as ReviewCount from dbo.Review RW where RW.Deleted =0 and RW.ProductID=PD.ProductID) as ReviewCount 
      ,(select Avg(RW.Rating) as AvgRating from dbo.Review RW where RW.Deleted =0 and RW.ProductID= PD.ProductID )   as AvgRating  
      ,dbo.fn_SelectparentCategories('+CONVERT(varchar(50), @CategoriesID)+') as CategoriesName        
  FROM [Product] PD         
  INNER JOIN ProductCategories PC ON PD.ProductID =PC.ProductID        
  LEFT JOIN ProductFilter  PFG ON PD.ProductID =PFG.ProductID         
  LEFT JOIN Categories C ON PC.CategoriesID =C.CategoriesID       
  WHERE PD.DELETED=0 AND (PC.CategoriesID ='+CONVERT(varchar(50), @CategoriesID)+' OR C.ParentID = '+CONVERT(varchar(50), @CategoriesID)+')'        
          
          
 IF @Filter <> ''       
 BEGIN        
 SET @SQL = @SQL + ' and (PFG.FilterID in ('+@Filter+'))'      
 END        
 IF  @OrderBy <> ''     
 BEGIN        
 SET @SQL = @SQL + ' ORDER BY PD.Price '+@OrderBy+''        
 END        
         
 EXEC (@SQL)  
 print(@SQL)        
END



GO
/****** Object:  StoredProcedure [dbo].[StoredProcedure_ErrorLog]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[StoredProcedure_ErrorLog]
AS
BEGIN
SET NOCOUNT ON 
        
         INSERT INTO [ErrorLog]  
             (
             ErrorNumber 
            ,ErrorDescription 
            ,ErrorProcedure 
            ,ErrorState 
            ,ErrorSeverity 
            ,ErrorLine 
            ,ErrorTime 
           )
           VALUES
           (
             ERROR_NUMBER()
            ,ERROR_MESSAGE()
            ,ERROR_PROCEDURE()
            ,ERROR_STATE()
            ,ERROR_SEVERITY()
            ,ERROR_LINE()
            ,GETDATE()  
           );
    
SET NOCOUNT OFF    
END

GO
/****** Object:  UserDefinedFunction [dbo].[fn_SelectparentCategories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_SelectparentCategories]
(
	@CategoriesID varchar(50)
)
RETURNS varchar(max)
AS
BEGIN
DECLARE @ret varchar(max); 

WITH CTE(CategoriesID, CategoriesName) AS  
(  
  SELECT   
    CategoriesID, cast(CategoriesName as varchar(max))
    
  FROM   
    Categories   
  WHERE   
    parentid is null and Deleted=0 
  UNION ALL  
  SELECT   
    p.CategoriesID, cast(c.CategoriesName + '  /  ' + p.CategoriesName as varchar(max))
      
  FROM   
    Categories p   
  JOIN  
    CTE c ON c.CategoriesID = p.parentid    where  p.Deleted=0  
)  

  
    SELECT @ret =(SELECT   CategoriesName  FROM   CTE  WHERE   CategoriesID=@CategoriesID)


return @ret







	---- Declare the return variable here
	--DECLARE <@ResultVar, sysname, @Result> <Function_Data_Type, ,int>

	---- Add the T-SQL statements to compute the return value here
	--SELECT <@ResultVar, sysname, @Result> = <@Param1, sysname, @p1>

	---- Return the result of the function
	--RETURN <@ResultVar, sysname, @Result>

END



GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = Rtrim(Ltrim(SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))))
      END
 
      RETURN
END



GO
/****** Object:  Table [dbo].[Affiliates]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Affiliates](
	[AffiliateID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[EMail] [varchar](30) NULL,
	[Telephone] [char](11) NULL,
	[Fax] [char](11) NULL,
	[Company] [varchar](100) NULL,
	[website] [varchar](100) NULL,
	[StateID] [int] NULL,
	[CityID] [int] NULL,
	[Address] [varchar](300) NULL,
	[Pincode] [int] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Affiliates] PRIMARY KEY CLUSTERED 
(
	[AffiliateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Attribute]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Attribute](
	[AttributeID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [varchar](50) NULL,
	[AttributeGroupID] [int] NULL,
	[SortOrder] [int] NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Attribute] PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AttributeGroup]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AttributeGroup](
	[AttributeGroupID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeGroupName] [varchar](50) NULL,
	[SortOrder] [int] NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_AttributeGroup] PRIMARY KEY CLUSTERED 
(
	[AttributeGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CartItemsList]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CartItemsList](
	[CartItemsID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[ProductID] [int] NULL,
	[Image] [varchar](max) NULL,
	[ModelNo] [varchar](50) NULL,
	[DiscountedPrice] [numeric](18, 2) NULL,
	[Price] [numeric](18, 2) NULL,
	[Quantity] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_CartItemsList] PRIMARY KEY CLUSTERED 
(
	[CartItemsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoriesID] [int] IDENTITY(1,1) NOT NULL,
	[CategoriesName] [varchar](50) NULL,
	[ParentID] [int] NULL,
	[StoreID] [int] NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[FilterGroupID] [int] NULL,
	[SEOKeywords] [varchar](max) NULL,
	[ImageName] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoryFilterGroup]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFilterGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FilterGroupID] [int] NULL,
	[CategoriesID] [int] NULL,
 CONSTRAINT [PK_CategoryFilterGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[StateID] [int] NULL,
	[CityName] [varchar](50) NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerGroupID] [int] NULL,
	[Name] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[EMail] [varchar](30) NULL,
	[Password] [varchar](30) NULL,
	[Telephone] [char](11) NULL,
	[Fax] [char](11) NULL,
	[StateID] [int] NULL,
	[CityID] [int] NULL,
	[Address] [varchar](300) NULL,
	[Pincode] [int] NULL,
	[Newsletter] [bit] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerGroup]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerGroup](
	[CustomerGroupID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerGroupName] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[StoreID] [int] NULL,
	[SortOrder] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_CustomerGroup] PRIMARY KEY CLUSTERED 
(
	[CustomerGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DeliveryDetails]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliveryDetails](
	[DeliveryDetailID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[Name] [varchar](50) NULL,
	[Mobile] [varchar](10) NULL,
	[Address1] [varchar](max) NULL,
	[Address2] [varchar](max) NULL,
	[StateID] [int] NULL,
	[CityID] [int] NULL,
	[Pincode] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_DeliveryDetails] PRIMARY KEY CLUSTERED 
(
	[DeliveryDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Discount](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[Priority] [varchar](10) NULL,
	[DiscountOrder] [varchar](10) NULL,
	[DiscountPercent] [numeric](18, 2) NULL,
	[StartDate] [char](10) NULL,
	[EndDate] [char](10) NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Enquiry]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Enquiry](
	[EnquiryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[ContactNo] [varchar](50) NULL,
	[Message] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Enquiry] PRIMARY KEY CLUSTERED 
(
	[EnquiryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorID] [bigint] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [nvarchar](50) NOT NULL,
	[ErrorDescription] [nvarchar](4000) NULL,
	[ErrorProcedure] [nvarchar](100) NULL,
	[ErrorState] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorLine] [int] NULL,
	[ErrorTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Filter]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Filter](
	[FilterID] [int] IDENTITY(1,1) NOT NULL,
	[FilterName] [varchar](150) NULL,
	[FilterGroupID] [int] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_FilterGroup] PRIMARY KEY CLUSTERED 
(
	[FilterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FilterGroup]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FilterGroup](
	[FilterGroupID] [int] IDENTITY(1,1) NOT NULL,
	[FilterGroupName] [varchar](150) NULL,
	[SortOrder] [int] NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_FilterGroup_1] PRIMARY KEY CLUSTERED 
(
	[FilterGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HomePageImages]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HomePageImages](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](max) NULL,
	[Status] [bit] NULL,
	[SortOrder] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_HomePageImages] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HomePageProduct]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HomePageProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[SortNo] [int] NULL,
	[NumberOfProduct] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_HomePageProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Information]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Information](
	[InformationID] [int] IDENTITY(1,1) NOT NULL,
	[InformationTitle] [varchar](50) NULL,
	[StoreID] [int] NULL,
	[Description] [varchar](max) NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[FilterGroupID] [int] NULL,
	[SEOKeywords] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Information] PRIMARY KEY CLUSTERED 
(
	[InformationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[DeliveryDetailID] [int] NULL,
	[CartSubTotal] [varchar](50) NULL,
	[ShippingFee] [varchar](50) NULL,
	[PaymentModeID] [int] NULL,
	[OrderTotalPrice] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[InvoiceDetailID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NULL,
	[ProductID] [int] NULL,
	[ModelNo] [varchar](50) NULL,
	[Price] [numeric](18, 2) NULL,
	[Quantity] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LengthClass]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LengthClass](
	[LengthID] [int] IDENTITY(1,1) NOT NULL,
	[LengthTitle] [varchar](50) NULL,
	[LengthUnit] [varchar](50) NULL,
	[Value] [numeric](18, 10) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_LengthClass] PRIMARY KEY CLUSTERED 
(
	[LengthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Location]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationName] [varchar](max) NULL,
	[PinCode] [varchar](10) NULL,
	[StateID] [int] NULL,
	[CityID] [int] NULL,
	[COD] [bit] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LocationWiseShipping]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocationWiseShipping](
	[LocationWiseShippingID] [int] IDENTITY(1,1) NOT NULL,
	[LocationWiseType] [varchar](50) NULL,
	[LocationTypeID] [int] NULL,
	[ShippingPrice] [varchar](50) NULL,
	[COD] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_LocationWiseShipping] PRIMARY KEY CLUSTERED 
(
	[LocationWiseShippingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Login]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Login](
	[LoginID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[StoreID] [int] NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerName] [varchar](50) NULL,
	[Image] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[StoreID] [int] NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[FilterGroupID] [int] NULL,
	[SEOKeywords] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Manufacurer] PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Marketing]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Marketing](
	[MarketingID] [int] IDENTITY(1,1) NOT NULL,
	[CampaignName] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Marketing] PRIMARY KEY CLUSTERED 
(
	[MarketingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Option]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Option](
	[OptionID] [int] IDENTITY(1,1) NOT NULL,
	[OptionName] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[SortOrder] [int] NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Option] PRIMARY KEY CLUSTERED 
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OptionDetails]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OptionDetails](
	[OptionDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[OptionID] [int] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_OptionValue] PRIMARY KEY CLUSTERED 
(
	[OptionDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentType]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentType](
	[PaymentModeID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMode] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[MetaTagDescription] [varchar](max) NULL,
	[SEOKeywords] [varchar](max) NULL,
	[ProductTags] [varchar](50) NULL,
	[Image] [varchar](250) NULL,
	[ModelNo] [varchar](50) NULL,
	[SKU] [varchar](50) NULL,
	[UPC] [varchar](50) NULL,
	[EAN] [varchar](50) NULL,
	[JAN] [varchar](50) NULL,
	[ISBN] [varchar](50) NULL,
	[MPN] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Price] [numeric](18, 2) NULL,
	[TaxID] [int] NULL,
	[Quantity] [varchar](50) NULL,
	[MinimumQuantity] [char](10) NULL,
	[SubtractStock] [bit] NULL,
	[StockStatusID] [int] NULL,
	[RequiresShipping] [bit] NULL,
	[DateAvailable] [char](10) NULL,
	[Length] [varchar](50) NULL,
	[Width] [varchar](50) NULL,
	[Height] [varchar](50) NULL,
	[LengthID] [int] NULL,
	[Weight] [varchar](50) NULL,
	[WeightID] [int] NULL,
	[Status] [bit] NULL,
	[SortOrder] [int] NULL,
	[ManufacturerID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductAttribute](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeID] [int] NULL,
	[ProductID] [int] NULL,
	[Text] [varchar](250) NULL,
 CONSTRAINT [PK_ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CategoriesID] [int] NULL,
	[ProductID] [int] NULL,
	[Status] [varchar](10) NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductDiscount]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductDiscount](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[WSaler] [bit] NULL,
	[Quantity] [varchar](10) NULL,
	[Priority] [varchar](10) NULL,
	[Price] [numeric](18, 2) NULL,
	[StartDate] [varchar](10) NULL,
	[EndDate] [varchar](50) NULL,
 CONSTRAINT [PK_ProductDiscount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductFilter]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductFilter](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FilterID] [int] NULL,
	[ProductID] [int] NULL,
 CONSTRAINT [PK_ProductFilterGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Image] [varchar](max) NULL,
	[ProductID] [int] NULL,
	[SortOrder] [int] NULL,
 CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductOption]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductOption](
	[ProductOptionID] [int] IDENTITY(1,1) NOT NULL,
	[OptionID] [int] NULL,
	[Required] [bit] NULL,
	[ProductID] [int] NULL,
 CONSTRAINT [PK_ProductOption] PRIMARY KEY CLUSTERED 
(
	[ProductOptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductOptionDetails]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductOptionDetails](
	[ProductOptionDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProductOptionID] [int] NULL,
	[OptionDetailsID] [int] NULL,
	[Quantity] [int] NULL,
	[SubtractStock] [bit] NULL,
	[Priceflag] [varchar](5) NULL,
	[Price] [numeric](18, 2) NULL,
	[Pointflag] [varchar](5) NULL,
	[Point] [int] NULL,
	[Weightflag] [varchar](5) NULL,
	[Weight] [varchar](50) NULL,
 CONSTRAINT [PK_ProductOptionDetails] PRIMARY KEY CLUSTERED 
(
	[ProductOptionDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductRewardPoint]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductRewardPoint](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerGroupID] [int] NULL,
	[ProductID] [int] NULL,
	[RewardPoint] [varchar](10) NULL,
 CONSTRAINT [PK_ProductRewardPoint] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductSpecial]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductSpecial](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[CustomerGroupID] [int] NULL,
	[Quantity] [varchar](10) NULL,
	[Priority] [varchar](10) NULL,
	[Price] [numeric](18, 2) NULL,
	[StartDate] [varchar](10) NULL,
	[EndDate] [nchar](10) NULL,
 CONSTRAINT [PK_ProductSpecial] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductStores]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStores](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NULL,
	[ProductID] [int] NULL,
 CONSTRAINT [PK_ProductStores] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RelatedProduct]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelatedProduct](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RelatedProductID] [int] NULL,
	[ProductID] [int] NULL,
 CONSTRAINT [PK_RelatedProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Review]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ProductID] [int] NULL,
	[Text] [varchar](max) NULL,
	[Rating] [int] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShippingPrice]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingPrice](
	[ShippingPriceID] [int] IDENTITY(1,1) NOT NULL,
	[WeightID] [int] NULL,
	[Unit] [varchar](50) NULL,
	[UnitPrice] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_PerUnitPrice] PRIMARY KEY CLUSTERED 
(
	[ShippingPriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShippingSetting]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingSetting](
	[ShipingSettingID] [int] IDENTITY(1,1) NOT NULL,
	[ShippingType] [varchar](50) NULL,
 CONSTRAINT [PK_ShippingSetting] PRIMARY KEY CLUSTERED 
(
	[ShipingSettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Special]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Special](
	[SpecialID] [int] IDENTITY(1,1) NOT NULL,
	[DiscountOnPrice] [numeric](18, 2) NULL,
	[Discount] [numeric](18, 2) NULL,
	[StartDate] [char](10) NULL,
	[EndDate] [char](10) NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Special] PRIMARY KEY CLUSTERED 
(
	[SpecialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](50) NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockStatus]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StockStatus](
	[StockStatusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_StockStatus] PRIMARY KEY CLUSTERED 
(
	[StockStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Store]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [int] IDENTITY(1,1) NOT NULL,
	[StoreName] [varchar](50) NULL,
	[StoreOwner] [varchar](50) NULL,
	[StateID] [int] NULL,
	[CityID] [int] NULL,
	[Address] [varchar](500) NULL,
	[Pincode] [int] NULL,
	[EMail] [varchar](50) NULL,
	[Telephone] [varchar](15) NULL,
	[Fax] [varchar](15) NULL,
	[OpeningTime] [varchar](50) NULL,
	[Comment] [varchar](500) NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[MetaTagDescription] [varchar](max) NULL,
	[SEOKeywords] [varchar](max) NULL,
	[Image] [varchar](max) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubCategories]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubCategories](
	[SubCategoriesID] [int] IDENTITY(1,1) NOT NULL,
	[CategoriesID] [int] NULL,
	[SubCategoriesName] [varchar](50) NULL,
	[StoreID] [int] NULL,
	[MetaTagTitle] [varchar](150) NULL,
	[MetaTagKeywords] [varchar](max) NULL,
	[FilterGroupID] [int] NULL,
	[SEOKeywords] [varchar](max) NULL,
	[ImageName] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[Status] [bit] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_SubCategories] PRIMARY KEY CLUSTERED 
(
	[SubCategoriesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tax]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tax](
	[TaxID] [int] IDENTITY(1,1) NOT NULL,
	[TaxName] [varchar](50) NULL,
	[TaxRate] [numeric](18, 2) NULL,
	[TaxTypeID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Tax] PRIMARY KEY CLUSTERED 
(
	[TaxID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaxType]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaxType](
	[TaxTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TaxTypeName] [varchar](50) NULL,
 CONSTRAINT [PK_TaxType] PRIMARY KEY CLUSTERED 
(
	[TaxTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Voucher](
	[VoucherID] [int] IDENTITY(1,1) NOT NULL,
	[VoucherName] [varchar](50) NULL,
	[Image] [varchar](max) NULL,
	[StoreID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Voucher] PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WeightClass]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeightClass](
	[WeightID] [int] IDENTITY(1,1) NOT NULL,
	[WeightTitle] [varchar](50) NULL,
	[WeightUnit] [varchar](50) NULL,
	[Value] [numeric](18, 10) NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_WeightClass] PRIMARY KEY CLUSTERED 
(
	[WeightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WishList]    Script Date: 13-02-2017 12:48:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WishList](
	[WishListID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[CustomerID] [int] NULL,
	[CreatedBy] [int] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedDate] [varchar](50) NULL,
	[UpdatedDate] [varchar](50) NULL,
	[DeletedDate] [varchar](50) NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_WishList] PRIMARY KEY CLUSTERED 
(
	[WishListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [ECommerce_10022017] SET  READ_WRITE 
GO
