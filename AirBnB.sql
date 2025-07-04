CREATE DATABASE AirBnBDB;
-- DROP DATABASE AirBnBDB;
USE AirBnBDB;

-- Hostt table stores host information 
CREATE TABLE Hostt (
    Host_id INT AUTO_INCREMENT Primary KEY, -- Unique identifier for the host
    full_name VARCHAR(255), -- Full name of the host
    email VARCHAR(255), -- Email address for communication
    phone VARCHAR(15), -- Contact phone number
    address TEXT, -- Physical address
    rating FLOAT, -- Rating score for a host 
    profile_picture VARCHAR(255) -- URL of the profile picture
);

-- Host_verification table stores information about host profile verification
CREATE TABLE Host_verification (
    Verification_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a verification entry
    email_verified BOOLEAN, -- Indicates if the email is verified (true/false)
    phone_verified BOOLEAN, -- Indicates if the phone is verified (true/false)
    id_verified BOOLEAN, -- Indicates if the ID is verified (true/false)
    verification_date TIMESTAMP, -- Date and time of verification
    host_id INT, -- Unique identifier for the host
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id) -- Foreign key referencing Hostt table
);

-- Host_payment_details stores information about payment details of host
CREATE TABLE Host_payment_details (
    Payment_details_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for payment details
    payment_method VARCHAR(255), -- Method of payment (e.g., credit card, PayPal)
    account_number VARCHAR(255), -- Account or card number
    expiry_date DATE, -- Expiry date of the payment method
    host_id INT, -- Unique identifier for the host
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id) -- Foreign key referencing Hostt table
);

-- Guest table stores guest information 
CREATE TABLE Guest (
    Guest_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the guest
    full_name VARCHAR(255), -- Full name of the guest
    email VARCHAR(255), -- Email address for communication
    phone VARCHAR(15), -- Contact phone number
    address TEXT, -- Physical address
    rating FLOAT, -- Rating sscore for a guest
    profile_picture VARCHAR(255) -- URL of the profile picture
);

-- Guest_verification table stores information about guest profile verification
CREATE TABLE Guest_verification (
    Verification_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a verification entry
    email_verified BOOLEAN, -- Indicates if the email is verified (true/false)
    phone_verified BOOLEAN, -- Indicates if the phone is verified (true/false)
    id_verified BOOLEAN, -- Indicates if the ID is verified (true/false)
    verification_date TIMESTAMP, -- Date and time of verification
    guest_id INT, -- Unique identifier for the guest
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id) -- Foreign key referencing Guest table
);

-- Guest_payment_details stores information about payment details of guest
CREATE TABLE Guest_payment_details (
    Payment_details_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for payment details
    payment_method VARCHAR(255), -- Method of payment (e.g., credit card, PayPal)
    account_number VARCHAR(255), -- Account or card number
    expiry_date DATE, -- Expiry date of the payment method
    guest_id INT, -- Unique identifier for the guest
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id) -- Foreign key referencing Guest table
);

-- Admin table stores admin information 
CREATE TABLE Adminn (
    Admin_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the admin
    full_name VARCHAR(255), -- Full name of the admin
    admin_role VARCHAR(255) -- Role of the admin (e.g., manager, support)
);

-- Location table stores information about location of properties
CREATE TABLE Location (
    Location_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the location
    country VARCHAR(255), -- Country name
    city VARCHAR(255), -- City name
    zip_code VARCHAR(20) -- ZIP or postal code
);

-- Property_type stores information about property types
CREATE TABLE Property_type (
    Property_type_id INT auto_increment PRIMARY KEY, -- Unique identifier for the property type
    property_type_name VARCHAR(255) -- Name of the property type (e.g., apartment, house)
);

-- Property table stores information about properties
CREATE TABLE Property (
    Property_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for the property
    title VARCHAR(255), -- Title of the property listing
    property_description TEXT, -- Detailed description of the property
    price_per_night DECIMAL(10, 2), -- Cost of staying per night
    property_type_id INT, -- Unique identifier for the property type
    host_id INT, -- Unique identifier for the host
    location_id INT, -- Unique identifier for the location
    FOREIGN KEY (property_type_id) REFERENCES Property_type(Property_type_id), -- Foreign key referencing Property table
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id), -- Foreign key referencing Hostt table
    FOREIGN KEY (location_id) REFERENCES Location(Location_id) -- Foreign key referencing Location table
);


