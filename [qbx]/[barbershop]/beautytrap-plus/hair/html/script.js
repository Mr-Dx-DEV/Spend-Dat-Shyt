// Detect resource name dynamically
const resourceName = 'beautytrap-plus';

const DEBUG = true; // Set to true to enable tablet console logging

var clientId
var currentItem
var hasFade = false

var CustomNames = {}

// Tablet variables
var tabletMode = null;
var selectedServices = [];
var invoiceTotal = 0;
var customerTip = 0;
var customerSubtotal = 0;
var customerEmployeeId = null;
var tabletServices = [];
var chargeLimit = 500;
var jobGrades = [];
var currentValue = {
    ["hair_1"]: {min: 0, value: 0, max: 0},
    ["hair_2"]: {min: 0, value: 0, max: 0},
    ["hair_fade"]: {min: 0, value: 0, max: 0},
    ["hair_color_1"]: {min: 0, value: 0, max: 0},
    ["hair_color_2"]: {min: 0, value: 0, max: 0},
    ["beard_1"]: {min: 0, value: 0, max: 0},
    ["beard_2"]: {min: 0, value: 0, max: 0},
    ["beard_3"]: {min: 0, value: 0, max: 0},
    ["beard_4"]: {min: 0, value: 0, max: 0},
    ["eye_color"]: {min: 0, value: 0, max: 0},
    ["eyebrows_1"]: {min: 0, value: 0, max: 0},
    ["eyebrows_2"]: {min: 0, value: 0, max: 0},
    ["eyebrows_3"]: {min: 0, value: 0, max: 0},
    ["makeup_1"]: {min: 0, value: 0, max: 0},
    ["makeup_2"]: {min: 0, value: 0, max: 0},
    ["makeup_3"]: {min: 0, value: 0, max: 0},
    ["makeup_4"]: {min: 0, value: 0, max: 0},
    ["lipstick_1"]: {min: 0, value: 0, max: 0},
    ["lipstick_2"]: {min: 0, value: 0, max: 0},
    ["lipstick_3"]: {min: 0, value: 0, max: 0},
    ["blush_1"]: {min: 0, value: 0, max: 0},
    ["blush_2"]: {min: 0, value: 0, max: 0},
    ["blush_3"]: {min: 0, value: 0, max: 0},
}

// Add translation object for makeup section
const translate = {
    makeup_style: "MAKEUP STYLE",
    makeup_opacity: "MAKEUP OPACITY",
    makeup_color: "MAKEUP COLOR",
    makeup2_color: "MAKEUP COLOR 2",
    lipstick_style: "LIPSTICK STYLE",
    lipstick_opacity: "LIPSTICK OPACITY",
    lipstick_color: "LIPSTICK COLOR",
    blush_style: "BLUSH STYLE",
    blush_opacity: "BLUSH OPACITY",
    blush_color: "BLUSH COLOR"
}

window.addEventListener('message', function(event){
    var item = event.data;
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // TABLET UI HANDLERS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    if (item.action == "showTablet") {
        if (DEBUG) console.log("[TABLET] Showing tablet UI, mode:", item.mode);
        tabletMode = item.mode;
        
        // Show body
        $("body").css("display", "block");
        
        // Hide hair styling UI elements
        $("body > div:not(#tablet-container)").hide();
        
        // Show tablet container
        $("#tablet-container").css({
            "display": "flex",
            "position": "fixed",
            "top": "0",
            "left": "0",
            "width": "100vw",
            "height": "100vh",
            "justify-content": "center",
            "align-items": "center",
            "z-index": "9999",
            "background": "rgba(0,0,0,0.7)",
            "pointer-events": "auto"
        });
        
        // Show tablet frame
        $("#tablet-frame").css({
            "display": "flex",
            "width": "1100px",
            "height": "700px"
        });
        
        // Show tablet screen
        $("#tablet-screen").css({
            "display": "flex",
            "flex-direction": "column",
            "flex": "1"
        });
        
        // Make sure header and content are visible
        $("#tablet-header").css("display", "flex");
        $("#tablet-content").css("display", "block");
        
        if (item.mode == "employee") {
            showEmployeeMode(item);
        } else if (item.mode == "customer") {
            showCustomerMode(item);
        }
        
        return;
    }
    
    if (item.action == "hideTablet") {
        if (DEBUG) console.log("[TABLET] Hiding tablet UI");
        hideTablet();
        $("body").css("display", "none");
        return;
    }
    
    // Tablet data handlers
    if (item.action == "updateTransactions") { renderTransactions(item.transactions); return; }
    if (item.action == "updateStats") { renderStats(item.stats); return; }
    if (item.action == "updateAppointments") { renderAppointments(item.appointments); return; }
    if (item.action == "updateFinances") { renderFinances(item.finances); return; }
    if (item.action == "updateEmployeeStats") { renderEmployeeStats(item.employeeStats); return; }
    if (item.action == "updateDeclinedTransactions") { renderDeclined(item.declinedTransactions); return; }
    if (item.action == "updateJobGrades") { jobGrades = item.grades || []; return; }
    if (item.action == "updateCurrentEmployees") { renderCurrentEmployees(item.employees); return; }
    if (item.action == "updateNearbyHireable") { renderNearbyHireable(item.players); return; }
    if (item.action == "hideHireableList") { $("#nearby-hireable-list").hide(); return; }
    if (item.action == "updateSocietyBalance") { 
        $("#society-balance").text('$' + (item.balance || 0));
        $("#finance-balance").text('$' + (item.balance || 0));
        return; 
    }
    if (item.action == "receiveShelfPrices") { renderShelfPrices(item.prices); return; }

    // Appointment system handlers
    if (item.action == "receiveAppointments") { renderAppointments(item.appointments); return; }
    if (item.action == "receiveMyAvailability") { renderMyAvailability(item.availability); return; }
    if (item.action == "receiveAvailableEmployees") { renderAvailableEmployees(item.employees); return; }
    if (item.action == "receiveEmployeeDates") { renderEmployeeDates(item.dates); return; }
    if (item.action == "receiveTimeSlots") { renderTimeSlots(item.slots); return; }
    if (item.action == "receiveMyBookings") { renderMyBookings(item.bookings); return; }
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // HAIR STYLING UI HANDLERS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    if (item.action == "show") {
        // Hide tablet completely if showing hair UI
        $("#tablet-container").hide().css({
            "pointer-events": "none",
            "z-index": "-1"
        });
        $("#tablet-frame").hide();
        $("#tablet-screen").hide();

        $("body > div:not(#tablet-container)").show();
        
        $("body").css("display", "block")
        for (const [key, value] of Object.entries(item.data)) {
            if (currentValue[key]) {
                currentValue[key] = {
                    value: value.value,
                    min: value.min,
                    max: value.max
                }
            }
        }
        if (item.Makeup) {
            $(".makeup_circle").css("display", "block")
        }
        hasFade = item.hasFade || false
        if (hasFade) {
            $("#fade-slider-row").show()
        } else {
            $("#fade-slider-row").hide()
        }
        if (item.Others) {
            $(".others_circle").css("display", "block")
        }
        if (item.clientId) {
            clientId = item.clientId
        }
        CustomNames = item.CustomNames
    }
    if (item.action == "hide") {
        clientId = undefined
        $("body").css("display", "none")
    }
    if (item.action == "openAgain") {
        $("body").css("display", "block")
    }
    // Refresh action handler
    if (item.action == "refresh") {
        // Update all UI elements with the new data
        for (const [key, value] of Object.entries(item.data)) {
            if (currentValue[key]) {
                currentValue[key] = {
                    value: value.value,
                    min: value.min,
                    max: value.max
                }
               
                // Update any visible UI elements
                var element = document.getElementById("current-" + key);
                if (element) {
                    element.textContent = value.value;
                }
            }
        }
        console.log("UI refreshed with current appearance data");
    }
    // Update field action handler
    if (item.action == "update_field") {
        // Update a specific field's value in the UI
        if (currentValue[item.field]) {
            currentValue[item.field].value = item.value;
            
            // Update any visible UI elements
            const element = document.getElementById("current-" + item.field);
            if (element) {
                element.textContent = item.value;
            }
            
            console.log("Updated UI field: " + item.field + " to " + item.value);
        }
    }
});

