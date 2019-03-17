<template>

  <div class="rating row mt-2">
    <div class="col-sm-12 col-md-6">
      <div class="rating-for"> {{ positionName }} </div>
    </div>
    <div class="col-sm-12 col-md-6">
      <star-rating :rating="rating" :read-only="true" :show-rating="false" :increment="0.5" :star-size=30 active-color="#a8cb5c"></star-rating>
    </div>
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
