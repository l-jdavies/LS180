/*It seems there was a mistake when we were inserting data in the birds table. One of the rows has a species of 'Crow', but that bird is actually a Raven. Update the birds table so that a row with a species of 'Crow' now reads 'Raven'.*/

UPDATE birds SET species = 'Raven'
WHERE species = 'Crow';