$("#hair").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({clientId: clientId}));
    } else {
        currentItem = "hair"
        
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({}))
    }
    $("#panel").empty()
    $("#panel").append(`
        <div class="position:absolute;height:60%;">
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">HAIR STYLE<span class="itemLabel" id="name-hair_1">ㅤ</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('hair_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-hair_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_1"].value}</p>
                            <button onclick="next('hair_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 0)" style="background: #060606;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 1)" style="background: #131313;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 2)" style="background: #303230;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 3)" style="background: #1e0f0a;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 4)" style="background: #4e2a1d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 5)" style="background: #90543d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 6)" style="background: #EDC87D;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 7)" style="background: #F5D38F;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 8)" style="background: #F7D99D;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 9)" style="background: #FCE3B2;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 10)" style="background: #c5b495;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 11)" style="background: #dfcdac;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 12)" style="background: #F9E5BF;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 13)" style="background: #e3c48a;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 14)" style="background: #ebd09d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 15)" style="background: #f6e3c0;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 16)" style="background: #8e8370;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 17)" style="background: #A4530B;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 18)" style="background: #EA3C11;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 19)" style="background: #620000;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 20)" style="background: #8d0000;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 21)" style="background: #ff0505;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 22)" style="background: #ff4242;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 23)" style="background: #ff5c26;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 24)" style="background: #F58159;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 25)" style="background: #ac5c41;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 26)" style="background: #AFABAA;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 27)" style="background: #BCB9B8;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 28)" style="background: #E6E6E6;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 29)" style="background: #FFFFFF;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 30)" style="background: #533c67;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 31)" style="background: #82619f;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 32)" style="background: #7f3286;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 33)" style="background: #ff0ae7;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 34)" style="background: #ff0357;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 35)" style="background: #ff9bcb;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 36)" style="background: #22b1a1;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 37)" style="background: #1e7590;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 38)" style="background: #2231ff;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 39)" style="background: #1def55;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 40)" style="background: #068d60;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 41)" style="background: #154e60;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 42)" style="background: #a0f742;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_1', 43)" style="background: #47F225;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px;">TEXTURE</p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 100%;justify-content: space-evenly;">
                            <button onclick="previous('hair_2')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-hair_2" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_2"].value}</p>
                            <button onclick="next('hair_2')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                    </div>
                    <div id="fade-slider-row" style="margin-right: 15px;width:31%;display:none;">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px;">FADE</p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 100%;justify-content: space-evenly;">
                            <button onclick="previous('hair_fade')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-hair_fade" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_fade"].value}</p>
                            <button onclick="next('hair_fade')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR<span class="itemLabel" id="name-hair_2">ㅤ</span></p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 0)"  style="background: #060606;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 1)"  style="background: #131313;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 2)"  style="background: #303230;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 3)"  style="background: #1e0f0a;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 4)"  style="background: #4e2a1d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 5)"  style="background: #90543d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 6)"  style="background: #EDC87D;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 7)"  style="background: #F5D38F;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 8)"  style="background: #F7D99D;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 9)" style="background: #FCE3B2;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 10)" style="background: #c5b495;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 11)" style="background: #dfcdac;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 12)" style="background: #F9E5BF;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 13)" style="background: #e3c48a;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 14)" style="background: #ebd09d;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 15)" style="background: #f6e3c0;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 16)" style="background: #8e8370;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 17)" style="background: #A4530B;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 18)" style="background: #EA3C11;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 19)" style="background: #620000;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 20)" style="background: #8d0000;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 21)" style="background: #ff0505;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 22)" style="background: #ff4242;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 23)" style="background: #ff5c26;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 24)" style="background: #F58159;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 25)" style="background: #ac5c41;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 26)" style="background: #AFABAA;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 27)" style="background: #BCB9B8;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 28)" style="background: #E6E6E6;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 29)" style="background: #FFFFFF;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 30)" style="background: #533c67;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 31)" style="background: #82619f;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 32)" style="background: #7f3286;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 33)" style="background: #ff0ae7;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 34)" style="background: #ff0357;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 35)" style="background: #ff9bcb;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 36)" style="background: #22b1a1;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 37)" style="background: #1e7590;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 38)" style="background: #2231ff;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 39)" style="background: #1def55;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 40)" style="background: #068d60;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 41)" style="background: #154e60;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 42)" style="background: #a0f742;"></div>
                            <div class="colour-selection" onclick="changeColor('hair_color_2', 43)" style="background: #47F225;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `)
})

$("#eye").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({clientId: clientId}));
    } else {
        currentItem = "eye"
        
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({}))
    }
    $("#panel").empty()
    $("#panel").append(`
        <div class="position:absolute;height:60%;">
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="width:100%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">EYE COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('eye_color', 0)" style="background: #0d3b14;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 1)" style="background: #196e26;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 2)" style="background: #4e7c8a;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 3)" style="background: #154775;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 4)" style="background: #735139;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 5)" style="background: #2e1f14;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 6)" style="background: #915f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 7)" style="background: #454545;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 8)" style="background: #7d7d7d;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 9)" style="background: #a74cb5;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 10)" style="background: #c2ae2b;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 11)" style="background: #772bc2;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 12)" style="background: #09080a;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 13)" style="background: #615e63;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 14)" style="background: #cfca4c;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 15)" style="background: linear-gradient(45deg, #fff608 50%, #080808 50%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 16)" style="background: linear-gradient(45deg, #fff 10%, #000 20%, #000 30%, #fff 30%, #fff 40%, #000 40%, #000 50%, #fff 50%, #fff 60%, #000 60%, #000 70%, #fff 70%, #fff 80%, #000 90%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 17)" style="background: #fff"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 18)" style="background: linear-gradient(45deg, #47bef5 45%, #ff8a14 55%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 19)" style="background: linear-gradient(90deg, #fff, #000 40%, #000 60%, #fff);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 20)" style="background: radial-gradient(black 30%, white 40%, red 50%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 21)" style="background: linear-gradient(90deg, #12db15 30%, #000 33%, #000 66%, #12db15 70%"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 22)" style="background: linear-gradient(90deg, #db5512 30%, #000 33%, #000 66%, #db5512 70%"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 23)" style="background: linear-gradient(90deg, #126cdb 30%, #000 33%, #000 66%, #126cdb 70%"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 24)" style="background: linear-gradient(0deg, #dbae32 30%, #000 33%, #000 66%, #dbae32 70%"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 25)" style="background: radial-gradient(black 30%, #ffdf0d 35%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 26)" style="background: black;"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 27)" style="background: radial-gradient(black 30%, red 35%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 28)" style="background: radial-gradient(#0daeff 30%, red 35%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 29)" style="background: radial-gradient(black 30%, #0daeff 35%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 30)" style="background: radial-gradient(black 30%, white 35%, red 120%);"></div>
                            <div class="colour-selection" onclick="changeColor('eye_color', 31)" style="background: radial-gradient(#d6d6d6 30%, white 35%);"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">EYEBROWS<span class="itemLabel" id="name-eyebrows_1">ㅤ</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('eyebrows_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-eyebrows_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["eyebrows_1"].value}</p>
                            <button onclick="next('eyebrows_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">EYEBROWS OPACITY</p>
                        <input type="range" min="1" max="50" value="1" class="slider" id="eyebrows_2" onmousemove="changeRange('eyebrows_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 0)" style="background: #060606;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 1)" style="background: #131313;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 2)" style="background: #303230;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 3)" style="background: #1e0f0a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 4)" style="background: #4e2a1d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 5)" style="background: #90543d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 6)" style="background: #EDC87D;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 7)" style="background: #F5D38F;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 8)" style="background: #F7D99D;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 9)" style="background: #FCE3B2;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 10)" style="background: #c5b495;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 11)" style="background: #dfcdac;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 12)" style="background: #F9E5BF;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 13)" style="background: #e3c48a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 14)" style="background: #ebd09d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 15)" style="background: #f6e3c0;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 16)" style="background: #8e8370;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 17)" style="background: #A4530B;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 18)" style="background: #EA3C11;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 19)" style="background: #620000;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 20)" style="background: #8d0000;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 21)" style="background: #ff0505;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 22)" style="background: #ff4242;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 23)" style="background: #ff5c26;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 24)" style="background: #F58159;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 25)" style="background: #ac5c41;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 26)" style="background: #AFABAA;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 27)" style="background: #BCB9B8;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 28)" style="background: #E6E6E6;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 29)" style="background: #FFFFFF;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 30)" style="background: #533c67;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 31)" style="background: #82619f;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 32)" style="background: #7f3286;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 33)" style="background: #ff0ae7;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 34)" style="background: #ff0357;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 35)" style="background: #ff9bcb;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 36)" style="background: #22b1a1;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 37)" style="background: #1e7590;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 38)" style="background: #2231ff;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 39)" style="background: #1def55;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 40)" style="background: #068d60;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 41)" style="background: #154e60;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 42)" style="background: #a0f742;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 43)" style="background: #47F225;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `)
})

