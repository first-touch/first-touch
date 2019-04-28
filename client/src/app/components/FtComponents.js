import Vue from 'vue'

import Dialog from "./FtDialog.vue";

const components = [
  Dialog
];

const install = function(Vue, opts = {}){


  components.forEach(component => {
    Vue.component(component.name, component)
  });
}

export default {
  install,
  Dialog
}
