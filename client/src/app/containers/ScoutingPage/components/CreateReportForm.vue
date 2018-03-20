<template>
  <div class="report-form">
      <div class="arrow"></div>
        <div class="form-container">
        <table v-if="type == ''">
        <tr><td><label>Club</label></td> <td><label>Player</label></td></tr>
        <tr><td><button  v-on:click="setType('Club')" ><img src="/images/landing-page/ft-icons-club.png" alt="Ft Logo" /></button></td><td><button  v-on:click="setType('Player')"><img src="/images/landing-page/ft-icons-player.png" alt="Ft Logo" /></button></td></tr>
        </table>

        <table  v-if="target">
        <tr><td><button  v-on:click="launch()" >Create new {{ type }}</button></td><td><button>Select {{ type }}</button></td></tr>
        </table>
        <clubreportform v-if="show" :club_id="1" :createReport="createReport" :reportStatus="reportStatus" />
     </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.create_form table{
  text-align: center;
}

.report-form {
  display: flex;
  border-left: 7px solid $main-header-color;
  margin-top: 20px;
  .arrow {
    margin-top: 18px;
    border-left-color: $main-header-color;
  }
  .form-container {
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
  }
}
</style>

<script>
import ClubReportForm from './ClubReportForm.vue';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS,ASYNC_FAIL } from 'app/constants/AsyncStatus';

export default {
  name: 'CreateReportForm',
  props: [
  ],
   components: {
    clubreportform:ClubReportForm
  },
   computed: {
    ...mapGetters(['report']),
    reportStatus() {
      console.log(this.report);
      return this.report.status === ASYNC_FAIL
        ? this.report: null
    }
  },
  data() {
    return {
      type:'',
      target: false,
      show: false
    };
  },
  methods: {
    ...mapActions(['createReport']),
    launch(){
      this.show = true
      this.target = false
    },
    setType(type){
      this.type = type;
      this.target = true
    }
  }
};
</script>