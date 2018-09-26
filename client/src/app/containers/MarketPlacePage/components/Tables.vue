<template>
  <table class="table table-search">
    <thead>
      <tr v-if="type == 'player'">
        <th scope="col" class="shortable" @click="setOrder('type_report')">
          <p>Type</p>
          <span v-if="params.order == 'type_report'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('player')">
          <p>Player</p>
          <span v-if="params.order == 'player'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('playing_position')">
          <p>Position</p>
          <span v-if="params.order == 'playing_position'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('preferred_foot')">
          <p>P. Foot</p>
          <span v-if="params.order == 'preferred_foot'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('height')">
          <p>Height</p>
          <span v-if="params.order == 'height'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('weight')">
          <p>Weight</p>
          <span v-if="params.order == 'weight'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('nationality_country_code')">
          <p>Nationality</p>
          <span v-if="params.order == 'nationality_country_code'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('scout_name')">
          <p>SCOUT</p>
          <span v-if="params.order == 'scout_name'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('created_at')">
          <p>Published</p>
          <span v-if="params.order == 'created_at'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
                <th scope="col" class="shortable" @click="setOrder('price')">
          <p>Action/Price</p>
          <span v-if="params.order == 'price'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
      </tr>
      <tr v-if="type == 'team'">
        <th scope="col" class="shortable" @click="setOrder('type_report')">
          <p>Type</p>
          <span v-if="params.order == 'type_report'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('club')">
          <p>Club Name</p>
          <span v-if="params.order == 'club'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('category')">
          <p>Team</p>
          <span v-if="params.order == 'category'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('competition')">
          <p>League</p>
          <span v-if="params.order == 'competition'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('scout_name')">
          <p>SCOUT</p>
          <span v-if="params.order == 'scout_name'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('updated_at')">
          <p>Published</p>
          <span v-if="params.order == 'updated_at'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
        <th scope="col" class="shortable" @click="setOrder('price')">
          <p>Action/Price</p>
          <span v-if="params.order == 'price'">
            <icon name='arrow-alt-circle-up' v-if="params.order_asc"></icon>
            <icon name='arrow-alt-circle-down' v-if="!params.order_asc"></icon>
          </span>
        </th>
      </tr>
    </thead>
    <tbody>
      <report v-if="type == 'player'" v-for="report in listReport" :report="report" :key="report.id" :viewAction="viewAction" :buyActionWithPrice="buyAction"
        mode="table" :widgets="['type2c','player2c','position','foot','height','weight','nationality','scout','updated','action']"
      />
      <report v-if="type == 'team'" v-for="report in listReport" :report="report" :key="report.id" :viewAction="viewAction" :buyActionWithPrice="buyAction"
        mode="table" :widgets="['type2c','club','category','competition','scout','updated','action']"
      />
    </tbody>
  </table>
</template>


<script>
  import ReportItem from 'app/components/ReportItem';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import 'vue-awesome/icons/eye-slash';
  import Icon from 'vue-awesome/components/Icon';
  import {
    ASYNC_NONE
  } from 'app/constants/AsyncStatus';
  export default {
    name: 'ReportsList',
    props: ['buyAction', 'setOrder', 'params', 'listReport', 'viewAction', 'type'],
    components: {
      report: ReportItem,
      icon: Icon,
    },
  }
</script>
