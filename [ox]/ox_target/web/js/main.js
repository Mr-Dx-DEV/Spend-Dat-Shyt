import { createOptions } from "./createOptions.js";

const optionsWrapper = document.getElementById("options-wrapper");
const body = document.body;
const eye = document.getElementById("eyeSvg");

window.addEventListener("message", (event) => {
  optionsWrapper.innerHTML = "";

  switch (event.data.event) {
    case "visible": {
      body.style.visibility = event.data.state ? "visible" : "hidden";
      eye.style.transform = 'translateY(0px)';
      document.querySelectorAll('.iconClass').forEach(el => el.classList.remove('fa-check'));
      eye.style.color = 'white';
      document.querySelector('.center').textContent = '';
      document.querySelectorAll('.iconClass').forEach(el => el.classList.add('fa-question'));
      return eye.classList.remove("eye-hover");
    }

    case "leftTarget": {
      document.querySelector('.center').textContent = '';
      eye.style.transform = 'translateY(0px)';
      document.querySelectorAll('.iconClass').forEach(el => el.classList.remove('fa-check'));
      eye.style.color = 'white';
      document.querySelectorAll('.iconClass').forEach(el => el.classList.add('fa-question'));
      return eye.classList.remove("eye-hover");
    }

    case "setTarget": {
      document.querySelector('.center').textContent = '';
      eye.style.fill = '#cfd2da';
      eye.style.transform = 'translateY(30px)';
      eye.style.color = 'rgb(0,247,181)';
      document.querySelectorAll('.iconClass').forEach(el => el.classList.remove('fa-question'));
      document.querySelectorAll('.iconClass').forEach(el => el.classList.add('fa-check'));
      eye.classList.add("eye-hover");

      if (event.data.options) {
        for (const type in event.data.options) {
          event.data.options[type].forEach((data, id) => {
            createOptions(type, data, id + 1);
          });
        }
      }

      if (event.data.zones) {
        for (let i = 0; i < event.data.zones.length; i++) {
          event.data.zones[i].forEach((data, id) => {
            createOptions("zones", data, id + 1, i + 1);
          });
        }
      }
    }
  }
});
