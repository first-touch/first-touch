
<template>
<div>
<h4 class="career_sec">CAREER STATISTICS
        </h4>
<div class="timeline-widget">
<div class="arrow"></div>
<div class="timeline-widget-button">
<b-btn v-b-toggle.post-text>
<div class="row">
<div class="col no-padding">
<img src="../../../../img/newpost.png">
</div>
<div class="col">
Publish
<br>
new post
</div>
</div>
</b-btn>
</div>
<div class="timeline-widget-button">
<b-btn v-b-toggle.post-media>
<div class="row">
<div class="col no-padding">
<img src="../../../../img/picture.png">
</div>
<div class="col">
Upload
<br>
a photo
</div>
</div>
</b-btn>
</div>
</div>
<b-collapse id="post-text" accordion="post-upload">
<b-card>
<div class="container">
<form @submit.prevent="handleSubmit">
<fieldset class="form-group">
<textarea  class="form-control" rows="4" placeholder="Share a thought, link or opinion"></textarea>
</fieldset>
<div class="row justify-content-end">
<button type="submit" class="a-bar-button">Post</button>
</div>
</form>
</div>
</b-card>
</b-collapse>
<b-collapse id="post-media" accordion="post-upload">
<b-card>
<div class="container">
<form @submit.prevent="handleSubmit">
<fieldset class="form-group">
<b-form-file accept="image/jpeg, image/png, image/gif"></b-form-file>
</fieldset>
<div class="row justify-content-end">
<button type="submit" class="a-bar-button">Post</button>
</div>
</form>
</div>
</b-card>
</b-collapse>




</div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';

#post-text,
#post-media {
border-left: 7px solid $secondary-header-color;
padding-left: 25px;
textarea {
border: none;
color: #7F8081;
}
.a-bar-button {
border: none;
box-shadow: none;
background: #B3CB75;
width: 200px;
}
}

.timeline-widget {
display: flex;
border-left: 7px solid $secondary-header-color;
.timeline-widget-button {
.btn-secondary {
border: none; // max-width: 12vw;
margin-right: 20px;
margin-bottom: 20px;
color: $secondary-text-color;
text-transform: uppercase;
background-color: #343434;
text-align: left;
}
.btn-text-title {
margin-top: 10px;
}
img {
height: 50px;
}
}
.arrow {
margin-top: 18px;
border-left-color: $secondary-header-color;
}
}

.search_box2 {
width: 100%;
margin-top: 35px;
float: left;
}

.profile_div {
width: 96%;
background: url(../../../../img/img02.png) repeat-y;
padding-left: 25px;
position: relative;
}


.profile_box {
background: #fff;
border-radius: 5px;
width: 100%;
display: inline-block;
}

.Pellentesque-arrow-right {
border-top: 7px solid transparent;
border-left: 8px solid #a5ce4b;
float: left;
margin-left: -13px;
border-bottom: 7px solid transparent;
top: 50px;
position: absolute;
}

.lionel_div {
float: left;
width: 554px;
background: #fff;
border-radius: 5px;
}

.lionel {
width: 96%;
margin: 20px 0 20px 20px;
}

.lionel_inner_img {
float: left;
width: 70px;
}

.lionel_div h3 {
color: #40bc5c;
float: left;
margin: 8px 0 0 0;
font-family: ubuntulight;
font-size: 18px;
font-weight: normal;
letter-spacing: 4px;
}

.lionel_div p {
font-size: 14px;
font-family: ubuntulight;
font-weight: normal;
color: #929292;
float: left;
letter-spacing: 4px;
}


.lionel1 {
width: 93%;
float: left;
margin: 17px 20px;
height: 300px;
background: #d5d5d5;
}


.career_sec {
    margin: 42px 0 0 0;
    font-size: 18px;
    letter-spacing: 3px;
    color: #929292;
    font-weight: normal;
    padding-top: 12px;
    padding-bottom: 14px;
    &:before {
      content: '';
      position: absolute;
      margin-top: -15px;
      width: 5%;
      border-top: 5px solid #a8cb5c;
    }
  }
.btn.btn-secondary.collapsed {
    background-color: #212123 !important;
}

</style>
<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'CareerStatics',
  components: {
    'timeline-item': TimelineItem,
  },
  props: ['CareerStatics'],
};

</script>