$("#beard").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({clientId: clientId}));
    } else {
        currentItem = "beard"
        
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({}))
    }
    $("#panel").empty()
    $("#panel").append(`
        <div class="position:absolute;height:60%;">
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">BEARD STYLE<span class="itemLabel" id="name-beard_1">ㅤ</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('beard_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-beard_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["beard_1"].value}</p>
                            <button onclick="next('beard_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">BEARD OPACITY</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="beard_2" onmousemove="changeRange('beard_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('beard_3', 0)" style="background: #060606;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 1)" style="background: #131313;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 2)" style="background: #303230;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 3)" style="background: #1e0f0a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 4)" style="background: #4e2a1d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 5)" style="background: #90543d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 6)" style="background: #EDC87D;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 7)" style="background: #F5D38F;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 8)" style="background: #F7D99D;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 9)" style="background: #FCE3B2;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 10)" style="background: #c5b495;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 11)" style="background: #dfcdac;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 12)" style="background: #F9E5BF;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 13)" style="background: #e3c48a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 14)" style="background: #ebd09d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 15)" style="background: #f6e3c0;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 16)" style="background: #8e8370;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 17)" style="background: #A4530B;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 18)" style="background: #EA3C11;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 19)" style="background: #620000;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 20)" style="background: #8d0000;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 21)" style="background: #ff0505;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 22)" style="background: #ff4242;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 23)" style="background: #ff5c26;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 24)" style="background: #F58159;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 25)" style="background: #ac5c41;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 26)" style="background: #AFABAA;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 27)" style="background: #BCB9B8;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 28)" style="background: #E6E6E6;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 29)" style="background: #FFFFFF;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 30)" style="background: #533c67;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 31)" style="background: #82619f;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 32)" style="background: #7f3286;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 33)" style="background: #ff0ae7;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 34)" style="background: #ff0357;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 35)" style="background: #ff9bcb;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 36)" style="background: #22b1a1;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 37)" style="background: #1e7590;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 38)" style="background: #2231ff;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 39)" style="background: #1def55;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 40)" style="background: #068d60;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 41)" style="background: #154e60;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 42)" style="background: #a0f742;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 43)" style="background: #47F225;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `)
})

