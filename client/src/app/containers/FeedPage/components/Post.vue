<template>
  <timeline-item>
<<<<<<< HEAD

<b-container>
    <b-row>
        <b-col md="12" col lg="12">


            <b-col id="career-statics-large">
                     <b-col id="career-statics-inner">
                     <b-col id="career-statics-inner-1">
                     <b-col id="career-statics-inner-2">
                                <img src="../../../../img/lionel-img.png">
                                        </b-col>
                                    <h3>{{ info.author_name }}</h3>
                                    <p>{{ info.author_status }}</p>
                                        </b-col>
                                        </b-col>

                    	<b-col id="career-statics-inner-3">   </b-col>

                </b-col>

         <p class="content">  {{ info.content }} </p>

        </b-col>

    </b-row>
</b-container>
=======
    <div class="header">
      <img class="avatar" src="https://unsplash.it/200/200" />
      <div class="info spaced-title upper-cased main-color">
        <h5 class="name">{{ info.author_name }}</h5>
        <p class="role">{{ info.author_status }}</p>
      </div>
    </div>
    <div class="body">
      <!-- <img class="img-fluid" src="https://unsplash.it/1000/600" /> -->
      <p class="content">
        {{ info.content }}
      </p>
    </div>
>>>>>>> [Chore] cleaning up some more styling
  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.header {
  display: flex;
  margin-bottom: 20px;
  .avatar {
    border-radius: 50%;
    max-height: 70px;
    width: 70px;
  }
  .info {
    margin-left: 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .name {
      color: $secondary-header-color;
    }
  }
}

.body {
  *:not(:last-child) {
    margin-bottom: 20px;
  }
  .content {
    color: $main-text-color;
    letter-spacing: 1.3px;
    margin-bottom: 0;
  }
}

.search_box2 {
    width: 100%;
    margin-top: 35px;
    float: left;
}

.profile_div {
    width: 96%;

    position: relative;
}


.profile_box {
    background: #fff;
    border-radius: 5px;
    width: 100%;
    display: inline-block;
}


#career-statics-large {
    float: left;
    width: 554px;
    background: #fff;
    border-radius: 5px;
}

#career-statics-inner {
   width: 96%;
    margin: 7px 0px;
    position: relative;
    right: 40px;
}

#career-statics-inner-2{
    float: left;
    width: 90px;
}

#career-statics-inner-1 h3 {
    color: #40bc5c;
    float: left;
    margin: 8px 0 0 0;
    font-family: ubuntulight;
    font-size: 18px;
    font-weight: normal;
    letter-spacing: 4px;
}
#career-statics-inner-1 p {
    font-size: 14px;
    font-family: ubuntulight;
    font-weight: normal;
    color: #929292;
    float: left;
    width: 73%;
    letter-spacing: 4px;
}


#career-statics-inner-3 {
    width: 93%;
    float: left;
    margin: 17px 0px;
    height: 300px;
    background: #d5d5d5;
}

.content {
    font-size: 24px;
    color: #929292;
     padding-left: 15px;

}

.timeline-post .item-container {
    width: 96% !important;
}


</style>




<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'Post',
  props: ['info'],
  components: {
    'timeline-item': TimelineItem,
  },
};
</script>
