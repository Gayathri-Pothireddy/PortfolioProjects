/*

Cleaning Data in SQL 

*/

USE [Project-2]

SELECT * 
FROM [Project-2].dbo.NashvilleHousing


-------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

SELECT SaleDate, CONVERT(date, SaleDate)
FROM [Project-2].dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate DATE

 -------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

SELECT *
FROM [Project-2].dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Project-2].dbo.NashvilleHousing a
JOIN [Project-2].dbo.NashvilleHousing b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Project-2].dbo.NashvilleHousing a
JOIN [Project-2].dbo.NashvilleHousing b
    ON a.ParcelID = b.ParcelID
    AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL


--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


SELECT PropertyAddress
FROM [Project-2].dbo.NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Addres
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Address
FROM [Project-2].dbo.NashvilleHousing

ALTER TABLE NashvilleHousing 
ADD PropertySplitAddress NVARCHAR(MAX)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)


ALTER TABLE NashvilleHousing 
ADD PropertySplitCity NVARCHAR(MAX)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))





SELECT OwnerAddress
FROM [Project-2].dbo.NashvilleHousing


SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM [Project-2].dbo.NashvilleHousing


ALTER TABLE NashvilleHousing 
ADD OwnerSplitAddress NVARCHAR(MAX)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing 
ADD OwnerSplitCity NVARCHAR(MAX)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing 
ADD OwnerSplitState NVARCHAR(MAX)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [Project-2].dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
       WHEN SoldAsVacant = 'N' THEN 'No'
       ELSE SoldAsVacant
       END
FROM [Project-2].dbo.NashvilleHousing


UPDATE NashvilleHousing 
SET SoldAsVacant = 
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END


--------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates


WITH RowNumCTE AS (
SELECT * ,
    ROW_NUMBER() OVER(
        PARTITION BY ParcelID, 
                     PropertyAddress, 
                     SalePrice, 
                     SaleDate, 
                     LegalReference
                     ORDER BY
                        UniqueID
    ) row_num
FROM [Project-2].dbo.NashvilleHousing
--ORDER BY ParcelID
)
SELECT * 
FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress


--------------------------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE [Project-2].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

SELECT * 
FROM [Project-2].dbo.NashvilleHousing