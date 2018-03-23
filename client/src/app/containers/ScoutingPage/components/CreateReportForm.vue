<template>
  <div class="report-form">
    <div class="arrow"></div>
    <div class="form-container">

      <div v-if="type_select == ''" class="col-md-12 report-select">
        <span class="col-md-4">
              <label>Club</label>
              <button  v-on:click="setType('club')" ><img src="/images/landing-page/ft-icons-club.png" alt="Ft Logo" /></button>
            </span>
        <span class="col-md-4">
              <label>Player</label>
              <button  v-on:click="setType('player')"><img src="/images/landing-page/ft-icons-player.png" alt="Ft Logo" /></button>
            </span>
      </div>
      <div v-if="target" class="col-md-12 create-new">
        <router-link :to="newuri">New {{ type_select }}</router-link>
        <search-bar :search="getSearchResultsRole" :results="searchResult.value" class="search-bar-report col-md-4" :placeholder="placeholder" :target="geturi" />
      </div>
    </div>
  </div>
</template>

<style lang="scss" child-component="SearchBar">
  @import '~stylesheets/variables';
  .create-new {
    a {
      float: left;
    }
  }

  .report-select {
    color: $main-header-color;
  }

  .btn-new {
    background: $main-header-color;
    border-radius: 5px;
  }

  .searchbar-top.search-bar-report {
    float: left;
    width: 350px;
    position: relative !important;
    background: inherit;
    padding: 0;
    margin: 0;
    .input-group input {
      background: yellow;
    }
  }

  .create_form table {
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
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  import SearchBar from 'app/components/SearchBar';
  export default {
    name: 'CreateReportForm',
    props: [
      'type',
    ],
    components: {
      'search-bar': SearchBar
    },
    computed: {
      ...mapGetters(['report', 'searchResult']),
      reportStatus() {
        return this.report.status === ASYNC_FAIL ?
          this.report : null
      },
      placeholder() {
        return 'Search for ' + this.type_select + 's'
      },
      geturi() {
        if (this.type_select == 'club')
          return ('/club/${info.id}/report')
        return ('/users/${info.id}/report')
      },
      newuri() {
        return this.geturi.replace('${info.id}', 'new')
      }
    },
    data() {
      return {
        type_select: '',
        target: false,
      };
    },
    watch: {
      $route(to, from) {
        this.prepareReport()
      }
    },
    mounted() {
      this.prepareReport();
    },
    methods: {
      ...mapActions(['createReport', 'getSearchResults']),
      prepareReport() {
        this.type_select = '';
        this.target = false;
        if (this.type) {
          this.type_select = this.type;
          this.target = false;
        }
      },
      getSearchResultsRole(query) {
        query.role = this.type_select;
        return this.getSearchResults(query)
      },
      launch(type) {
        this.target = false
      },
      setType(type) {
        this.type_select = type;
        this.target = true
      }
    }
  };
</script>