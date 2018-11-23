<template>
  <timeline-item>

   <b-row>

         <b-col lg="6" md="6" sm="12">


                  <div class="select_box1">
                    <select>
                      <option value="volvo">View</option>
                      <option value="saab">Saab</option>
                      <option value="mercedes">Mercedes</option>
                      <option value="audi">Audi</option>
                    </select>
                  </div>
          </b-col>

          <b-col lg="6" md="6" sm="12">

                  <div class="select_box1">
                    <select>
                      <option value="volvo">Display</option>
                      <option value="saab">Saab</option>
                      <option value="mercedes">Mercedes</option>
                      <option value="audi">Audi</option>
                    </select>
                  </div>


           </b-col>

           <b-col lg="12" md="12" sm="12">

                <div class="match_table">
                  <table class="table" style="width:100%">
                    <tbody><tr>
                      <th>YEAR</th>
                      <th>CLUB</th>
                      <th>COUNTRY</th>
                      <th>COMPETITION</th>
                      <th>APPS</th>
                      <th>GLS</th>
                    </tr>

                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>
                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                    <tr>
                      <td>2002–03</td>
                      <td>Sporting CP B</td>
                      <td>Portugal</td>
                      <td>Segunda Divisão</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>

                    <tr>
                      <td>Total</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                    <tr>
                      <td>Career total</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>XX</td>
                      <td>XX</td>
                    </tr>

                  </tbody></table>

                </div>

           </b-col>





         <b-col lg="6" md="6" sm="12">

                  <div class="button_div_bottom"> <a href="#">GO TO CAREER HISTORY</a> </div>

         </b-col>

         <b-col lg="6" md="6" sm="12">

                 <div class="button_div_bottom"> <a href="#">GO TO MATCH STATISTICS</a> </div>



         </b-col>




    <!-- <div class="section">

    </div> -->

   </b-row>

  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.title {
  color: $secondary-text-color;
  text-transform: uppercase;
  margin-bottom: 50px;
}

.section {
  &:not(:last-child) {
    margin-bottom: 50px;
  }
  .section-title {
    color: $secondary-text-color;
    text-transform: uppercase;
    font-weight: 300;
  }
  .section-item {
    padding: 20px 0;
    display: flex;
    justify-content: space-between;
    &:not(:last-child) {
      border-bottom: 1px solid $secondary-text-color;
    }
    .team {
      display: flex;
      align-items: center;
      .name {
        text-transform: uppercase;
      }
      .logo-holder {
        height: 100px;
        width: 100px;
        display: flex;
        justify-content: center;
      }
      .logo {
        max-height: 100px;
        max-width: 100px;
      }
      .team-info {
        margin-left: 20px;
        color: $secondary-text-color;
      }
    }
    .info {
      display: flex;
      align-items: center;
      color: $secondary-text-color;
      .duration,
      .stats {
        margin-bottom: 0.1rem;
      }
      .duration,
      .app,
      .gls {
        font-weight: bold;
      }
    }
    &:hover {
      .team .name,
      .duration,
      .app,
      .gls {
        color: #000;
      }
    }
  }
}
.btn-holder {
  display: flex;
  justify-content: flex-end;
}


.profile_cont {
    width: 92%;
    margin: auto;
    padding-top: 20px;
    border-bottom: 1px solid #d5d5d5;
}

.select_div {
    margin: 10px 0px 20px 0;
    float: left;
    width: 100%;
}
.select_box1 {
    float: left;
    margin-right: 10px;
    width: 200px;
}

.select_box1 select {
    border: 1px solid #a8a8a8;
    text-align: center;
    padding: 5px 5px;
    border-radius: 3px;
    font-size: 12px;
    color: #a8a8a8;
    width: 100%;
    text-decoration: none;
    letter-spacing: 0px;
    font-family: 'ubuntulight';
    margin: 0 10px;
}

.match_table {
    float: left;
    width: 100%;
    color: #6d6d6d;
    font-family: 'ubuntulight';
    margin-top:10px;
}

.match_table th {
    font-size: 14px;
    font-weight: normal;
    text-align: left;
    line-height: 20px;
     padding: 0.45rem;
     border:none;
}

.table_button {
    float: left;
    width: 100%;
}

.button_div_bottom {
    float: left;
    margin: 22px 5px;
      width: 100%;
}

.button_div_bottom a {
    border: 1px solid #a8a8a8;
    text-align: center;
       width: 100%;
    padding: 12px 34px;
    border-radius: 3px;
    font-size: 11px;
    color: #a8a8a8;
    text-decoration: none;
    letter-spacing: 4px;
    font-family: 'ubuntulight';
}

.match_table td {
    font-size: 12px;
    font-weight: normal;
    text-align: left;
    line-height: 18px;
        border: none;
}








</style>

<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'CareerHistory',
  components: {
    'timeline-item': TimelineItem,
  },
  props: ['careerHistory'],
};
</script>
