/*
Cleaning Data in SQL Queries
*/

Select *
From PortfolioProject..NashvilleHousing



--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDateConverted, CONVERt(Date,Saledate)
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET Saledate = CONVERT(date,SaleDate)


-- If it doesn't Update properly

AlTER Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(date,SaleDate)

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is Null
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is Null

Update a
SET PropertyAddress = ISNULL(a.propertyaddress,b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is Null



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject..NashvilleHousing

SELECT 
Substring(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) AS Address
, Substring(PropertyAddress, CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress)) AS Address

From PortfolioProject..NashvilleHousing

AlTER Table NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

AlTER Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = Substring(PropertyAddress, CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))



-- Easier way than doing 'SUBSTRING'

Select OwnerAddress
From PortfolioProject..NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress,',', '.' ),3)
,PARSENAME(REPLACE(OwnerAddress,',', '.' ),2)
,PARSENAME(REPLACE(OwnerAddress,',', '.' ),1)
From PortfolioProject..NashvilleHousing



AlTER Table NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.' ),3)

AlTER Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.' ),2)

AlTER Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.' ),1)




--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group By SoldAsVacant
Order By 2


Select SoldAsVacant ,
	CASE
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END







-----------------------------------------------------------------------------------------------------------------------------------------------------------

--Finding Duplicates

WITH RowNUMCTE AS(
Select *, --Finding Duplicates
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					) row_num
From PortfolioProject..NashvilleHousing
--order by ParcelID
)
Select *
From RowNUMCTE
Where row_num > 1
Order by PropertyAddress



--Removing Duplicates

WITH RowNUMCTE AS(
Select *, --Finding Duplicates
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
					UniqueID
					) row_num
From PortfolioProject..NashvilleHousing
--order by ParcelID
)
DELETE
From RowNUMCTE
Where row_num > 1


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From PortfolioProject..NashvilleHousing

Alter TABLE PortfolioProject..NashvilleHousing
DROP COLUMn OwnerAddress, TaxDistrict, PropertyAddress

Alter TABLE PortfolioProject..NashvilleHousing
DROP COLUMn SaleDate




-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