$("#makeup").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({clientId: clientId}));
    } else {
        currentItem = "makeup"
        
        $.post(`https://${resourceName}/switchCategory`, JSON.stringify({}))
    }
    $("#panel").empty()
    $("#panel").append(`
        <div class="position:absolute;height:60%;">
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">${translate.makeup_style}<span class="itemLabel" id="name-makeup_1">ㅤ</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('makeup_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-makeup_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["makeup_1"].value}</p>
                            <button onclick="next('makeup_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">${translate.makeup_opacity}</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="makeup_2" onmousemove="changeRange('makeup_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.makeup_color}</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('makeup_3', 0)" style="background: #992532;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 1)" style="background: #c8395d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 2)" style="background: #bd516c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 3)" style="background: #b8637a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 4)" style="background: #a6526b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 5)" style="background: #b1434c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 6)" style="background: #7f3133;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 7)" style="background: #a4645d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 8)" style="background: #c18779;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 9)" style="background: #cba096;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 10)" style="background: #c6918f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 11)" style="background: #ab6f63;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 12)" style="background: #b06050;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 13)" style="background: #a84c33;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 14)" style="background: #b47178;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 15)" style="background: #ca7f92;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 16)" style="background: #ed9cbe;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 17)" style="background: #e775a4;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 18)" style="background: #de3e81;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 19)" style="background: #b34c6e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 20)" style="background: #712739;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 21)" style="background: #4f1f2a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 22)" style="background: #aa222f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 23)" style="background: #de2034;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 24)" style="background: #cf0813;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 25)" style="background: #e55470;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 26)" style="background: #dc3fb5;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 27)" style="background: #c227b2;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 28)" style="background: #a01ca9;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 29)" style="background: #6e1875;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 30)" style="background: #731465;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 31)" style="background: #56165c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 32)" style="background: #6d1a9d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 33)" style="background: #1b3771;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 34)" style="background: #1d4ea7;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 35)" style="background: #1e74bb;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 36)" style="background: #21a3ce;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 37)" style="background: #25c2d2;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 38)" style="background: #23cca5;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 39)" style="background: #27c07d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 40)" style="background: #1b9c32;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 41)" style="background: #148604;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 42)" style="background: #70d041;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 43)" style="background: #c5ea34;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 44)" style="background: #e1e32f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 45)" style="background: #ffdd26;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 46)" style="background: #fac026;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 47)" style="background: #f78a27;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 48)" style="background: #fe5910;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 49)" style="background: #be6e19;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 50)" style="background: #f7c97f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 51)" style="background: #fbe5c0;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 52)" style="background: #f5f5f5;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 53)" style="background: #b3b4b3;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 54)" style="background: #919191;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 55)" style="background: #564e4e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 56)" style="background: #180e0e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 57)" style="background: #58969e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 58)" style="background: #4d6f8c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 59)" style="background: #1a2b55;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 60)" style="background: #a07e6b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 61)" style="background: #826355;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 62)" style="background: #6d5346;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 63)" style="background: #3e2d27;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="width:100%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.makeup2_color}</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('makeup_4', 0)" style="background: #1c1f20;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 1)" style="background: #282a2c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 2)" style="background: #35261c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 3)" style="background: #4b321f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 4)" style="background: #5b3b24;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 5)" style="background: #6c4c36;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 6)" style="background: #6b4f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 7)" style="background: #755c44;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 8)" style="background: #7e684d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 9)" style="background: #99815d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 10)" style="background: #a69369;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 11)" style="background: #d5b97b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 12)" style="background: #d9c38c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 13)" style="background: #a07f59;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 14)" style="background: #85503a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 15)" style="background: #62120d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 16)" style="background: #650e0b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 17)" style="background: #7c140e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 18)" style="background: #a02e18;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 19)" style="background: #b44a27;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 20)" style="background: #a2512f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 21)" style="background: #ab4e2a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 22)" style="background: #a9aaab;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 23)" style="background: #c5c5c5;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 24)" style="background: #473955;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 25)" style="background: #5a3f6b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 26)" style="background: #763c77;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 27)" style="background: #ee74e4;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 28)" style="background: #e94b93;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 29)" style="background: #f399bb;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 30)" style="background: #04959f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 31)" style="background: #035f85;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 32)" style="background: #023a73;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 33)" style="background: #175c55;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 34)" style="background: #b5bf34;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 35)" style="background: #6fa90a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 36)" style="background: #439d12;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 37)" style="background: #ddb858;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 38)" style="background: #e69102;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 39)" style="background: #f28831;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 40)" style="background: #fb8058;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 41)" style="background: #d1593c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 42)" style="background: #ac0903;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_4', 43)" style="background: #870302;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;height: 45%;background-color: rgb(25, 25, 25);border-radius: 12px;">
                <div style="display: inline-flex;margin: 10px;">
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">${translate.lipstick_style}<span class="itemLabel" id="name-lipstick_1">ㅤ</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('lipstick_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-lipstick_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["lipstick_1"].value}</p>
                            <button onclick="next('lipstick_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">${translate.lipstick_opacity}</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="lipstick_2" onmousemove="changeRange('lipstick_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.lipstick_color}</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 0)" style="background: #992532;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 1)" style="background: #c8395d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 2)" style="background: #bd516c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 3)" style="background: #b8637a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 4)" style="background: #a6526b;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 5)" style="background: #b1434c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 6)" style="background: #7f3133;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 7)" style="background: #a4645d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 8)" style="background: #c18779;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 9)" style="background: #cba096;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 10)" style="background: #c6918f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 11)" style="background: #ab6f63;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 12)" style="background: #b06050;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 13)" style="background: #a84c33;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 14)" style="background: #b47178;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 15)" style="background: #ca7f92;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 16)" style="background: #ed9cbe;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 17)" style="background: #e775a4;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 18)" style="background: #de3e81;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 19)" style="background: #b34c6e;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 20)" style="background: #712739;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 21)" style="background: #4f1f2a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 22)" style="background: #aa222f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 23)" style="background: #de2034;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 24)" style="background: #cf0813;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 25)" style="background: #e55470;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 26)" style="background: #dc3fb5;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 27)" style="background: #c227b2;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 28)" style="background: #a01ca9;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 29)" style="background: #6e1875;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 30)" style="background: #731465;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 31)" style="background: #56165c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 32)" style="background: #6d1a9d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 33)" style="background: #1b3771;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 34)" style="background: #1d4ea7;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 35)" style="background: #1e74bb;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 36)" style="background: #21a3ce;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 37)" style="background: #25c2d2;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 38)" style="background: #23cca5;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 39)" style="background: #27c07d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 40)" style="background: #1b9c32;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 41)" style="background: #148604;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 42)" style="background: #70d041;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 43)" style="background: #c5ea34;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 44)" style="background: #e1e32f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 45)" style="background: #ffdd26;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 46)" style="background: #fac026;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 47)" style="background: #f78a27;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 48)" style="background: #fe5910;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 49)" style="background: #be6e19;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 50)" style="background: #f7c97f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 51)" style="background: #fbe5c0;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 52)" style="background: #f5f5f5;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 53)" style="background: #b3b4b3;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 54)" style="background: #919191;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 55)" style="background: #564e4e;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 56)" style="background: #180e0e;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 57)" style="background: #58969e;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 58)" style="background: #4d6f8c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 59)" style="background: #1a2b55;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 60)" style="background: #a07e6b;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 61)" style="background: #826355;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 62)" style="background: #6d5346;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 63)" style="background: #3e2d27;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="width: 92%;margin-left: auto;margin-right: auto;margin-top: 5%;background-color: rgb(25, 25, 25);border-radius: 12px;padding: 10px;">
            <div style="display: inline-flex;margin: 10px;width: 95%;">
                <div style="margin-right: 15px;width:31%">
                    <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">${translate.blush_style}<span class="itemLabel" id="name-blush_1">ã…¤</span></p>
                    <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                        <button onclick="previous('blush_1')" id="minus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                            <i class="fa-solid fa-caret-left"></i>
                        </button>
                        <p id="current-blush_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["blush_1"].value}</p>
                        <button onclick="next('blush_1')" id="plus" style="width: 33px;height: 33px;background-color: #ff69b4;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                            <i class="fa-solid fa-caret-right"></i>
                        </button>
                    </div>
                    <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">${translate.blush_opacity}</p>
                    <input type="range" min="0" max="10" value="0" class="slider" id="blush_2" onmousemove="changeRange('blush_2')">
                </div>
                <div style="width:66%">
                    <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.blush_color}</p>
                    <div style="display: flex;flex-wrap: wrap;width: 101%;">
                        <div class="colour-selection" onclick="changeColor('blush_3', 0)" style="background: #992532;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 1)" style="background: #c8395d;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 2)" style="background: #bd516c;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 3)" style="background: #b8637a;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 4)" style="background: #a6526b;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 5)" style="background: #b1434c;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 6)" style="background: #7f3133;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 7)" style="background: #a4645d;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 8)" style="background: #c18779;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 9)" style="background: #cba096;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 10)" style="background: #c6918f;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 11)" style="background: #ab6f63;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 12)" style="background: #b06050;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 13)" style="background: #a84c33;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 14)" style="background: #b47178;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 15)" style="background: #ca7f92;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 16)" style="background: #ed9cbe;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 17)" style="background: #e775a4;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 18)" style="background: #de3e81;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 19)" style="background: #b34c6e;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 20)" style="background: #712739;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 21)" style="background: #4f1f2a;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 22)" style="background: #aa222f;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 23)" style="background: #de2034;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 24)" style="background: #cf0813;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 25)" style="background: #e55470;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 26)" style="background: #dc3fb5;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 27)" style="background: #c227b2;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 28)" style="background: #a01ca9;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 29)" style="background: #6e1875;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 30)" style="background: #731465;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 31)" style="background: #56165c;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 32)" style="background: #6d1a9d;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 33)" style="background: #1b3771;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 34)" style="background: #1d4ea7;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 35)" style="background: #1e74bb;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 36)" style="background: #21a3ce;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 37)" style="background: #25c2d2;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 38)" style="background: #23cca5;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 39)" style="background: #27c07d;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 40)" style="background: #1b9c32;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 41)" style="background: #148604;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 42)" style="background: #70d041;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 43)" style="background: #c5ea34;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 44)" style="background: #e1e32f;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 45)" style="background: #ffdd26;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 46)" style="background: #fac026;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 47)" style="background: #f78a27;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 48)" style="background: #fe5910;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 49)" style="background: #be6e19;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 50)" style="background: #f7c97f;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 51)" style="background: #fbe5c0;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 52)" style="background: #f5f5f5;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 53)" style="background: #b3b4b3;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 54)" style="background: #919191;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 55)" style="background: #564e4e;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 56)" style="background: #180e0e;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 57)" style="background: #58969e;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 58)" style="background: #4d6f8c;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 59)" style="background: #1a2b55;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 60)" style="background: #a07e6b;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 61)" style="background: #826355;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 62)" style="background: #6d5346;"></div>
                        <div class="colour-selection" onclick="changeColor('blush_3', 63)" style="background: #3e2d27;"></div>
                    </div>
                </div>
            </div>
        </div>
    `)
})

