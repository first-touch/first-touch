<template>
  <router-link class="search-results-item" :to="target">
    <div class="arrow"></div>
    <img class="img-fluid" src="https://unsplash.it/100/100" />
    <p class="search-results-item-name">{{ info.display_name }}</p>
  </router-link>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';

.search-results-item {
  flex: 1 0 100%;
  display: flex;
  align-items: center;
  background-color: rgba(33, 34, 35, 0.95);
  padding: 10px 20px;
  height: 80px;
  color: $secondary-header-color;
  border-left: 7px solid $secondary-header-color;
  &:hover,
  &:focus {
    text-decoration: none;
  }
  .arrow {
    margin-left: -20px;
  }
  .img-fluid {
    max-height: 100%;
    border-radius: 50%;
  }
  .search-results-item-name {
    margin-left: 20px;
    margin-bottom: 0;
  }
}
</style>

<script>
export default {
  name: 'SearchResult',
  props: ['info','uri'],
  data() {
    return {
      target:  this.uri? this.uri.replace('${info.id}',this.info.id): '#'
    };
  }
};
</script>