-- Amenities table stores information about amenities available in the property
CREATE TABLE Amenities (
    Amenity_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for an amenity
    amenity_name VARCHAR(255), -- Name of the amenity (e.g., Wi-Fi, parking)
    amenity_description VARCHAR(255) -- Description of the amenity
);

-- Property_amenities table establishes relatinoship between Properties and Amenities tables
CREATE TABLE Property_amenities (
    Property_id INT, -- Unique identifier for a property
    Amenity_id INT, -- Unique identifier for an amenity
    PRIMARY KEY (Property_id, Amenity_id), -- Composite primary key
    FOREIGN KEY (Property_id) REFERENCES Property(Property_id), -- Foreign key referencing Property table
    FOREIGN KEY (Amenity_id) REFERENCES Amenities(Amenity_id) -- Foreign key referencing Amenities table
);

-- Photos table stores photos of properties
CREATE TABLE Photos (
    Photo_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a photo
    image_url VARCHAR(255) -- URL of the property photo
);

-- Property_photos table establishes relationship between Property and Photos tables
CREATE TABLE Property_photos (
    Property_id INT, -- Unique identifier for a property
    Photo_id INT, -- Unique identifier for a photo
    PRIMARY KEY (Property_id, Photo_id), --  Composite primary key
    FOREIGN KEY (Property_id) REFERENCES Property(Property_id), -- Foreign key referencing Property table
    FOREIGN KEY (Photo_id) REFERENCES Photos(Photo_id) -- Foreign key referencing Photos table
);

-- Booking table stores information about bookings made by guests
CREATE TABLE Booking (
    Booking_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a booking
    check_in_date DATE, -- Check-in date for the booking
    check_out_date DATE, -- Check-out date for the booking
    total_price DECIMAL(10, 2), -- Total price for the booking
    payment_status ENUM('Paid', 'Pending'), -- Status of the payment (e.g., Paid, Pending)
    booking_date TIMESTAMP, -- Date and time the booking was made
    guest_id INT, -- Unique identifier for the guest
    host_id INT, -- Unique identifier for the host
    property_id INT, -- Unique identifier for the property
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id), -- Foreign key referencing Guest table
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id), -- Foreign key referencing Hostt table
    FOREIGN KEY (property_id) REFERENCES Property(Property_id) -- Foreign key referencing Property table
);

-- Cancellation_policy stores information about cancellation policies for properties
CREATE TABLE Cancellation_policy (
    Cancellation_policy_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a cancellation policy
    policy_description TEXT -- Description of the cancellation policy
);

-- Booking_cancellation establishes relationship between Booking and Cancellation_policy tables
CREATE TABLE Booking_cancellation (
    Cancellation_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a booking cancellation
    cancellation_date DATE, -- Cancellation date of a booking
    booking_id INT, -- Unique identifier for a booking
    cancellation_policy_id INT, -- Unique identifier for a cancellation policy
    FOREIGN KEY (booking_id) REFERENCES Booking(Booking_id), -- Foreign key referencing Booking table
    FOREIGN KEY (cancellation_policy_id) REFERENCES Cancellation_policy(Cancellation_policy_id) -- Foreign key referencing Cancellation_policy table
);

-- Payment table stores information about payments made for bookings
CREATE TABLE Payment (
    Payment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a payment
    amount DECIMAL(10, 2), -- Amount paid
    payment_status ENUM('Completed', 'Failed', 'Pending'), -- Status of the payment (e.g., Completed, Failed, Pending)
	payment_date DATETIME, -- Date of payment
    booking_id INT, -- Unique identifier for a booking
    FOREIGN KEY (booking_id) REFERENCES Booking(Booking_id) -- Foreign key referencing Booking table
);

-- Transactions table stores information about transactions made 
CREATE TABLE Transactions (
    Transaction_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a transaction
    transaction_type ENUM('Credit', 'Debit', 'Paypal'), -- Type of transaction (Credit/Debit/PayPal)
    transaction_date DATETIME, -- Date of the transaction
    transaction_amount DECIMAL(10, 2), -- Amount involved in the transaction
    payment_id INT, -- Unique identifier for a payment
    host_id INT, -- Unique identifier for a host
    guest_id INT, -- Unique identifier for a payment
    FOREIGN KEY (payment_id) REFERENCES Payment(Payment_id), -- Foreign key referencing Payment table
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id), -- Foreign key referencing Hostt table
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id) -- Foreign key referencing Guest table
);

