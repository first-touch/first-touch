<template>
  <div class="searchbar-top">
    <div class="input-group">
      <input type="text" v-model="searchTerm" @keyup.prevent="search({ searchTerm })" class="form-control" :placeholder="placeholder"
      />
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button">
          <img class="img-fluid" src="https://d30y9cdsu7xlg0.cloudfront.net/png/15803-200.png" />
        </button>
      </span>
      <div class="search-results-container">
        <result v-for="result in results" :info="result" :key="result.id" :action="action" />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .searchbar-top {
    position: fixed;
    z-index: 2;
    top: 0;
    left: $navbar-width;
    width: 62vw;
    padding: $searchbar-padding;
    background-color: $navbar-background-color-faded;

    .input-group {
      flex-wrap: wrap;
      .form-control {
        flex: 1 0 80%;
        border-radius: 0;
        border: none;
        &:focus {
          border-color: #ccc;
        }
        &:hover,
        &:focus {
          border: none;
          box-shadow: none;
        }
        &:focus~.search-results-container {
          display: flex;
        }
      }
      .input-group-btn .btn {
        flex: 1 0 20%;
        border-radius: 0;
        border: none;
        background-color: #fff;
        &:hover {
          background-color: #fff;
          border-color: #ccc;
          border-left: none;
        }
        .img-fluid {
          width: 20px;
          height: 20px;
        }
      }
    }
    .search-results-container {
      display: none;
      flex-wrap: wrap;
      position: absolute;
      flex: 1 0 auto;
      width: 100%;
      margin-top: 40px;
      &:hover {
        display: flex;
      }
    }
  }
</style>

<script>
  import SearchResult from './components/SearchResult';

  export default {
    name: 'SearchBar',
    props: ['search', 'results', 'placeholder', 'action'],
    components: {
      result: SearchResult,
    },
    data() {
      return {
        searchTerm: ''
      };
    },
    computed: {
      searchResult() {
        return this.searchTerm != '' ? results : []
      },
    }
  };
</script>