$("#camrotate").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/cam`, JSON.stringify({clientId: clientId}));
    } else {
        $.post(`https://${resourceName}/cam`, JSON.stringify({}));
    }
})

$("#hide").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/hide`, JSON.stringify({clientId: clientId}));
        clientId = undefined
    } else {
        $.post(`https://${resourceName}/hide`, JSON.stringify({}));
    }
})

$("#buy").click(function() {
    if (clientId) {
        $.post(`https://${resourceName}/buy`, JSON.stringify({clientId: clientId}));
    } else {
        $.post(`https://${resourceName}/buy`, JSON.stringify({currentItem: currentItem}));
    }
})

function previous(item) {
    if (currentValue[item].value > currentValue[item].min) {
        currentValue[item].value = currentValue[item].value - 1
    }
    $(`#current-${item}`).html(currentValue[item].value)
    if (CustomNames[item] && CustomNames[item][currentValue[item].value]) {
        $(`#name-${item}`).html(CustomNames[item][currentValue[item].value])
    } else {
        $(`#name-${item}`).html("ㅤ")
    }
    if (clientId) {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: currentValue[item].value,
            clientId: clientId,
        }));
    } else {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: currentValue[item].value
        }));
    }
}

function next(item) {
    if (currentValue[item].value < currentValue[item].max) {
        currentValue[item].value = currentValue[item].value + 1
    }
    $(`#current-${item}`).html(currentValue[item].value)
    if (CustomNames[item] && CustomNames[item][currentValue[item].value]) {
        $(`#name-${item}`).html(CustomNames[item][currentValue[item].value])
    } else {
        $(`#name-${item}`).html("ㅤ")
    }
    if (clientId) {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: currentValue[item].value,
            clientId: clientId,
        }));
    } else {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: currentValue[item].value
        }));
    }
}

function changeColor(item, dataId) {
    if (clientId) {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: dataId,
            clientId: clientId,
        }));
    } else {
        $.post(`https://${resourceName}/change`, JSON.stringify({
            type: item,
            new: dataId
        }));
    }
    currentValue[item].value = dataId
}

function changeRange(item) {
    let inputValue = $("#" + item).val()
    let result = inputValue
    if (result != currentValue[item].value) {
        console.log(`Changing ${item} opacity to ${result}`);
        if (clientId) {
            $.post(`https://${resourceName}/change`, JSON.stringify({
                type: item,
                new: result,
                clientId: clientId,
            }));
        } else {
            $.post(`https://${resourceName}/change`, JSON.stringify({
                type: item,
                new: result
            }));
        }
        currentValue[item].value = result
    }
}
// ═══════════════════════════════════════════════════════════════════════════════
// TABLET UI FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

// Employee Mode Setup
function showEmployeeMode(data) {
    if (DEBUG) console.log("[TABLET] Setting up employee mode, data:", data);
    
    $(".employee-only").css("display", "block");
    $(".customer-only").css("display", "none");
    $("#tablet-nav").css("display", "flex");
    
    if (data.isManager || data.isManagement) {
        $(".management-only").css("display", "block");
    } else {
        $(".management-only").css("display", "none");
    }
    
    tabletServices = data.services || [];
    chargeLimit = data.chargeLimit || 500;
    
    renderServiceList(tabletServices);
    
    selectedServices = [];
    invoiceTotal = 0;
    
    $("#invoice-summary").css("display", "block");
    $("#invoice-items").css("display", "block");
    $("#invoice-total").css("display", "flex");
    
    updateInvoiceDisplay();
    
    $(".tab-panel").css("display", "none").removeClass("active");
    $("#tab-home").css("display", "block").addClass("active");
    $(".tab-btn").removeClass("active");
    $(".tab-btn[data-tab='home']").addClass("active");
    
    $.post("https://" + resourceName + "/getStats", JSON.stringify({}));
}

// Customer Mode Setup  
function showCustomerMode(data) {
    if (DEBUG) console.log("[TABLET] Setting up customer mode");
    
    $(".employee-only").each(function() { $(this).attr("style", "display: none !important;"); });
    $("#tablet-nav").attr("style", "display: none !important;");
    $(".tab-panel").each(function() { $(this).removeClass("active").attr("style", "display: none !important;"); });
    
    $(".customer-only").attr("style", "display: block !important;");
    $("#tab-customer-payment").removeClass("employee-only").addClass("active").attr("style", "display: block !important;");
    
    customerEmployeeId = data.employeeId || data.barberId;
    customerSubtotal = data.subtotal || 0;
    customerTip = 0;
    
    $("#payment-employee-name").text(data.employeeName || data.barberName || "Your Stylist");
    $("#payment-subtotal").text('$' + customerSubtotal);
    
    renderCustomerServices(data.services || []);
    updateCustomerTotal();
    
    $(".tip-btn").removeClass("selected");
    $("#custom-tip-input").val("");
}

function renderServiceList(services) {
    var html = '';
    services.forEach(function(service, index) {
        html += '<div class="service-item" data-index="' + index + '" data-name="' + service.name + '" data-price="' + service.price + '" data-category="' + (service.category || 'all') + '">';
        html += '<span class="service-name">' + service.name + '</span>';
        html += '<span class="service-price">$' + service.price + '</span>';
        html += '</div>';
    });
    $("#services-list").html(html);
}

function updateInvoiceDisplay() {
    var html = '';
    if (selectedServices.length === 0) {
        html = '<div class="empty-invoice">No services selected</div>';
    } else {
        selectedServices.forEach(function(service, index) {
            html += '<div class="invoice-item" data-index="' + index + '">';
            html += '<span class="invoice-item-name">' + service.name + '</span>';
            html += '<span class="invoice-item-price">$' + service.price + '</span>';
            html += '<span class="invoice-item-remove"><i class="fa-solid fa-xmark"></i></span>';
            html += '</div>';
        });
    }
    
    $("#invoice-items").html(html);
    $("#invoice-subtotal").text('$' + invoiceTotal);
    
    var passBtn = $("#pass-to-customer-btn");
    if (invoiceTotal > 0 && selectedServices.length > 0) {
        passBtn.removeClass("disabled").prop("disabled", false).css({"background": "linear-gradient(135deg, #ff69b4 0%, #ff85c1 100%)", "color": "#fff", "cursor": "pointer"});
    } else {
        passBtn.addClass("disabled").prop("disabled", true).css({"background": "#333", "color": "#666", "cursor": "not-allowed"});
    }
}

function renderCustomerServices(services) {
    var html = '';
    services.forEach(function(service) {
        html += '<div class="payment-service-item"><span class="payment-service-name">' + service.name + '</span><span class="payment-service-price">$' + service.price + '</span></div>';
    });
    $("#payment-services").html(html);
    $("#payment-subtotal").text('$' + customerSubtotal);
}

function updateCustomerTotal() {
    var total = customerSubtotal + customerTip;
    $("#payment-total").text('$' + total);
    $("#payment-tip").text('$' + customerTip);
}

