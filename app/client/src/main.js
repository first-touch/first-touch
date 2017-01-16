import Vue from 'vue';

import AppComponent from './components/App.vue';

new Vue({
  el: '#app',
  components: {
    app: AppComponent
  },
  render: (h) => h('app')
});