// Detect resource name dynamically
const resourceName = 'fadetrap-plus';

const DEBUG = false; // Set to true to enable console logging

var clientId
var currentItem
var hasFade = false

var CustomNames = {}
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
}

// Add translation object for makeup section
const translate = {
    makeup_style: "MAKEUP STYLE",
    makeup_opacity: "MAKEUP OPACITY",
    makeup_color: "MAKEUP COLOR",
    makeup2_color: "MAKEUP COLOR 2",
    lipstick_style: "LIPSTICK STYLE",
    lipstick_opacity: "LIPSTICK OPACITY",
    lipstick_color: "LIPSTICK COLOR"
}

window.addEventListener('message', function(event){
    var item = event.data;
    
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    // TABLET UI HANDLERS
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    
    if (item.action == "showTablet") {
        if (DEBUG) console.log("[TABLET] Showing tablet UI, mode:", item.mode);
        tabletMode = item.mode;
        
        // Show body
        $("body").css("display", "block");
        
        // Hide hair styling UI elements (hide direct children of body except tablet)
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
            "background": "rgba(0,0,0,0.7)"
        });
        
        // Show tablet frame (bezel)
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
        
        if (DEBUG) console.log("[TABLET] Container shown");
        
        if (item.mode == "barber") {
            showBarberMode(item);
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
    
    if (item.action == "updateTransactions") {
        renderTransactions(item.transactions);
        return;
    }
    
    if (item.action == "updateStats") {
        renderStats(item.stats);
        return;
    }
    
    if (item.action == "updateAppointments") {
        renderAppointments(item.appointments);
        return;
    }
    
    if (item.action == "updateManagement") {
        if (item.finances) renderFinances(item.finances);
        if (item.employeeStats) renderEmployeeStats(item.employeeStats);
        if (item.declined) renderDeclined(item.declined);
        return;
    }
    
    // Individual management data handlers
    if (item.action == "updateFinances") {
        if (DEBUG) console.log("[TABLET] Received finances:", item.finances);
        renderFinances(item.finances);
        return;
    }
    
    if (item.action == "updateEmployeeStats") {
        if (DEBUG) console.log("[TABLET] Received employee stats:", item.employeeStats);
        renderEmployeeStats(item.employeeStats);
        return;
    }
    
    if (item.action == "updateDeclinedTransactions") {
        if (DEBUG) console.log("[TABLET] Received declined transactions:", item.declinedTransactions);
        renderDeclined(item.declinedTransactions);
        return;
    }
    
    // Employee management handlers
    if (item.action == "updateJobGrades") {
        if (DEBUG) console.log("[TABLET] Received job grades:", item.grades);
        jobGrades = item.grades || [];
        return;
    }
    
    if (item.action == "updateCurrentEmployees") {
        if (DEBUG) console.log("[TABLET] Received current employees:", item.employees);
        renderCurrentEmployees(item.employees);
        return;
    }
    
    if (item.action == "updateNearbyHireable") {
        if (DEBUG) console.log("[TABLET] Received nearby hireable:", item.players);
        renderNearbyHireable(item.players);
        return;
    }
    
    if (item.action == "hideHireableList") {
        $("#nearby-hireable-list").hide();
        return;
    }
    
    if (item.action == "updateSocietyBalance") {
        if (DEBUG) console.log("[TABLET] Received society balance:", item.balance);
        $("#finance-balance").text('$' + (item.balance || 0));
        return;
    }
    
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    // HAIR STYLING UI HANDLERS
    // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
    
    if (item.action == "show") {
        // Hide tablet if showing hair UI
        $("#tablet-container").hide();
        $("body").css("display", "block")
        if (item.hasFade !== undefined) {
            hasFade = item.hasFade
        }
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
        if (item.Others) {
            $(".others_circle").css("display", "block")
        }
        if (item.clientId) {
            clientId = item.clientId
        }
        CustomNames = item.CustomNames
    }
    if (item.action == "hide") {
        $("body").css("display", "none")
    }
    if (item.action == "openAgain") {
        $("body").css("display", "block")
    }
    if (item.action == "refresh") {
        for (const [key, value] of Object.entries(item.data)) {
            if (currentValue[key]) {
                currentValue[key] = {
                    value: value.value,
                    min: value.min,
                    max: value.max
                }
               
                var element = document.getElementById("current-" + key);
                if (element) {
                    element.textContent = value.value;
                }
            }
        }
        console.log("UI refreshed with current appearance data");
    }
    if (item.action == "update_field") {
        if (currentValue[item.field]) {
            currentValue[item.field].value = item.value;
            
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
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">HAIR STYLE</p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('hair_1')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-hair_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_1"].value}</p>
                            <button onclick="next('hair_1')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
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
    <button onclick="previous('hair_2')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
        <i class="fa-solid fa-caret-left"></i>
    </button>
    <p id="current-hair_2" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_2"].value}</p>
    <button onclick="next('hair_2')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
        <i class="fa-solid fa-caret-right"></i>
    </button>
</div>
${hasFade ? `
<p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px;margin-top:8px;">FADE</p>
<div style="display: inline-flex;margin-bottom: 10px;width: 100%;justify-content: space-evenly;">
    <button onclick="previous('hair_fade')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
        <i class="fa-solid fa-caret-left"></i>
    </button>
    <p id="current-hair_fade" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["hair_fade"].value}</p>
    <button onclick="next('hair_fade')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
        <i class="fa-solid fa-caret-right"></i>
    </button>
</div>` : ''}
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
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
                    <div style="margin-right: 15px;width:31%">
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">EYEBROW STYLE<span class="itemLabel" id="name-eyebrows_1"></span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('eyebrows_1')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-eyebrows_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["eyebrows_1"].value}</p>
                            <button onclick="next('eyebrows_1')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">EYEBROW OPACITY</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="eyebrows_2" onmousemove="changeRange('eyebrows_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 0)" style="background: #1c1f20;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 1)" style="background: #282a2c;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 2)" style="background: #35261c;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 3)" style="background: #4b321f;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 4)" style="background: #5b3b24;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 5)" style="background: #6c4c36;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 6)" style="background: #6b4f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 7)" style="background: #755c44;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 8)" style="background: #7e684d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 9)" style="background: #99815d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 10)" style="background: #a69369;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 11)" style="background: #d5b97b;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 12)" style="background: #d9c38c;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 13)" style="background: #a07f59;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 14)" style="background: #85503a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 15)" style="background: #62120d;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 16)" style="background: #650e0b;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 17)" style="background: #7c140e;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 18)" style="background: #a02e18;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 19)" style="background: #b44a27;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 20)" style="background: #a2512f;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 21)" style="background: #ab4e2a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 22)" style="background: #a9aaab;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 23)" style="background: #c5c5c5;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 24)" style="background: #473955;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 25)" style="background: #5a3f6b;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 26)" style="background: #763c77;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 27)" style="background: #ee74e4;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 28)" style="background: #e94b93;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 29)" style="background: #f399bb;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 30)" style="background: #04959f;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 31)" style="background: #035f85;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 32)" style="background: #023a73;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 33)" style="background: #175c55;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 34)" style="background: #b5bf34;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 35)" style="background: #6fa90a;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 36)" style="background: #439d12;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 37)" style="background: #ddb858;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 38)" style="background: #e69102;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 39)" style="background: #f28831;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 40)" style="background: #fb8058;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 41)" style="background: #d1593c;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 42)" style="background: #ac0903;"></div>
                            <div class="colour-selection" onclick="changeColor('eyebrows_3', 43)" style="background: #870302;"></div>
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
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">BEARD STYLE<span class="itemLabel" id="name-beard_1"></span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('beard_1')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-beard_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["beard_1"].value}</p>
                            <button onclick="next('beard_1')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">BEARD OPACITY</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="beard_2" onmousemove="changeRange('beard_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">COLOR</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('beard_3', 0)" style="background: #1c1f20;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 1)" style="background: #282a2c;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 2)" style="background: #35261c;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 3)" style="background: #4b321f;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 4)" style="background: #5b3b24;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 5)" style="background: #6c4c36;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 6)" style="background: #6b4f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 7)" style="background: #755c44;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 8)" style="background: #7e684d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 9)" style="background: #99815d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 10)" style="background: #a69369;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 11)" style="background: #d5b97b;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 12)" style="background: #d9c38c;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 13)" style="background: #a07f59;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 14)" style="background: #85503a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 15)" style="background: #62120d;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 16)" style="background: #650e0b;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 17)" style="background: #7c140e;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 18)" style="background: #a02e18;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 19)" style="background: #b44a27;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 20)" style="background: #a2512f;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 21)" style="background: #ab4e2a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 22)" style="background: #a9aaab;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 23)" style="background: #c5c5c5;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 24)" style="background: #473955;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 25)" style="background: #5a3f6b;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 26)" style="background: #763c77;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 27)" style="background: #ee74e4;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 28)" style="background: #e94b93;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 29)" style="background: #f399bb;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 30)" style="background: #04959f;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 31)" style="background: #035f85;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 32)" style="background: #023a73;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 33)" style="background: #175c55;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 34)" style="background: #b5bf34;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 35)" style="background: #6fa90a;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 36)" style="background: #439d12;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 37)" style="background: #ddb858;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 38)" style="background: #e69102;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 39)" style="background: #f28831;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 40)" style="background: #fb8058;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 41)" style="background: #d1593c;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 42)" style="background: #ac0903;"></div>
                            <div class="colour-selection" onclick="changeColor('beard_3', 43)" style="background: #870302;"></div>
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
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">${translate.makeup_style}<span class="itemLabel" id="name-makeup_1">ÃƒÂ£Ã¢â‚¬Â¦Ã‚Â¤</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('makeup_1')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-makeup_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["makeup_1"].value}</p>
                            <button onclick="next('makeup_1')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">${translate.makeup_opacity}</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="makeup_2" onmousemove="changeRange('makeup_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.makeup_color}</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('makeup_3', 0)" style="background: #1c1f20;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 1)" style="background: #282a2c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 2)" style="background: #35261c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 3)" style="background: #4b321f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 4)" style="background: #5b3b24;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 5)" style="background: #6c4c36;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 6)" style="background: #6b4f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 7)" style="background: #755c44;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 8)" style="background: #7e684d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 9)" style="background: #99815d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 10)" style="background: #a69369;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 11)" style="background: #d5b97b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 12)" style="background: #d9c38c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 13)" style="background: #a07f59;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 14)" style="background: #85503a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 15)" style="background: #62120d;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 16)" style="background: #650e0b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 17)" style="background: #7c140e;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 18)" style="background: #a02e18;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 19)" style="background: #b44a27;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 20)" style="background: #a2512f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 21)" style="background: #ab4e2a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 22)" style="background: #a9aaab;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 23)" style="background: #c5c5c5;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 24)" style="background: #473955;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 25)" style="background: #5a3f6b;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 26)" style="background: #763c77;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 27)" style="background: #ee74e4;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 28)" style="background: #e94b93;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 29)" style="background: #f399bb;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 30)" style="background: #04959f;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 31)" style="background: #035f85;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 32)" style="background: #023a73;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 33)" style="background: #175c55;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 34)" style="background: #b5bf34;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 35)" style="background: #6fa90a;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 36)" style="background: #439d12;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 37)" style="background: #ddb858;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 38)" style="background: #e69102;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 39)" style="background: #f28831;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 40)" style="background: #fb8058;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 41)" style="background: #d1593c;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 42)" style="background: #ac0903;"></div>
                            <div class="colour-selection" onclick="changeColor('makeup_3', 43)" style="background: #870302;"></div>
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
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;font-size:15px">${translate.lipstick_style}<span class="itemLabel" id="name-lipstick_1">ÃƒÂ£Ã¢â‚¬Â¦Ã‚Â¤</span></p>
                        <div style="display: inline-flex;margin-bottom: 10px;width: 101%;justify-content: space-evenly;">
                            <button onclick="previous('lipstick_1')" id="minus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-left"></i>
                            </button>
                            <p id="current-lipstick_1" style="font-family: 'Montserrat', sans-serif;font-size: 20px;color: #dededef9;margin-left: 18px;margin-right: 18px;">${currentValue["lipstick_1"].value}</p>
                            <button onclick="next('lipstick_1')" id="plus" style="width: 33px;height: 33px;background-color: #1a1a1a;border-radius: 6px;color: #fff;font-size: 23px;border: none;">
                                <i class="fa-solid fa-caret-right"></i>
                            </button>
                        </div>
                        <p style="font-family: 'Montserrat', sans-serif;text-align:left;color: #dededef9;margin-bottom: -1px; font-size:15px;">${translate.lipstick_opacity}</p>
                        <input type="range" min="0" max="10" value="0" class="slider" id="lipstick_2" onmousemove="changeRange('lipstick_2')">
                    </div>
                    <div style="width:66%">
                        <p style="color: #dededef9;font-size: 20px;line-height: 0px;margin-top: 13px;font-family: 'Montserrat', sans-serif;text-align: left; margin-left: 3px;">${translate.lipstick_color}</p>
                        <div style="display: flex;flex-wrap: wrap;width: 101%;">
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 0)" style="background: #1c1f20;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 1)" style="background: #282a2c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 2)" style="background: #35261c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 3)" style="background: #4b321f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 4)" style="background: #5b3b24;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 5)" style="background: #6c4c36;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 6)" style="background: #6b4f3a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 7)" style="background: #755c44;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 8)" style="background: #7e684d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 9)" style="background: #99815d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 10)" style="background: #a69369;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 11)" style="background: #d5b97b;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 12)" style="background: #d9c38c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 13)" style="background: #a07f59;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 14)" style="background: #85503a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 15)" style="background: #62120d;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 16)" style="background: #650e0b;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 17)" style="background: #7c140e;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 18)" style="background: #a02e18;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 19)" style="background: #b44a27;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 20)" style="background: #a2512f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 21)" style="background: #ab4e2a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 22)" style="background: #a9aaab;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 23)" style="background: #c5c5c5;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 24)" style="background: #473955;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 25)" style="background: #5a3f6b;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 26)" style="background: #763c77;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 27)" style="background: #ee74e4;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 28)" style="background: #e94b93;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 29)" style="background: #f399bb;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 30)" style="background: #04959f;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 31)" style="background: #035f85;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 32)" style="background: #023a73;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 33)" style="background: #175c55;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 34)" style="background: #b5bf34;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 35)" style="background: #6fa90a;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 36)" style="background: #439d12;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 37)" style="background: #ddb858;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 38)" style="background: #e69102;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 39)" style="background: #f28831;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 40)" style="background: #fb8058;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 41)" style="background: #d1593c;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 42)" style="background: #ac0903;"></div>
                            <div class="colour-selection" onclick="changeColor('lipstick_3', 43)" style="background: #870302;"></div>
                        </div>
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
        $(`#name-${item}`).html("ÃƒÂ£Ã¢â‚¬Â¦Ã‚Â¤")
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
        $(`#name-${item}`).html("ÃƒÂ£Ã¢â‚¬Â¦Ã‚Â¤")
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

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// TABLET UI - Payment System
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

var tabletMode = null;
var selectedServices = [];
var invoiceTotal = 0;
var customerTip = 0;
var customerSubtotal = 0;
var customerBarberId = null;
var tabletServices = [];
var chargeLimit = 500;

// Barber Mode Setup
function showBarberMode(data) {
    if (DEBUG) console.log("[TABLET] Setting up barber mode, data:", data);
    if (DEBUG) console.log("[TABLET] isManager:", data.isManager, "isManagement:", data.isManagement);
    
    // Show barber elements, hide customer elements
    $(".barber-only").css("display", "block");
    $(".customer-only").css("display", "none");
    
    // Nav needs to be flex
    $("#tablet-nav").css("display", "flex");
    
    // Show/hide management based on permissions
    if (data.isManager || data.isManagement) {
        $(".management-only").css("display", "block");
        if (DEBUG) console.log("[TABLET] Management features ENABLED");
    } else {
        $(".management-only").css("display", "none");
        if (DEBUG) console.log("[TABLET] Management features DISABLED");
    }
    
    // Store services and charge limit
    tabletServices = data.services || [];
    chargeLimit = data.chargeLimit || 500;
    
    if (DEBUG) console.log("[TABLET] Services received:", tabletServices.length, tabletServices);
    
    // Render service list
    renderServiceList(tabletServices);
    
    // Reset invoice
    selectedServices = [];
    invoiceTotal = 0;
    
    // Show invoice elements explicitly
    $("#invoice-summary").css("display", "block");
    $("#invoice-items").css("display", "block");
    $("#invoice-total").css("display", "flex");
    
    updateInvoiceDisplay();
    
    // Show HOME section by default
    $(".tablet-section").css("display", "none").removeClass("active");
    $("#section-home").css("display", "block").addClass("active");
    
    // Update tab styling - home is active by default
    $(".tab-btn").removeClass("active");
    $(".tab-btn[data-tab='home']").addClass("active");
    
    // Request stats for home screen
    $.post(`https://${resourceName}/getStats`, JSON.stringify({}));
    
    if (DEBUG) console.log("[TABLET] Barber mode setup complete");
}

// Customer Mode Setup  
function showCustomerMode(data) {
    if (DEBUG) console.log("[TABLET] Setting up customer mode");
    if (DEBUG) console.log("[TABLET] Customer data:", data);
    
    // Hide ALL barber elements - use attr style to override !important
    $(".barber-only").each(function() {
        $(this).attr("style", "display: none !important;");
    });
    $("#tablet-nav").attr("style", "display: none !important;");
    
    // Hide all tablet sections first
    $(".tablet-section").each(function() {
        $(this).removeClass("active").attr("style", "display: none !important;");
    });
    
    // Show ONLY customer payment section
    $(".customer-only").attr("style", "display: block !important;");
    $("#section-customer").removeClass("barber-only").addClass("active").attr("style", "display: block !important;");
    
    // Store customer data
    customerBarberId = data.barberId;
    customerSubtotal = data.subtotal || 0;
    customerTip = 0;
    
    // Set barber name
    $("#customer-barber-name").text(data.barberName || "Your Barber");
    
    // Set subtotal display
    $("#customer-subtotal").text('$' + customerSubtotal);
    
    // Render services on receipt
    renderCustomerServices(data.services || []);
    
    // Update totals
    updateCustomerTotal();
    
    // Reset tip selection
    $(".tip-btn").removeClass("selected");
    $("#custom-tip-input").val("");
    
    if (DEBUG) console.log("[TABLET] Customer mode setup complete - showing section-customer only");
}

// Render service list for barber
function renderServiceList(services) {
    var html = '';
    services.forEach(function(service, index) {
        html += '<div class="service-item" data-index="' + index + '" data-name="' + service.name + '" data-price="' + service.price + '">';
        html += '<span class="service-name">' + service.name + '</span>';
        html += '<span class="service-price">$' + service.price + '</span>';
        html += '</div>';
    });
    $("#service-list").html(html);
}

// Update invoice display
function updateInvoiceDisplay() {
    if (DEBUG) console.log("[TABLET] Updating invoice display, total:", invoiceTotal, "services:", selectedServices.length);
    
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
    
    // Update invoice items
    var $invoiceItems = $("#invoice-items");
    $invoiceItems.html(html);
    if (DEBUG) console.log("[TABLET] Invoice items updated, element found:", $invoiceItems.length > 0);
    
    // Update the total amount - multiple methods to ensure it works
    var totalText = '$' + invoiceTotal;
    var $totalAmount = $("#total-amount");
    
    if (DEBUG) console.log("[TABLET] Total amount element found:", $totalAmount.length > 0);
    
    // Try jQuery
    $totalAmount.text(totalText);
    $totalAmount.html(totalText);
    
    // Try vanilla JS
    var totalElement = document.getElementById('total-amount');
    if (totalElement) {
        totalElement.textContent = totalText;
        totalElement.innerText = totalText;
        if (DEBUG) console.log("[TABLET] Total element value set to:", totalElement.innerText);
    } else {
        if (DEBUG) console.log("[TABLET] ERROR: total-amount element not found!");
    }
    
    if (DEBUG) console.log("[TABLET] Total updated to:", totalText);
    
    // Enable/disable pass button
    var $passBtn = $("#pass-tablet-btn");
    if (invoiceTotal > 0 && selectedServices.length > 0) {
        $passBtn.removeClass("disabled").prop("disabled", false);
        $passBtn.css({
            "background": "linear-gradient(135deg, #4ade80 0%, #22c55e 100%)",
            "color": "#000",
            "cursor": "pointer"
        });
        if (DEBUG) console.log("[TABLET] Pass button ENABLED");
    } else {
        $passBtn.addClass("disabled").prop("disabled", true);
        $passBtn.css({
            "background": "#333",
            "color": "#666",
            "cursor": "not-allowed"
        });
        if (DEBUG) console.log("[TABLET] Pass button DISABLED");
    }
}

// Render customer services
function renderCustomerServices(services) {
    var html = '';
    services.forEach(function(service) {
        html += '<div class="customer-service-item">';
        html += '<span>' + service.name + '</span>';
        html += '<span>$' + service.price + '</span>';
        html += '</div>';
    });
    $("#customer-services").html(html);
    $("#customer-subtotal").text('$' + customerSubtotal);
}

// Update customer total with tip
function updateCustomerTotal() {
    var total = customerSubtotal + customerTip;
    $("#customer-total").text('$' + total);
    $("#customer-tip-amount").text('$' + customerTip);
}

// Show specific section
function showSection(sectionName) {
    if (DEBUG) console.log("[TABLET] Switching to section:", sectionName);
    
    // Hide all tablet sections
    $(".tablet-section").css("display", "none").removeClass("active");
    
    // Show the selected section
    var $section = $("#section-" + sectionName);
    $section.css("display", "block").addClass("active");
    
    if (DEBUG) console.log("[TABLET] Section found:", $section.length > 0);
    
    // Update tab styling
    $(".tab-btn").removeClass("active");
    $(".tab-btn[data-tab='" + sectionName + "']").addClass("active");
}

// Hide tablet
function hideTablet() {
    $("#tablet-container").hide();
    
    // Show hair UI elements again
    $("body > div:not(#tablet-container):not(#minigame-overlay)").show();
    
    // Ensure minigame overlay stays hidden
    $("#minigame-overlay").hide();
    
    // Reset state
    tabletMode = null;
    selectedServices = [];
    invoiceTotal = 0;
    customerTip = 0;
    customerSubtotal = 0;
    customerBarberId = null;
}

// Render functions for data
function renderTransactions(transactions) {
    var html = '';
    if (!transactions || transactions.length === 0) {
        html = '<div class="empty-list">No transactions yet</div>';
    } else {
        transactions.forEach(function(tx) {
            // Server sends: customer_name, created_at, total, status
            var customerName = tx.customer_name || tx.customerName || 'Unknown';
            var date = tx.created_at || tx.date || '';
            var amount = tx.total || tx.amount || 0;
            var status = tx.status || 'completed';
            
            html += '<div class="transaction-item">';
            html += '<div class="tx-info">';
            html += '<span class="tx-customer">' + customerName + '</span>';
            html += '<span class="tx-date">' + date + '</span>';
            html += '</div>';
            html += '<div class="tx-amount ' + status + '">$' + amount + '</div>';
            html += '</div>';
        });
    }
    $("#transactions-list").html(html);
}

function renderStats(stats) {
    if (!stats) return;
    
    // Server sends: { today: { total_earned, total_tips, customer_count }, week: { ... } }
    var todayEarnings = 0, todayTips = 0, todayCustomers = 0;
    var weekEarnings = 0, weekTips = 0, weekCustomers = 0;
    
    if (stats.today) {
        todayEarnings = stats.today.total_earned || 0;
        todayTips = stats.today.total_tips || 0;
        todayCustomers = stats.today.customer_count || 0;
    }
    
    if (stats.week) {
        weekEarnings = stats.week.total_earned || 0;
        weekTips = stats.week.total_tips || 0;
        weekCustomers = stats.week.customer_count || 0;
    }
    
    // Stats tab
    $("#stat-today-earnings").text('$' + todayEarnings);
    $("#stat-today-tips").text('$' + todayTips);
    $("#stat-today-customers").text(todayCustomers);
    $("#stat-week-earnings").text('$' + weekEarnings);
    $("#stat-week-tips").text('$' + weekTips);
    $("#stat-week-customers").text(weekCustomers);
    
    // Home screen stats
    $("#home-today-cuts").text(todayCustomers);
    $("#home-today-earned").text('$' + todayEarnings);
    $("#home-appointments").text(stats.upcomingAppointments || 0);
}

function renderAppointments(appointments) {
    var html = '';
    if (!appointments || appointments.length === 0) {
        html = '<div class="empty-list">No appointments scheduled</div>';
    } else {
        appointments.forEach(function(appt) {
            // Server sends: id, customer_name, appointment_date, appointment_time
            var id = appt.id || 0;
            var customerName = appt.customer_name || appt.customerName || 'Unknown';
            var date = appt.appointment_date || appt.date || '';
            var time = appt.appointment_time || appt.time || '';
            
            html += '<div class="appointment-item" data-id="' + id + '">';
            html += '<div class="appt-info">';
            html += '<span class="appt-customer">' + customerName + '</span>';
            html += '<span class="appt-time">' + date + ' @ ' + time + '</span>';
            html += '</div>';
            html += '<button class="appt-cancel"><i class="fa-solid fa-trash"></i></button>';
            html += '</div>';
        });
    }
    $("#appointments-list").html(html);
}

function renderFinances(finances) {
    if (!finances) {
        if (DEBUG) console.log("[TABLET] renderFinances called with null/undefined");
        return;
    }
    
    if (DEBUG) console.log("[TABLET] Rendering finances:", finances);
    
    // Server sends: balance, todaySales, weekSales, monthSales
    $("#finance-today").text('$' + (finances.todaySales || 0));
    $("#finance-week").text('$' + (finances.weekSales || 0));
    $("#finance-month").text('$' + (finances.monthSales || 0));
    $("#finance-balance").text('$' + (finances.balance || 0));
}

function renderEmployeeStats(employees) {
    var html = '';
    if (!employees || employees.length === 0) {
        html = '<div class="empty-list">No employee data</div>';
    } else {
        employees.forEach(function(emp) {
            // Server sends: barber_name, total_earned, total_tips, customer_count
            var name = emp.barber_name || emp.name || 'Unknown';
            var revenue = emp.total_earned || emp.revenue || 0;
            var tips = emp.total_tips || 0;
            var customers = emp.customer_count || 0;
            
            html += '<div class="employee-stat-item">';
            html += '<span class="emp-name">' + name + '</span>';
            html += '<span class="emp-stats">' + customers + ' cuts</span>';
            html += '<span class="emp-revenue">$' + revenue + ' (+$' + tips + ' tips)</span>';
            html += '</div>';
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
            // Server sends: customer_name, total, created_at, decline_reason
            var customerName = dec.customer_name || dec.customerName || 'Unknown';
            var amount = dec.total || dec.amount || 0;
            var date = dec.created_at || dec.date || '';
            var reason = dec.decline_reason || '';
            
            html += '<div class="declined-item">';
            html += '<span class="dec-customer">' + customerName + '</span>';
            html += '<span class="dec-amount">$' + amount + '</span>';
            html += '<span class="dec-date">' + date + '</span>';
            if (reason) {
                html += '<span class="dec-reason">' + reason + '</span>';
            }
            html += '</div>';
        });
    }
    $("#declined-list").html(html);
}

// ═══════════════════════════════════════════════════════════════════════════════
// EMPLOYEE MANAGEMENT FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

var jobGrades = []; // Store grades from server

function renderCurrentEmployees(employees) {
    var html = '';
    if (!employees || employees.length === 0) {
        html = '<div class="no-employees">No employees found</div>';
    } else {
        employees.forEach(function(emp) {
            var statusClass = emp.online ? 'online' : 'offline';
            var statusText = emp.online ? '● Online' : '○ Offline';
            
            html += '<div class="employee-item" data-identifier="' + emp.identifier + '" data-player-id="' + (emp.playerId || '') + '">';
            html += '<div class="employee-info">';
            html += '<span class="employee-name">' + emp.name + '</span>';
            html += '<span class="employee-grade">' + emp.gradeName + ' (Grade ' + emp.grade + ')</span>';
            html += '<span class="employee-status ' + statusClass + '">' + statusText + '</span>';
            html += '</div>';
            html += '<div class="employee-actions">';
            
            // Grade selector
            html += '<select class="employee-grade-select" data-identifier="' + emp.identifier + '">';
            jobGrades.forEach(function(grade) {
                var selected = grade.grade === emp.grade ? 'selected' : '';
                html += '<option value="' + grade.grade + '" ' + selected + '>' + grade.name + '</option>';
            });
            html += '</select>';
            
            // Update grade button
            html += '<button class="promote-btn update-grade-btn" data-identifier="' + emp.identifier + '"><i class="fa-solid fa-arrow-up"></i></button>';
            
            // Fire button
            html += '<button class="fire-btn" data-identifier="' + emp.identifier + '" data-name="' + emp.name + '"><i class="fa-solid fa-user-minus"></i></button>';
            
            html += '</div>';
            html += '</div>';
        });
    }
    $("#current-employees-list").html(html);
}

function renderNearbyHireable(players) {
    if (!players || players.length === 0) {
        $("#nearby-hireable-list").html('<div class="no-hireable">No players nearby to hire</div>');
        $("#nearby-hireable-list").show();
        return;
    }
    
    var html = '<div class="hireable-header">';
    html += '<h4>Nearby Players</h4>';
    html += '<button class="close-hireable"><i class="fa-solid fa-times"></i></button>';
    html += '</div>';
    
    players.forEach(function(player) {
        html += '<div class="hireable-item" data-player-id="' + player.id + '">';
        html += '<div class="hireable-info">';
        html += '<span class="hireable-name">' + player.name + '</span>';
        html += '<span class="hireable-distance">' + player.distance.toFixed(1) + 'm away</span>';
        html += '</div>';
        html += '<div class="hireable-actions">';
        
        // Grade selector
        html += '<select class="grade-select">';
        jobGrades.forEach(function(grade) {
            html += '<option value="' + grade.grade + '">' + grade.name + '</option>';
        });
        html += '</select>';
        
        // Hire button
        html += '<button class="hire-player-btn" data-player-id="' + player.id + '"><i class="fa-solid fa-check"></i> Hire</button>';
        
        html += '</div>';
        html += '</div>';
    });
    
    $("#nearby-hireable-list").html(html);
    $("#nearby-hireable-list").show();
}

// Render service prices for management
function renderServicePrices(services) {
    var html = '';
    if (!services || services.length === 0) {
        html = '<div class="empty-list">No services configured</div>';
    } else {
        services.forEach(function(service, index) {
            html += '<div class="price-edit-item" data-service-id="' + index + '" data-service-name="' + service.name + '">';
            html += '<span class="price-edit-name">' + service.name + '</span>';
            html += '<input type="number" class="price-edit-input" value="' + service.price + '" min="0">';
            html += '<button class="price-save-btn"><i class="fa-solid fa-check"></i></button>';
            html += '</div>';
        });
    }
    $("#service-prices-list").html(html);
    if (DEBUG) console.log("[TABLET] Service prices rendered:", services ? services.length : 0);
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// TABLET EVENT HANDLERS
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

$(document).ready(function() {
    // Click text logo to go back to home
    $(document).on("click", "#tablet-logo", function() {
        if (DEBUG) console.log("[TABLET] Logo clicked, going home");
        showSection('home');
        $.post(`https://${resourceName}/getStats`, JSON.stringify({}));
    });
    
    // Start New Charge button on home screen
    $(document).on("click", "#start-charge-btn", function() {
        if (DEBUG) console.log("[TABLET] Start charge clicked");
        showSection('charge');
    });
    
    // Tab navigation
    $(document).on("click", ".tab-btn", function() {
        var tab = $(this).data("tab");
        if (DEBUG) console.log("[TABLET] Tab clicked:", tab);
        showSection(tab);
        
        // Request data for certain tabs
        if (tab === "history") {
            $.post(`https://${resourceName}/getTransactions`, JSON.stringify({}));
        } else if (tab === "stats") {
            $.post(`https://${resourceName}/getStats`, JSON.stringify({}));
        } else if (tab === "appointments") {
            $.post(`https://${resourceName}/getAppointments`, JSON.stringify({}));
        } else if (tab === "management") {
            $.post(`https://${resourceName}/getFinances`, JSON.stringify({}));
            $.post(`https://${resourceName}/getEmployeeStats`, JSON.stringify({}));
            $.post(`https://${resourceName}/getDeclinedTransactions`, JSON.stringify({}));
            $.post(`https://${resourceName}/getJobGrades`, JSON.stringify({}));
            $.post(`https://${resourceName}/getCurrentEmployees`, JSON.stringify({}));
            
            // Render service prices for editing
            renderServicePrices(tabletServices);
            
            // Set current charge limit
            $("#charge-limit-input").val(chargeLimit);
        }
    });
    
    // Service selection
    $(document).on("click", ".service-item", function() {
        var $this = $(this);
        var name = $this.data("name");
        var price = parseFloat($this.data("price"));
        
        if (DEBUG) console.log("[TABLET] Service clicked:", name, "Price:", price, "Raw price data:", $this.data("price"));
        
        if (isNaN(price)) {
            if (DEBUG) console.log("[TABLET] ERROR: Price is NaN!");
            price = 0;
        }
        
        if ($this.hasClass("selected")) {
            // Remove from invoice
            $this.removeClass("selected");
            var idx = selectedServices.findIndex(s => s.name === name);
            if (idx > -1) {
                selectedServices.splice(idx, 1);
                invoiceTotal -= price;
            }
        } else {
            // Add to invoice
            if (invoiceTotal + price > chargeLimit) {
                alert("Charge limit exceeded ($" + chargeLimit + ")");
                return;
            }
            $this.addClass("selected");
            selectedServices.push({ name: name, price: price });
            invoiceTotal += price;
        }
        
        if (DEBUG) console.log("[TABLET] Current total:", invoiceTotal, "Services:", selectedServices.length);
        updateInvoiceDisplay();
    });
    
    // Remove from invoice
    $(document).on("click", ".invoice-item-remove", function(e) {
        e.stopPropagation();
        var $item = $(this).parent();
        var idx = $item.data("index");
        var service = selectedServices[idx];
        
        if (service) {
            invoiceTotal -= service.price;
            selectedServices.splice(idx, 1);
            
            // Deselect in service list
            $(".service-item").each(function() {
                if ($(this).data("name") === service.name) {
                    $(this).removeClass("selected");
                }
            });
            
            updateInvoiceDisplay();
        }
    });
    
    // Custom charge
    $(document).on("click", "#add-custom-charge", function() {
        var name = $("#custom-charge-name").val().trim();
        var price = parseFloat($("#custom-charge-price").val());
        
        if (!name || isNaN(price) || price <= 0) {
            return;
        }
        
        if (invoiceTotal + price > chargeLimit) {
            alert("Charge limit exceeded ($" + chargeLimit + ")");
            return;
        }
        
        selectedServices.push({ name: name, price: price, custom: true });
        invoiceTotal += price;
        updateInvoiceDisplay();
        
        // Clear inputs
        $("#custom-charge-name").val("");
        $("#custom-charge-price").val("");
    });
    
    // Pass tablet to customer
    $(document).on("click", "#pass-tablet-btn", function() {
        if ($(this).hasClass("disabled") || selectedServices.length === 0) {
            if (DEBUG) console.log("[TABLET] Pass button disabled or no services");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Passing tablet to customer, services:", selectedServices.length, "total:", invoiceTotal);
        $.post(`https://${resourceName}/passToCustomer`, JSON.stringify({
            services: selectedServices,
            subtotal: invoiceTotal
        }));
    });
    
    // Tip selection
    $(document).on("click", ".tip-btn", function() {
        $(".tip-btn").removeClass("selected");
        $(this).addClass("selected");
        
        var tipPercent = $(this).data("tip");
        if (tipPercent !== undefined) {
            customerTip = Math.round(customerSubtotal * (tipPercent / 100));
            $("#custom-tip-input").val("");
        }
        
        updateCustomerTotal();
    });
    
    // Custom tip
    $(document).on("input", "#custom-tip-input", function() {
        var val = parseFloat($(this).val());
        if (!isNaN(val) && val >= 0) {
            customerTip = val;
            $(".tip-btn").removeClass("selected");
            updateCustomerTotal();
        }
    });
    
    // Payment buttons
    $(document).on("click", "#pay-cash-btn", function() {
        if (DEBUG) console.log("[TABLET] Pay cash clicked");
        $.post(`https://${resourceName}/processPayment`, JSON.stringify({
            paymentMethod: "cash",
            tip: customerTip
        }));
    });
    
    $(document).on("click", "#pay-card-btn", function() {
        if (DEBUG) console.log("[TABLET] Pay card clicked");
        $.post(`https://${resourceName}/processPayment`, JSON.stringify({
            paymentMethod: "card",
            tip: customerTip
        }));
    });
    
    // Decline payment - send to Lua which will handle the reason prompt
    $(document).on("click", "#decline-btn", function() {
        if (DEBUG) console.log("[TABLET] Decline clicked");
        $.post(`https://${resourceName}/declinePayment`, JSON.stringify({}));
    });
    
    // Close tablet
    $(document).on("click", "#tablet-close", function() {
        if (DEBUG) console.log("[TABLET] Close button clicked");
        $.post(`https://${resourceName}/closeTablet`, JSON.stringify({}));
    });

    // Open availability settings (ox_lib menu)
$(document).on("click", "#set-availability-btn", function() {
    if (DEBUG) console.log("[TABLET] Opening availability settings");
    $.post(`https://${resourceName}/openAvailability`, JSON.stringify({}));
});
    
    // Appointment cancel
    $(document).on("click", ".appt-cancel", function() {
        var id = $(this).parent().data("id");
        if (DEBUG) console.log("[TABLET] Cancel appointment:", id);
        $.post(`https://${resourceName}/cancelAppointment`, JSON.stringify({ id: id }));
    });
    
    // Add appointment
    $(document).on("click", "#add-appointment-btn", function() {
        var customerName = $("#appt-customer-name").val().trim();
        var date = $("#appt-date").val();
        var time = $("#appt-time").val();
        
        if (!customerName || !date || !time) {
            alert("Please fill in all appointment fields");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Adding appointment:", customerName, date, time);
        $.post(`https://${resourceName}/addAppointment`, JSON.stringify({
            customerName: customerName,
            date: date,
            time: time
        }));
        
        // Clear form
        $("#appt-customer-name").val("");
        $("#appt-date").val("");
        $("#appt-time").val("");
    });
    
    // Update charge limit
    $(document).on("click", "#update-charge-limit-btn", function() {
        var newLimit = parseInt($("#charge-limit-input").val());
        
        if (isNaN(newLimit) || newLimit < 0) {
            alert("Please enter a valid charge limit");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Updating charge limit:", newLimit);
        $.post(`https://${resourceName}/updateChargeLimit`, JSON.stringify({
            limit: newLimit
        }));
        
        chargeLimit = newLimit;
    });
    
    // Save service price
    $(document).on("click", ".price-save-btn", function() {
        var $item = $(this).closest(".price-edit-item");
        var serviceId = $item.data("service-id");
        var serviceName = $item.data("service-name");
        var newPrice = parseFloat($item.find(".price-edit-input").val());
        
        if (isNaN(newPrice) || newPrice < 0) {
            alert("Please enter a valid price");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Updating service price:", serviceName, newPrice);
        $.post(`https://${resourceName}/updateServicePrice`, JSON.stringify({
            serviceId: serviceId,
            serviceName: serviceName,
            price: newPrice
        }));
    });
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // SOCIETY BANKING HANDLERS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    // Deposit money
    $(document).on("click", "#deposit-btn", function() {
        var amount = parseInt($("#deposit-amount").val());
        
        if (isNaN(amount) || amount <= 0) {
            alert("Please enter a valid amount");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Depositing:", amount);
        $.post(`https://${resourceName}/depositMoney`, JSON.stringify({
            amount: amount
        }));
        
        // Clear input
        $("#deposit-amount").val("");
    });
    
    // Withdraw money
    $(document).on("click", "#withdraw-btn", function() {
        var amount = parseInt($("#withdraw-amount").val());
        
        if (isNaN(amount) || amount <= 0) {
            alert("Please enter a valid amount");
            return;
        }
        
        if (DEBUG) console.log("[TABLET] Withdrawing:", amount);
        $.post(`https://${resourceName}/withdrawMoney`, JSON.stringify({
            amount: amount
        }));
        
        // Clear input
        $("#withdraw-amount").val("");
    });
    
    // ═══════════════════════════════════════════════════════════════════════════════
    // EMPLOYEE MANAGEMENT HANDLERS
    // ═══════════════════════════════════════════════════════════════════════════════
    
    // Open hire menu (get nearby players)
    $(document).on("click", "#hire-employee-btn", function() {
        if (DEBUG) console.log("[TABLET] Getting nearby hireable players");
        $.post(`https://${resourceName}/getNearbyHireable`, JSON.stringify({}));
    });
    
    // Close hireable list
    $(document).on("click", ".close-hireable", function() {
        $("#nearby-hireable-list").hide();
    });
    
    // Hire a player
    $(document).on("click", ".hire-player-btn", function() {
        var $item = $(this).closest(".hireable-item");
        var playerId = $item.data("player-id");
        var grade = parseInt($item.find(".grade-select").val());
        
        if (DEBUG) console.log("[TABLET] Hiring player:", playerId, "at grade:", grade);
        $.post(`https://${resourceName}/hireEmployee`, JSON.stringify({
            playerId: playerId,
            grade: grade
        }));
        
        // Hide the hireable list
        $("#nearby-hireable-list").hide();
    });
    
    // Update employee grade
    $(document).on("click", ".update-grade-btn", function() {
        var $item = $(this).closest(".employee-item");
        var identifier = $item.data("identifier");
        var newGrade = parseInt($item.find(".employee-grade-select").val());
        
        if (DEBUG) console.log("[TABLET] Updating grade for:", identifier, "to:", newGrade);
        $.post(`https://${resourceName}/updateEmployeeGrade`, JSON.stringify({
            identifier: identifier,
            grade: newGrade
        }));
    });
    
// Fire employee
$(document).on("click", ".fire-btn", function() {
    var $item = $(this).closest(".employee-item");
    var identifier = $item.data("identifier");
    
    if (DEBUG) console.log("[TABLET] Firing employee:", identifier);
    $.post(`https://${resourceName}/fireEmployee`, JSON.stringify({
        identifier: identifier
    }));
});
    
    // ESC key to close tablet
    $(document).on("keydown", function(e) {
        if (e.key === "Escape" && tabletMode !== null) {
            if (DEBUG) console.log("[TABLET] ESC pressed, closing tablet");
            $.post(`https://${resourceName}/closeTablet`, JSON.stringify({}));
        }
    });

    // ═══════════════════════════════════════════════════════════════════════════════
// WHACK FLASH MINIGAME
// ═══════════════════════════════════════════════════════════════════════════════

var WhackFlashGame = {
    config: {
        totalHits: 7,
        maxMisses: 3,
        flashDuration: 1000
    },
    hits: 0,
    misses: 0,
    currentIndex: null,
    timeout: null,
    ready: false,

    init: function(data) {
        this.config = Object.assign({}, this.config, data);
        this.hits = 0;
        this.misses = 0;
        this.currentIndex = null;
        this.ready = false;
        this.buildUI();
        this.startCountdown();
    },

    buildUI: function() {
        $("body").show();  // Make sure body is visible for minigame
        var html = `
            <div class="minigame-header">
                <div class="minigame-title">Precision Check</div>
                <div class="minigame-stats">
                    Hits: <span id="whack-hits">0</span> | Misses: <span id="whack-misses">0</span>
                </div>
            </div>
            <div id="whack-countdown" class="whack-countdown">3</div>
            <div class="whack-grid" id="whack-grid" style="display: none;">
                <div class="whack-row">
                    <div class="whack-circle" data-index="0"></div>
                    <div class="whack-circle" data-index="1"></div>
                    <div class="whack-circle" data-index="2"></div>
                </div>
                <div class="whack-row">
                    <div class="whack-circle" data-index="3"></div>
                    <div class="whack-circle" data-index="4"></div>
                    <div class="whack-circle" data-index="5"></div>
                    <div class="whack-circle" data-index="6"></div>
                </div>
                <div class="whack-row">
                    <div class="whack-circle" data-index="7"></div>
                    <div class="whack-circle" data-index="8"></div>
                    <div class="whack-circle" data-index="9"></div>
                </div>
            </div>
        `;
        $("#minigame-content").html(html);
        $("#minigame-overlay").css("display", "flex");
    },

    startCountdown: function() {
        var self = this;
        var count = 3;
        var countdownEl = $("#whack-countdown");
        
        var interval = setInterval(function() {
            count--;
            if (count > 0) {
                countdownEl.text(count);
            } else if (count === 0) {
                countdownEl.text("GO!");
            } else {
                clearInterval(interval);
                countdownEl.fadeOut(300, function() {
                    $("#whack-grid").show();
                    self.ready = true;
                    self.bindEvents();
                    self.nextFlash();
                });
            }
        }, 800);
    },

    bindEvents: function() {
        var self = this;
        $(".whack-circle").off("click").on("click", function() {
            if (!self.ready) return;
            
            var idx = parseInt($(this).data("index"));
            if (idx === self.currentIndex) {
                self.hits++;
                $(this).addClass("success");
            } else {
                self.misses++;
                $(this).addClass("fail");
            }
            self.updateStats();
            
            setTimeout(function() {
                self.nextFlash();
            }, 200);
        });
    },

    nextFlash: function() {
        var self = this;
        clearTimeout(this.timeout);
        $(".whack-circle").removeClass("active success fail");

        if (this.hits >= this.config.totalHits) {
            this.endGame(true);
            return;
        }
        if (this.misses >= this.config.maxMisses) {
            this.endGame(false);
            return;
        }

        this.currentIndex = Math.floor(Math.random() * 10);
        var el = $(".whack-circle[data-index=" + this.currentIndex + "]");
        el.addClass("active");

        this.timeout = setTimeout(function() {
            if (!el.hasClass("success")) {
                el.addClass("fail");
                self.misses++;
                self.updateStats();
                
                if (self.misses >= self.config.maxMisses) {
                    self.endGame(false);
                } else {
                    setTimeout(function() {
                        self.nextFlash();
                    }, 300);
                }
            }
        }, this.config.flashDuration);
    },

    updateStats: function() {
        $("#whack-hits").text(this.hits);
        $("#whack-misses").text(this.misses);
    },

    endGame: function(success) {
        var self = this;
        this.ready = false;
        clearTimeout(this.timeout);
        $(".whack-circle").off("click");
        
        var resultClass = success ? "success" : "fail";
        var resultText = success ? "SUCCESS" : "FAILED";
        
        var html = `<div class="minigame-result ${resultClass}">${resultText}</div>`;
        $("#minigame-content").html(html);

        setTimeout(function() {
            $("#minigame-overlay").css("display", "none");
            $("#minigame-content").empty();
            
            $.post(`https://${resourceName}/minigameResult`, JSON.stringify({ 
                success: success 
            }));
        }, 1500);
    }
};

// Listen for minigame start message
window.addEventListener('message', function(event) {
    var item = event.data;
    
    if (item.action === "startMinigame") {
        WhackFlashGame.init({
            totalHits: item.totalHits || 7,
            maxMisses: item.maxMisses || 3,
            flashDuration: item.flashDuration || 1000
        });
    }
});
});