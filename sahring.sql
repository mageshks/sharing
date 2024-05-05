UPDATE Table1
SET ColumnToUpdate = 
    CASE 
        WHEN COUNT(Table2.CommonColumn) > 1 THEN 'duplicate' -- Set to 'duplicate' if more than one record is returned
        ELSE COALESCE(MAX(Table2.ValueToUpdate), '') -- Set to the value from Table2, or empty string if no record is returned
    END
FROM Table1
INNER JOIN Table2 ON Table1.CommonColumn = Table2.CommonColumn
WHERE [Add your condition here if needed]
GROUP BY Table1.PrimaryKeyColumn; -- Group by the primary key of Table1 to count the number of records from Table2 for each row



UPDATE Table1
SET ColumnToUpdate = 
    CASE 
        WHEN EXISTS (SELECT 1 FROM Table2 WHERE Table1.CommonColumn = Table2.CommonColumn HAVING COUNT(*) > 1) THEN 'duplicate' -- Set to 'duplicate' if more than one record is returned
        ELSE COALESCE((SELECT TOP 1 ValueToUpdate FROM Table2 WHERE Table1.CommonColumn = Table2.CommonColumn), '') -- Set to the value from Table2, or empty string if no record is returned
    END
FROM Table1
