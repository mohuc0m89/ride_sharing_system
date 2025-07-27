"Base Class Ride"
Object subclass: Ride [
    | rideID pickupLocation dropoffLocation distance fare |
    
    "Initialize the Ride object with basic information"
    Ride class >> initialize: aRideID pickup: aPickupLocation dropoff: aDropoffLocation distance: aDistance [
        rideID := aRideID.
        pickupLocation := aPickupLocation.
        dropoffLocation := aDropoffLocation.
        distance := aDistance.
        fare := 0.
    ]
    
    "Calculate the fare based on distance"
    Ride class >> fare [
        ^ fare := distance * 2. "Default fare $2 per mile"
    ]
    
    "Show the ride details"
    Ride class >> rideDetails [
        ^ 'Ride ID: ', rideID asString , ' Pickup: ', pickupLocation , ' Dropoff: ', dropoffLocation , 
        ' Distance: ', distance printPadded , ' miles, Fare: $', fare printPadded
    ]
]

"StandardRide Subclass"
Ride subclass: StandardRide [
    "Override fare method for StandardRide"
    StandardRide class >> fare [
        ^ fare := distance * 2. "Standard fare $2 per mile"
    ]
]

"PremiumRide Subclass"
Ride subclass: PremiumRide [
    "Override fare method for PremiumRide"
    PremiumRide class >> fare [
        ^ fare := distance * 3. "Premium fare $3 per mile"
    ]
]

"Driver Class"
Object subclass: Driver [
    | driverID name rating assignedRides |
    
    "Initialize the Driver object"
    Driver class >> initialize: aDriverID name: aName rating: aRating [
        driverID := aDriverID.
        name := aName.
        rating := aRating.
        assignedRides := Array new.
    ]
    
    "Add ride to the assignedRides list"
    Driver class >> addRide: aRide [
        assignedRides := assignedRides, (Array with: aRide).
    ]
    
    "Display driver information"
    Driver class >> getDriverInfo [
        ^ 'Driver ID: ', driverID asString , ' Name: ', name , ' Rating: ', rating asString.
    ]
    
    "Get assigned rides"
    Driver class >> getAssignedRides [
        ^ assignedRides
    ]
]

"Rider Class"
Object subclass: Rider [
    | riderID name requestedRides |
    
    "Initialize the Rider object"
    Rider class >> initialize: aRiderID name: aName [
        riderID := aRiderID.
        name := aName.
        requestedRides := Array new.
    ]
    
    "Request a ride"
    Rider class >> requestRide: aRide [
        requestedRides := requestedRides, (Array with: aRide).
    ]
    
    "Display requested rides"
    Rider class >> viewRides [
        requestedRides do: [ :ride |
            FileStream stdout nextLine: ride rideDetails.
        ].
    ]
]

"System Functionality - Demonstrate Polymorphism"
Object subclass: RideSystem [
    
    "Demonstrate polymorphism by storing different ride types in an array and invoking fare() and rideDetails()"
    RideSystem class >> demonstratePolymorphism: aRides [
        aRides do: [ :ride |
            FileStream stdout nextLine: ride rideDetails.
            FileStream stdout nextLine: 'Fare: $', (ride fare printPadded).
        ].
    ]
]

"Testing the System"

"Create rides"
| ride1 ride2 |
ride1 := StandardRide new initialize: 101 pickup: 'Location A' dropoff: 'Location B' distance: 10.
ride2 := PremiumRide new initialize: 102 pickup: 'Location C' dropoff: 'Location D' distance: 15.

"Create a driver and assign rides"
| driver |
driver := Driver new initialize: 1 name: 'John Doe' rating: 4.8.
driver addRide: ride1.
driver addRide: ride2.

"Create a rider and request rides"
| rider |
rider := Rider new initialize: 1 name: 'Alice'.
rider requestRide: ride1.
rider requestRide: ride2.

"Display driver information"
FileStream stdout nextLine: driver getDriverInfo.

"Display rider's requested rides"
FileStream stdout nextLine: 'Rider''s Requested Rides:'.
rider viewRides.

"Demonstrating polymorphism with rides"
FileStream stdout nextLine: 'Demonstrating Polymorphism - Ride Fares and Details:'.
RideSystem demonstratePolymorphism: (Array with: ride1 with: ride2).
