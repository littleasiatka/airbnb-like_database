use AirBnBDB;
-- CASE 1
-- Search properties in Cologne
-- Step 1
SELECT
	Property.title AS Property_Title,
    Property.property_description AS Property_Desription,
    Property.price_per_night AS Price_Per_Night,
    Location.city AS City
FROM
	Property
JOIN Location ON Property.location_id = Location.Location_id
WHERE
	Location.city = 'Cologne';
    
-- Step 2
-- Insert Booking
INSERT INTO Booking (guest_id, property_id, check_in_date, check_out_date, total_price, payment_status)
VALUES (2, 1, '2025-01-20', '2025--1-25', 500.00, 'Pending');

-- Step 3
-- Update payment status
UPDATE Booking
SET payment_status = 'Paid'
WHERE Booking_id = 1;


-- CASE 2
-- Retrieve booking information along with payment details
SELECT
	Booking.Booking_id,
    Guest.full_name AS Guest_Name,
    Payment.amount AS Payment_Amount,
    Payment.payment_date AS Payment_Date
FROM
	Booking
JOIN Guest ON Booking.guest_id = Guest.Guest_id
JOIN Payment ON Booking.Booking_id = Payment.booking_id
WHERE
	Payment.payment_status = 'Completed';
    