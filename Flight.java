import java.time.LocalDateTime;

class Flight {
    int id;
    String flightDate;
    String carrier;
    int carrierNum;
    String origin;
    String originCity;
    String originState;
    int originWAC;
    String destinationAir;
    String destinationCity;
    String destinationState;
    int destinationWAC;
    int crsDepartureTime;
    int departureTime;
    int crsArrivalTime;
    int arrivalTime;
    int cancelled;
    int diverted;
    int distance;

    Flight(int id, String flightDate, String carrier, int carrierNum, String origin, String originCity,
            String originState,
            int originWAC, String destinationAir, String destinationCity, String destinationState, int destinationWAC,
            int crsDepartureTime, int departureTime, int crsArrivalTime, int arrivalTime, int cancelled, int diverted,
            int distance) {
        this.id = id;
        this.flightDate = flightDate;
        this.carrier = carrier;
        this.carrierNum = carrierNum;
        this.origin = origin;
        this.originCity = originCity;
        this.originState = originState;
        this.originWAC = originWAC;
        this.destinationAir = destinationAir;
        this.destinationCity = destinationCity;
        this.destinationState = destinationState;
        this.destinationWAC = destinationWAC;
        this.crsDepartureTime = crsDepartureTime;
        this.departureTime = departureTime;
        this.crsArrivalTime = crsArrivalTime;
        this.arrivalTime = arrivalTime;
        this.cancelled = cancelled;
        this.diverted = diverted;
        this.distance = distance;
    }

    public LocalDateTime getFlightDate() {
        // 01/02/2022 00:00
        String[] dateTimeParts = flightDate.split(" ");
        String[] dateParts = dateTimeParts[0].split("/");
        String[] timeParts = dateTimeParts[1].split(":");
        int year = Integer.parseInt(dateParts[2]);
        int month = Integer.parseInt(dateParts[0]);
        int day = Integer.parseInt(dateParts[1]);
        int hour = Integer.parseInt(timeParts[0]);
        int minute = Integer.parseInt(timeParts[1]);
        return LocalDateTime.of(year, month, day, hour, minute);
    }

    public int getDelay() {
        if (cancelled == 1 || diverted == 1) {
            return Integer.MAX_VALUE;
        }
        return arrivalTime - crsArrivalTime;
    }

    public String toString() {
        return "Flight {" +
                "\n  Time: '" + flightDate + '\'' +
                ", Carrier: '" + carrier + "' (#" + carrierNum + ")" +
                "\n  Origin: " + origin + " (" + originCity + ", " + originState + ") [WAC: " + originWAC + "]" +
                "\n  Dest:   " + destinationAir + " (" + destinationCity + ", " + destinationState + ") [WAC: "
                + destinationWAC + "]" +
                "\n  Departure (CRS/Actual): " + crsDepartureTime + " / " + departureTime +
                "\n  Arrival   (CRS/Actual): " + crsArrivalTime + " / " + arrivalTime +
                "\n  Distance: " + distance + " miles" +
                "\n  Status: " + (cancelled == 1 ? "CANCELLED" : diverted == 1 ? "DIVERTED" : "OK") +
                "\n}";
    }

}
