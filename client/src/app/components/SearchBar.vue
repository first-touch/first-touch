<template>
  <div class="searchbar-top">
    <div class="input-group">
      <input type="text" v-model="searchTerm" @keyup.prevent="search(searchTerm)" class="form-control" placeholder="Search for players, clubs, events" />
      <span class="input-group-btn">
        <button class="btn btn-secondary" type="button">
          <img class="img-fluid" src="https://d30y9cdsu7xlg0.cloudfront.net/png/15803-200.png" />
        </button>
      </span>
      <div class="search-results-container">
        <result v-for="result in results" :info="result" />
      </div>
    </div>
  </div>
</template>

<style lang="sass">
@import "~stylesheets/variables";

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
      border-color: #ccc;
      &:focus { border-color: #ccc; }
      &:hover, &:focus { border-right: none; }
      &:focus ~ .search-results-container {
        display: flex;
      }
    }
    .input-group-btn .btn {
      flex: 1 0 20%;
      border-radius: 0;
      border-left: none;
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
    &:hover { display: flex; }
  }
}
</style>

<script>
import SearchResult from './SearchResult.vue';

export default {
  name: 'SearchBar',
  props: ['search', 'results'],
  components: {
    'result': SearchResult
  },
  data() {
    return {
      searchTerm: '',
    }
  }
}
</script>