<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <actions class="widget"/>
          <reportlist class="widget" />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget{
  margin-bottom: 20px;
}
</style>

<script>
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import ReportList from './components/ReportsList';
import Actions from './components/Actions';

export default {
  name: 'JobList',
  components: {
    sidebar: NotificationSidebar,
    reportlist: ReportList,
    actions:Actions
  },
  data () {
    return {
      reportSelected: null
    };
  },
  methods: {}
};
</script>
