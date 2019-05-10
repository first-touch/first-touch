<template>
  <h1> TO BE DELETED? </h1>
  <!-- <div class="wrapper">
    <div class="header-wrapper">
      <div class="header col-lg-10">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-lg-8">
          <h2 class="title" :title="report.headline">{{report.headline}}</h2>
          <p class="extra">
            <span class="target" v-if="report.type_report =='player'">{{report.player.first_name}} {{report.player.last_name}} </span>
            <span class="target" v-if="report.type_report =='team'"> Club Name</span>
            <span>{{report.updated_at | moment}}</span>
          </p>
        </div>
      </div>
      <div class="widget">
        <router-link :to="{ name: 'scoutReportView', params: { id: report.id }}">
          <button class="btn-round">View</button>
        </router-link>
        <a v-if="report.status == 'publish'" @click="UpdateReport('private',report.id)">
          <button class="btn-round">Unpublish</button>
        </a>
        <a v-if="report.status == 'private'" @click="UpdateReport('publish',report.id)">
          <button class="btn-round">Publish</button>
        </a>
      </div>
    </div>
  </div> -->
</template>

<script>
  export default {
    name: 'ReportItem',
    props: ['report', 'UpdateReport']
  };
</script>
