#include <iostream>
#include <vector>
#include <string>
#include <memory>
// Base Ride Class
class Ride {
protected:
    int rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;
    double fare;
public:
    Ride(int id, std::string pickup, std::string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist), fare(0) {}
    
    virtual double calculateFare() {
        return fare = distance * 1.5; // Base rate for standard ride
    }
    void rideDetails() {
        std::cout << "Ride ID: " << rideID << "\n"
                  << "Pickup: " << pickupLocation << "\n"
                  << "Dropoff: " << dropoffLocation << "\n"
                  << "Distance: " << distance << " miles\n"
                  << "Fare: $" << fare << "\n";
    }
};
// StandardRide Subclass
class StandardRide : public Ride {
public:
    StandardRide(int id, std::string pickup, std::string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() override {
        return fare = distance * 1.5; // Base rate for standard ride
    }
};
// PremiumRide Subclass
class PremiumRide : public Ride {
public:
    PremiumRide(int id, std::string pickup, std::string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double calculateFare() override {
        return fare = distance * 2.0; // Premium rate
    }
};

// Driver Class
class Driver {
private:
    int driverID;
    std::string name;
    double rating;
    std::vector<Ride*> assignedRides;

public:
    Driver(int id, std::string driverName, double driverRating)
        : driverID(id), name(driverName), rating(driverRating) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() {
        std::cout << "Driver ID: " << driverID << "\n"
                  << "Name: " << name << "\n"
                  << "Rating: " << rating << "/5\n";
    }
};
// Rider Class
class Rider {
private:
    int riderID;
    std::string name;
    std::vector<Ride*> requestedRides;
public:
    Rider(int id, std::string riderName) : riderID(id), name(riderName) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }
    void viewRides() {
        std::cout << name << "'s Ride History:\n";
        for (auto ride : requestedRides) {
            ride->rideDetails();
        }
    }
};
int main() {
    // Create Ride objects
    Ride* ride1 = new StandardRide(101, "Location A", "Location B", 10);
    Ride* ride2 = new PremiumRide(102, "Location C", "Location D", 15);
    // Create Driver and Rider objects
    Driver driver(1, "John Doe", 4.8);
    Rider rider(1, "Jane Smith");
    // Add rides to driver
    driver.addRide(ride1);
    driver.addRide(ride2);
    // Rider requests rides
    rider.requestRide(ride1);
    rider.requestRide(ride2);
    // Show driver and rider info
    driver.getDriverInfo();
    rider.viewRides();
    // Calculate fares
    ride1->calculateFare();
    ride2->calculateFare();
    return 0;
}