function showSection(sectionName) {
    $(".tab-panel").css("display", "none").removeClass("active");
    $("#tab-" + sectionName).css("display", "block").addClass("active");
    $(".tab-btn").removeClass("active");
    $(".tab-btn[data-tab='" + sectionName + "']").addClass("active");
}

function hideTablet() {
    $("#tablet-container").hide().css({"pointer-events": "none", "z-index": "-1"});
    $("#tablet-frame").hide();
    $("#tablet-screen").hide();
    tabletMode = null;
    selectedServices = [];
    invoiceTotal = 0;
    customerTip = 0;
    customerSubtotal = 0;
    customerEmployeeId = null;
}

function renderTransactions(transactions) {
    var html = '';
    if (!transactions || transactions.length === 0) {
        html = '<div class="empty-list">No transactions yet</div>';
    } else {
        transactions.forEach(function(tx) {
            html += '<div class="history-item"><div class="history-item-header"><span class="history-customer">' + (tx.customer_name || 'Unknown') + '</span><span class="history-date">' + (tx.created_at || '') + '</span></div><div class="history-amount"><span class="history-total">$' + (tx.total || 0) + '</span></div></div>';
        });
    }
    $("#history-list").html(html);
}

function renderStats(stats) {
    if (!stats) return;
    var todayEarnings = stats.today ? (stats.today.total_earned || 0) : 0;
    var todayTips = stats.today ? (stats.today.total_tips || 0) : 0;
    var todayCustomers = stats.today ? (stats.today.customer_count || 0) : 0;
    var weekEarnings = stats.week ? (stats.week.total_earned || 0) : 0;
    var weekTips = stats.week ? (stats.week.total_tips || 0) : 0;
    var weekCustomers = stats.week ? (stats.week.customer_count || 0) : 0;
    
    $("#stat-today-sales").text('$' + todayEarnings);
    $("#stat-today-tips").text('$' + todayTips);
    $("#stat-today-count").text(todayCustomers);
    $("#stat-week-sales").text('$' + weekEarnings);
    $("#stat-week-tips").text('$' + weekTips);
    $("#stat-week-count").text(weekCustomers);
    $("#home-today-services").text(todayCustomers);
    $("#home-today-earned").text('$' + todayEarnings);
    $("#home-today-customers").text(todayCustomers);
}

// ═══════════════════════════════════════════════════════════════════════════════
// APPOINTMENT SYSTEM RENDER FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

var currentAvailability = [];
var dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

function renderAppointments(appointments) {
    var html = '';
    if (!appointments || appointments.length === 0) {
        html = '<div class="empty-list">No appointments scheduled</div>';
    } else {
        appointments.forEach(function(appt) {
            var statusClass = appt.status === 'confirmed' ? 'confirmed' : 'pending';
            var services = '';
            try {
                var servicesArr = typeof appt.services === 'string' ? JSON.parse(appt.services) : appt.services;
                if (servicesArr && servicesArr.length > 0) {
                    services = servicesArr.map(function(s) { return s.name || s.label || s; }).join(', ');
                }
            } catch(e) { services = ''; }
            
            html += '<div class="appointment-item ' + statusClass + '" data-id="' + (appt.id || 0) + '">';
            html += '<div class="appt-info">';
            html += '<span class="appt-customer">' + (appt.customer_name || 'Unknown') + '</span>';
            html += '<span class="appt-time">' + (appt.appointment_date || '') + ' @ ' + (appt.appointment_time || '') + '</span>';
            if (services) html += '<span class="appt-services">' + services + '</span>';
            if (appt.total_price > 0) html += '<span class="appt-price">$' + appt.total_price + '</span>';
            html += '</div>';
            html += '<div class="appt-actions">';
            html += '<span class="appt-status ' + statusClass + '">' + (appt.status || 'pending') + '</span>';
            html += '<button class="appt-cancel" title="Cancel"><i class="fa-solid fa-trash"></i></button>';
            html += '</div>';
            html += '</div>';
        });
    }
    $("#appointments-list").html(html);
}

function renderMyAvailability(availability) {
    currentAvailability = availability || [];
    var html = '';
    var acceptingBookings = false;
    
    for (var i = 0; i < 7; i++) {
        var dayData = currentAvailability.find(function(d) { return d.day_of_week === i; }) || {
            day_of_week: i,
            start_time: '09:00',
            end_time: '17:00',
            slot_increment: 30,
            enabled: false,
            accepting_bookings: false
        };
        
        if (dayData.accepting_bookings) acceptingBookings = true;
        
        html += '<div class="availability-day" data-day="' + i + '">';
        html += '<div class="day-header">';
        html += '<label class="day-toggle">';
        html += '<input type="checkbox" class="day-enabled" ' + (dayData.enabled ? 'checked' : '') + '>';
        html += '<span>' + dayNames[i] + '</span>';
        html += '</label>';
        html += '</div>';
        html += '<div class="day-times ' + (dayData.enabled ? '' : 'disabled') + '">';
        html += '<input type="time" class="start-time" value="' + (dayData.start_time || '09:00') + '">';
        html += '<span>to</span>';
        html += '<input type="time" class="end-time" value="' + (dayData.end_time || '17:00') + '">';
        html += '<select class="slot-increment">';
        html += '<option value="15" ' + (dayData.slot_increment == 15 ? 'selected' : '') + '>15 min</option>';
        html += '<option value="30" ' + (dayData.slot_increment == 30 ? 'selected' : '') + '>30 min</option>';
        html += '<option value="45" ' + (dayData.slot_increment == 45 ? 'selected' : '') + '>45 min</option>';
        html += '<option value="60" ' + (dayData.slot_increment == 60 ? 'selected' : '') + '>60 min</option>';
        html += '</select>';
        html += '</div>';
        html += '</div>';
    }
    
    $("#availability-days").html(html);
    $("#accepting-bookings-toggle").prop('checked', acceptingBookings);
    $("#availability-editor").show();
}

function renderAvailableEmployees(employees) {
    // For future customer booking UI
    if (DEBUG) console.log("[TABLET] Available employees:", employees);
}

function renderEmployeeDates(dates) {
    // For future customer booking UI
    if (DEBUG) console.log("[TABLET] Employee dates:", dates);
}

function renderTimeSlots(slots) {
    // For future customer booking UI
    if (DEBUG) console.log("[TABLET] Time slots:", slots);
}

function renderMyBookings(bookings) {
    // For future customer booking UI
    if (DEBUG) console.log("[TABLET] My bookings:", bookings);
}

function collectAvailabilityData() {
    var data = [];
    var acceptingBookings = $("#accepting-bookings-toggle").is(':checked');
    
    $(".availability-day").each(function() {
        var day = $(this).data('day');
        var enabled = $(this).find('.day-enabled').is(':checked');
        var startTime = $(this).find('.start-time').val() || '09:00';
        var endTime = $(this).find('.end-time').val() || '17:00';
        var slotIncrement = parseInt($(this).find('.slot-increment').val()) || 30;
        
        data.push({
            day_of_week: day,
            start_time: startTime,
            end_time: endTime,
            slot_increment: slotIncrement,
            enabled: enabled,
            accepting_bookings: enabled && acceptingBookings
        });
    });
    
    return data;
}

function renderFinances(finances) {
    if (!finances) return;
    $("#finance-today").text('$' + (finances.todaySales || 0));
    $("#finance-week").text('$' + (finances.weekSales || 0));
    $("#finance-month").text('$' + (finances.monthSales || 0));
    $("#finance-balance").text('$' + (finances.balance || 0));
    $("#society-balance").text('$' + (finances.balance || 0));
}

