# MPCS 52553 - Final Project Starting Point

# May 6 2017

# Benyan Gong

1. My structure and MaroonAir's are prettly alike since they are similar on data pattern and I learned a lot from MaroonAir.

2. Essentially I have "restaurant", "user", "timesegment" models, I also provide a MaroonAir-like interface to check on them. A intermediate class "reservation" connects user and timesegment but I havn't figured out how to present them in a clear way, so this page wouldn't work.

3. So my idea is to have many timesegement as a main connection between restaurant and reservations. A timesegment represented by the restaurant it belongs to and all the reservation it has. Reservation is one customer to one segement. Restaurants have same timesegements on time dimension.   
