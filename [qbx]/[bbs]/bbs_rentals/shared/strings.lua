Strings = {
    Notify = {
        NotMoney            = "You don't have enought money!",
        InVehicle           = "You are in vehicle!",
        NoHourMoney         = "You don't have enought money and your car was taken away!",
        CantRentOnExactSpot = "You can't rent on exact location while renting vehicle here!",
        ReturnedRental      = "You returned rented vehicle!",
        NotRentedVehicle    = "This is not rented vehicle!",
        NoVehiclesInZone    = "There is no vehicles in zone!",
        NoRentedPlayerZone  = "There is no rented vehicles by you in zone!",
        NoRentedVehicles    = "You don't have any rented vehicles!",
        NotPlayerReceipt    = "This is not yours receipt!",
        NoRentalReceipt     = "You don't have rental receipt for this plates!"
    },
    Target = {
        ReturnVehicle       = "Return vehicle",
        ReturnVehicleIcon   = "fas fa-rotate-left"
    },
    Inventory = {
        RentPlate = "Plate" --for metadata label
    },
    DUI = {
        Title = {
            label = "VEHICLE RENTAL",
            desc  = "Premium Vehicle Services"
        },
        Details = {
            title         = "Vehicle Details",
            model         = "Vehicle Model",
            class         = "Vehicle Class",
            maxPassengers = "Max Passengers",
            topSpeed      = "Estimated Top Speed",
            press         = "Press",
            toExpand      = "to expand"
        },
        Structure = {
            title      = "Price Structure",
            hourlyRent = {
                title  = "Hourly Rent",
                desc   = "Paid at the time of return based on usage"
            },
            security   = "Security Deposit",
            insurance  = "Insurance Cost",
            fee        = "Processing Fee",
            upfront    = "Final Upfront Cost",
            press      = "Press",
            toRent     = "to Rent Now"
        }
    },
    NUI = {
        Receipt = {
            title = "Rental Invoice",
            details = {
                title = "Vehicle Details",
                model = "Vehicle Model",
                plate = "Vehicle Plate",
                class = "Vehicle Class",
                paid  = "Paid"
            },
            rentedBy    = "Rented by",
            description = "I hereby assume full responsibility for the rental vehicle including any damages accident or liabilities incurred during the rental."
        },
        Return = {
            Title = {
                label = "VEHICLE RENTAL",
                desc  = "Premium Vehicle Services"
            },
            hide = "ESC to hide",
            title = "Return rental vehicle",
            select = "Select Return Vehicle",
            error = "No selected vehicle!",
            returnBtn = "Return"
        }
    }
}