function renderEmployeeStats(employees) {
    var html = '';
    if (!employees || employees.length === 0) {
        html = '<div class="empty-list">No employee data</div>';
    } else {
        employees.forEach(function(emp) {
            html += '<div class="employee-stat-item"><span class="emp-name">' + (emp.barber_name || 'Unknown') + '</span><span class="emp-stats">' + (emp.customer_count || 0) + ' services</span><span class="emp-revenue">$' + (emp.total_earned || 0) + ' (+$' + (emp.total_tips || 0) + ' tips)</span></div>';
        });
    }
    $("#employee-stats-list").html(html);
}

function renderDeclined(declined) {
    var html = '';
    if (!declined || declined.length === 0) {
        html = '<div class="empty-list">No declined transactions</div>';
    } else {
        declined.forEach(function(dec) {
            html += '<div class="declined-item"><span class="dec-customer">' + (dec.customer_name || 'Unknown') + '</span><span class="dec-amount">$' + (dec.total || 0) + '</span><span class="dec-date">' + (dec.created_at || '') + '</span></div>';
        });
    }
    $("#declined-list").html(html);
}

function renderCurrentEmployees(employees) {
    var html = '';
    if (!employees || employees.length === 0) {
        html = '<div class="no-employees">No employees found</div>';
    } else {
        employees.forEach(function(emp) {
            var statusClass = emp.online ? 'online' : 'offline';
            var statusText = emp.online ? '● Online' : '○ Offline';
            html += '<div class="employee-item" data-identifier="' + emp.identifier + '">';
            html += '<div class="employee-info"><span class="employee-name-text">' + emp.name + '</span><span class="employee-grade">' + emp.gradeName + ' (Grade ' + emp.grade + ')</span><span class="employee-status ' + statusClass + '">' + statusText + '</span></div>';
            html += '<div class="employee-actions"><select class="employee-grade-select" data-identifier="' + emp.identifier + '">';
            jobGrades.forEach(function(grade) { html += '<option value="' + grade.grade + '"' + (grade.grade === emp.grade ? ' selected' : '') + '>' + grade.name + '</option>'; });
            html += '</select><button class="promote-btn update-grade-btn" data-identifier="' + emp.identifier + '"><i class="fa-solid fa-arrow-up"></i></button>';
            html += '<button class="fire-btn" data-identifier="' + emp.identifier + '"><i class="fa-solid fa-user-minus"></i></button></div></div>';
        });
    }
    $("#current-employees-list").html(html);
}

function renderNearbyHireable(players) {
    if (!players || players.length === 0) {
        $("#nearby-hireable-list").html('<div class="no-hireable">No players nearby to hire</div>').show();
        return;
    }
    var html = '<div class="hireable-header"><h4>Nearby Players</h4><button class="close-hireable"><i class="fa-solid fa-times"></i></button></div>';
    players.forEach(function(player) {
        html += '<div class="hireable-item" data-player-id="' + player.id + '"><div class="hireable-info"><span class="hireable-name">' + player.name + '</span><span class="hireable-distance">' + player.distance.toFixed(1) + 'm away</span></div>';
        html += '<div class="hireable-actions"><select class="grade-select">';
        jobGrades.forEach(function(grade) { html += '<option value="' + grade.grade + '">' + grade.name + '</option>'; });
        html += '</select><button class="hire-player-btn" data-player-id="' + player.id + '"><i class="fa-solid fa-check"></i> Hire</button></div></div>';
    });
    $("#nearby-hireable-list").html(html).show();
}

function renderServicePrices(services) {
    var html = '';
    if (!services || services.length === 0) {
        html = '<div class="empty-list">No services configured</div>';
    } else {
        services.forEach(function(service, index) {
            html += '<div class="price-edit-item" data-service-id="' + index + '" data-service-name="' + service.name + '"><span class="price-edit-name">' + service.name + '</span><input type="number" class="price-edit-input" value="' + service.price + '" min="0"><button class="price-save-btn"><i class="fa-solid fa-check"></i></button></div>';
        });
    }
    $("#price-management-list").html(html);
}

function renderShelfPrices(shelves) {
    var container = $("#shelf-prices-list");
    container.empty();
    if (!shelves || shelves.length === 0) { container.html('<div class="empty-list">No shelf products found</div>'); return; }
    shelves.forEach(function(shelf, index) {
        var shelfId = 'shelf-section-' + index;
        var itemsHtml = '';
        shelf.items.forEach(function(item) {
            itemsHtml += '<div class="shelf-price-row"><span class="shelf-item-label">' + item.label + '</span><div class="shelf-price-controls"><span class="shelf-config-price">$' + item.configPrice + '</span><input type="number" class="shelf-price-input" data-name="' + item.name + '" data-label="' + item.label + '" value="' + item.price + '" min="0"><button class="shelf-price-save-btn"><i class="fa-solid fa-check"></i></button></div></div>';
        });
        container.append('<div class="shelf-section"><div class="shelf-header" data-target="' + shelfId + '"><span class="shelf-title"><i class="fa-solid fa-box"></i> ' + shelf.shelfLabel + '</span><span class="shelf-item-count">' + shelf.items.length + ' items</span><i class="fa-solid fa-chevron-down shelf-toggle"></i></div><div class="shelf-items" id="' + shelfId + '">' + itemsHtml + '</div></div>');
    });
}

// ═══════════════════════════════════════════════════════════════════════════════
// TABLET EVENT HANDLERS
// ═══════════════════════════════════════════════════════════════════════════════

