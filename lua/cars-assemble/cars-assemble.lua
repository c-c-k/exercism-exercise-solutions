local cars = {}

cars.single_car_cost = 10000
cars.batch_cost = 95000
cars.batch_size = 10

-- returns the amount of working cars produced by the assembly line every hour
function cars.calculate_working_cars_per_hour(production_rate, success_rate)
    return production_rate * success_rate / 100
end

-- returns the amount of working cars produced by the assembly line every minute
function cars.calculate_working_cars_per_minute(production_rate, success_rate)
    return math.floor(cars.calculate_working_cars_per_hour(production_rate, success_rate) / 60)
end

-- returns the cost of producing the given number of cars
function cars.calculate_cost(cars_count)
    local car_batches = math.floor(cars_count / cars.batch_size)
    local single_cars = cars_count % cars.batch_size
    -- local single_cars = cars_count - car_batches * cars.batch_size
    return car_batches * cars.batch_cost + single_cars * cars.single_car_cost
end

return cars
