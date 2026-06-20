/*======================================================================//
//																		//
//		Project: "Delta Enhanced Aiming UI (DEA UI)"					//
//		Copyright � 2020-2025 Delta District (deltadistrict.com)		//
//																		//
//======================================================================*/

var menuData = {};
var aimingType = 0;
var currentMenu = "main";
var configStyle = "radial";
var configUseIMG = true;
var uiKeybind = 'G';
var selectedButtons = {submenu1:1, submenu2:1, submenu3:1, submenu4:1};

const root = document.documentElement;
const menus = {
	radial: document.getElementById("radial-menu"),
	grid: document.getElementById("grid-menu"),
	list: document.getElementById("list-menu"),
};

function addLogoToRadialMenu() {
    const radialMenu = document.getElementById("radial-menu");
    let logo = document.getElementById("radial-logo");
    if (!logo) {
        logo = document.createElement("div");
        logo.id = "radial-logo";
        logo.style.backgroundImage = "url('images/dea_ui_logo.png')";
        logo.style.backgroundSize = "contain";
        logo.style.backgroundRepeat = "no-repeat";
        logo.style.width = "300px";
        logo.style.height = "300px";
        logo.style.position = "absolute";
        logo.style.top = "50%";
        logo.style.left = "50%";
        logo.style.transform = "translate(-50%, -50%)";
        logo.style.zIndex = "1";
        radialMenu.appendChild(logo);
    }
}

function populateMenu(style, menuName) {
    Object.values(menus).forEach(menu => (menu.innerHTML = ""));
    const buttonData = menuData[menuName];
	if (style === "radial") { addLogoToRadialMenu(); }
    if (buttonData) {
        buttonData.forEach((item, index) => {
            const button = document.createElement("div");
            button.className = `${style}-button button`;
            button.id = `${menuName}-button-${index + 1}`;
            
            const buttonText = document.createElement("div");
            buttonText.className = "button-text";
            buttonText.textContent = item.text;
            
            const buttonSubText = document.createElement("div");
            buttonSubText.className = "button-subtext";
            buttonSubText.textContent = item.subtext || "";
            
            button.appendChild(buttonText);
            button.appendChild(buttonSubText);

            if (item.img && configUseIMG) {
                button.style.backgroundImage = `url(${item.img})`;
                button.style.backgroundSize = "cover";
                button.style.backgroundPosition = "center";
				button.style.opacity = "0.75";
            }
				
            if (item.disabled) {
                button.classList.add("disabled");
            } else {
                button.addEventListener("click", () => {
                    if (currentMenu === "main") {
                        if (menuData[`submenu${index + 1}`]) {
                            currentMenu = `submenu${index + 1}`;
                            populateMenu(style, currentMenu);
                        }
                    } else {
						//if (selectedButtons[menuName] !== (index+1)) {
							selectedButtons[menuName] = index + 1;
							highlightSelectedButton(currentMenu, index + 1);
							$.post("https://DD_UI_Aimstyle/aimstyleSelected", JSON.stringify({ menu: menuName, style: item.id }));	
						//}
                        currentMenu = "main";
                        populateMenu(style, "main");
                    }
                });
            }

            if (configStyle === "radial") {
                const radialMenu = menus.radial;
                const angle = (-2 * Math.PI / buttonData.length) * index;
                const radius = (buttonData.length * 40);
                const x = -radius * Math.cos(angle);
                const y = radius * Math.sin(angle);
                button.style.transform = `translate(${x + 100}px, ${y}px)`;
                radialMenu.appendChild(button);
            } else {
                menus[configStyle].appendChild(button);
            }
			
			if (selectedButtons[menuName]) {
				highlightSelectedButton(menuName, selectedButtons[menuName]);
			}
        });
    }
}

function highlightSelectedButton(menuName, index) {
    const buttons = document.querySelectorAll(`#${menus[configStyle].id} .button`);
    buttons.forEach(button => {
        button.classList.remove("selected");
    });

    const selectedButton = document.querySelector(`#${menuName}-button-${index}`);
    if (selectedButton) {
        selectedButton.classList.add("selected");
    }
}

