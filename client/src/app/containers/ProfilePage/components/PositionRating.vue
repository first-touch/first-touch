<template>
  <div class="rating flex-row">
    <div class="rating-for"> {{ positionName }} </div>
    <star-rating :rating="rating" :read-only="true" :show-rating="false" star-size="30" active-color="#a8cb5c"></star-rating>
  </div>
</template>

<style lang="scss" scoped>
  .rating-for {
    width: 50%;
    margin-top: auto;
    margin-bottom: auto;
    margin-right: 20px;
  }
</style>


<script>
import StarRating from 'vue-star-rating';

export default {
  name: 'PositionRating',
  props: ['positionRating'],
  components: {
    'star-rating': StarRating
  },
  computed: {
    positionName() {
      return this.positionRating.position;
    },
    rating() {
      return this.positionRating.skill;
    }
  }
};
</script>
