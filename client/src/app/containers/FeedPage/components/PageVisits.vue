<template>
  <div>
     <b-carousel id="carousel1" class="slider"
            style="text-shadow: 1px 1px 2px #333;"
            controls
            indicators
            background="#000"
            :interval="4000"
            img-width="1024"
            img-height="480" 
            
            >
            <!-- Text slides with image -->
            <b-carousel-slide class="salider_img_sec"
               img-src="../img/slider_img.png"
               >
            </b-carousel-slide>
            <!-- Slides with custom text -->
            <b-carousel-slide class="salider_img_sec" 
            img-src="../img/slider_img.png">
            </b-carousel-slide>
         </b-carousel>
        
  </div>
  
</template>
<style lang="css" scoped>



.salider_img_sec {
    width: 80% !important;
    margin: 0 auto;
}

div#__BVID__25 {
    max-width: 80% !important;
    margin: 0 auto;
}

.carousel-control-prev {
	background-color: #191818;
	width: 28px;
	opacity: unset;
}

div#carousel1 a.carousel-control-prev {
    background-color: #000;
    width: 10%;
}
a.carousel-control-prev
    {
      width: 10%;
        
        
        margin: 0;
        display: flex;
        flex-direction: column;
        align-items: stretch;
    }
</style>


<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'PageVisits',
  props: ['info'],
  components: {
    'timeline-item': TimelineItem,
  },
};



</script>