-- Review table stores information about reviews given 	by guests for properties
CREATE TABLE Review (
    Review_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a review
    rating FLOAT, -- Rating score for a property
    review_comment TEXT, -- Comments left in a review
    review_date DATE, -- Date when the review was written
    host_id INT, -- Unique identifier for a host
    guest_id INT, -- Unique identifier for a guest
    property_id INT, -- Unique identifier for a property
    FOREIGN KEY (host_id) REFERENCES Hostt(Host_id), -- Foreign key referencing Hostt table
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id), -- Foreign key referencing Guest table
    FOREIGN KEY (property_id) REFERENCES Property(Property_id) -- Foreign key referencing Property table
);

-- Wishlist table stores information about properties guests want to visit
CREATE TABLE Wishlist (
    Wishlist_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a Wishlist entry
    date_added DATE, -w- Date when the property was added to the wishlist
    guest_id INT, -- Unique identifier for a guest
    property_id INT, -- Unique identifier for a property
    FOREIGN KEY (guest_id) REFERENCES Guest(Guest_id), -- Foreign key referencing Guest table
    FOREIGN KEY (property_id) REFERENCES Property(Property_id) -- Foreign key referencing Property table
);

-- Discounts table stores information about discounts for properties
CREATE TABLE Discounts (
    Discount_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a discount entry
    percentage FLOAT, -- Discount percentage
    start_date DATE, -- Date the discount starts
    end_date DATE, -- Date the discount ends
    property_id INT, -- Unique identifier for a property
    FOREIGN KEY (property_id) REFERENCES Property(Property_id) -- Foreign key referencing Property table
);

-- Dispute tables stores information about disputes 
CREATE TABLE Dispute (
    Dispute_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a dispute
    details TEXT, -- Details of the dispute
    dispute_status ENUM('Open', 'In Progress', 'Resolved', 'Closed'), -- Current status of a dispute (e.g., Open, Resolved)
    created_at TIMESTAMP, -- Date and time the dispute was created
    resolution_date DATE, -- Date the dispute was solved
    booking_id INT, -- Unique identifier for a booking
    admin_id INT, -- Unique identifier for an admin
    FOREIGN KEY (booking_id) REFERENCES Booking(Booking_id), -- Foreign key referencing Booking table
    FOREIGN KEY (admin_id) REFERENCES Adminn(Admin_id) -- Foreign key referencing Admin table
);

-- Rules table stores information about the rules of property
CREATE TABLE Rules (
    Rules_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a rule
    rule_description TEXT -- Description of a rule
);

-- Property_rules table establishes the relationship between Property and Rules tables
CREATE TABLE Property_Rules (
    Property_id INT, -- Unique identifier for a property
    Rules_id INT, -- Unique identifier for a rule
    PRIMARY KEY (Property_id, Rules_id), -- Composite primary key 
    FOREIGN KEY (Property_id) REFERENCES Property(Property_id), -- Foreign key referencing Property table
    FOREIGN KEY (Rules_id) REFERENCES Rules(Rules_id) -- Foreign key referencing Rules table
);

-- Neighbourhood table stores neighbourhood information
CREATE TABLE Neighbourhood (
    Neighbourhood_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for a neighbourhood
    neighbourhood_name VARCHAR(255), -- Name of the neighbourhood
    neighbourhood_description TEXT, -- A detailed description of about the neighbourhood’s characteristics
    popular_spots TEXT, -- List of popular attractions
    transportation_info TEXT, -- Information about the available transportation options in the neighbourhood
    location_id INT, -- Unique identifier for a location
    FOREIGN KEY (location_id) REFERENCES Location (Location_id) -- Foreign key referencing Location table
);

-- Messages table stores infromation about messages between a host and a guest
CREATE TABLE Messages (
    Message_id INT AUTO_INCREMENT  PRIMARY KEY, -- Unique identifier for a message
    sender_id INT, -- Unique identifier for a sender (guest)
    receiver_id INT, -- Unique identifier for a receiver (host)
    message_content TEXT, -- Content of the message sent between users
    sent_at TIMESTAMP, -- Date and time the message was sent
    is_read BOOLEAN, -- Indicates if a message has been read (true/false)
    FOREIGN KEY (sender_id) REFERENCES Guest(Guest_id), -- Foreign key referencing Guest table
    FOREIGN KEY (receiver_id) REFERENCES Hostt(Host_id) -- Foreign key referencing Hostt table
);