function setActiveMenu(style) {
	Object.keys(menus).forEach(menuStyle => {
		menus[menuStyle].style.display = menuStyle === style ? "grid" : "none";
	});
}

function updateUIPlacement(place) {
	if (place==='left') {
        root.style.setProperty('--ui-list-placement', '7%');
    } else if (place==='right') {
        root.style.setProperty('--ui-list-placement', '85%');
    } else if (place==='middle') {
        root.style.setProperty('--ui-list-placement', '45%');
    };
}

function updateUIColors(ui) {
	if (ui.default.text) {
        root.style.setProperty('--default-text-color', ui.default.text);
    };
	if (ui.default.subtext) {
        root.style.setProperty('--default-subtext-color', ui.default.subtext);
    };
    if (ui.default.border) {
        root.style.setProperty('--default-border-color', ui.default.border);
    };
    if (ui.default.background) {
        root.style.setProperty('--default-shadow-color', ui.default.background);
    };
	if (ui.hover.text) {
        root.style.setProperty('--hover-text-color', ui.hover.text);
    };
	if (ui.hover.subtext) {
        root.style.setProperty('--hover-subtext-color', ui.hover.subtext);
    };
    if (ui.hover.border) {
        root.style.setProperty('--hover-border-color', ui.hover.border);
    }
    if (ui.hover.background) {
        root.style.setProperty('--hover-shadow-color', ui.hover.background);
    };
	if (ui.selected.text) {
        root.style.setProperty('--selected-text-color', ui.selected.text);
    };
	if (ui.selected.subtext) {
        root.style.setProperty('--selected-subtext-color', ui.selected.subtext);
    };
    if (ui.selected.border) {
        root.style.setProperty('--selected-border-color', ui.selected.border);
    };
    if (ui.selected.background) {
        root.style.setProperty('--selected-shadow-color', ui.selected.background);
    };
}



function closeUI() {
    $.post("https://DD_UI_Aimstyle/closeUI");
    $("#ui-container").hide();
}

document.addEventListener("DOMContentLoaded", function () {
	$("#ui-container").hide();
});

document.onkeyup = function (event) {
	if (event.key === "Escape" || event.key === uiKeybind) {
		closeUI();
	} else if (event.key === "Backspace" || event.button === 2) { 
        if (currentMenu !== "main") {
            currentMenu = "main";
            populateMenu(configStyle, "main");
        } else {
            closeUI();
        }
    }
};

document.onmousedown = function (event) {
    if (event.button === 2) { 
        if (currentMenu !== "main") {
            currentMenu = "main";
            populateMenu(configStyle, "main");
        } else {
            closeUI();
        }
        event.preventDefault();
    }
};

window.addEventListener('message', function( event ) {
	var item = event.data;
	if (item.action=="OpenUI") {
		currentMenu = "main";
		populateMenu(configStyle, 'main');
		$("#ui-container").show();
	} else if (item.action=="CloseUI") {
		$("#ui-container").hide();
	} else if (item.action=="SetupOptions") {
		if (item.config) {
			if (item.config?.style) configStyle = item.config.style;
			if (item.config?.style=='list' && item.config.placement) updateUIPlacement(item.config.placement);
			//if (item.config.aiming==false) selectedButtons = {submenu1:0, submenu2:0, submenu3:0, submenu4:0};
			if (item.config?.color) updateUIColors(item.config.color);
			if (item.config?.image!==null) configUseIMG = item.config.image;
			if (item.config?.keybind!==null) uiKeybind = item.config.keybind;
			if (item.config?.selected!==null && item.config?.selected?.['1']!==null) {
				selectedButtons['submenu1'] = item.config.selected?.['1'];
				selectedButtons['submenu2'] = item.config.selected?.['2'];
				selectedButtons['submenu3'] = item.config.selected?.['3'];
				selectedButtons['submenu4'] = item.config.selected?.['4'];
			}
		}
		menuData = JSON.parse(item.buttons);
		setActiveMenu(configStyle);
		populateMenu(configStyle, 'main');
		$("#ui-container").show();
	}
})

