  <template>
  <div>

  <b-col lg="12" md="12" sm="12">

        <div class="create_sec">
        <div class="clender_img"><img src="../../../../img/calender.png"></div>
        <div class="events_tac"> <div class="right_line_arrow"><img src="../../../../img/right_tac.png"></div>
            <h3> CREATE A NEW EVENT</h3>
        </div>
      </div>

    </b-col>
      <b-row> 
       <b-col lg="12" md="12" sm="12">

        <div class="month_date_sec"><p>05</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="../../../../img/right_tac-shot.png"></div>

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
            <img src="../../../../img/dote_icon.png">
          </div>
        </div>

     </b-col>




 
        <b-col lg="12" md="12" sm="12" id="top-time-box">

        <div class="green_date_sec"><p>15</p><p>JUN</p></div>

        <div class="right_arrow_icon"><img src="../../../../img/green_line.png"></div>

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
            <img src="../../../../img/dote_icon.png">
          </div>
        </div>

     </b-col>
     </b-row>
     </div>
  </template>
<style lang="scss" scoped>
 .champions_sec {
  float: left;
  width: 450px;
  vertical-align: top;
  background-color: #fff;
  padding: 15px;
  height: 185px;
  margin-bottom: 26px;
}


.ft-page:before {
  margin-left: 16px;
}

.profile {
  margin-left: 16px;
  h4 {
    color: #929292;
  }
}


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
  li {
    display: inline-block;
    width: 12%;
    color: #666;
    text-align: center;
    font-family: 'ubuntulight';
    border: none;
  }
}

.days {
  padding: 18px 0 10px 0;
  margin: 0 0 26px 0;
  text-align: center;
  li {
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
  .fa {
    color: #fff;
    width: 34px;
    height: 34px;
    text-align: center;
    border: 1px solid #fff;
    border-radius: 65%;
    position: relative;
    top: 0px;
    font-size: 32px;
  }
}

.month_sec {
  padding-bottom: 30px;
  padding-top: 23px;
  ul {
    list-style: none;
    li {
      font-size: 18px;
      padding: 18px 0;
      color: #6b8238;
      font-family: 'ubuntulight';
      display: inline-block;
      width: 100%;
    }
  }
}

.up_month .fa {
  color: #fff;
  width: 34px;
  height: 34px;
  text-align: center;
  border: 1px solid #fff;
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
  border: 1px solid #a6cf4c;
  border-radius: 56%;
  text-align: center;
  p {
    color: #fff;
    position: relative;
    top: 14px;
    font-size: 14px;
    font-family: ubuntulight;
    margin: 0px;
  }
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
  h5 {
    font-size: 16px;
    color: #a6cf4c;
    font-family: ubuntulight;
    margin: 0px;
  }
  h6 {
    font-size: 14px;
    color: #606060;
    padding-top: 18px;
    font-family: ubuntulight;
  }
}

.time_sec {
  padding-top: 0px;
}

.champion_tittle p {
  font-size: 14px;
  color: #a8a8a8;
  font-family: ubuntulight;
  margin: 0px;
  span {
    color: #606065;
    font-size: 16px;
  }
}

.right_cleck {
  width: 80px;
  float: left;
  text-align: center;
  height: 185px;
  background-color: #000;
  padding: 20px 0;
}

.right_cleck_sec .fa {
  color: #a6cf4c;
  font-size: 16px;
  width: 26px;
  height: 26px;
  border: 1px solid #a6cf4c;
  border-radius: 62%;
  &:before {
    position: relative;
    top: 5px;
    left: 1px;
  }
}

.close_cleck_sec {
  padding-top: 32px;
  .fa {
    color: #40bc5c;
    font-size: 16px;
    width: 26px;
    height: 26px;
    border: 1px solid #a6cf4c;
    border-radius: 62%;
    &:before {
      position: relative;
      top: 4px;
      left: 0px;
    }
  }
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
  border: 1px solid #40bc5c;
  border-radius: 56%;
  text-align: center;
  p {
    color: #fff;
    position: relative;
    top: 14px;
    font-size: 14px;
    font-family: ubuntulight;
    margin: 0px;
  }
}
</style>