$(document).ready(function() {
    $(document).on("click", "#tablet-logo", function() { showSection('home'); $.post("https://" + resourceName + "/getStats", JSON.stringify({})); });
    $(document).on("click", "#start-charge-btn", function() { showSection('services'); });
    
    $(document).on("click", ".tab-btn", function() {
        var tab = $(this).data("tab");
        showSection(tab);
        if (tab === "history") $.post("https://" + resourceName + "/getTransactions", JSON.stringify({}));
        else if (tab === "stats") $.post("https://" + resourceName + "/getStats", JSON.stringify({}));
        else if (tab === "appointments") $.post("https://" + resourceName + "/getAppointments", JSON.stringify({}));
        else if (tab === "management") {
            $.post("https://" + resourceName + "/getFinances", JSON.stringify({}));
            $.post("https://" + resourceName + "/getEmployeeStats", JSON.stringify({}));
            $.post("https://" + resourceName + "/getDeclinedTransactions", JSON.stringify({}));
            $.post("https://" + resourceName + "/getJobGrades", JSON.stringify({}));
            $.post("https://" + resourceName + "/getCurrentEmployees", JSON.stringify({}));
            $.post("https://" + resourceName + "/getShelfPrices", JSON.stringify({}));
            renderServicePrices(tabletServices);
            $("#charge-limit-input").val(chargeLimit);
        }
    });
    
    $(document).on("click", ".shelf-header", function() { var target = $(this).data("target"); $("#" + target).slideToggle(200); $(this).find(".shelf-toggle").toggleClass("rotated"); });
    $(document).on("click", ".cat-btn", function() { $(".cat-btn").removeClass("active"); $(this).addClass("active"); var category = $(this).data("category"); if (category === "all") $(".service-item").show(); else { $(".service-item").hide(); $(".service-item[data-category='" + category + "']").show(); } });
    
    $(document).on("click", ".service-item", function() {
        var el = $(this), name = el.data("name"), price = parseFloat(el.data("price")) || 0;
        if (el.hasClass("selected")) { el.removeClass("selected"); var idx = selectedServices.findIndex(function(s) { return s.name === name; }); if (idx > -1) { selectedServices.splice(idx, 1); invoiceTotal -= price; } }
        else { el.addClass("selected"); selectedServices.push({ name: name, price: price }); invoiceTotal += price; }
        updateInvoiceDisplay();
    });
    
    $(document).on("click", ".invoice-item-remove", function(e) {
        e.stopPropagation();
        var item = $(this).parent(), idx = item.data("index"), service = selectedServices[idx];
        if (service) { invoiceTotal -= service.price; selectedServices.splice(idx, 1); $(".service-item").each(function() { if ($(this).data("name") === service.name) $(this).removeClass("selected"); }); updateInvoiceDisplay(); }
    });
    
    $(document).on("click", "#add-custom-charge", function() {
        var name = $("#custom-charge-name").val().trim() || "Custom Charge", price = parseFloat($("#custom-charge-input").val());
        if (isNaN(price) || price <= 0) return;
        if (price > chargeLimit) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Charge limit exceeded ($" + chargeLimit + ")", type: "error" })); return; }
        selectedServices.push({ name: name, price: price, custom: true }); invoiceTotal += price; updateInvoiceDisplay();
        $("#custom-charge-name").val(""); $("#custom-charge-input").val("");
    });
    
    $(document).on("click", "#pass-to-customer-btn", function() { if ($(this).hasClass("disabled") || selectedServices.length === 0) return; $.post("https://" + resourceName + "/passToCustomer", JSON.stringify({ services: selectedServices, subtotal: invoiceTotal })); });
    $(document).on("click", ".tip-btn", function() { $(".tip-btn").removeClass("selected"); $(this).addClass("selected"); var tipPercent = $(this).data("tip"); if (tipPercent !== undefined) { customerTip = Math.round(customerSubtotal * (tipPercent / 100)); $("#custom-tip-input").val(""); } updateCustomerTotal(); });
    $(document).on("input", "#custom-tip-input", function() { var val = parseFloat($(this).val()); if (!isNaN(val) && val >= 0) { customerTip = val; $(".tip-btn").removeClass("selected"); updateCustomerTotal(); } });
    $(document).on("click", ".pay-btn", function() { $.post("https://" + resourceName + "/processPayment", JSON.stringify({ paymentMethod: $(this).data("type"), tip: customerTip })); });
    $(document).on("click", "#decline-payment-btn", function() { $.post("https://" + resourceName + "/declinePayment", JSON.stringify({})); });
    $(document).on("click", "#tablet-close", function() { $.post("https://" + resourceName + "/closeTablet", JSON.stringify({})); });
// ═══════════════════════════════════════════════════════════════════════════════
    // APPOINTMENT SYSTEM CLICK HANDLERS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    // Open availability editor
    $(document).on("click", "#manage-availability-btn", function() {
        $.post("https://" + resourceName + "/getMyAvailability", JSON.stringify({}));
    });
    
    // Close availability editor
    $(document).on("click", "#close-availability-btn", function() {
        $("#availability-editor").hide();
    });
    
    // Toggle day enabled/disabled
    $(document).on("change", ".day-enabled", function() {
        var dayTimes = $(this).closest('.availability-day').find('.day-times');
        if ($(this).is(':checked')) {
            dayTimes.removeClass('disabled');
        } else {
            dayTimes.addClass('disabled');
        }
    });
    
    // Save availability
    $(document).on("click", "#save-availability-btn", function() {
        var availabilityData = collectAvailabilityData();
        $.post("https://" + resourceName + "/saveAvailability", JSON.stringify({ availability: availabilityData }));
        $("#availability-editor").hide();
    });
    
    // Cancel appointment (employee view)
    $(document).on("click", ".appt-cancel", function() {
        var id = $(this).closest('.appointment-item').data("id");
        $.post("https://" + resourceName + "/cancelAppointment", JSON.stringify({ id: id }));
    });
    
    $(document).on("click", "#update-charge-limit-btn", function() { var newLimit = parseInt($("#charge-limit-input").val()); if (isNaN(newLimit) || newLimit < 0) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Please enter a valid charge limit", type: "error" })); return; } $.post("https://" + resourceName + "/updateChargeLimit", JSON.stringify({ limit: newLimit })); chargeLimit = newLimit; });
    $(document).on("click", ".price-save-btn", function() { var item = $(this).closest(".price-edit-item"), serviceName = item.data("service-name"), newPrice = parseFloat(item.find(".price-edit-input").val()); if (isNaN(newPrice) || newPrice < 0) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Please enter a valid price", type: "error" })); return; } $.post("https://" + resourceName + "/updateServicePrice", JSON.stringify({ serviceName: serviceName, price: newPrice })); for (var i = 0; i < tabletServices.length; i++) { if (tabletServices[i].name === serviceName) { tabletServices[i].price = newPrice; break; } } renderServiceList(tabletServices); });
    $(document).on("click", ".shelf-price-save-btn", function() { var input = $(this).parent().find(".shelf-price-input"), itemName = input.data("name"), newPrice = parseFloat(input.val()); if (isNaN(newPrice) || newPrice < 0) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Please enter a valid price", type: "error" })); return; } $.post("https://" + resourceName + "/updateShelfPrice", JSON.stringify({ itemName: itemName, price: newPrice })); });
    $(document).on("click", "#deposit-btn", function() { var amount = parseInt($("#deposit-amount").val()); if (isNaN(amount) || amount <= 0) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Please enter a valid amount", type: "error" })); return; } $.post("https://" + resourceName + "/depositMoney", JSON.stringify({ amount: amount })); $("#deposit-amount").val(""); });
    $(document).on("click", "#withdraw-btn", function() { var amount = parseInt($("#withdraw-amount").val()); if (isNaN(amount) || amount <= 0) { $.post("https://" + resourceName + "/showNotification", JSON.stringify({ title: "Error", description: "Please enter a valid amount", type: "error" })); return; } $.post("https://" + resourceName + "/withdrawMoney", JSON.stringify({ amount: amount })); $("#withdraw-amount").val(""); });
    $(document).on("click", "#refresh-balance", function() { $.post("https://" + resourceName + "/getFinances", JSON.stringify({})); });
    $(document).on("click", "#hire-employee-btn", function() { $.post("https://" + resourceName + "/getNearbyHireable", JSON.stringify({})); });
    $(document).on("click", ".close-hireable", function() { $("#nearby-hireable-list").hide(); });
    $(document).on("click", ".hire-player-btn", function() { var item = $(this).closest(".hireable-item"), playerId = item.data("player-id"), grade = parseInt(item.find(".grade-select").val()); $.post("https://" + resourceName + "/hireEmployee", JSON.stringify({ playerId: playerId, grade: grade })); $("#nearby-hireable-list").hide(); });
    $(document).on("click", ".update-grade-btn", function() { var item = $(this).closest(".employee-item"), identifier = item.data("identifier"), newGrade = parseInt(item.find(".employee-grade-select").val()); $.post("https://" + resourceName + "/updateEmployeeGrade", JSON.stringify({ identifier: identifier, grade: newGrade })); });
    $(document).on("click", ".fire-btn", function() { $.post("https://" + resourceName + "/fireEmployee", JSON.stringify({ identifier: $(this).closest(".employee-item").data("identifier") })); });
    
    $(document).on("keydown", function(e) { if (e.key === "Escape" && tabletMode !== null) { $.post("https://" + resourceName + "/closeTablet", JSON.stringify({})); } });
});