<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page network">
        <h4 class="header">Calendar</h4>

    <b-row>

      <b-col lg="8" md="8" sm="12">

        <div class="month">
            <ul class="weekdays">
              <li>Mo</li>
              <li>Tu</li>
              <li>We</li>
              <li>Th</li>
              <li>Fr</li>
              <li>Sa</li>
              <li>Su</li>
            </ul>
            <ul class="days">
              <li>1</li>
              <li>2</li>
              <li>3</li>
              <li>4</li>
              <li><span class="active">5</span></li>
              <li>6</li>
              <li>7</li>
              <li>8</li>
              <li>9</li>
              <li>10</li>
              <li>11</li>
              <li>12</li>
              <li>13</li>
              <li>14</li>
              <li><span class="active">15</span></li>
              <li>16</li>
              <li>17</li>
              <li>18</li>
              <li>19</li>
              <li>20</li>
              <li>21</li>
              <li>22</li>
              <li>23</li>
              <li>24</li>
              <li>25</li>
              <li>26</li>
              <li>27</li>
              <li>28</li>
              <li>29</li>
              <li>30</li>
              <li>1</li>
              <li>2</li>
              <li>3</li>
              <li>4</li>
              <li>5</li>
            </ul>
            <div class="clear"></div>
          </div>

      </b-col>

       <b-col lg="4" md="4" sm="12">

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
        <div class="clender_img"><img src="http://demourls.xyz/first-touch/calender.png"></div>
        <div class="events_tac"> <div class="right_line_arrow"><img src="http://demourls.xyz/first-touch/right_tac.png"></div>
            <h3> CREATE A NEW EVENT</h3>
        </div>
      </div>

    </b-col>


       <b-col lg="12" md="12" sm="12">

        <div class="month_date_sec"><p>05</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="http://demourls.xyz/first-touch/right_tac-shot.png"></div>

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
            <img src="http://demourls.xyz/first-touch/dote_icon.png">
          </div>
        </div>

     </b-col>





        <b-col lg="12" md="12" sm="12" id="top-time-box">

        <div class="green_date_sec"><p>15</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="http://demourls.xyz/first-touch/green_line.png"></div>

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
            <img src="http://demourls.xyz/first-touch/dote_icon.png">
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
