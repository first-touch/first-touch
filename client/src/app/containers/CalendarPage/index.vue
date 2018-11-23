<template>
  <div>
      <sidebar />

<div class="profile">
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
  </div>
</template>

<style>
.leonel_sec {
	padding: 32px 0 0 0;
}

.player_sec {
	width: 180px;
	display: inline-block;
}

.month {
	float: left;
	width: 500px;
	background-color: #ffffff;
	border-radius: 2px;
}

.weekdays {
	margin: 26px 0 0 0;
	padding: 10px 0;
	display: inline-block;
	width: 100%;
	text-align: center;
}

.weekdays li {
	display: inline-block;
	width: 12%;
	color: #666;
	text-align: center;
	font-family: 'ubuntulight';
	border: none;
}

.days {
	padding: 18px 0 10px 0;
	margin: 0 0 26px 0;
	text-align: center;
}

.days li {
	list-style-type: none;
	display: inline-block;
	width: 12%;
	text-align: center;
	font-size: 16px;
	color: #777;
	font-family: 'ubuntulight';
	padding-bottom: 17px;
	border: none;
}

.month_live {
	float: left;
	width: 150px;
	text-align: center;
	padding: 50px 0;
	background-color: #222222;
}

.up_month {
	width: 100%;
}

.up_month .fa {
	color: #fff;
	width: 34px;
	height: 34px;
	text-align: center;
	border: 1px solid#fff;
	border-radius: 65%;
	position: relative;
	top: 0px;
	font-size: 32px;
}

.month_sec {
	padding-bottom: 30px;
	padding-top: 23px;
}

.month_sec ul {
	list-style: none;
}

.month_sec ul li {
	font-size: 18px;
	padding: 18px 0;
	color: #6b8238;
	font-family: 'ubuntulight';
	display: inline-block;
	width: 100%;
}

.up_month .fa {
	color: #fff;
	width: 34px;
	height: 34px;
	text-align: center;
	border: 1px solid#fff;
	border-radius: 65%;
	position: relative;
	top: 0px;
	font-size: 32px;
}

.create_sec {
	padding: 26px 0;
	display: inline-block;
}

.clender_img {
	display: inline-block;
	width: 80px;
	padding-right: 20px;
}

.events_tac {
	display: inline-block;
	vertical-align: top;
	padding-top: 10px;
}

.right_line_arrow {
	width: 20px;
	float: left;
	margin-right: 16px;
}

.events_tac h3 {
	display: inline-block;
	vertical-align: top;
	font-size: 18px;
	color: #929292;
	font-family: ubuntulight;
	font-weight: normal;
	letter-spacing: 4px;
	padding-top: 10px;
}

.month_date_sec {
	float: left;
	width: 70px;
	height: 70px;
	border: 1px solid#a6cf4c;
	border-radius: 56%;
	text-align: center;
}

.month_date_sec p {
	color: #fff;
	position: relative;
	top: 14px;
	font-size: 14px;
	font-family: ubuntulight;
	margin: 0px;
}

.right_arrow_icon {
	float: left;
	width: 15px;
	padding-left: 16px;
	margin-right: 34px;
}

.champions_sec {
	float: left;
	width: 450px;
	vertical-align: top;
	background-color: #fff;
	padding: 15px;
	height: 185px;
}

.box_type {
	background-color: #d5d5d5;
	height: 150px;
	width: 150px;
	float: left;
}

.champion_tittle {
	float: left;
	width: 250px;
	padding-left: 10px;
}

.champion_tittle h5 {
	font-size: 16px;
	color: #a6cf4c;
	font-family: ubuntulight;
	margin: 0px;
}

.champion_tittle h6 {
	font-size: 14px;
	color: #606060;
	padding-top: 18px;
	font-family: ubuntulight;
}

.time_sec {
	padding-top: 0px;
}

.champion_tittle p {
	font-size: 14px;
	color: #a8a8a8;
	font-family: ubuntulight;
	margin: 0px;
}

.champion_tittle p span {
	color: #606065;
	font-size: 16px;
}

.right_cleck {
	width: 80px;
	float: left;
	text-align: center;
	height: 185px;
	background-color: #222;
	padding: 20px 0;
}

.right_cleck_sec .fa {
	color: #a6cf4c;
	font-size: 16px;
	width: 26px;
	height: 26px;
	border: 1px solid#a6cf4c;
	border-radius: 62%;
}

.right_cleck_sec .fa:before {
	position: relative;
	top: 5px;
	left: 1px;
}

.close_cleck_sec {
	padding-top: 32px;
}

.close_cleck_sec .fa {
	color: #40bc5c;
	font-size: 16px;
	width: 26px;
	height: 26px;
	border: 1px solid#a6cf4c;
	border-radius: 62%;
}

.close_cleck_sec .fa:before {
	position: relative;
	top: 4px;
	left: 0px;
}

.dote_sec {
	padding-top: 32px;
}

.real_sec_two {
	padding-top: 20px;
	display: inline-block;
}

.green_date_sec {
	float: left;
	width: 70px;
	height: 70px;
	border: 1px solid#40bc5c;
	border-radius: 56%;
	text-align: center;
}

.green_date_sec p {
	color: #fff;
	position: relative;
	top: 14px;
	font-size: 14px;
	font-family: ubuntulight;
	margin: 0px;
}

.ft-page .header {
    color: #929292;
}

</style>


<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar';

export default {
  name: 'Calender',
  components: {
       sidebar: NotificationSidebar,
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
