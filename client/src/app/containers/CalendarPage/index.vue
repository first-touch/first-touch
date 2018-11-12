<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page network">
        <h4 class="header">Calendar</h4>

    <b-row>

      <b-col lg="12" md="12" sm="12">



        <div class="month">
            <ul class="weekdays">
              <li class="list-group-item">Mo</li>
              <li class="list-group-item">Tu</li>
              <li class="list-group-item">We</li>
              <li class="list-group-item">Th</li>
              <li class="list-group-item">Fr</li>
              <li class="list-group-item">Sa</li>
              <li class="list-group-item">Su</li>
            </ul>

            <ul class="days">
              <li class="list-group-item">1</li>
              <li class="list-group-item">2</li>
              <li class="list-group-item">3</li>
              <li class="list-group-item">4</li>
              <li class="list-group-item"><span class="active">5</span></li>
              <li class="list-group-item">6</li>
              <li class="list-group-item">7</li>
              <li class="list-group-item">8</li>
              <li class="list-group-item">9</li>
              <li class="list-group-item">10</li>
              <li class="list-group-item">11</li>
              <li class="list-group-item">12</li>
              <li class="list-group-item">13</li>
              <li class="list-group-item">14</li>
              <li class="list-group-item"><span class="active">15</span></li>
              <li class="list-group-item">16</li>
              <li class="list-group-item">17</li>
              <li class="list-group-item">18</li>
              <li class="list-group-item">19</li>
              <li class="list-group-item">20</li>
              <li class="list-group-item">21</li>
              <li class="list-group-item">22</li>
              <li class="list-group-item">23</li>
              <li class="list-group-item">24</li>
              <li class="list-group-item">25</li>
              <li class="list-group-item">26</li>
              <li class="list-group-item">27</li>
              <li class="list-group-item">28</li>
              <li class="list-group-item">29</li>
              <li class="list-group-item">30</li>
              <li class="list-group-item">1</li>
              <li class="list-group-item">2</li>
              <li class="list-group-item">3</li>
              <li class="list-group-item">4</li>
              <li class="list-group-item">5</li>
            </ul>           
            <div class="clear"></div>
          </div>
          <div class="month_live">

            <div class="up_month">
               <i class="fa fa-angle-up" aria-hidden="true"></i>
            </div>
              <div class="month_sec">
                <ul>
                  <li>MAY</li>
                  <li>JUNE</li>
                  <li>JULY</li>
                </ul>
               </div>

            <div class="up_month">
              <i class="fa fa-angle-down" aria-hidden="true"></i>
            </div>

            <div class="clear"></div>
          </div>



      </b-col>

       

    <b-col lg="12" md="12" sm="12">

          <div class="create_sec">
        <div class="clender_img"><img src="../../../img/calender.png"></div>
        <div class="events_tac"> <div class="right_line_arrow"><img src="../../../img/right_tac.png"></div>
            <h3> CREATE A NEW EVENT</h3>
        </div>
      </div>

    </b-col>


       <b-col lg="12" md="12" sm="12">

        <div class="month_date_sec"><p>05</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="../../../img/right_tac-shot.png"></div>

        <div class="champions_sec">
            <div class="box_type"></div>
            <div class="champion_tittle">
              <h5>UEFA CHAMPIONS</h5>
              <h5>LEAGUE FINAL MATCH</h5>

              <h6>Real Madrid x Atletico Madrid</h6>

            <div class="time_sec">
              <p>Organizer<span>UEFA</span></p>
              <p>Date<span>28 May at 18:30</span></p>
              <p>Venue<span>San Siro Stadium, Milan, Italy</span></p>
            </div>

            </div>

            <div class="clear"></div>
        </div>

        <div class="right_cleck">
          <div class="right_cleck_sec">
              <i class="fa fa-check" aria-hidden="true"></i>
          </div>

           <div class="close_cleck_sec">
              <i class="fa fa-times" aria-hidden="true"></i>
          </div>

          <div class="dote_sec">
            <img src="../../../img/dote_icon.png">
          </div>
        </div>

     </b-col>





        <b-col lg="12" md="12" sm="12" id="top-time-box">

        <div class="green_date_sec"><p>15</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="../../../img/green_line.png"></div>

        <div class="champions_sec">
            <div class="box_type"></div>
            <div class="champion_tittle">
              <h5>UEFA CHAMPIONS</h5>
              <h5>LEAGUE FINAL MATCH</h5>

              <h6>Real Madrid x Atletico Madrid</h6>

            <div class="time_sec">
              <p>Organizer<span>UEFA</span></p>
              <p>Date<span>28 May at 18:30</span></p>
              <p>Venue<span>San Siro Stadium, Milan, Italy</span></p>
            </div>

            </div>

            <div class="clear"></div>
        </div>

        <div class="right_cleck">
          <div class="right_cleck_sec">
              <i class="fa fa-check" aria-hidden="true"></i>
          </div>

           <div class="close_cleck_sec">
              <i class="fa fa-times" aria-hidden="true"></i>
          </div>

          <div class="dote_sec">
            <img src="../../../img/dote_icon.png">
          </div>
        </div>

     </b-col>

   </b-row>

        <div class="network-container">
          <div v-if="loading">
            <h4 class="text-center">Loading...</h4>
          </div>
          <network-item v-for="item in items"
            :info="item"
            :unfollow="unfollow.bind(this, { token: token.value, id: item.id })"
            :key="item.id"
            />
        </div>
      </div>
    </div>
        <sidebar />

  </div>
</template>

<style lang="scss" scoped>

@import '~stylesheets/variables';
@import '~stylesheets/common_style';

.network {
  .network-widget {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    .network-widget-sort,
    .network-widget-search {
      flex: 0 0 48%;
      border: 1px solid $main-text-color;
      background-color: $navbar-background-color;
      color: $main-text-color;
      padding: 2px 7px;
    }
    .network-widget-search {
      border-radius: 4px;
    }
  }
  .network-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
  }
}








</style>




<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';

import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import NetworkItem from './components/NetworkItem.vue';

export default {
  name: 'Calender',
  components: {
    sidebar: NotificationSidebar,
    'network-item': NetworkItem,
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
  methods: {
    ...mapActions(['getNetwork', 'unfollow']),
  },
  mounted() {
    this.getNetwork({ token: this.token.value });
  },
};
</script>
