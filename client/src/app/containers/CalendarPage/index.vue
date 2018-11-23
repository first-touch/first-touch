<template>
  <div>
    <sidebar />
    <div class="ft-page">
      <div class="profile">
        <h4 class="">Calendar</h4>
        <calendar-int/>
        <calendar-contest/>
      </div>
    </div>
  </div>
</template>

<style lang="scss">


.ft-page:before {
  margin-left: 16px;
}

.profile {
  margin-left: 16px;
  h4 {
    color: #929292;
  }
}

</style>


<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar';
import CalendarInt from './components/CalendarInt';
import CalendarContest from './components/CalendarContest';

export default {
  name: 'Calender',
  components: {
       sidebar: NotificationSidebar,
      'calendar-int': CalendarInt,
      'calendar-contest' : CalendarContest,  
   },
  computed: {
    ...mapGetters(['token', 'network']),
    loading() {
      return this.network.status === ASYNC_LOADING;
    },
    items() {
      return this.network.value || [];
    },
  },
};
</script>
